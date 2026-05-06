"""
Hookah Mix Master — Firestore importer.

Завантажує seed JSON у Firestore.

Передумови:
1. Firebase проєкт створено
2. Firestore database ініціалізована (Native mode)
3. Service Account ключ збережено локально (НЕ КОМІТЬ ЦЕ В GIT!)
4. firebase-admin встановлено: pip install firebase-admin

Запуск:
    python3 import_to_firestore.py path/to/serviceAccountKey.json hookah_seed_v1.json

Безпека:
    - Скрипт запускається ОДИН РАЗ при ініціалізації проєкту
    - Service Account має права Firestore Admin (тимчасово)
    - Після імпорту — обмежити права Service Account або видалити ключ
"""
import json
import sys
import time
from pathlib import Path

try:
    import firebase_admin
    from firebase_admin import credentials, firestore
except ImportError:
    print("❌ firebase-admin не встановлено")
    print("   Запустіть: pip install firebase-admin")
    sys.exit(1)


def chunked(items, size):
    for i in range(0, len(items), size):
        yield items[i:i + size]


def main(service_account_path: str, seed_json_path: str, dry_run: bool = False):
    # Load and validate JSON
    seed_path = Path(seed_json_path)
    if not seed_path.exists():
        print(f"❌ Не знайдено seed файл: {seed_json_path}")
        sys.exit(1)

    data = json.loads(seed_path.read_text(encoding="utf-8"))
    print(f"📦 Завантажено seed v{data['version']}")
    print(f"   Brands:   {data['stats']['brands']}")
    print(f"   Tobaccos: {data['stats']['tobaccos']}")
    print(f"   Mixes:    {data['stats']['mixes']}")

    if dry_run:
        print("\n🔍 DRY RUN — нічого не завантажую")
        return

    # Init Firebase
    cred = credentials.Certificate(service_account_path)
    firebase_admin.initialize_app(cred)
    db = firestore.client()
    print(f"\n🔥 Підключено до Firestore: {firebase_admin.get_app().project_id}")

    # 1. Brands
    print("\n📤 Завантажую brands...")
    for brand in data["brands"]:
        db.collection("brands").document(brand["id"]).set(brand)
    print(f"   ✅ {len(data['brands'])} brands")

    # 2. Tobaccos (batched — Firestore limit 500 per batch)
    print("\n📤 Завантажую tobaccos (batched)...")
    BATCH_SIZE = 400
    total = 0
    for i, chunk in enumerate(chunked(data["tobaccos"], BATCH_SIZE), 1):
        batch = db.batch()
        for tobacco in chunk:
            ref = db.collection("tobaccos").document(tobacco["id"])
            batch.set(ref, tobacco)
        batch.commit()
        total += len(chunk)
        print(f"   Batch {i}: {len(chunk)} records (total {total})")
        time.sleep(0.5)  # gentle rate limiting

    # 3. Curated mixes
    print("\n📤 Завантажую curated mixes...")
    for m in data["mixes"]:
        db.collection("curated_mixes").document(m["id"]).set(m)
    print(f"   ✅ {len(data['mixes'])} mixes")

    print("\n🎉 Імпорт завершено!")
    print("\nНаступні кроки:")
    print("  1. Перевір дані в Firebase Console")
    print("  2. Налаштуй Firestore Security Rules (read-only для tobaccos/brands/curated_mixes)")
    print("  3. Видали service account ключ з локальної машини або обмеж права")


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print(__doc__)
        sys.exit(0)

    dry_run = "--dry-run" in sys.argv
    main(
        service_account_path=sys.argv[1],
        seed_json_path=sys.argv[2],
        dry_run=dry_run,
    )

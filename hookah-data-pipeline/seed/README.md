# Hookah Mix Master — Seed Data v1.0

Початковий датасет з **100 табаками**, **8 брендами** і **10 курованими міксами** для застосунку Hookah Mix Master.

## 📁 Файли

- `hookah_seed_v1.json` — готовий датасет для Firestore
- `build_seed.py` — генератор датасета (запускати при оновленнях)
- `import_to_firestore.py` — імпортер у Firestore
- `README.md` — цей файл

## 📊 Що в датасеті

### Бренди (8)
| Бренд | Країна | Тип листа | Заснований |
|-------|--------|-----------|------------|
| Al Fakher | 🇦🇪 ОАЕ | Blonde | 1999 |
| Adalya | 🇹🇷 Туреччина | Blonde | 2003 |
| Fumari | 🇺🇸 США | Blonde | 1997 |
| Tangiers | 🇺🇸 США | Dark | 2005 |
| Starbuzz | 🇺🇸 США | Blonde | 2005 |
| Mazaya | 🇯🇴 Йорданія | Blonde | 2006 |
| Nakhla | 🇪🇬 Єгипет | Dark | 1913 |
| Trifecta | 🇺🇸 США | Mixed | 2017 |

### Розподіл табаків

- Al Fakher: 25
- Adalya: 20
- Fumari: 12
- Tangiers: 10
- Starbuzz: 10
- Mazaya: 8
- Nakhla: 8
- Trifecta: 7

### Куровані мікси (10)

Розподіл за рівнями:
- **Beginner:** 4 мікси (прості, безпрограшні)
- **Intermediate:** 5 міксів (3-компонентні)
- **Expert:** 1 мікс (dark leaf)

## 🗂️ Схема даних

### `tobaccos` collection

```typescript
{
  id: string                          // "al_fakher__double_apple"
  brand: { id, name, country }
  name: { en, uk, original }
  leafType: "blonde" | "dark"
  strength: 1 | 2 | 3 | 4 | 5         // 2 для blonde, 3-4 для dark
  flavorCategories: string[]          // ["fruity", "spice"] — для UI фільтрів
  tasteNotes: string[]                // ["apple", "anise"] — для smart matching
  tasteProfile: {                     // 0-5 на кожній осі
    sweet: number,
    sour: number,
    fresh: number,                    // прохолода/ментол
    spicy: number,
    bitter: number,
    floral: number
  }
  description: { en, uk }
  imageUrl: string | null
  popularity: number                  // 0-100, для сортування
  availability: {
    ua: { available, shops, lastChecked }   // заповниться у v1.1
  }
  sources: [{ name, verified }]
  createdAt: ISO8601
  updatedAt: ISO8601
}
```

### `curated_mixes` collection

```typescript
{
  id: string
  name: { en, uk }
  components: [{ tobaccoId, percentage }]   // sum = 100
  expectedProfile: { sweet, sour, fresh, spicy, bitter, floral }
  strengthLevel: 1-5
  difficulty: "easy" | "medium" | "hard"
  description: { en, uk }
  targetPersona: "beginner" | "intermediate" | "expert"
  tags: string[]
  popularity: number
  isCurated: true
  authorId: null                       // null = official curated
}
```

### `brands` collection

```typescript
{
  id: string                           // "al_fakher"
  name: string                         // "Al Fakher"
  country: string                      // ISO "AE"
  countryName: { en, uk }
  leafType: "blonde" | "dark"
  foundedYear: number
  description: { en, uk }
  popularity: number
}
```

## 🚀 Завантаження у Firestore

### Передумови

1. Створи Firebase проєкт: https://console.firebase.google.com
2. Увімкни Cloud Firestore (Native mode, регіон europe-west3 для України)
3. Згенеруй Service Account ключ:
   - Project Settings → Service Accounts → Generate new private key
   - Збережи як `serviceAccountKey.json` (НЕ КОМІТЬ В GIT!)
4. Встанови залежності:
   ```bash
   pip install firebase-admin
   ```

### Імпорт

```bash
# Спочатку — dry run, щоб перевірити
python3 import_to_firestore.py path/to/serviceAccountKey.json hookah_seed_v1.json --dry-run

# Реальний імпорт
python3 import_to_firestore.py path/to/serviceAccountKey.json hookah_seed_v1.json
```

Час виконання: ~30 секунд.

### Перевірка в консолі

Після імпорту в Firebase Console → Firestore Database має з'явитись:
- `brands/` — 8 документів
- `tobaccos/` — 100 документів
- `curated_mixes/` — 10 документів

## 🔒 Firestore Security Rules

Після імпорту **обов'язково** налаштуй security rules. Базовий шаблон:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Public read для каталогу
    match /brands/{brandId} {
      allow read: if request.auth != null;
      allow write: if false;  // Тільки через admin SDK
    }

    match /tobaccos/{tobaccoId} {
      allow read: if request.auth != null;
      allow write: if false;
    }

    match /curated_mixes/{mixId} {
      allow read: if request.auth != null;
      allow write: if false;
    }

    // User data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;

      match /favorites/{favId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }

      match /mix_history/{mixId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }

    // User-created mixes (private by default in MVP)
    match /mixes/{mixId} {
      allow read, write: if request.auth != null
                        && resource.data.userId == request.auth.uid;
      allow create: if request.auth != null
                   && request.resource.data.userId == request.auth.uid;
    }
  }
}
```

Деплой:
```bash
firebase deploy --only firestore:rules
```

## 🎯 Як це використовується у Flutter

### Smart Recommender алгоритм (для новачка)

Користувач вибирає бажаний `tasteProfile` (наприклад: sweet=4, fresh=3).
Алгоритм:

1. Фільтрує мікси з `targetPersona: "beginner"`
2. Обчислює "відстань" між бажаним профілем і `expectedProfile` міксу:
   ```
   distance = |sweet_user - sweet_mix| + |fresh_user - fresh_mix| + ...
   ```
3. Сортує за зростанням distance — топ-3 рекомендуються

Можна навіть без серверної логіки — рахувати на клієнті, бо датасет малий.

### Manual Mix Builder (для знавця)

1. Користувач вибирає до 4 табаків зі списку
2. UI рахує сумарний `tasteProfile` як зважене середнє за `percentage`
3. Валідація: сума `percentage` = 100

### Каталог

- Фільтри по `flavorCategories` (UI чіпи)
- Сортування за `popularity` за замовчуванням
- Пошук по `name.en`, `name.uk`, `tasteNotes`

## 🔮 Roadmap по даних

### v1.0 (зараз)
✅ 100 табаків з топ-8 брендів  
✅ 10 курованих міксів  
✅ Базова таксономія (categories, notes, profile)

### v1.1 (~1 місяць після MVP)
- [ ] Скрейпери для Aladin Kyiv, Dumok, Huka, Daza
- [ ] Заповнення `availability.ua` (де купити в Україні)
- [ ] Розширення до 200-300 табаків
- [ ] Зображення пачок (Firebase Storage)

### v1.2
- [ ] Українські бренди: Heven, Molfar, Yammy, Tenarat
- [ ] Cloud Functions для періодичної перевірки наявності
- [ ] Admin-панель для редагування каталогу

### v2.0
- [ ] UGC: користувачі додають свої мікси
- [ ] Соціальні фічі: лайки, коментарі
- [ ] Інтеграція з магазинами (deep links на купівлю)

## ⚠️ Важливі застереження

- **Дані базуються на публічно доступних відомостях** з офіційних сайтів брендів і агрегаторів. Жодних маркетингових текстів магазинів не копіювалось — описи написані самостійно.
- **Strength** є приблизним — реальна міцність залежить від методу куріння, чаші, нагріву.
- **TasteProfile** є експертною оцінкою на основі публічних описів — може суб'єктивно відрізнятись.
- **Availability в Україні** буде додано в v1.1.

## 🛠️ Оновлення датасета

Якщо потрібно додати нові табаки:

1. Відредагуй `build_seed.py` — додай записи у відповідний масив бренду
2. Запусти:
   ```bash
   python3 build_seed.py
   ```
3. Імпортуй знову (Firestore зробить upsert):
   ```bash
   python3 import_to_firestore.py serviceAccountKey.json hookah_seed_v1.json
   ```

Скрипт-генератор автоматично валідує:
- Унікальність ID
- Сума percentage у міксах = 100
- Всі посилання на табаки існують

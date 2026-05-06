# Hookah Mix Master

## Brief
Mobile app для міксування кальянних табаків. Дві основні аудиторії:
1. **Знавці** — шукають конкретний табак за брендом, дивляться смакові ноти, створюють власні мікси
2. **Новачки** — отримують готові рекомендації міксу за простими параметрами (солодкий/кислий, легкий/міцний)

Користувачі зберігають улюблені табаки, історію міксів, оцінюють комбінації.

## Architecture
- Flutter 3.x stable channel, Dart 3.x
- State management: **Riverpod 2.x** (тільки code-gen варіант: `@riverpod`)
- Routing: **go_router** з auth-guards
- Backend: **Firebase** (Auth, Firestore, Storage, Crashlytics, Analytics)
- Локальне сховище: **Hive** (для офлайн-кешу каталогу) + **flutter_secure_storage** (для токенів)
- DI: Riverpod providers (без get_it — Riverpod достатньо)
- Кодогенерація: `freezed`, `json_serializable`, `riverpod_generator`, `go_router_builder`

## Architecture Pattern: Feature-First + Light Clean Architecture
- lib/
  - core/                        — спільна інфраструктура
    - theme/                     — Material 3 dark/light, design tokens
    - router/                    — go_router конфіг + guards
    - services/                  — Firebase, Hive, network
    - utils/                     — extensions, helpers
    - constants/                 — app-wide константи
    - errors/                    — AppException, failure types
  - features/                    — фічі за модулями
    - auth/
      - data/                    — datasources, repository_impl, DTOs
      - domain/                  — entities (freezed), repository interface
      - presentation/            — screens, widgets, providers (Riverpod)
    - tobacco_catalog/
    - mix_builder/
    - smart_recommender/
    - favorites/
    - mix_history/
    - profile/
  - l10n/                        — ARB файли (en, uk)
  - main.dart
- test/                          — дзеркалить структуру lib/

**Use_cases створюй ТІЛЬКИ коли:**
- логіка зачіпає 2+ репозиторії
- є складна бізнес-логіка яку потрібно тестувати ізольовано
В інших випадках — repository викликається безпосередньо з provider'а.

## Tech Stack Rules (NON-NEGOTIABLE)
- ❌ ЗАБОРОНЕНО `dynamic`, `var` для типів які можна явно вказати, `Object?` без причини
- ❌ ЗАБОРОНЕНО `setState` — тільки Riverpod providers (`ConsumerWidget`/`ConsumerStatefulWidget`)
- ❌ ЗАБОРОНЕНО `FutureBuilder`/`StreamBuilder` — використовуй `AsyncValue` через Riverpod
- ❌ ЗАБОРОНЕНО хардкодні рядки в UI — тільки `AppLocalizations.of(context).keyName`
- ❌ ЗАБОРОНЕНО хардкодні кольори/розміри/шрифти — тільки через `Theme.of(context)` або `AppTokens`
- ❌ ЗАБОРОНЕНО `print` — використовуй `dev.log` або `Logger`
- ✅ ЗАВЖДИ `const` конструктори де можливо
- ✅ ЗАВЖДИ типізуй freezed-моделі для DTO та entities
- ✅ ЗАВЖДИ обгортай асинхронні дії в try/catch з `AppException`
- ✅ ЗАВЖДИ використовуй immutable моделі (freezed)
- ✅ ЗАВЖДИ роби null-safety явно (без `!` без явної перевірки)

## Naming Conventions
- Файли: `snake_case.dart`
- Класи/типи: `PascalCase`
- Приватні поля/методи: `_camelCase`
- Константи: `kCamelCase` або `SCREAMING_SNAKE_CASE` для глобальних
- Один widget — один файл, якщо widget > 80 рядків або використовується в 2+ місцях
- Riverpod providers: `nameProvider` (camelCase + Provider суфікс)

## Firebase Rules
- Усі Firestore-запити через repository, ніколи напряму з UI
- Security Rules мають захищати всі колекції — перед deploy запускати тести
- Жодного `where` запиту без індексу
- Pagination через `startAfterDocument` для каталогу > 50 елементів
- Офлайн-кеш каталогу через Hive, синк раз на 24 години

## Localization
- Дві мови з першого дня: `en`, `uk`
- ARB-файли: `lib/l10n/app_en.arb`, `lib/l10n/app_uk.arb`
- Доступ через `context.l10n.keyName` (через extension)
- Жодних хардкодних рядків навіть у логах помилок користувача

## Testing
- **Unit-тести**: всі repositories, services, use_cases (якщо є), provider notifiers
- **Widget-тести**: всі screens (мінімум happy path + 1 error case)
- **Integration-тести**: критичні флоу — реєстрація, створення міксу, додавання в улюблені
- Mocktail для моків, fake_cloud_firestore для Firestore
- Coverage target: 70%+

## Code Style
- `dart format .` перед кожним комітом (line length 100)
- `flutter analyze` має давати 0 warnings
- Lints: `flutter_lints` + `very_good_analysis` (опційно)
- Імпорти сортовані: dart → flutter → package → relative

## Commands
- `flutter run` — запуск
- `flutter test` — всі тести
- `flutter test --coverage` — з coverage
- `flutter analyze` — лінтер
- `dart format .` — форматування
- `dart run build_runner build --delete-conflicting-outputs` — кодогенерація
- `dart run build_runner watch --delete-conflicting-outputs` — watch mode
- `flutter gen-l10n` — згенерувати локалізаційні класи

## Git Rules
- ✅ ЗАВЖДИ commit після кожної завершеної таски
- ❌ НІКОЛИ не роби push без явного дозволу від користувача
- Conventional Commits: `feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `chore:`
- Перед commit: `dart format . && flutter analyze && flutter test`
- Гілки: `feature/<task-id>-<short-name>`, `fix/<short-name>`

## Security Rules
- Жодних API-ключів у коді — тільки через `--dart-define` або `flavor`-конфіги
- Firebase config файли в `.gitignore` (для production)
- Усі токени через `flutter_secure_storage`
- Жодного PII у логах

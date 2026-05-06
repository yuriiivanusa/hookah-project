# Localization (L10N)

## Files
- `app_en.arb` — English (template, source of truth)
- `app_uk.arb` — Ukrainian

Generated files in `lib/l10n/` (do not edit manually):
- `app_localizations.dart`
- `app_localizations_en.dart`
- `app_localizations_uk.dart`

## Key naming convention

```
<feature>_<scope>_<element>
```

| Prefix | Feature |
|---|---|
| `general` | Shared across all screens |
| `auth` | Authentication flow |
| `catalog` | Tobacco catalog |
| `recommender` | Smart mix recommender |
| `builder` | Mix builder |
| `favorites` | Favorites screen |
| `history` | Mix history |
| `profile` | Profile & settings |
| `error` | Error states |

## Usage

```dart
// In any widget with BuildContext:
context.l10n.catalogTitle
context.l10n.authLoginButton
```

## Adding new keys

1. Add to `app_en.arb` first (template)
2. Add matching key to `app_uk.arb`
3. Run `flutter gen-l10n`
4. Never hardcode user-facing strings in widgets

## Pluralization

Use ICU message syntax in ARB:
```json
"itemCount": "{count, plural, =0{No items} =1{1 item} other{{count} items}}"
```

# Project Context — Handoff for Claude Code

> **READ THIS FIRST.** This document gives you full context to continue work on the Hookah Mix Master project. The user (Yurii) started planning this project in a different Claude session and is now switching to you for hands-on implementation via VS Code + Claude Code.

---

## 🎯 What we're building

**Hookah Mix Master** — a mobile app that helps users create custom hookah tobacco mixes. Two personas:

1. **The Connoisseur** — knows brands, wants to find specific tobaccos by flavor profile, builds custom 2-4 component mixes
2. **The Beginner** — doesn't know brands, wants ready recommendations: "something sweet and light" or "sour and strong"

Users save favorites, mix history, and rate combinations.

---

## 👤 About the user (Yurii)

- **Role:** Flutter Developer
- **Stack experience:** Flutter, Riverpod, Firebase
- **Working in:** VS Code on macOS (Python 3.9 currently — may need to upgrade to 3.11+ for Spec Kit CLI)
- **Language preference:** Ukrainian for explanations, English for code/comments
- **Approach style:** Wants to learn AI-augmented workflows (Spec Kit, skills, MCP). Prefers structured, step-by-step guidance.
- **Discipline level:** Aware of Spec Kit principles (one task at a time, commit after each, never push without permission)

---

## 📂 Repository structure (already exists)

```
~/hookah-project/
├── hookah-data-pipeline/        ← ETL scripts (separate Git repo if used)
│   ├── seed/
│   │   ├── hookah_seed_v1.json
│   │   ├── build_seed.py
│   │   ├── import_to_firestore.py
│   │   └── README.md
│   ├── venv/                    ← Python virtual env
│   ├── .gitignore
│   └── (serviceAccountKey.json moved to ~/.firebase-keys/)
│
└── hookah_mix_app/              ← Flutter project (primary work area)
    ├── CLAUDE.md                ← contains rules, conventions
    ├── PROJECT_CONTEXT.md       ← THIS FILE
    ├── .specify/                ← (will be created via specify init)
    ├── .claude/                 ← (will be created via specify init)
    └── lib/, ios/, android/, ...
```

---

## ✅ What's already done

### Data layer
- [x] Firebase project created (Android-only app registered, iOS not yet)
- [x] Cloud Firestore (Native mode) initialized
- [x] Service Account key generated, stored at `~/.firebase-keys/`
- [x] Seed dataset designed: 100 tobaccos, 8 brands, 10 curated mixes
- [x] **Pending verification:** seed data uploaded to Firestore via `import_to_firestore.py`
- [x] **Pending verification:** Firestore Security Rules configured

### Planning artifacts
- [x] `CLAUDE.md` written — defines Riverpod 2.x, go_router, Firebase stack, naming conventions, code style
- [x] Detailed prompts prepared for: `/speckit.constitution`, `/speckit.specify`, `/speckit.clarify`, `/speckit.plan`
- [x] Architecture decisions made: Feature-First + light Clean Architecture, Riverpod with code-gen, Hive for offline, freezed for models

### Not yet done
- [ ] Spec Kit not yet initialized in `hookah_mix_app/`
- [ ] No `/speckit.*` commands run yet
- [ ] Flutter + Firebase not yet wired (no `firebase_options.dart`, no FlutterFire CLI run)
- [ ] No code written yet

---

## 🛠️ Tech stack (locked decisions)

```yaml
flutter: 3.x stable
dart: 3.x
state_management: Riverpod 2.x with @riverpod code generation (no Provider/Bloc/GetX)
routing: go_router with declarative auth guards
backend: Firebase (Auth, Firestore, Storage, Crashlytics, Analytics)
local_storage: Hive (catalog cache) + flutter_secure_storage (tokens)
DI: Riverpod providers (no get_it)
codegen: freezed, json_serializable, riverpod_generator, go_router_builder
testing: mocktail, fake_cloud_firestore, firebase_auth_mocks
linter: flutter_lints
i18n: intl + flutter_localizations (en, uk)
```

### Architecture: Feature-First + Light Clean Architecture
```
lib/
├── core/                  — theme, router, services, errors, extensions, shared widgets
├── features/<name>/
│   ├── data/             — datasources, dtos, repository_impl
│   ├── domain/           — entities (freezed), repository interface
│   └── presentation/     — providers, screens, widgets
├── l10n/                 — app_en.arb, app_uk.arb
└── main.dart
```

**Use cases policy:** Create only when (a) logic spans 2+ repositories, OR (b) complex business logic needs isolated testing. Otherwise — repository called directly from provider.

---

## 📊 Firestore schema (already deployed in seed data)

### Collections

**`brands`** (8 docs, public-read for authenticated)
```typescript
{
  id: string,                       // "al_fakher"
  name: string,                     // "Al Fakher"
  country: string,                  // ISO "AE"
  countryName: { en, uk },
  leafType: "blonde" | "dark",
  foundedYear: number,
  description: { en, uk },
  popularity: number                // 0-100
}
```

**`tobaccos`** (100 docs, public-read for authenticated)
```typescript
{
  id: string,                       // "al_fakher__double_apple"
  brand: { id, name, country },
  name: { en, uk, original },
  leafType: "blonde" | "dark",
  strength: 1 | 2 | 3 | 4 | 5,      // 2 for blonde, 3-4 for dark
  flavorCategories: string[],       // for UI filters: ["fruity", "spice"]
  tasteNotes: string[],             // for smart matching: ["apple", "anise"]
  tasteProfile: {                   // 6 axes, 0-5 scale
    sweet: number,
    sour: number,
    fresh: number,                  // cooling/menthol
    spicy: number,
    bitter: number,
    floral: number
  },
  description: { en, uk },
  imageUrl: string | null,
  popularity: number,               // 0-100
  availability: {
    ua: {
      available: boolean | null,
      shops: string[],
      lastChecked: string | null
    }
  },
  sources: [{ name, verified }],
  createdAt: ISO8601,
  updatedAt: ISO8601
}
```

**`curated_mixes`** (10 docs, public-read for authenticated)
```typescript
{
  id: string,
  name: { en, uk },
  components: [{ tobaccoId, percentage }],   // sum MUST = 100
  expectedProfile: {                          // 6 axes, computed average
    sweet, sour, fresh, spicy, bitter, floral
  },
  strengthLevel: 1-5,
  difficulty: "easy" | "medium" | "hard",
  description: { en, uk },
  targetPersona: "beginner" | "intermediate" | "expert",
  tags: string[],
  popularity: number,
  isCurated: true,
  authorId: null                              // null = official
}
```

**`users`** (per-user, owner-write only)
```typescript
{
  id: string,                       // matches uid
  email: string,
  displayName: string,
  photoUrl: string | null,
  preferredLanguage: "en" | "uk",
  preferredTheme: "dark" | "light" | "system",
  ageVerified: boolean,
  ageVerifiedAt: timestamp,
  createdAt: timestamp,
  updatedAt: timestamp
}
```

**`users/{userId}/favorites`** (subcollection)
```typescript
{
  id: string,
  type: "tobacco" | "mix",
  refId: string,
  addedAt: timestamp
}
```

**`mixes`** (UGC, currently empty — for user-created mixes)
```typescript
{
  id: string,
  userId: string,                   // owner
  name: string,
  description: string | null,
  components: [{ tobaccoId, percentage }],
  expectedFlavorTags: string[],
  strengthLevel: number,            // computed from components
  isFavorite: boolean,
  rating: number | null,            // 1-5
  notes: string | null,
  createdAt: timestamp,
  updatedAt: timestamp
}
```

---

## 🧮 Smart Recommender Algorithm

For "Beginner" users who select desired flavor preferences:

```
Input: user_profile = { sweet: 0-5, sour: 0-5, fresh: 0-5, spicy: 0-5, bitter: 0-5, floral: 0-5 }
       persona: "beginner" | "intermediate" | "expert"

For each curated_mix where targetPersona == persona:
    distance = Σ |user_profile[axis] - mix.expectedProfile[axis]|  for all 6 axes

Sort by distance ASC.
Return top 3-5 mixes.
```

Computation runs **client-side** — dataset is small (~10-50 curated mixes). No Cloud Functions needed for v1.

---

## 🚀 Platform Strategy

**Phase 1 (current MVP): Android-only**
- Target: Android API 26+ (Android 8.0)
- Auth: Email/Password + Google Sign In
- Distribution: Google Play (after MVP)

**Phase 2 (post-MVP): iOS**
- Target: iOS 14+
- Add: Apple Sign In (App Store requirement)
- Code should be cross-platform-friendly (no Android-only APIs unless absolutely needed)

**Phase 3 (future): UGC, social features, premium**

---

## 📋 Core Features (MVP scope)

1. **Authentication** — email/password, Google Sign In, password reset, email verification, age gate (18+), guest mode (limited), account deletion
2. **Tobacco Catalog** — list with filters (brand, country, leaf type, strength, flavor category), search, detail page, offline cache via Hive
3. **Smart Mix Recommender** — wizard for beginners (taste → strength → optional fruit → optional brand), returns 3-5 mixes
4. **Manual Mix Builder** — for connoisseurs, drag-and-drop up to 4 tobaccos, percentage adjustment (must sum 100), live preview of expected flavor
5. **Favorites & Mix History** — separate lists for tobaccos/mixes, sort/filter, share via deep link, JSON export
6. **Profile & Settings** — language (en/uk), theme (dark/light/system), notifications toggle, privacy (delete account, export data, opt-out analytics), about

**Out of Scope for MVP:**
- iOS version (Phase 2)
- Apple Sign In (Phase 2)
- UGC mixes for all users (private only in MVP)
- Social features (comments, likes, friends)
- Push notifications
- Premium subscription
- AR pack scanning
- UA-shop availability (`availability.ua` field) — will be filled via ETL pipeline in v1.1

---

## 🔒 Non-Negotiable Coding Standards

- ❌ NO `dynamic`, `setState`, `FutureBuilder`/`StreamBuilder`, `print`, hardcoded strings/colors/sizes
- ✅ ALWAYS use `const` constructors where possible
- ✅ ALWAYS use `AsyncValue` for async via Riverpod
- ✅ ALWAYS use `AppLocalizations.of(context)` (or `context.l10n`) for ALL user-visible strings
- ✅ ALWAYS use `Theme.of(context)` for colors/styles
- ✅ ALWAYS use freezed for immutable models
- ✅ ALWAYS handle nullability explicitly (no force unwrap `!` without explicit check)
- ✅ ALWAYS commit after each completed task with conventional commit message
- ❌ NEVER `git push` without explicit user permission

---

## 🎬 What to do next (Spec Kit workflow)

The user wants to follow the full Spec-Driven Development pipeline using GitHub's Spec Kit. **Steps in order:**

### Step 0: Verify environment
```bash
# In hookah_mix_app/ directory
flutter --version          # should show 3.x stable
flutter doctor             # should be all green for Android (iOS may have issues — that's OK)
specify --version          # if missing, install: uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

If `specify` requires Python 3.11+ and user has 3.9, suggest: `brew install python@3.12` then reinstall `specify`.

### Step 1: Initialize Spec Kit
```bash
cd ~/hookah-project/hookah_mix_app
specify init . --ai claude
```

This creates `.specify/` and `.claude/` directories.

### Step 2: Run /speckit.constitution
Use this prompt (customized for our project):

```
Create a constitution file for "Hookah Mix Master" — a hookah tobacco mixing helper mobile app.

NON-NEGOTIABLE TECHNICAL CONSTRAINTS:
- Flutter 3.x stable, Dart 3.x
- Phase 1 platform: Android-only (min API 26 / Android 8.0)
- Phase 2 platform: iOS 14+ (post-MVP, code should be cross-platform-friendly)
- State management: EXCLUSIVELY Riverpod 2.x with @riverpod code generation
- Routing: go_router with declarative auth guards
- Backend: Firebase (Auth, Firestore, Storage, Crashlytics, Analytics)
- Local storage: Hive for catalog cache + flutter_secure_storage for tokens
- Code generation mandatory: freezed for all models, json_serializable for DTOs

ARCHITECTURE:
- Feature-First: lib/features/<name>/{data, domain, presentation}
- Light Clean Architecture: use_cases ONLY when business logic is complex or spans 2+ repos
- Repository pattern for all external data sources
- DI via Riverpod (no get_it)

CODING STANDARDS (NON-NEGOTIABLE):
- FORBIDDEN: dynamic, setState, FutureBuilder/StreamBuilder, print, hardcoded strings/colors/sizes
- REQUIRED: const where possible, AsyncValue for async, AppLocalizations for all strings, Theme.of(context) for styles
- Null-safety explicit, no force unwrap without check
- 0 warnings policy with flutter_lints

UI/UX:
- Material 3 with custom theme
- Dark-first design (hookah lounge atmosphere) + light theme
- Localization from day one: English + Ukrainian
- Adaptive: small (compact phones) to tablets
- Accessibility: semantic labels, AA contrast, system font scaling support

PERFORMANCE:
- Cold start < 2 seconds on mid-range devices
- 60 FPS catalog scrolling
- Offline catalog browsing (24h Hive cache)
- Lazy loading for catalogs > 50 items

SECURITY:
- Firebase Security Rules for all collections (read/write rules)
- No API keys in code — use --dart-define or flavors
- Secure storage for auth tokens
- No PII (email, phone) in logs/analytics
- Age verification 18+ on registration (GDPR-friendly)

DATA & PRIVACY:
- Users can delete account with full data wipe
- Data export to JSON
- Offline-only mode for guests (no Firebase)
- Anonymized analytics, opt-out from settings

TESTING:
- Unit tests: all repositories, services, providers
- Widget tests: all screens (happy path + error case minimum)
- Integration tests: signup, create mix, add to favorites
- Coverage target: 70%+
- Tools: mocktail, fake_cloud_firestore

GIT & CI/CD:
- Conventional Commits required
- NEVER push without explicit user permission — only commit
- Pre-commit: format + analyze + test must pass
- Feature branches: feature/<task-id>-<name>

LEGAL/COMPLIANCE (tobacco app):
- Age gate 18+ on first launch
- Smoking harm disclaimer on splash screen
- Compliance with Google Play Guidelines for tobacco content
- No advertising/promotion of specific brands — informational catalog only
```

### Step 3: Run /speckit.specify
After constitution is generated and user reviews/corrects it, run with the spec prompt — adapted from the Features section above. Make sure to include:
- Two personas (Connoisseur, Beginner)
- All 6 core features with detailed acceptance criteria
- Edge cases (offline first launch, guest-to-account migration, account deletion cascade, version conflicts)
- Out of scope items

### Step 4: Run /speckit.clarify
Optional but strongly recommended. Ask the model to identify:
- Smart Recommender exact algorithm
- Mix percentage validation logic
- Offline registration handling
- Guest data migration to account
- Catalog version invalidation
- GDPR cascade delete

### Step 5: Run /speckit.plan
Use the architecture stack and project structure from this document. **CRITICAL:** the data models in plan.md MUST match the Firestore schema described above (collections: `tobaccos`, `curated_mixes`, `brands`, `users`, `mixes`, with the EXACT field names and `tasteProfile` 6-axis structure).

### Step 6: Run /speckit.tasks
Generate atomic tasks. Expect 200-500+ tasks across phases.

### Step 7: /speckit.implement (THE GOLDEN RULE)
**One task at a time. Commit after each. Never push without permission.**

Recommended phase order:
1. Project setup, dependencies, FlutterFire CLI, Hive init
2. Theme, design tokens, l10n skeleton, core widgets
3. Routing + auth guards
4. Auth feature (data + domain + screens)
5. Tobacco catalog
6. Mix builder
7. Smart recommender
8. Favorites + history
9. Profile + settings
10. Polishing, accessibility, error states
11. Integration tests

---

## ⚠️ Things to verify with user before starting

1. Has the seed data import to Firestore actually completed? (Check Firebase Console → Firestore → should see 8 brands, 100 tobaccos, 10 curated_mixes)
2. Are Security Rules deployed and matching the schema in this document?
3. Is FlutterFire CLI configured? (Check for `lib/firebase_options.dart`)
4. Is Python 3.11+ available for Spec Kit CLI?
5. Confirm: Android-first MVP, iOS in Phase 2 — correct understanding?

---

## 📚 Reference: How we got here

The user attended a workshop on AI-augmented development (March 2026) covering:
- **Skills:** MD files with patterns/templates that LLMs use
- **Agents:** autonomous execution mode
- **Rules:** formalized constraints
- **MCP (Model Context Protocol):** standardized integrations
- **Spec Kit:** GitHub's open-source SDD framework with 6-step pipeline

The user is following Spec Kit philosophy: discipline over speed, planning over coding, one task per commit.

Key principles emphasized:
1. Always Plan Mode first, then Agent Mode
2. Verify generated plan before execution
3. Implement one task at a time, commit after each
4. Never run all tasks at once (impossible to debug)
5. Skills must be opened and reviewed (not blindly trusted)
6. Constitution defines non-negotiables; everything downstream cites it

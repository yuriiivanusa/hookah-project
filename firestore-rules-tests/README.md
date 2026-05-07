# Firestore Security Rules Tests

## Requirements

- Node.js 18+
- Java 21+ (for Firebase Emulator Suite)
- Firebase CLI (`npm i -g firebase-tools`)

## Setup

```bash
npm install
```

## Running

Start the Firestore emulator in one terminal:

```bash
cd ../hookah_mix_app
firebase emulators:start --only firestore --project hookah-mix-master
```

Run tests in another terminal:

```bash
npm test
```

## What is tested

| Scenario | Expected |
|---|---|
| Unauthenticated read from `tobaccos`, `brands`, `metadata`, `mixes`, `curated_mixes` | DENY |
| Authenticated read from all public collections | ALLOW |
| Authenticated write to `tobaccos` | DENY |
| Owner reads/writes own `users/{uid}` doc | ALLOW |
| Other user reads/writes `users/{alice}` | DENY |
| Unauthenticated reads `users/{uid}` | DENY |
| Owner CRUD on `users/{uid}/favorites` | ALLOW |
| Other user CRUD on `users/{alice}/favorites` | DENY |
| Owner CRUD on `users/{uid}/mixes` | ALLOW |
| Other user CRUD on `users/{alice}/mixes` | DENY |
| Owner read on `users/{uid}/history` | ALLOW |
| Other user read on `users/{alice}/history` | DENY |

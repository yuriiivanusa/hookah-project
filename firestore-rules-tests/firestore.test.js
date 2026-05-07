/**
 * Firestore Security Rules tests.
 * Runs against the Firestore emulator: firebase emulators:start --only firestore
 */

const {
  initializeTestEnvironment,
  assertFails,
  assertSucceeds,
} = require('@firebase/rules-unit-testing');
const fs = require('fs');
const path = require('path');

const PROJECT_ID = 'hookah-mix-master';
const RULES_PATH = path.resolve(__dirname, '../hookah_mix_app/firestore.rules');

let testEnv;

beforeAll(async () => {
  testEnv = await initializeTestEnvironment({
    projectId: PROJECT_ID,
    firestore: {
      rules: fs.readFileSync(RULES_PATH, 'utf8'),
      host: '127.0.0.1',
      port: 8080,
    },
  });
});

afterAll(async () => {
  await testEnv.cleanup();
});

afterEach(async () => {
  await testEnv.clearFirestore();
});

// ─── Public catalog ─────────────────────────────────────────────────────────

describe('Public catalog — unauthenticated user', () => {
  const collections = ['tobaccos', 'brands', 'metadata', 'mixes', 'curated_mixes'];

  for (const col of collections) {
    test(`cannot read /${col}/{docId}`, async () => {
      const unauth = testEnv.unauthenticatedContext();
      await assertFails(unauth.firestore().collection(col).doc('doc1').get());
    });
  }
});

describe('Public catalog — authenticated user', () => {
  const collections = ['tobaccos', 'brands', 'metadata', 'mixes', 'curated_mixes'];

  for (const col of collections) {
    test(`can read /${col}/{docId}`, async () => {
      const alice = testEnv.authenticatedContext('alice');
      await assertSucceeds(alice.firestore().collection(col).doc('doc1').get());
    });
  }

  test('cannot write to /tobaccos', async () => {
    const alice = testEnv.authenticatedContext('alice');
    await assertFails(
      alice.firestore().collection('tobaccos').doc('t1').set({ name: 'Hack' }),
    );
  });
});

// ─── Per-user data ───────────────────────────────────────────────────────────

describe('/users/{userId} — own data', () => {
  test('owner can read own user doc', async () => {
    const alice = testEnv.authenticatedContext('alice');
    await assertSucceeds(alice.firestore().collection('users').doc('alice').get());
  });

  test('owner can write own user doc', async () => {
    const alice = testEnv.authenticatedContext('alice');
    await assertSucceeds(
      alice.firestore().collection('users').doc('alice').set({ displayName: 'Alice' }),
    );
  });

  test('other user cannot read foreign user doc', async () => {
    const bob = testEnv.authenticatedContext('bob');
    await assertFails(bob.firestore().collection('users').doc('alice').get());
  });

  test('other user cannot write to foreign user doc', async () => {
    const bob = testEnv.authenticatedContext('bob');
    await assertFails(
      bob.firestore().collection('users').doc('alice').set({ displayName: 'Hacked' }),
    );
  });

  test('unauthenticated user cannot read any user doc', async () => {
    const unauth = testEnv.unauthenticatedContext();
    await assertFails(unauth.firestore().collection('users').doc('alice').get());
  });
});

describe('/users/{userId}/favorites — own subcollection', () => {
  test('owner can read own favorites', async () => {
    const alice = testEnv.authenticatedContext('alice');
    await assertSucceeds(
      alice.firestore().collection('users').doc('alice').collection('favorites').doc('f1').get(),
    );
  });

  test('owner can write own favorites', async () => {
    const alice = testEnv.authenticatedContext('alice');
    await assertSucceeds(
      alice
        .firestore()
        .collection('users')
        .doc('alice')
        .collection('favorites')
        .doc('f1')
        .set({ tobaccoId: 't1' }),
    );
  });

  test('other user cannot read foreign favorites', async () => {
    const bob = testEnv.authenticatedContext('bob');
    await assertFails(
      bob.firestore().collection('users').doc('alice').collection('favorites').doc('f1').get(),
    );
  });

  test('other user cannot write to foreign favorites', async () => {
    const bob = testEnv.authenticatedContext('bob');
    await assertFails(
      bob
        .firestore()
        .collection('users')
        .doc('alice')
        .collection('favorites')
        .doc('f1')
        .set({ tobaccoId: 'stolen' }),
    );
  });
});

describe('/users/{userId}/mixes — own subcollection', () => {
  test('owner can read own mixes', async () => {
    const alice = testEnv.authenticatedContext('alice');
    await assertSucceeds(
      alice.firestore().collection('users').doc('alice').collection('mixes').doc('m1').get(),
    );
  });

  test('other user cannot read foreign mixes', async () => {
    const bob = testEnv.authenticatedContext('bob');
    await assertFails(
      bob.firestore().collection('users').doc('alice').collection('mixes').doc('m1').get(),
    );
  });

  test('other user cannot write to foreign mixes', async () => {
    const bob = testEnv.authenticatedContext('bob');
    await assertFails(
      bob
        .firestore()
        .collection('users')
        .doc('alice')
        .collection('mixes')
        .doc('m1')
        .set({ name: 'Hacked mix' }),
    );
  });
});

describe('/users/{userId}/history — own subcollection', () => {
  test('owner can read own history', async () => {
    const alice = testEnv.authenticatedContext('alice');
    await assertSucceeds(
      alice.firestore().collection('users').doc('alice').collection('history').doc('h1').get(),
    );
  });

  test('other user cannot read foreign history', async () => {
    const bob = testEnv.authenticatedContext('bob');
    await assertFails(
      bob.firestore().collection('users').doc('alice').collection('history').doc('h1').get(),
    );
  });
});

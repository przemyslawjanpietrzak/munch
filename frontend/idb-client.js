import idb from 'idb';

export const idbFactory = storeKey => {  
  const dbPromise = idb.open(`${storeKey}-store`, 1, upgradeDB => {
    upgradeDB.createObjectStore(storeKey);
  });

  return {
    get(key) {
      return dbPromise.then(db => {
        return db.transaction(storeKey)
          .objectStore(storeKey).get(key);
      });
    },
    set(key, val) {
      return dbPromise.then(db => {
        const tx = db.transaction(storeKey, 'readwrite');
        tx.objectStore(storeKey).put(val, key);
        return tx.complete;
      });
    },
    delete(key) {
      return dbPromise.then(db => {
        const tx = db.transaction(storeKey, 'readwrite');
        tx.objectStore(storeKey).delete(key);
        return tx.complete;
      });
    },  
    clear() {
      return dbPromise.then(db => {
        const tx = db.transaction(storeKey, 're adwrite');
        tx.objectStore(storeKey).clear();
        return tx.complete;
      });
    },
    keys() {
      return dbPromise.then(db => {
        const tx = db.transaction(storeKey);
        const keys = [];
        const store = tx.objectStore(storeKey);

        (store.iterateKeyCursor || store.iterateCursor).call(store, cursor => {
          if (!cursor) return;
          keys.push(cursor.key);
          cursor.continue();
        });

        return tx.complete.then(() => keys);
      });
    }
  }
};

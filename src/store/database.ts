import { DBSchema, IDBPDatabase, openDB } from 'idb';
import { Game } from 'types';

export type AwaitedDatabase = Promise<IDBPDatabase<CachedGameStore>>;

export const openDatabase = async (): AwaitedDatabase => {
    return await openDB<CachedGameStore>('better-steam-achievements', 1, {
        upgrade: (db: IDBPDatabase<CachedGameStore>) => {
            db.createObjectStore('cached-games');
            db.createObjectStore('credentials');
        }
    });
}

interface CachedGameStore extends DBSchema {
    'cached-games': {
        key: string;
        value: Game;
    },
    'credentials': {
        key: string;
        value: string;
    }
}
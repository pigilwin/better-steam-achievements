import { configureStore } from '@reduxjs/toolkit';
import { rootReducer } from './rootReducer';
import { AwaitedDatabase, openDatabase } from './database';
import { useDispatch } from 'react-redux';

export const initialiseStore = () => {
    return configureStore({
        reducer: rootReducer,
        devTools: process.env.NODE_ENV === 'development',
        middleware: getDefaultMiddleware => getDefaultMiddleware({
            thunk: {
                extraArgument: async () => {
                    return openDatabase();
                }
            }
        })
    });
}

export type DatabaseFetcher = () => AwaitedDatabase;

export const store = initialiseStore();

export type AppDispatch = typeof store.dispatch;
export const useAppDispatch: () => AppDispatch = useDispatch;
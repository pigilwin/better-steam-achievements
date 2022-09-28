import { configureStore, Action, ThunkAction } from '@reduxjs/toolkit';
import { rootReducer, RootState } from './rootReducer';
import { openDatabase } from './database';

export const initialiseStore = () => {
    return configureStore({
        reducer: rootReducer,
        devTools: process.env.NODE_ENV === 'development',
        middleware: getDefaultMiddleware => getDefaultMiddleware({
            thunk: {
                extraArgument: openDatabase()
            }
        })
    });
}

export const store = initialiseStore();

export type AppDispatch = typeof store.dispatch;
export type AppThunk = ThunkAction<void, RootState, null, Action<string>>;
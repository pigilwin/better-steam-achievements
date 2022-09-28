import { combineReducers } from '@reduxjs/toolkit';

import { reducer as gamesReducer } from './gameSlice/gameSlice';

export const rootReducer = combineReducers({
    gamesReducer
});
export type RootState = ReturnType<typeof rootReducer>;
export type RootStateHook = () => RootState;
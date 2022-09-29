import { combineReducers } from '@reduxjs/toolkit';

import { reducer as gamesReducer } from './gameSlice/gameSlice';
import { reducer as configurationReducer } from './configurationSlice/configurationSlice';

export const rootReducer = combineReducers({
    gamesReducer,
    configurationReducer
});
export type RootState = ReturnType<typeof rootReducer>;
export type RootStateHook = () => RootState;
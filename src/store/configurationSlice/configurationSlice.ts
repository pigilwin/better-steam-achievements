import { createAsyncThunk, createSlice, PayloadAction } from "@reduxjs/toolkit";
import { DatabaseFetcher } from "store";
import { RootState } from "store/rootReducer";

interface Config {
    steamApiKey: string;
    steamApiUserId: string;
}

interface Configuration extends Config {
    loaded: boolean;
}

export const loadConfigFromDatabase = createAsyncThunk('configuration/loadConfig', async (
    _: undefined,
    config 
) => {
    const database = await (config.extra as DatabaseFetcher)();
    const credentials = await database.getAll('credentials');
    console.log(credentials);
    config.dispatch(loadConfig({
        steamApiKey: '',
        steamApiUserId: ''
    }));
});

export const initialState: Configuration =  {
    steamApiKey: '',
    steamApiUserId: '',
    loaded: false
};
const achievementsSlice = createSlice({
    name: 'files',
    initialState,
    reducers: {
        loadConfig: (state: Configuration, action: PayloadAction<Config>) => {
            state.loaded = true;
            return state;
        }
    }
});

export const reducer = achievementsSlice.reducer;
export const {
    loadConfig
} = achievementsSlice.actions;

export const hasCredentialsAttempedToBeLoadedSelector = (state: RootState): boolean => state.configurationReducer.loaded;
export const doWeHaveCredentialsSelector = (state: RootState): boolean => {
    const reducer = state.configurationReducer;
    return reducer.steamApiKey.length > 0 && reducer.steamApiUserId.length > 0;
};
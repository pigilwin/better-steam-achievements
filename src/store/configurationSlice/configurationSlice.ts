import { createAsyncThunk, createSlice, PayloadAction } from "@reduxjs/toolkit";
import { DatabaseFetcher } from "store";
import { RootState } from "store/rootReducer";

interface Config {
    steamApiKey: string;
    steamUserId: string;
}

interface Configuration extends Config {
    loaded: boolean;
}

export const loadConfigFromDatabase = createAsyncThunk('configuration/loadConfig', async (
    _: undefined,
    config 
) => {
    const database = await (config.extra as DatabaseFetcher)();
    const transaction = database.transaction('credentials');
    const store = transaction.objectStore('credentials');
    const credentials = await store.getAll();
    await transaction.done;
    config.dispatch(loadConfig({
        steamApiKey: credentials[0],
        steamUserId: credentials[1]
    }));
});

export const saveConfigToDatabase = createAsyncThunk('configuration/saveConfig', async (
    data: Config,
    config
) => {
    const database = await (config.extra as DatabaseFetcher)();
    const transaction = database.transaction('credentials', 'readwrite');
    const store = transaction.objectStore('credentials');
    await store.put(data.steamApiKey, 'steamApiKey');
    await store.put(data.steamUserId, 'steamUserId');
    await transaction.done;

    config.dispatch(loadConfig(data));
});

export const initialState: Configuration =  {
    steamApiKey: '',
    steamUserId: '',
    loaded: false
};
const configurationSlice = createSlice({
    name: 'configuration',
    initialState,
    reducers: {
        loadConfig: (state: Configuration, action: PayloadAction<Config>) => {
            state.steamApiKey = action.payload.steamApiKey;
            state.steamUserId = action.payload.steamUserId;
            state.loaded = true;
            return state;
        }
    }
});

export const reducer = configurationSlice.reducer;
export const {
    loadConfig
} = configurationSlice.actions;

export const hasCredentialsAttempedToBeLoadedSelector = (state: RootState): boolean => state.configurationReducer.loaded;
export const doWeHaveCredentialsSelector = (state: RootState): boolean => {
    const reducer = state.configurationReducer;
    return reducer.steamApiKey.length > 0 && reducer.steamUserId.length > 0;
};
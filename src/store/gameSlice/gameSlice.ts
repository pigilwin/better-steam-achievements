import { createAsyncThunk, createSlice, PayloadAction } from "@reduxjs/toolkit";
import { DatabaseFetcher } from "store";
import { RootState } from "store/rootReducer";
import { Games } from "types";

interface LoadedGames {
    games: Games
}


export const loadDataFromDatabase = createAsyncThunk('games/loadGames', async (
    _: undefined,
    config 
) => {
    const database = await (config.extra as DatabaseFetcher)();
    const games = await database.getAll('cached-games');
    config.dispatch(loadData(games));
});

export const initialState: LoadedGames =  {
    games: []
};
const achievementsSlice = createSlice({
    name: 'files',
    initialState,
    reducers: {
        loadData: (state: LoadedGames, action: PayloadAction<Games>) => {
            state.games = Array.from(action.payload);
            return state;
        }
    }
});

export const reducer = achievementsSlice.reducer;
export const {
    loadData
} = achievementsSlice.actions;

export const doWeHaveGamesSelector = (state: RootState) => state.gamesReducer.games.length > 0;  
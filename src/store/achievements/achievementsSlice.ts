import { createSlice } from "@reduxjs/toolkit";

interface Foo {

}

export const initialState: Foo =  {
    files: null,
    viewing: ''
};

const achievementsSlice = createSlice({
    name: 'files',
    initialState,
    reducers: {
        
    }
});

export const reducer = achievementsSlice.reducer;
export const {} = achievementsSlice.actions;
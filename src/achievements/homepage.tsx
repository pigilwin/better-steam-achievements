import { useEffect } from "react";
import { useAppDispatch } from "store";
import { loadDataFromDatabase } from "store/gameSlice/gameSlice";

export const Homepage = (): JSX.Element => {

    const dispatch = useAppDispatch();

    useEffect(() => {
        dispatch(loadDataFromDatabase());
    },[dispatch]);

    return (
        <div></div>
    );
}
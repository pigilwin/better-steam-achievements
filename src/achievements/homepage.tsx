import { useEffect } from "react";
import { useSelector } from "react-redux";
import { useNavigate } from "react-router-dom";
import { useAppDispatch } from "store";
import { hasCredentialsAttempedToBeLoaded, loadConfigFromDatabase } from "store/configurationSlice/configurationSlice";
import { loadDataFromDatabase } from "store/gameSlice/gameSlice";

export const Homepage = (): null | JSX.Element => {

    const dispatch = useAppDispatch();
    const credentialsAttempedToBeLoaded = useSelector(hasCredentialsAttempedToBeLoaded);
    const navigate = useNavigate();

    useEffect(() => {
        dispatch(loadDataFromDatabase());
        dispatch(loadConfigFromDatabase());
    }, [dispatch]);

    if (credentialsAttempedToBeLoaded) {
        navigate('/preferences');
        return null;
    }

    return (
        <div></div>
    );
}
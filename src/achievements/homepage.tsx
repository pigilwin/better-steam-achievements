import { useEffect } from "react";
import { useSelector } from "react-redux";
import { useNavigate } from "react-router-dom";
import { useAppDispatch } from "store";
import { doWeHaveCredentialsSelector, hasCredentialsAttempedToBeLoadedSelector, loadConfigFromDatabase } from "store/configurationSlice/configurationSlice";
import { loadDataFromDatabase } from "store/gameSlice/gameSlice";

export const Homepage = (): null | JSX.Element => {

    const dispatch = useAppDispatch();
    const credentialsAttempedToBeLoaded = useSelector(hasCredentialsAttempedToBeLoadedSelector);
    const weHaveCredentials = useSelector(doWeHaveCredentialsSelector);
    const navigate = useNavigate();

    useEffect(() => {
        dispatch(loadDataFromDatabase());
        dispatch(loadConfigFromDatabase());
    }, [dispatch]);

    useEffect(() => {
        if (credentialsAttempedToBeLoaded && !weHaveCredentials) {
            navigate('/preferences', {
                replace: true
            });
        }
    }, [credentialsAttempedToBeLoaded, weHaveCredentials]);

    return (
        <div></div>
    );
}
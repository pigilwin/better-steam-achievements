import { a, config, useSpring } from "@react-spring/web";
import { ChangeEvent, useState } from "react";
import { useNavigate } from "react-router-dom";
import { useAppDispatch } from "store";
import { saveConfigToDatabase } from "store/configurationSlice/configurationSlice";
import { StyledButton } from "./components/button";
import { Input } from "./components/Input";

export const Preferences = (): JSX.Element => {

    const [steamApiKey, setSteamApiKey] = useState('');
    const [steamUserId, setSteamUserId] = useState('');
    const navigate = useNavigate();
    const dispatch = useAppDispatch();

    const [styles] = useSpring({
        config: {
            ...config.stiff
        },
        from: {
            opacity: 0,
            transform: 'scale(1.0)'
        },
        to: async (next, cancel) => {
            await next({
                opacity: 1,
                transform: `scale(1.1)`
            });
            await next({
                opacity: 1,
                transform: `scale(1.0)`
            });
        },
    }, []);

    const onSteamApiKeyChanged = (e: ChangeEvent<HTMLInputElement>) => {
        setSteamApiKey(e.currentTarget.value);
    };
    const onSteamUserIdChanged = (e: ChangeEvent<HTMLInputElement>) => {
        let id = e.currentTarget.value;
        const regex = /https:\/\/steamcommunity\.com\/profiles\/([0-9]+)\//gm;
        const matchedParts = [...id.matchAll(regex) || []];
        if (matchedParts.length > 0) {
            /**
             * Set the id of the group found within the url
             */
            id = matchedParts[0][1];
        }
        setSteamUserId(id);
    }
    const savePreferencesListener = async () => {
        const result = await dispatch(saveConfigToDatabase({
            steamApiKey,
            steamUserId
        }));
        if (result.meta.requestStatus === 'fulfilled') {
            navigate('/', {
                replace: true
            });
        }
    };

    return (
        <div className="min-h-screen">
            <a.div style={styles} className="flex justify-center items-center flex-col p-10 gap-6">
                <h1 className="text-center text-6xl">Configuration is required for this to work</h1>
                <p>To find you steam user id, open your steam profile, copy the page url and paste it in the input below</p>
                <Input onChangeHandler={onSteamUserIdChanged} placeholder="Steam User Id" />
                <p>You can apply for an API key using <a className="text-blue-300" rel="noreferrer" target="_blank" href="https://steamcommunity.com/dev/apikey">this</a> link</p>
                <Input onChangeHandler={onSteamApiKeyChanged} placeholder="Steam API Key" />
                <StyledButton buttonText="Save Preferences" onClick={savePreferencesListener} />
            </a.div>
        </div>
    );
};
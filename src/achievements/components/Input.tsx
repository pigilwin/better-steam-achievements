import { ChangeEventHandler } from "react";

interface InputProps {
    placeholder: string;
    onChangeHandler: ChangeEventHandler<HTMLInputElement>;
}
export const Input = ({ placeholder, onChangeHandler }: InputProps): JSX.Element => {
    return (
        <input
            type="text"
            onChange={onChangeHandler}
            placeholder={placeholder}
            className="text-sm sm:text-base relative w-full border rounded placeholder-gray-400 focus:border-indigo-400 focus:outline-none py-2 p-2" />
    );
}
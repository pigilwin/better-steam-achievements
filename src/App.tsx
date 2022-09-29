import {
  BrowserRouter,
  Route,
  Routes
} from 'react-router-dom';

import { Homepage } from './achievements/homepage';
import { Preferences } from 'achievements/preferences';

export const App = (): JSX.Element => {
  return (
    <main className="font-sans antialiased leading-normal tracking-wider bg-gray-100 dark:bg-gray-700 dark:text-white min-h-screen">
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Homepage />} />
          <Route path="/preferences" element={<Preferences />} />
        </Routes>
      </BrowserRouter>
    </main>
  );
}
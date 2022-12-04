import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import ThemeProvider from './ThemeProvider';
import {BrowserRouter, Route, Routes} from 'react-router-dom';
import Deploy from './pages/Deploy';
import Poll from './pages/Poll';
import PollNew from './pages/PollNew';
import NotFound from './pages/NotFound';
ReactDOM.render(
  <ThemeProvider>
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<App />}>
          <Route path="/" element={<Poll />} />
          <Route path="/new" element={<PollNew />} />
          <Route path="/deploy" element={<Deploy />} />
          <Route path="/*" element={<NotFound />} />
        </Route>
      </Routes>
    </BrowserRouter>
  </ThemeProvider>,
  document.getElementById('root'),
);

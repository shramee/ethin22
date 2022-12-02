import React from 'react'
import ReactDOM from 'react-dom'
import App from './App'
import ThemeProvider from './ThemeProvider'
import {BrowserRouter, Route, Routes} from "react-router-dom";
import Home from "./pages/Home";
import SignIn from "./pages/SignIn";
import SignUp from "./pages/SignUp";
import NotFound from "./pages/NotFound";

ReactDOM.render(
  <ThemeProvider>
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<App />}>
          <Route path="/" element={<Home />} />
          <Route path="/signin" element={<SignIn />} />
          <Route path="/signup" element={<SignUp />} />
          <Route path="/*" element={<NotFound />} />
        </Route>
      </Routes>
    </BrowserRouter>
  </ThemeProvider>,
  document.getElementById('root')
)

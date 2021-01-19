import React from 'react';
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link
} from 'react-router-dom';
import './App.css';
import Players from './components/Players';
import PlayersGroupedByTeam from './components/PlayersGroupedByTeam';

export default function AppRouter() {
  return (
    <Router>
      <div>
        <ul>
          <li>
            <Link to="/">Home</Link>
          </li>
          <li>
            <Link to="/grouped_by_team">Players Grouped by Team</Link>
          </li>
        </ul>

        <hr />

        {/*
          A <Switch> looks through all its children <Route>
          elements and renders the first one whose path
          matches the current URL. Use a <Switch> any time
          you have multiple routes, but you want only one
          of them to render at a time
        */}
        <Switch>
          <Route exact path="/">
            <Home />
          </Route>
          <Route path="/grouped_by_team">
            <GroupedByTeam />
          </Route>
        </Switch>
      </div>
    </Router>
  );
}

function Home() {
  return (
    <div className="App">
      <Players limit={30} />
    </div>
  );
}

function GroupedByTeam() {
  return (
    <div className="App">
      <PlayersGroupedByTeam limit={30} />
    </div>
  );
}

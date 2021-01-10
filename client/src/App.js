import React from 'react';
import './App.css';
import Players from './components/Players';

function App() {
  return (
    <div className="App">
      <Players limit={30} />
    </div>
  );
}

export default App;

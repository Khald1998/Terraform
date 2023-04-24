import React, { useState } from 'react';

function App() {
  const [word, setWord] = useState('Hello'); // State to store the word value
  const [buttonVal, setButtonVal] = useState('click me'); // State to store the word value

  const handleClick = () => {
    fetch('http://localhost:8080/data') // Make GET request to back-end
      .then(response => response.json()) // Parse the response as JSON
      .then(data => {setWord(data.word); setButtonVal(data.word);}) // Update word state with received value
      .catch(error => console.error(error)); // Handle any errors
  };

  return (
    <>
      <div className="text-center m-5">
        <p>{word}</p> 
        <button type="button" className="btn btn-primary" onClick={handleClick}>
          {buttonVal}
        </button>
      </div>
    </>
  );
}

export default App;

import React, { useState } from "react";
const url = import.meta.env.VITE_URL || 'http://localhost:8080';
console.log(url);
function App() {
  const [word, setWord] = useState("Hello"); // State to store the word value
  const [buttonVal, setButtonVal] = useState(""); // State to store the word value

  const handleClick = () => {
    fetch(`${url}/`) // Make GET request to back-end
      .then((response) => response.json()) // Parse the response as JSON
      .then((data) => {
        setWord(data.word);
        setButtonVal(data.word);
      }) // Update word state with received value
      .catch((error) => console.error(error)); // Handle any errors
  };

  return (
    <>
      <div className="text-center m-5">
        <h1>keep clicking for random strings</h1>
        <p>{word}</p>
        <button type="button" className="btn btn-primary" onClick={handleClick}>
          Click me {buttonVal}
        </button>
      </div>
    </>
  );
}

export default App;

const express = require("express");
const cors = require('cors');


const corsOptions = {
  origin: 'http://localhost:3000',
  credentials: true,
  optionSuccessStatus: 200
};

const port = 8080;

const app = express();
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.use(cors(corsOptions));


app.get('/data', async (req, res) => {
  const data = {
    word: 'xffing' // Replace with your desired value
  };
  res.json(data); // Send the JSON response with the data object
});

app.listen(port, () => {
  console.log(`Server is running on port: ${port}`);
});

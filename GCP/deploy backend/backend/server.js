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
  const randomString = Math.random().toString(36).substring(2, 15);
  const data = {
    word: randomString
  };
  res.json(data);
});

app.listen(port, () => {
  console.log(`Server is running on port: ${port}`);
});

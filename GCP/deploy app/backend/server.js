const express = require("express");

const port = 8080;

const app = express();
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

app.get('/', async (req, res) => {
  const randomString = Math.random().toString(36).substring(2, 15);
  const data = {
    word: randomString
  };
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.json(data);
});

app.listen(port, () => {
  console.log(`Server is running on port: ${port}`);
});

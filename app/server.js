const express = require("express");
const path = require("path");

const app = express();

app.get("/", (req, res) => {
  res.send("Hello World! This is Money");
});

const PORT = 8080;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

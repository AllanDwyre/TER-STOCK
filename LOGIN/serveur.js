var express = require('express');
var connection = require('./config/db.js');
var app = express();

app.use(function(req, res, next) {
  req.socket = connection
  next()
})

app.use(express.urlencoded());

const authRouter = require("./routes/routes");

app.use("/", authRouter);

let port = process.env.PORT || 3000;
app.listen(port, function () {
  return console.log("Seveur Login utlisateur en écoute dans le port " + port);
});
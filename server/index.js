const express = require("express");
const dotenv = require("dotenv");
const mongoose = require("mongoose");
const productRouter = require("./routes/product.router.js");
const cors = require("cors");

dotenv.config();
const app = express();

const PORT = process.env.PORT;
const MONGO_DB_URI = process.env.MONGODB_URI;

// Middleware
app.use(express.json());
app.use(
  cors({
    origin: "*",
    methods: ["GET", "POST", "PATCH", "DELETE"],
  })
);

app.use((req, res, next) => {
  console.log(req.method, " ", req.url, req.body);
  next();
});

app.get("/", (req, res) => {
  res.status(200).send({
    status: "active",
    date: new Date(),
    message: "Server is running...",
  });
});
app.use("/api/v1/products", productRouter);

app.use((err, req, res) => {
  console.error(err);
})

app.listen(PORT, () => {
  mongoose
    .connect(MONGO_DB_URI)
    .then(() => {
      console.log(
        `Server is running on http://localhost:${PORT} & MondoDB Connected...`
      );
    })
    .catch((err) => {
      console.error("Error: " + err.message);
    });
});

const express = require("express");
const { addProduct, getAllProduct, getProductById, updateProduct, deleteProduct } = require("../controllers/product.controller");


const productRouter = express.Router();

productRouter.post("/", addProduct);
productRouter.get("/", getAllProduct);
productRouter.get("/:id", getProductById);
productRouter.put("/:id", updateProduct);
productRouter.delete("/:id", deleteProduct);

module.exports = productRouter;


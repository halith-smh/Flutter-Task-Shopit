const Product = require("../models/product.model");

const addProduct = async (req, res) => {
  const data = req.body;
  try {
    const result = await Product.create(data);
    res
      .status(201)
      .send({ message: "product Created Successfully", product: result });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const getAllProduct = async (req, res) => {
  try {
    const products = await Product.find({});
    res.send({ products: products });
  } catch (error) {
    res.status(500).send("Error in get all products: " + error.message);
  }
};

const getProductById = async (req, res) => {
  const { id } = req.params;
  try {
    const product = await Product.findById(id);
    if (!product) {
      return res.status(404).send({ message: "product not found" });
    }
    res.status(200).send({ product: product });
  } catch (error) {
    res.status(500).send("Error in get a product by id: " + error.message);
  }
};

const updateProduct = async (req, res) => {
  const { id } = req.params;
  try {
    const findproduct = await Product.findById(id);
    if (!findproduct) {
      return res.status(404).send({ message: "product not found" });
    }
    const product = await Product.findByIdAndUpdate(id, req.body);
    const updatedproduct = await Product.findById(id);
    res
      .status(200)
      .send({ message: "product Updated", product: updatedproduct });
  } catch (error) {
    res.status(500).send("Error in update a product by id: " + error.message);
  }
};

const deleteProduct = async (req, res) => {
  const { id } = req.params;

  try {
    const findproduct = await Product.findById(id);
    if (!findproduct) {
      return res.status(404).send({ message: "product not found" });
    }
    const productDelete = await Product.deleteOne({ _id: id });
    res.status(200).send({ message: "product Deleted Successfully" });
  } catch (error) {
    res.status(500).send("Error in delete a product by id: " + error.message);
  }
};

module.exports = {
  addProduct,
  getAllProduct,
  getProductById,
  updateProduct,
  deleteProduct,
};

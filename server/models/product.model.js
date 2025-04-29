const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
    title: {
        type: String,
        required: [true, "Product title is required"]
    },
    price: {
        type: Number,
        required: [true, "Product price is required"]
    },
    description: {
        type: String,
        required: [true, "Product description is required"]
    },
    category: {
        type: String,
        required: [true, "Product category is required"]
    },
    image: {
        type: String,
        required: [true, "Product image URL is required"]
    },
    ratings: {
        type: Number,
        default: 0
    }
}, { timestamps: true });

const Product = mongoose.model("products", productSchema);

module.exports = Product;

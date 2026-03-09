const express = require("express");
const { readCollection } = require("../services/fileDb");
const { getSeedProducts } = require("../utils/seed");

const router = express.Router();
const PRODUCTS_FILE = "products.txt";

router.get("/", async (req, res, next) => {
  try {
    const products = await readCollection(PRODUCTS_FILE, getSeedProducts());
    const {
      search,
      category,
      brand,
      minPrice,
      maxPrice,
      sort,
      limit,
      page,
    } = req.query;

    let result = [...products];

    if (search) {
      const keyword = String(search).trim().toLowerCase();
      result = result.filter((item) => {
        return (
          item.name.toLowerCase().includes(keyword) ||
          item.brand.toLowerCase().includes(keyword) ||
          item.description.toLowerCase().includes(keyword)
        );
      });
    }

    if (category) {
      const value = String(category).trim().toLowerCase();
      result = result.filter((item) => item.category.toLowerCase() === value);
    }

    if (brand) {
      const value = String(brand).trim().toLowerCase();
      result = result.filter((item) => item.brand.toLowerCase() === value);
    }

    if (minPrice) {
      result = result.filter((item) => item.price >= Number(minPrice));
    }

    if (maxPrice) {
      result = result.filter((item) => item.price <= Number(maxPrice));
    }

    if (sort === "price_asc") {
      result.sort((a, b) => a.price - b.price);
    }

    if (sort === "price_desc") {
      result.sort((a, b) => b.price - a.price);
    }

    const numericPage = Math.max(1, Number(page) || 1);
    const numericLimit = Math.max(1, Number(limit) || result.length || 1);
    const startIndex = (numericPage - 1) * numericLimit;
    const paged = result.slice(startIndex, startIndex + numericLimit);

    res.json({
      total: result.length,
      page: numericPage,
      limit: numericLimit,
      products: paged,
    });
  } catch (error) {
    next(error);
  }
});

router.get("/:id", async (req, res, next) => {
  try {
    const products = await readCollection(PRODUCTS_FILE, getSeedProducts());
    const product = products.find((item) => item.id === req.params.id);

    if (!product) {
      return res.status(404).json({ message: "Product not found" });
    }

    res.json({ product });
  } catch (error) {
    next(error);
  }
});

module.exports = router;

const express = require("express");
const crypto = require("crypto");
const { readCollection, writeCollection } = require("../services/fileDb");
const { hashPassword, verifyPassword } = require("../utils/hash");
const { createSession, deleteSession } = require("../services/tokenService");
const { authMiddleware } = require("../middleware/authMiddleware");

const router = express.Router();
const USERS_FILE = "users.txt";

function sanitizeUser(user) {
  return {
    id: user.id,
    fullName: user.fullName,
    email: user.email,
    phone: user.phone || "",
    avatarUrl: user.avatarUrl || "",
    createdAt: user.createdAt,
    updatedAt: user.updatedAt,
  };
}

router.post("/register", async (req, res, next) => {
  try {
    const { fullName, email, password, phone } = req.body || {};

    if (!fullName || !email || !password) {
      return res.status(400).json({
        message: "fullName, email and password are required",
      });
    }

    const users = await readCollection(USERS_FILE, []);
    const normalizedEmail = String(email).trim().toLowerCase();
    const existing = users.find((user) => user.email === normalizedEmail);

    if (existing) {
      return res.status(409).json({ message: "Email already registered" });
    }

    const now = new Date().toISOString();
    const user = {
      id: crypto.randomUUID(),
      fullName: String(fullName).trim(),
      email: normalizedEmail,
      passwordHash: hashPassword(String(password)),
      phone: phone ? String(phone).trim() : "",
      avatarUrl: "",
      createdAt: now,
      updatedAt: now,
    };

    users.push(user);
    await writeCollection(USERS_FILE, users);

    const token = await createSession(user.id);

    res.status(201).json({
      message: "Registration successful",
      token,
      user: sanitizeUser(user),
    });
  } catch (error) {
    next(error);
  }
});

router.post("/login", async (req, res, next) => {
  try {
    const { email, password } = req.body || {};

    if (!email || !password) {
      return res.status(400).json({ message: "email and password are required" });
    }

    const users = await readCollection(USERS_FILE, []);
    const normalizedEmail = String(email).trim().toLowerCase();
    const user = users.find((item) => item.email === normalizedEmail);

    if (!user || !verifyPassword(String(password), user.passwordHash)) {
      return res.status(401).json({ message: "Invalid email or password" });
    }

    const token = await createSession(user.id);

    res.json({
      message: "Login successful",
      token,
      user: sanitizeUser(user),
    });
  } catch (error) {
    next(error);
  }
});

router.get("/me", authMiddleware, async (req, res) => {
  res.json({ user: sanitizeUser(req.user) });
});

router.post("/logout", authMiddleware, async (req, res, next) => {
  try {
    await deleteSession(req.authToken);
    res.json({ message: "Logout successful" });
  } catch (error) {
    next(error);
  }
});

module.exports = router;

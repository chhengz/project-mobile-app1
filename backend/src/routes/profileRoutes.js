const express = require("express");
const { authMiddleware } = require("../middleware/authMiddleware");
const { readCollection, writeCollection } = require("../services/fileDb");

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

router.get("/", authMiddleware, async (req, res) => {
  res.json({ profile: sanitizeUser(req.user) });
});

router.put("/", authMiddleware, async (req, res, next) => {
  try {
    const { fullName, phone, avatarUrl } = req.body || {};

    if (!fullName) {
      return res.status(400).json({ message: "fullName is required" });
    }

    const users = await readCollection(USERS_FILE, []);
    const index = users.findIndex((item) => item.id === req.user.id);

    if (index < 0) {
      return res.status(404).json({ message: "User not found" });
    }

    const updatedUser = {
      ...users[index],
      fullName: String(fullName).trim(),
      phone: phone ? String(phone).trim() : "",
      avatarUrl: avatarUrl ? String(avatarUrl).trim() : users[index].avatarUrl || "",
      updatedAt: new Date().toISOString(),
    };

    users[index] = updatedUser;
    await writeCollection(USERS_FILE, users);

    res.json({
      message: "Profile updated",
      profile: sanitizeUser(updatedUser),
    });
  } catch (error) {
    next(error);
  }
});

module.exports = router;

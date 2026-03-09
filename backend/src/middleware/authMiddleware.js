const { findSession } = require("../services/tokenService");
const { readCollection } = require("../services/fileDb");

async function authMiddleware(req, res, next) {
  try {
    const authHeader = req.headers.authorization || "";
    const token = authHeader.startsWith("Bearer ")
      ? authHeader.slice(7)
      : null;

    if (!token) {
      return res.status(401).json({ message: "Missing auth token" });
    }

    const session = await findSession(token);
    if (!session) {
      return res.status(401).json({ message: "Invalid or expired token" });
    }

    const users = await readCollection("users.txt", []);
    const user = users.find((item) => item.id === session.userId);

    if (!user) {
      return res.status(401).json({ message: "User not found" });
    }

    req.authToken = token;
    req.user = user;
    next();
  } catch (error) {
    next(error);
  }
}

module.exports = {
  authMiddleware,
};

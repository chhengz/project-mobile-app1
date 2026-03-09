const crypto = require("crypto");

function hashPassword(password, salt = crypto.randomBytes(16).toString("hex")) {
  const iterations = 100000;
  const keyLength = 64;
  const digest = "sha512";
  const hash = crypto
    .pbkdf2Sync(password, salt, iterations, keyLength, digest)
    .toString("hex");

  return `${salt}:${hash}`;
}

function verifyPassword(password, storedHash) {
  if (!storedHash || typeof storedHash !== "string" || !storedHash.includes(":")) {
    return false;
  }

  const [salt, originalHash] = storedHash.split(":");
  const hashedAttempt = hashPassword(password, salt).split(":")[1];
  return crypto.timingSafeEqual(Buffer.from(originalHash), Buffer.from(hashedAttempt));
}

module.exports = {
  hashPassword,
  verifyPassword,
};

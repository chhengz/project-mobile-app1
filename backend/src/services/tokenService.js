const crypto = require("crypto");
const { readCollection, writeCollection } = require("./fileDb");

const SESSIONS_FILE = "sessions.txt";

function createToken() {
  return crypto.randomBytes(24).toString("hex");
}

async function createSession(userId) {
  const sessions = await readCollection(SESSIONS_FILE, []);
  const token = createToken();
  const now = new Date().toISOString();

  sessions.push({
    token,
    userId,
    createdAt: now,
  });

  await writeCollection(SESSIONS_FILE, sessions);
  return token;
}

async function findSession(token) {
  if (!token) {
    return null;
  }

  const sessions = await readCollection(SESSIONS_FILE, []);
  return sessions.find((session) => session.token === token) || null;
}

async function deleteSession(token) {
  const sessions = await readCollection(SESSIONS_FILE, []);
  const filtered = sessions.filter((session) => session.token !== token);
  await writeCollection(SESSIONS_FILE, filtered);
}

module.exports = {
  createSession,
  findSession,
  deleteSession,
};

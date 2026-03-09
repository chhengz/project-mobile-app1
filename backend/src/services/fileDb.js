const fs = require("fs/promises");
const path = require("path");

const dataDir = path.join(__dirname, "../../data");

function filePath(fileName) {
  return path.join(dataDir, fileName);
}

async function ensureFile(fileName, fallbackData = []) {
  const target = filePath(fileName);

  try {
    await fs.access(target);
  } catch {
    await fs.mkdir(dataDir, { recursive: true });
    await fs.writeFile(target, JSON.stringify(fallbackData, null, 2), "utf-8");
  }
}

async function readCollection(fileName, fallbackData = []) {
  await ensureFile(fileName, fallbackData);
  const raw = await fs.readFile(filePath(fileName), "utf-8");

  if (!raw.trim()) {
    return fallbackData;
  }

  try {
    return JSON.parse(raw);
  } catch {
    return fallbackData;
  }
}

async function writeCollection(fileName, data) {
  await ensureFile(fileName, []);
  await fs.writeFile(filePath(fileName), JSON.stringify(data, null, 2), "utf-8");
}

module.exports = {
  readCollection,
  writeCollection,
  ensureFile,
};

const app = require("./app");
const { ensureFile } = require("./services/fileDb");
const { getSeedProducts } = require("./utils/seed");

const PORT = process.env.PORT || 4000;

async function bootstrap() {
  await ensureFile("users.txt", []);
  await ensureFile("sessions.txt", []);
  await ensureFile("products.txt", getSeedProducts());

  app.listen(PORT, () => {
    console.log(`Backend running on http://localhost:${PORT}`);
  });
}

bootstrap().catch((error) => {
  console.error("Failed to start backend:", error);
  process.exit(1);
});

import http from "http";
import app from "./app.js";
import { initSocket } from "./websocket/socketServer.js";
import { expirationChecker } from "./utils/expiration__checker.js";
import pool from "./config/db.js";

const server = http.createServer(app);
const port = process.env.PORT || 3000;

const exp_checker = new expirationChecker(pool);

initSocket(server);

server.listen(port, () => {
  console.log(`Server is running at PORT: ${port}`);
  exp_checker.start();
});

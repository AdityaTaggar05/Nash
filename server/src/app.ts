import express, { Request, Response } from "express";
import authRoutes from "./modules/auth/auth.routes.js";
import betRoutes from "./modules/bets/bets.routes.js";
import groupRoutes from "./modules/groups/groups.routes.js";
import notificationRoutes from "./modules/notifications/notifications.routes.js";
import transactionRoutes from "./modules/transactions/transactions.routes.js";
import userRoutes from "./modules/users/users.routes.js";
import messageRoutes from "./modules/messages/message.routes.js";
import { pino } from "pino";

const app = express();

const logger = pino({
  level: process.env.LOG_LEVEL || "debug",
});

// Middleware initialisation
app.use(express.json());
app.use((req, res, next) => {
  logger.debug({
    method: req.method,
    path: req.path,
    query: req.query,
    body: req.body,
  });
  next();
});

app.get("/health", (_req: Request, res: Response) => {
  res.status(204).json({});
});

app.use("/auth", authRoutes);
app.use("/users", userRoutes);
app.use("/group", betRoutes);
app.use("/group", groupRoutes);
app.use("/group", messageRoutes);
app.use("/transaction", transactionRoutes);
app.use("/notification", notificationRoutes);

export default app;

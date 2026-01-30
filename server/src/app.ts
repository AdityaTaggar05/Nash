import express, { Request, Response } from "express";
//import authRoutes from "./modules/auth/auth.routes.js";
//import roomRoutes from "./modules/chat-room/chat-room.routes.js";

const app = express();

// Middleware initialisation
app.use(express.json());

app.get("/health", (_req: Request, res: Response) => {
  res.status(204).json({});
});

//app.use("/auth", authRoutes);
//app.use("/room", roomRoutes);

export default app;

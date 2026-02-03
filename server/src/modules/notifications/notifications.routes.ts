import { Router } from "express";
import { authenticate } from "../../middleware/auth.middleware.js";
import * as controller from "./notifications.controller.js";

const router = Router();

router.get("/user", authenticate, controller.getNotifications);

export default router;

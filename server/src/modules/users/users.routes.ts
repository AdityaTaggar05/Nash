import { Router } from "express";
import { authenticate } from "../../middleware/auth.middleware.js";
import * as userControllers from "./users.controller.js";

const router = Router();

router.get("/me", authenticate, userControllers.getUser);
router.get("/:user_id", authenticate, userControllers.getUser);
router.post("/check_in", authenticate, userControllers.dailyCheckIn);
router.get("/:user_id/groups", authenticate, userControllers.getGroups);

export default router;

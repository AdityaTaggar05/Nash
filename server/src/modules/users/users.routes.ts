import { Router } from "express";
import { authenticate } from "../../middleware/auth.middleware.js";
import * as userControllers from "./users.controller.js";

const router = Router();

router.post("/check_in", authenticate, userControllers.dailyCheckIn);
router.get("/groups", authenticate, userControllers.getGroups);
router.get("/placed_bets", authenticate, userControllers.getUserPlacedOpenBets);
router.get(
  "/created_bets",
  authenticate,
  userControllers.getUserCreatedOpenBets,
);
router.get("/me", authenticate, userControllers.getCurrentUser);
router.get("/:user_id", authenticate, userControllers.getUser);

export default router;

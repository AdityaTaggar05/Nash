import { Router } from "express";
import { authenticate } from "../../middleware/auth.middleware.js";
import * as userControllers from "./users.controller.js";

const router = Router();

<<<<<<< HEAD
router.post('/check_in', authenticate, userControllers.dailyCheckIn)
router.get('/groups', authenticate, userControllers.getGroups)
router.get('/placed_bets', authenticate, userControllers.getUserPlacedOpenBets)
router.get('/created_bets', authenticate, userControllers.getUserCreatedOpenBets)
router.get("/me", authenticate, userControllers.getCurrentUser);
router.get('/:user_id', authenticate, userControllers.getUser)
=======
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
>>>>>>> fc1232deeb972d68e778636a3518969be82fe9e1

export default router;

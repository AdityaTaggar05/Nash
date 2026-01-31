import {Router} from "express";
import * as betControllers from "./bets.controller.js";
import { authenticate } from "../../middleware/auth.middleware.js";

const router = Router();

// router.get('/:user_id', authenticate, betControllers.getUser)
// router.post('/check_in', authenticate, userControllers.dailyCheckIn)

router.get('/:group_id/bet/:bet_id', authenticate, betControllers.getBet)
router.get('/:group_id/bet', authenticate, betControllers.getAllBets)
router.post('/:group_id/bet', authenticate, betControllers.postBet)
router.post('/:group_id/bet/:bet_id', authenticate, betControllers.placeBet)

export default router;
import {Router} from "express";
import * as userControllers from "./users.controller.js";
import { authenticate } from "../../middleware/auth.middleware.js";

const router = Router();

router.get('/:user_id', authenticate, userControllers.getUser)
router.post('/check_in', authenticate, userControllers.dailyCheckIn)
router.get('/:user_id/groups', authenticate, userControllers.getGroups)

export default router;
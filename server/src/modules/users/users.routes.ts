import {Router} from "express";
import * as userControllers from "./users.controller.js";

const router = Router();

router.get('/:user_id',userControllers.getUser)
router.post('/check_in',userControllers.dailyCheckIn)

export default router;
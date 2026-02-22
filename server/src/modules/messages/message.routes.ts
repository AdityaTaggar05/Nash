import { Router } from "express";
import { authenticate } from "../../middleware/auth.middleware.js";
import * as controller from "./message.controller.js";

const router = Router();

router.get(
  "/:group_id/bet/:bet_id/messages",
  authenticate,
  controller.getMessages,
);

export default router;

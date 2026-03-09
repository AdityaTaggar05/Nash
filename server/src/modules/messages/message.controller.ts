import { Response } from "express";
import { AuthRequest } from "../../middleware/auth.middleware.js";
import * as messageService from "./message.service.js";

export const getMessages = async (req: AuthRequest, res: Response) => {
  try {
    const cursor = req.query.cursor
      ? new Date(req.query.cursor as string)
      : undefined;

    const result = await messageService.getMessages(
      req.user,
      req.params.group_id.toString(),
      req.params.bet_id.toString(),
      cursor,
    );
    res.status(201).json(result);
  } catch (err: any) {
    res.status(400).json({ error: err.message });
  }
};

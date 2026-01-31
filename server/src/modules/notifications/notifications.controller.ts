import { Request, Response } from "express";
import * as notificationService from "./notifications.service.js";
import { AuthRequest } from "../../middleware/auth.middleware.js";

export const getNotifications = async (req: AuthRequest, res: Response) => {
    try {
        const result = await notificationService.getNotifications(req.user);
        res.status(200).json(result);
    } catch (err: any) {
        res.status(400).json({ error: err.message });
    }
}
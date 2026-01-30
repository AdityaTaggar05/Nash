import { Request, Response } from "express";
import * as userServices from "./users.services.js";
import { AuthRequest } from "../../middleware/auth.middleware.js";

export const getUser = async (req: AuthRequest, res: Response) => {
    try {
        const result = await userServices.getUser(req.user, req.params.user_id as string);
        res.status(201).json(result);
    } catch (err: any) {
        res.status(404).json({error: err.message});
    }
}

export const dailyCheckIn = async (req: AuthRequest, res: Response) => {
    try {
        const result = await userServices.dailyCheckIn(req.user);
        res.status(201).json(result);
    } catch (err: any) {
        res.status(400).json({error: err.message});
    }
}
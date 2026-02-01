import { Response } from "express";
import { AuthRequest } from "../../middleware/auth.middleware.js";
import * as userServices from "./users.services.js";

export const getCurrentUser = async (req: AuthRequest, res: Response) => {
  try {
    const result = await userServices.getCurrentUser(req.user);
    res.status(201).json(result);
  } catch (err: any) {
    res.status(404).json({ error: err.message });
  }
};

export const getUser = async (req: AuthRequest, res: Response) => {
  try {
    const result = await userServices.getUser(req.user, req.body);
    res.status(201).json(result);
  } catch (err: any) {
    res.status(400).json({ error: err.message });
  }
};

export const dailyCheckIn = async (req: AuthRequest, res: Response) => {
  try {
    const result = await userServices.dailyCheckIn(req.user);
    res.status(201).json(result);
  } catch (err: any) {
    res.status(400).json({ error: err.message });
  }
};

export const getGroups = async (req: AuthRequest, res: Response) => {
  try {
    const result = await userServices.getGroups(req.user);
    res.status(201).json(result);
  } catch (err: any) {
    res.status(404).json({ error: err.message });
  }
};

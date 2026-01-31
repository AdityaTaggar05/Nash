import { Request, Response } from "express";
import * as betServices from "./bets.services.js";
import { AuthRequest } from "../../middleware/auth.middleware.js";

export const getBet = async (req: AuthRequest, res: Response) => {
    try {
        const result = await betServices.getBet(req.params.bet_id as string, req.user);
        res.status(201).json(result);
    } catch (err: any) {
        res.status(404).json({error: err.message})
    }
}

export const getAllBets = async (req: AuthRequest, res: Response) => {
    try {
        const result = await betServices.getAllBets(req.params.group_id as string);
        res.status(201).json(result);
    } catch (err: any) {
        res.status(404).json({error: err.message})
    }
}

export const postBet = async (req: AuthRequest, res: Response) => {
    try {
        const result = await betServices.postBet(req.user, req.params.group_id as string, req.body.title, req.body.expires_at)
        res.status(201).json(result)
    } catch (err: any) {
        res.status(400).json({error: err.message})
    }
}

export const placeBet = async (req: AuthRequest, res: Response) => {
    try {
        const result = await betServices.placeBet(req.user, req.params.bet_id as string, req.body.amount, req.body.option)
        res.status(201).json(result)
    } catch (err: any) {
        res.status(400).json({error: err.message})
    }
}
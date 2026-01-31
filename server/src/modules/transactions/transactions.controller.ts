import { Request, Response } from "express";
import { AuthRequest } from "../../middleware/auth.middleware.js";
import * as transactionService from "./transactions.service.js";

export const getBetTransactions = async (req: AuthRequest, res: Response) => {
    try {
        const result = await transactionService.getBetTransactions(req.params.bet_id.toString());
        res.status(200).json(result);
    } catch (err: any) {
        res.status(400).json({ error: err.message });
    }
}

export const getUserTransactions = async (req : AuthRequest,res:Response)=>{
    try{
        const result = await transactionService.getUserTransactions(req.user);
        res.status(200).json(result);
    } catch(err:any){
        res.status(400).json({error:err.message});
    }
}
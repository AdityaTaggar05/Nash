import pool from "../../config/db.js";
import { BetTransactionsResponseDTO } from "./dtos/bet-transactions.dto.js";
import { BetTransactions, BetTransaction, UserTransaction, UserTransactions } from "./transactions.model.js";

const mapRowToBetTransaction = (row: any): BetTransaction => {
    return {
        amount: row.amount,
        option: row.selected_option,
        placed_at: row.created_at,
        user_id: row.user_id
    }
}

const mapRowToUserTransaction = (row: any): UserTransaction => {
    return {
        amount: row.amount,
        placed_at: row.created_at,
        description: row.description,
        bet_id: row.bet_id,
    }
}

export const getBetTransactions = async (
    betId: string
): Promise<BetTransactions> => {
    const userBets = await pool.query(
        `SELECT *
        FROM user_bets
        WHERE bet_id = $1`,
        [betId]
    );
    const result = userBets.rows.map((row: any) => {
        mapRowToBetTransaction(row);
    })
    
    return { transactions: result };
}

export const getUserTransactions = async (
    userId: string
): Promise<UserTransactions> => {
    try {
        const userBets = pool.query(
            `SELECT *
            FROM transactions
            WHERE bet_id = $1`,
            [userId]
        );
        const result = userBets.rows.map((row: any) => {
            mapRowToUserTransaction(row);
        })
        return {
            transactions: result
        };
    } catch (err: any) {
        throw err;
    }
}

export const createTransaction = async (
    userId: string,
    amount: number,
    description: string,
    betId?: string,
): Promise<void> => {
    await pool.query(
        `INSERT INTO transactions (bet_id, user_id, amount, description)
        VALUES ($1, $2, $3, $4, $5)`,
        [betId, userId, amount, description]
    )
}
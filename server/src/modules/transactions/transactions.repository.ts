import pool from "../../config/db.js";
import { BetTransactions, BetTransaction, UserTransaction, UserTransactions } from "./transactions.model.js";

const mapRowToBetTransaction = (row: any): BetTransaction => {
    return {
        amount: row.amount,
        option: row.selected_option,
        placed_at: row.created_at,
        user_id: row.user_id,
        username: row.username
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
    betId?: string
): Promise<BetTransactions> => {
    try {
        const userBets =await pool.query(
            `SELECT *
            FROM user_bets
            JOIN users ON user_bets.user_id = users.id
            WHERE bet_id = $1`,
            [betId]
        );
        const result = userBets.rows.map((row: any) => {
            return mapRowToBetTransaction(row);
        })
        return { transactions: result };
    } catch (err: any) {
        throw err;
    }
}

export const getUserTransactions = async (
    userId: string
): Promise<UserTransactions> => {
    try {
        const userTransactions = await pool.query(
            `SELECT *
            FROM transactions
            WHERE user_id = $1`,
            [userId]
        );
        const result = userTransactions.rows.map((row: any) => {
            return mapRowToUserTransaction(row);
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
        VALUES ($1, $2, $3, $4)`,
        [betId, userId, amount, description]
    )
}
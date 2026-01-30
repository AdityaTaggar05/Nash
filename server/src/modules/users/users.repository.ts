import { th } from "zod/locales";
import pool from "../../config/db.js";
import { User } from "./users.model.js";

export const getUserFromDB = async (userId: string): Promise<User> => {
    const result = await pool.query('SELECT * FROM users WHERE id = $1', [userId]);
    if(result.rows.length === 0) {
        throw new Error('User not found');
    }
    else {
        return result.rows[0];
    }
}

export const performDailyCheckIn = async (userId: string): Promise<{status: string}> => {
    const client = await pool.connect();

    try {
        
        await client.query('BEGIN');

        const result = await client.query('SELECT * FROM auth WHERE user_id = $1', [userId]);
        const lastCheckIn = result.rows[0].last_login;
        const currentDate = new Date(Date.now());

        if(lastCheckIn !== currentDate) {
            await client.query('UPDATE users SET wallet_balance = wallet_balance + 100 WHERE id = $1',[userId]);
            await client.query('UPDATE auth SET last_login = $1 WHERE user_id = $2', [currentDate,userId]);
            await client.query('COMMIT');
            return {status: 'Check-in successful. 100 credits added to wallet.'};
        } else {
            throw new Error('User has already checked in today.');
        }

    } catch (err: any) {
        await client.query('ROLLBACK');
        throw err;
    } finally {
        client.release();
    }
}
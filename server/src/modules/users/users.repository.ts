import { PoolClient } from "pg";
import pool from "../../config/db.js";
import { User } from "./users.model.js";
import { Group, Member, GroupMember } from "../groups/groups.model.js";
import * as transactionRepository from "../transactions/transactions.repository.js";
const chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

const mapRowToUser = (row: any): User => {
  return {
    id: row.id,
    username: row.username,
    email: row.email,
    wallet_balance: row.wallet_balance,
    referral_code: row.referral_code,
    created_at: row.created_at,
  };
};

export const createUser = async (
  username: string,
  email: string,
  client: PoolClient,
): Promise<User> => {
  let referralCode = "";
  for (let i = 6; i > 0; --i) {
    referralCode += chars[Math.floor(Math.random() * chars.length)];
  }

  const result = await client.query(
    `INSERT INTO users (username, email, referral_code)
	VALUES ($1, $2, $3)
	RETURNING *`,
    [username, email, referralCode],
  );

  return mapRowToUser(result.rows[0]);
};

export const findUserByEmail = async (email: string) => {
  const result = await pool.query(
    `SELECT *
	FROM users
	WHERE email=$1`,
    [email],
  );

  if (!result.rows[0]) return null;

  return mapRowToUser(result.rows[0]);
};

export const getUserFromDB = async (userId: string): Promise<User> => {
  const result = await pool.query(`SELECT * FROM users WHERE id = $1`, [
    userId,
  ]);

  if (result.rows.length === 0) throw new Error("User not found");

  return mapRowToUser(result.rows[0]);
};

export const getGroupMembers = async (userId: string): Promise<GroupMember[]> => {
  const result = await pool.query(`SELECT * FROM group_members WHERE user_id=$1`,[userId])
  return result.rows
}

export const getGroups = async (groupIds: string[]): Promise<Group[]> => {
  const result = await pool.query(`SELECT * FROM groups WHERE id=ANY($1)`,[groupIds])
  return result.rows
}

export const performDailyCheckIn = async (
  userId: string,
): Promise<{ status: string }> => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const result = await client.query("SELECT * FROM auth WHERE user_id = $1", [
      userId,
    ]);
    const lastCheckIn_date = result.rows[0].last_login.getDate();
    const lastCheckIn_month = result.rows[0].last_login.getMonth();
    const lastCheckIn_year = result.rows[0].last_login.getFullYear();
    const currentDate_date = new Date(Date.now()).getDate();
    const currentDate_month = new Date(Date.now()).getMonth();
    const currentDate_year = new Date(Date.now()).getFullYear();

    if (lastCheckIn_date !== currentDate_date ||
        lastCheckIn_month !== currentDate_month ||
        lastCheckIn_year !== currentDate_year) {
      const currentDate = new Date(Date.now());
      await client.query(
        "UPDATE users SET wallet_balance = wallet_balance + 100 WHERE id = $1",
        [userId],
      );
      await client.query("UPDATE auth SET last_login = $1 WHERE user_id = $2", [
        currentDate,
        userId,
      ]);
      await client.query("COMMIT");
      await transactionRepository.createTransaction(userId, 100, "Daily Check-in Reward", null);
      return { status: "Check-in successful. 100 credits added to wallet." };
    } else {
      throw new Error("User has already checked in today.");
    }
  } catch (err: any) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
};

export const updateUserWalletBalance = async (
  userId:string,
  payout:number
): Promise<void> => {
  await pool.query(`UPDATE users SET wallet_balance = wallet_balance + $1 WHERE id = $2`,[payout,userId])
}
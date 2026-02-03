import pool from "../../config/db.js";
import { Bet, PlacedBet, PoolInfo, UserBet } from "./bets.model.js";

const mapRowToBet = (row: any): Bet => {
  return {
    title: row.title,
    created_at: row.created_at,
    created_by: row.created_by,
    creator_id: row.creator_id,
    expires_at: row.expires_at,
    group_id: row.group_id,
    id: row.id,
    status: row.status,
    winning_option: row.winning_option,
    total_pot: row.total_pot,
  };
};

const mapRowToUserBet = (row: any): UserBet => {
  return {
    bet_id: row.bet_id,
    user_id: row.user_id,
    amount: row.amount,
    selected_option: row.selected_option,
    created_at: row.created_at,
  };
};

const mapRowToPlacedBet = (row: any): PlacedBet => {
  return {
    amount: row.amount,
    option: row.option,
  };
};

const mapRowToPoolInfo = (row: any): PoolInfo => {
  return {
    pool_against: row.pool_against,
    pool_for: row.pool_for,
    total_pot: row.total_pot,
  };
};

export const getBetFromDB = async (betId: string): Promise<Bet> => {
  const result = await pool.query(`SELECT * FROM bets WHERE id=$1`, [betId]);
  return mapRowToBet(result.rows[0]);
};

export const getAllBetsOfGroupFromDB = async (
  groupId: string,
): Promise<Bet[]> => {
  const result = await pool.query(
    `SELECT * FROM bets WHERE group_id=$1 ORDER BY created_at DESC`,
    [groupId],
  );
  return result.rows.map((row) => mapRowToBet(row));
};

export const getAllUserBetsFromDB = async (
  betID: string,
): Promise<UserBet[]> => {
  const result = await pool.query(
    `SELECT * FROM user_bets WHERE bet_id=$1 ORDER BY created_at DESC`,
    [betID],
  );
  return result.rows.map((row) => mapRowToUserBet(row));
};

export const postBet = async (
  authUserID: string,
  groupId: string,
  title: string,
  expires_at: number,
): Promise<Bet> => {
  const result = await pool.query(
    `INSERT INTO bets (group_id, creator_id, title, status, expires_at) VALUES ($1,$2,$3,'open',$4) RETURNING *`,
    [groupId, authUserID, title, new Date(expires_at)],
  );
  return mapRowToBet(result.rows[0]);
};

export const placeBet = async (
  userId: string,
  betId: string,
  amount: number,
  option: string,
): Promise<UserBet> => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const result = await client.query(
      `INSERT INTO user_bets (bet_id,user_id,amount,selected_option,created_at) VALUES ($1,$2,$3,$4,$5) RETURNING *`,
      [betId, userId, amount, option, new Date(Date.now())],
    );
    await client.query(
      `UPDATE bets SET total_pot = total_pot + $1 WHERE id = $2`,
      [amount, betId],
    );
    await client.query(
      `UPDATE users SET wallet_balance = wallet_balance - $1 WHERE id = $2`,
      [amount, userId],
    );

    await client.query("COMMIT");
    return mapRowToUserBet(result.rows[0]);
  } catch (err: any) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
};

export const decideBet = async (
  betId: string,
  option: string,
): Promise<Bet> => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    const result = await client.query(
      "UPDATE bets SET winning_option = $1 WHERE id=$2 RETURNING *",
      [option, betId],
    );
    // await client.query(`UPDATE bets SET status = $1 WHERE id = $2`,[option,betId])
    await client.query(`COMMIT`);
    return mapRowToBet(result.rows[0]);
  } catch (err: any) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
};

export const markResolved = async (betId: string): Promise<void> => {
  await pool.query(`UPDATE bets SET status = $1 WHERE id=$2`, [
    "resolved",
    betId,
  ]);
};

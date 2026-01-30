import { PoolClient } from "pg";
import pool from "../../config/db.js";
import { AuthUser, RefreshToken } from "./auth.model.js";

const mapRowToUser = (row: any): AuthUser => {
  return {
    id: row.id,
    email: row.email,
    passwordHash: row.password_hash,
    createdAt: row.created_at,
  };
};

const mapRowToRefreshToken = (row: any): RefreshToken => {
  return {
    id: row.id,
    userID: row.user_id,
    token: row.token,
    revoked: row.revoked,
    createdAt: row.created_at,
    expiresAt: row.expires_at,
  };
};

export const createUser = async (
  id: string,
  passwordHash: string,
  client: PoolClient,
): Promise<AuthUser> => {
  const result = await client.query(
    `INSERT INTO auth (user_id, password_hash)
    VALUES ($1, $2)
    RETURNING *`,
    [id, passwordHash],
  );

  return mapRowToUser(result.rows[0]);
};

export const findUserByID = async (id: string): Promise<AuthUser | null> => {
  const result = await pool.query(
    `SELECT *
    FROM auth
    WHERE user_id=$1`,
    [id],
  );

  if (!result.rows[0]) return null;

  return mapRowToUser(result.rows[0]);
};

export const createRefreshToken = async (userID: string, token: string) => {
  const milliInDay = 1000 * 60 * 60 * 24;

  await pool.query(
    `INSERT INTO refresh_tokens (user_id, token, expires_at)
       VALUES ($1, $2, $3)`,
    [userID, token, new Date(Date.now() + 7 * milliInDay)],
  );
};

export const getRefreshToken = async (
  token: string,
): Promise<RefreshToken | null> => {
  const result = await pool.query(
    `SELECT id, user_id, token, revoked, created_at, expires_at
    FROM refresh_tokens
    WHERE token=$1`,
    [token],
  );

  if (!result.rows[0]) return null;

  return mapRowToRefreshToken(result.rows[0]);
};

export const revokeRefreshToken = async (token: string) => {
  await pool.query(
    `UPDATE refresh_tokens
    SET revoked=true
    WHERE token=$1`,
    [token],
  );
};

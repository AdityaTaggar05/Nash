import pool from "../../config/db.js";
import { Message } from "./message.model.js";

const mapRowToMessage = (row: any): Message => ({
  id: row.id,
  roomID: row.room_id,
  senderID: row.sender_id,
  username: row.username,
  content: row.content,
  createdAt: row.created_at,
});

export const createMessage = async (
  roomID: string,
  senderID: string,
  content: string,
): Promise<Message> => {
  const result = await pool.query(
    `INSERT INTO messages (bet_id, sender_id, content)
     VALUES ($1, $2, $3)
     RETURNING *`,
    [roomID, senderID, content],
  );

  return mapRowToMessage(result.rows[0]);
};

export const getMessages = async (roomID: string): Promise<Message[]> => {
  const result = await pool.query(
    `SELECT * FROM messages 
    WHERE bet_id = $1
    ORDER BY created_at DESC`,
    [roomID],
  );

  return result.rows.map<Message>((row) => mapRowToMessage(row));
};

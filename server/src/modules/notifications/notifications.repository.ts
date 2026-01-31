import pool from "../../config/db.js"
import { CustomNotification, NotificationsList } from "./notifications.model.js";

const mapRowToCustomNotification = (row: any): CustomNotification => {
    return {
        notification_id: row.id,
        content: row.content,
        created_at: row.created_at
    }
}

export const getNotifications = async (
    userId: string
): Promise<NotificationsList> => {
    const response = await pool.query(
        `SELECT * 
        FROM notifications 
        WHERE user_id = $1`,
        [userId]
    );
    const notifications = response.rows.map((row: any) => {
        return mapRowToCustomNotification(row);
    });
    return { notifications: notifications };
}


export const createNotification = async (
    userId: string,
    content: string
): Promise<void> => {
    const now: Date = new Date(Date.now());
    await pool.query(
        `INSERT INTO notifications (user_id, content, created_at)
            VALUES ($1, $2, $3)`,
        [userId, content, now]
    );
}
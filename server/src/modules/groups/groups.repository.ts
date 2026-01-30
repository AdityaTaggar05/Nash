import pool from "../../config/db.js";
import { v4 as uuidv4 } from "uuid";
import { Group, Member } from "./groups.model.js";
import { ca, fi } from "zod/locales";

const mapRowToGroup = (row: any): Group => {
    return {
        id: row.id,
        name: row.name,
        description: row.description,
        created_at: row.created_at,
        created_by: row.created_by
    };
};

const mapRowToMember = (row: any) => {
    return {
        username: row.username,
        email: row.email,
        role: row.role
    };
};

export const createGroup = async (
    name: string,
    description: string,
    adminId: string
): Promise<Group> => {
    const client = await pool.connect();
    try {
        const id: string = uuidv4();
        const now: Date = new Date(Date.now());
        await client.query("BEGIN");
        const newGroup = await client.query(
            `INSERT INTO groups (id, name, description, created_by, created_at)
            VALUES ($1, $2, $3, $4, $5)
            RETURNING *` ,
            [id, name, description, adminId, now],
        );
        await client.query(
            `INSERT INTO group_members (group_id, user_id, role, joined_at)
            VALUES ($1, $2, $3, $4)`,
            [id, adminId, "admin", now],
        );
        await client.query("COMMIT");
        return mapRowToGroup(newGroup.rows[0]);
    } catch (err: any) {
        await client.query("ROLLBACK");
        throw err;
    } finally {
        client.release();
    }
};

export const getGroupById = async (groupId: string): Promise<Group> => {
    const client = await pool.connect()
    try {
        await client.query("BEGIN");
        const groupResponse = await client.query(
            `SELECT id, name, description, created_by, created_at
            FROM groups
            WHERE id = $1`,
            [groupId]
        );

        if (!groupResponse.rows[0]) throw new Error("Group not found");

        const membersResponse = await client.query(
            `SELECT username, email, role
            FROM group_members
            JOIN users ON group_members.user_id = users.id
            WHERE group_id = $1`,
            [groupId]
        );
        await client.query("COMMIT");

        const group = mapRowToGroup(groupResponse.rows[0]);
        group.members = membersResponse.rows.map((row: any) => mapRowToMember(row));

        return group;
    } catch (err: any) {
        await client.query("ROLLBACK");
        throw err;
    } finally { client.release(); }
}

export const isAdmin = async (
    groupId: string,
    userID: string
): Promise<boolean> => {
    try {
        const adminId = await pool.query(
            `SELECT user_id
            FROM group_members
            WHERE group_id = $1 
            AND role = $2`,
            [groupId, "admin"]
        );
        if (userID === adminId.rows[0].user_id) {
            return true;
        }
        return false;
    } catch (err: any) {
        throw err;
    }
}

export const addMember = async (
    group_id: string,
    username: string
): Promise<Member> => {
    const client = await pool.connect()
    try {
        const memberInfo = await client.query(
            `SELECT id, email 
            FROM users
            WHERE username = $1`,
            [username]
        );
        const now: Date = new Date(Date.now());
        const result = await client.query(
            `INSERT INTO group_members (group_id, user_id, role, joined_at)
            VALUES ($1, $2, $3, $4)
            RETURNING *`,
            [group_id, memberInfo.rows[0].id, "member", now]
        );
        return {
            email: memberInfo.rows[0].email,
            role: result.rows[0].role,
            username: username,
            joined_at: result.rows[0].joined_at,
        };
    } catch (err: any) {
        await client.query("ROLLBACK");
        throw err;
    } finally { client.release(); }
}

export const removeMember = async (
    groupId: string,
    username: string
): Promise<void> => {
    const client = await pool.connect()
    try {
        const memberId = await client.query(
            `SELECT id
            FROM users
            WHERE username = $1`,
            [username]
        );
        await client.query(
            `DELETE FROM group_members
            WHERE group_id = $1
            AND user_id = $2`,
            [groupId, memberId.rows[0].id]
        );
    } catch (err: any) {
        throw err;
    }
}

export const deleteGroup = async (
    groupId: string
): Promise<void> => {
    try {
        await pool.query(
            `DELETE FROM groups
            WHERE id = $1`,
            [groupId]
        )
    }
    catch (err: any) {
        throw err;
    }
}
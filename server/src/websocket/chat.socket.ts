import { Server, Socket } from "socket.io";
import * as betRepository from "../modules/bets/bets.repository.js";
import * as groupRepository from "../modules/groups/groups.repository.js";
import * as messageService from "../modules/messages/message.service.js";

export default function registerChatHandlers(io: Server, socket: Socket) {
  const userID = socket.data.userID;

  // Join Room
  socket.on("join_room", async ({ roomID }) => {
    try {
      const bet = await betRepository.getBetFromDB(roomID);
      const member = await groupRepository.isMember(userID, bet.group_id);

      if (!member) return socket.emit("error", "Not a member of this room");

      socket.join(roomID);
      socket.emit("room_joined");
    } catch (err: any) {
      socket.emit("error", err.message);
    }
  });

  // Send Message
  socket.on("send_message", async ({ roomID, content }, callback) => {
    try {
      const message = await messageService.sendMessage(roomID, userID, content);

      io.to(roomID).emit("new_message", message);

      if (callback) callback({ status: "ok" });
    } catch (err: any) {
      socket.emit("error", err.message);
    }
  });
}

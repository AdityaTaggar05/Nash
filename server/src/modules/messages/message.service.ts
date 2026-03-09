import * as betRepository from "../bets/bets.repository.js";
import * as groupRepository from "../groups/groups.repository.js";
import * as userRepo from "../users/users.repository.js";
import { MessageResponseDTO } from "./dtos/message-response.dto.js";
import * as messageRepo from "./message.repository.js";

export const sendMessage = async (
  roomID: string,
  senderID: string,
  content: string,
): Promise<MessageResponseDTO> => {
  const bet = await betRepository.getBetFromDB(roomID);

  if (!(await groupRepository.isMember(senderID, bet.group_id)))
    throw new Error("User is not a member of this room");

  const user = await userRepo.getUserFromDB(senderID);

  const message = await messageRepo.createMessage(
    roomID,
    senderID,
    user.username,
    content,
  );

  return {
    id: message.id,
    room_id: message.roomID,
    sender_id: message.senderID,
    username: message.username,
    content: message.content,
    created_at: message.createdAt,
  };
};

export const getMessages = async (
  userID: string,
  groupID: string,
  betID: string,
  cursor?: Date,
): Promise<MessageResponseDTO[]> => {
  if (!(await groupRepository.isMember(userID, groupID)))
    throw new Error("User is not a member of this group");

  const messages = await messageRepo.getMessages(betID, cursor);

  return messages.map<MessageResponseDTO>((message) => {
    return {
      id: message.id,
      room_id: message.roomID,
      sender_id: message.senderID,
      username: message.username,
      content: message.content,
      created_at: message.createdAt,
    };
  });
};

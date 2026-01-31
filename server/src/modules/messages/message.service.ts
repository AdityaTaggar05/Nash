import * as groupRepository from "../groups/groups.repository.js";
import { MessageResponseDTO } from "./dtos/message-response.dto.js";
import * as messageRepo from "./message.repository.js";

export const sendMessage = async (
  roomID: string,
  senderID: string,
  content: string,
): Promise<MessageResponseDTO> => {
  if (!(await groupRepository.isMember(senderID, roomID)))
    throw new Error("User is not a member of this room");

  const message = await messageRepo.createMessage(roomID, senderID, content);

  return {
    id: message.id,
    roomID: message.roomID,
    senderID: message.senderID,
    content: message.content,
    createdAt: message.createdAt,
  };
};

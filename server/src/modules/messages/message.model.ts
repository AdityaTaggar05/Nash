export interface Message {
  id: string;
  roomID: string;
  senderID: string;
  username: string;
  content: string;
  createdAt: Date;
}

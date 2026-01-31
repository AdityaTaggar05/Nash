import { NotificationResponseDTO } from "./dtos/notifications-response.dto.js";
import * as notificationRepo from "./notifications.repository.js"

export const getNotifications = async (
    userId: string
): Promise<NotificationResponseDTO> => {
    const user_id = userId;
    const result = await notificationRepo.getNotifications(user_id);
    return result;
}
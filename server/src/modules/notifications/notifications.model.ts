export interface CustomNotification {
    notification_id : string,
    created_at : Date,
    content : string
}

export interface NotificationsList{
    notifications : Array<CustomNotification>
}
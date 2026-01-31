export interface Group {
    id: string;
    name: string;
    description: string;
    created_at: Date;
    created_by: string;
    members?: Array<Member>;
}

export interface Member {
    user_id:string,
    username:string,
    email:string,
    role:string,
    joined_at:Date,
}

export interface GroupMember {
    group_id: string,
    user_id: string,
    role: string,
    joined_at: Date
}
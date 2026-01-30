export interface Group {
    id: string;
    name: string;
    description: string;
    created_at: Date;
    created_by: string;
    members?: Array<Member>;
}

export interface Member {
    username:string,
    email:string,
    role:string,
    joined_at:Date,
}
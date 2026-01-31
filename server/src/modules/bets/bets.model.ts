export interface Bet {
    title: string,
    id: string,
    group_id: string,
    creator_id: string,
    status: string,
    winning_option?: string,
    expires_at: Date,
    created_at: Date,
    created_by: string,
    total_pot: string
}

export interface PlacedBet {
    amount: number,
    option: string
}

export interface PoolInfo {
    total_pot: number,
    pool_for: number,
    pool_against: number,
}

export interface UserBet {
    bet_id: string,
    user_id: string,
    amount: number,
    selected_option: string,
    created_at: Date
}
export interface BetTransaction {
    username:string
    user_id: string,
    amount: number,
    placed_at: Date,
    option: string
}

export interface BetTransactions {
    transactions: Array<BetTransaction>
}

export interface UserTransaction {
    bet_id?: string,
    amount: number,
    placed_at: Date,
    description: string
}

export interface UserTransactions {
    transactions: Array<UserTransaction>
}
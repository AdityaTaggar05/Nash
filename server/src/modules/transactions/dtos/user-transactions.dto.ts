import { BetTransaction, UserTransaction } from "../transactions.model.js";

export interface UserTransactionsResponseDTO {
    total : number,
    transactions : Array <UserTransaction>;
}
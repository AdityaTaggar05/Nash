import { BetTransaction, UserTransaction } from "../transactions.model.js";

export interface UserTransactionsResponseDTO {
    last_month : number,
    transactions : Array <UserTransaction>;
}
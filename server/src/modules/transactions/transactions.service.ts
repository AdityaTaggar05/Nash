import { BetTransactionsResponseDTO } from "./dtos/bet-transactions.dto.js"
import { UserTransactionsResponseDTO } from "./dtos/user-transactions.dto.js";
import * as transactionsRepo from "./transactions.repository.js"

export const getBetTransactions = async (
    input: string
): Promise<BetTransactionsResponseDTO> => {

    const betTransactions = await transactionsRepo.getBetTransactions(input);

    return {
        transactions: betTransactions.transactions
    };
}

export const getUserTransactions = async (
    input: string
): Promise<UserTransactionsResponseDTO> => {

    const userTransactions = await transactionsRepo.getUserTransactions(input);
    const sum = userTransactions.transactions.reduce(function (acc, transaction) {
        return acc + transaction.amount;
    }, 0)
    return {
        total: sum,
        transactions: userTransactions.transactions
    };
}

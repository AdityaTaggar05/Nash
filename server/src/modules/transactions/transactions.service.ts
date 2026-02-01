import { BetTransactionsResponseDTO } from "./dtos/bet-transactions.dto.js";
import { UserTransactionsResponseDTO } from "./dtos/user-transactions.dto.js";
import * as transactionsRepo from "./transactions.repository.js";

export const getBetTransactions = async (
  input: string,
): Promise<BetTransactionsResponseDTO> => {
  const betTransactions = await transactionsRepo.getBetTransactions(input);

  return {
    transactions: betTransactions.transactions,
  };
};

export const getUserTransactions = async (
  input: string,
): Promise<UserTransactionsResponseDTO> => {
  const oneMonthAgo = new Date();
  oneMonthAgo.setMonth(oneMonthAgo.getMonth() - 1);

  const userTransactions = await transactionsRepo.getUserTransactions(input);
  const recentTransactions = userTransactions.transactions.filter(
    (transaction) => {
      return transaction.placed_at >= oneMonthAgo;
    },
  );
  const sum = recentTransactions.reduce(
    (acc, transaction) => acc + transaction.amount,
    0,
  );

  return {
    last_month: sum,
    transactions: userTransactions.transactions,
  };
};

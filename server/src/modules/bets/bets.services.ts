import { emitToRoom } from "../../websocket/socketEmitter.js";
import * as groupRepository from "../groups/groups.repository.js";
import * as notificationRepository from "../notifications/notifications.repository.js";
import * as transactionRepository from "../transactions/transactions.repository.js";
import * as userRepository from "../users/users.repository.js";
import { Bet } from "./bets.model.js";
import * as betRespository from "./bets.repository.js";
import { BetResponseDTO } from "./dtos/bet-response.dto.js";

export const getBet = async (
  betId: string,
  authUserID: string,
): Promise<BetResponseDTO> => {
  const bet = await betRespository.getBetFromDB(betId);
  const betsMade = await betRespository.getAllUserBetsFromDB(betId);

  let pool_for: number = 0;
  let pool_against: number = 0;

  betsMade.forEach((singleBet) => {
    if (singleBet.selected_option === "for")
      pool_for += Number(singleBet.amount);
    else pool_against += Number(singleBet.amount);
  });

  const total_pot = Number(pool_against) + Number(pool_for);

  const betMadeByUser = betsMade.find(
    (singleBet) => singleBet.user_id === authUserID,
  );

  let payout: number = 0;

  let response: BetResponseDTO = {
    created_at: bet.created_at,
    created_by: bet.created_by,
    creator_id: bet.creator_id,
    expires_at: bet.expires_at,
    group_id: bet.group_id,
    id: bet.id,
    status: bet.status,
    title: bet.title,
    winning_option: bet.winning_option,
    total_pot: total_pot,
    pool_against: pool_against,
    pool_for: pool_for,
  };

  if (betMadeByUser != undefined) {
    if (betMadeByUser.selected_option === "for") {
      payout = Math.round((betMadeByUser.amount * total_pot * 0.8) / pool_for);
    } else {
      payout = Math.round(
        (betMadeByUser.amount * total_pot * 0.8) / pool_against,
      );
    }

    response.my_bet = {
      amount: betMadeByUser!.amount,
      option: betMadeByUser!.selected_option,
      payout: payout,
    };
    return response;
  }

  return response;
};

export const getAllBets = async (groupId: string): Promise<Bet[]> => {
  const bets = await betRespository.getAllBetsOfGroupFromDB(groupId);
  return bets;
};

export const postBet = async (
  authUserID: string,
  groupId: string,
  title: string,
  expires_at: number,
): Promise<Bet> => {
  const bet = await betRespository.postBet(
    authUserID,
    groupId,
    title,
    expires_at,
  );
  return bet;
};

export const placeBet = async (
  authUserID: string,
  betId: string,
  amount: number,
  option: string,
): Promise<any> => {
  const bet = await betRespository.getBetFromDB(betId);
  const user = await userRepository.getUserFromDB(authUserID);
  const group = await groupRepository.getGroupById(bet.group_id);

  if (authUserID === bet.creator_id) {
    throw new Error("Creator cannot place bet on own bet");
  } else if (
    (await betRespository.getAllUserBetsFromDB(betId)).find(
      (single_bet) => single_bet.user_id === authUserID,
    )
  ) {
    throw new Error("Bet already placed by the user");
  } else if (bet.status !== "open") {
    throw new Error("Bet is not open for placing bets");
  } else if (user.wallet_balance < amount) {
    throw new Error("Insufficient wallet balance to place bet");
  } else {
    const placedBet = await betRespository.placeBet(
      authUserID,
      betId,
      amount,
      option,
    );

    transactionRepository.createTransaction(
      authUserID,
      -amount,
      `Placed bet on option "${option}" for bet "${bet.title}"\nGROUP: ${group.name}`,
      placedBet.bet_id,
    );

    emitToRoom(bet.id, "new_user_bet", {
      bet_id: bet.id,
      user_id: user.id,
      username: user.username,
      amount: amount,
      selected_option: option,
      created_at: placedBet.created_at,
    });

    return {
      bet_id: bet.id,
      user_id: user.id,
      username: user.username,
      amount: amount,
      selected_option: option,
      created_at: placedBet.created_at,
    };
  }
};

export const decideBet = async (
  authUserID: string,
  betId: string,
  option: string,
): Promise<Bet> => {
  const thisBet = await betRespository.getBetFromDB(betId);
  if (thisBet.status !== "open") {
    throw new Error("Bet not open");
  }
  if (thisBet.creator_id !== authUserID) {
    throw new Error(
      "Only the creator of bet is authorized to decide the outcome.",
    );
  }
  const bet = await betRespository.decideBet(betId, option);
  betRespository.markResolved(betId);

  const allBets = await betRespository.getAllUserBetsFromDB(betId);

  let total_pot: number = 0;
  let winning_pool: number = 0;

  allBets.forEach((singleBet) => {
    total_pot += Number(singleBet.amount);
    if (singleBet.selected_option === bet.winning_option) {
      winning_pool += Number(singleBet.amount);
    }
  });

  const creatorCut = Math.round((total_pot * 2) / 100);
  total_pot = Math.round((total_pot * 8) / 10);

  allBets.forEach((singleBet) => {
    if (singleBet.selected_option === bet.winning_option) {
      const wonAmount = Math.round(
        (Number(singleBet.amount) * total_pot) / winning_pool,
      ) as number;
      userRepository.updateUserWalletBalance(singleBet.user_id, wonAmount);
      transactionRepository.createTransaction(
        singleBet.user_id,
        wonAmount,
        `Winnings from bet "${bet.title}"`,
        bet.id,
      );
    }

    notificationRepository.createNotification(
      singleBet.user_id,
      `The bet "${bet.title}" has been resolved.\nWinning option: "${bet.winning_option}".\n${singleBet.selected_option === bet.winning_option ? "Check your wallet for winnings!" : "Unfortunately, you did not win this time."}`,
    );
  });

  userRepository.updateUserWalletBalance(bet.created_by, creatorCut);

  emitToRoom(betId, "bet_status_change", {
    status: "resolved",
    winning_option: option,
  });

  return bet;
};

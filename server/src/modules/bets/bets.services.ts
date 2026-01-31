import * as betRespository from "./bets.repository.js";
import { BetResponseDTO } from "./dtos/bet-response.dto.js";
import { Bet, UserBet } from "./bets.model.js";
import * as userRepository from "../users/users.repository.js";
import * as transactionRepository from "../transactions/transactions.repository.js";
import * as groupRepository from "../groups/groups.repository.js";
import { User } from "../users/users.model.js";
import { string } from "zod";

const hasUserBet = (bets: UserBet[], b_id: string): boolean => {
    const found = bets.find(bet => bet.bet_id === b_id)
    if (!found) return false
    else return true
}

export const getBet = async (betId: string, authUserID: string): Promise<BetResponseDTO> => {
    const bet = await betRespository.getBetFromDB(betId);
    const betsMade = (await betRespository.getAllUserBetsFromDB()).filter(singleBet => singleBet.bet_id === betId)

    const total_pot = betsMade.reduce(function (acc, singleBet) {
        return acc + singleBet.amount;
    }, 0);

    const forBetsMade = betsMade.filter(singleBet => singleBet.selected_option === "for")
    const againstBetsMade = betsMade.filter(singleBet => singleBet.selected_option === "against")

    const pool_for = forBetsMade.reduce(function (acc, singleBet) {
        return acc + singleBet.amount;
    }, 0);
    const pool_against = againstBetsMade.reduce(function (acc, singleBet) {
        return acc + singleBet.amount;
    }, 0);

    const betsMadeByUser = (await betRespository.getAllUserBetsFromDB()).filter(singleBet => singleBet.user_id === authUserID)

    let payout = 0;

    if (hasUserBet(betsMadeByUser, betId)) {
        const betMadeByUser = betsMade.find(singleBet => singleBet.user_id === authUserID)
        if (betMadeByUser.selected_option === "for") {
            payout = Math.round(betMadeByUser.amount / pool_for * total_pot)
        } else {
            payout = Math.round(betMadeByUser.amount / pool_against * total_pot)
        }

        return {
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
            my_bet: {
                amount: betMadeByUser!.amount,
                option: betMadeByUser!.selected_option,
                payout: payout
            }
        }
    }
    return {
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
    }
}

export const getAllBets = async (groupId: string): Promise<Bet[]> => {
    const bets = await betRespository.getAllBetsOfGroupFromDB(groupId);
    return bets;
}

export const postBet = async (authUserID: string, groupId: string, title: string, expires_at: number): Promise<Bet> => {
    const bet = await betRespository.postBet(authUserID, groupId, title, expires_at);
    return bet;
}

export const placeBet = async (authUserID: string, betId: string, amount: number, option: string): Promise<UserBet> => {
    const bet = await betRespository.getBetFromDB(betId);
    const user = await userRepository.getUserFromDB(authUserID);
    const group = await groupRepository.getGroupById(bet.group_id);
    if (authUserID === bet.creator_id) {
        throw new Error("Creator cannot place bet on own bet");
    } else if (bet.status !== "open") {
        throw new Error("Bet is not open for placing bets");
    } else if (user.wallet_balance < amount) {
        throw new Error("Insufficient wallet balance to place bet");
    } else {
        const placedBet = await betRespository.placeBet(authUserID, betId, amount, option);
        await transactionRepository.createTransaction(authUserID, -amount, `Placed bet on option ${option} for bet ${bet.title}\nGROUP: ${group.name}`, placedBet.bet_id);
        return placedBet;
    }
}

export const decideBet = async (authUserID: string, betId: string, option: string): Promise<Bet> => {
    const thisBet = await betRespository.getBetFromDB(betId)
    if(thisBet.status!=="open")
    {
        throw new Error("Bet not open")
    }
    const bet = await betRespository.decideBet(betId, option);
    betRespository.markResolved(betId);

    const allBets = await betRespository.getAllUserBetsFromDB();
    const thisBets = allBets.filter((bet)=> bet.bet_id===betId)
    const winningBets = thisBets.filter((singleBet)=> singleBet.selected_option===bet.winning_option)

    const total_pot =thisBets.reduce((acc,val) => acc+val.amount,0)
    console.log(total_pot)
    const winning_pool = winningBets.reduce((acc,val) => acc+val.amount,0)
    console.log(winning_pool)

    winningBets.forEach((winner)=> {userRepository.updateUserWalletBalance(winner.user_id, (Math.round((winner.amount)*total_pot/winning_pool)));
    })
    return bet;
}
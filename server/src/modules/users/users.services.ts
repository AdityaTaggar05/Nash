import * as userRepository from "./users.repository.js";
import {SameUserDTO as SameUserResponseDTO} from "./dtos/same-user.dto.js";
import {DifferentUserDTO as DifferentUserResponseDTO} from "./dtos/different-user.dto.js";
import { toDifferentUserResponse, toSameUserResponse } from "./users.mapper.js";
import { CheckInResponseDTO } from "./dtos/check-in-response.dto.js";
import { Group } from "../groups/groups.model.js";
import { Bet, UserBet } from "../bets/bets.model.js";

export const getCurrentUser = async (
  authUserID: string,
): Promise<SameUserResponseDTO> => {
  const user = await userRepository.getUserFromDB(authUserID);
  return toSameUserResponse(user);
};

export const getUser = async (authUserID: string, requestedUserID: string): Promise<SameUserResponseDTO | DifferentUserResponseDTO> => {
    console.log("Requested User ID: ", requestedUserID);
    const user = await userRepository.getUserFromDB(requestedUserID);
    if(authUserID === requestedUserID) {
        return toSameUserResponse(user);
    } else {
        return toDifferentUserResponse(user);
    }
}

export const dailyCheckIn = async (authUserID: string): Promise<CheckInResponseDTO> => {
    const response = await userRepository.performDailyCheckIn(authUserID);
    return response;
}

export const getGroups = async (authUserID: string): Promise<Group[]> => {
    const response = await userRepository.getGroupMembers(authUserID);
    const groupIds = response.map(group => group.group_id)
    const groups = await userRepository.getGroups(groupIds)
    return groups
}

export const getUserPlacedOpenBets = async (authUserID: string): Promise<UserBet[]> => {
    const allUserPlacedBets = await userRepository.getUserPlacedBets(authUserID);
    const allUserPlacedBetIds = allUserPlacedBets.map((bet)=> bet.bet_id)
    const openBets = await userRepository.getOpenBetsFromPlacedBets(allUserPlacedBetIds);
    const openBetIds = openBets.map((bet)=> bet.id);

    const userPlacedOpenBets = allUserPlacedBets.filter((bet)=> openBetIds.includes(bet.bet_id));
    return userPlacedOpenBets;
}

export const getUserCreatedOpenBets = async (authUserID: string): Promise<Bet[]> => {
    const allUserCreatedOpenBets = await userRepository.getUserCreatedOpenBets(authUserID);
    return allUserCreatedOpenBets;
}
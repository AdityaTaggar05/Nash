import { Bet } from "../bets/bets.model.js";
import { Group } from "../groups/groups.model.js";
import { CheckInResponseDTO } from "./dtos/check-in-response.dto.js";
import { DifferentUserDTO as DifferentUserResponseDTO } from "./dtos/different-user.dto.js";
import { OpenPlacedBetResponseDTO } from "./dtos/open-placed-bet-response.dto.js";
import { SameUserDTO as SameUserResponseDTO } from "./dtos/same-user.dto.js";
import { toDifferentUserResponse, toSameUserResponse } from "./users.mapper.js";
import * as userRepository from "./users.repository.js";

export const getCurrentUser = async (
  authUserID: string,
): Promise<SameUserResponseDTO> => {
  const user = await userRepository.getUserFromDB(authUserID);
  return toSameUserResponse(user);
};

export const getUser = async (
  authUserID: string,
  requestedUserID: string,
): Promise<SameUserResponseDTO | DifferentUserResponseDTO> => {
  const user = await userRepository.getUserFromDB(requestedUserID);
  if (authUserID === requestedUserID) {
    return toSameUserResponse(user);
  } else {
    return toDifferentUserResponse(user);
  }
};

export const dailyCheckIn = async (
  authUserID: string,
): Promise<CheckInResponseDTO> => {
  const response = await userRepository.performDailyCheckIn(authUserID);
  return response;
};

export const getGroups = async (authUserID: string): Promise<Group[]> => {
  const groups = await userRepository.getGroups(authUserID);
  return groups;
};

export const getUserPlacedOpenBets = async (
  authUserID: string,
): Promise<OpenPlacedBetResponseDTO[]> => {
  return (await userRepository.getOpenPlacedBets(authUserID)).map((bet) => {
    return {
      id: bet.id,
      group_id: bet.group_id,
      title: bet.title,
      expires_at: bet.expires_at,
      created_at: bet.created_at,
      total_pot: bet.total_pot,
      my_bet: {
        amount: bet.amount,
        option: bet.selected_option,
      },
    };
  });
};

export const getUserCreatedOpenBets = async (
  authUserID: string,
): Promise<Bet[]> => {
  const allUserCreatedOpenBets =
    await userRepository.getUserCreatedOpenBets(authUserID);
  return allUserCreatedOpenBets;
};

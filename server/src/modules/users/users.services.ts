import * as userRepository from "./users.repository.js";
import {SameUserDTO as SameUserResponseDTO} from "./dtos/same-user.dto.js";
import {DifferentUserDTO as DifferentUserResponseDTO} from "./dtos/different-user.dto.js";
import { toDifferentUserResponse, toSameUserResponse } from "./users.mapper.js";
import { CheckInResponseDTO } from "./dtos/check-in-response.dto.js";

export const getUser = async (authUserID: string, requestedUserID: string): Promise<SameUserResponseDTO | DifferentUserResponseDTO> => {
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

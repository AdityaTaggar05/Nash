import { DifferentUserDTO } from "./dtos/different-user.dto.js";
import { SameUserDTO } from "./dtos/same-user.dto.js";
import { User } from "./users.model.js";

export const toSameUserResponse = (user: User): SameUserDTO => {
    return {
        id: user.id,
        username: user.username,
        email: user.email,
        wallet_balance: user.wallet_balance,
        referal_code: user.referal_code,
        created_at: user.created_at
    }
}

export const toDifferentUserResponse = (user: User): DifferentUserDTO => {
    return {
        id: user.id,
        username: user.username,
        email: user.email,
        referal_code: user.referal_code,
        created_at: user.created_at
    }
}
import { Router } from "express";
import * as controller from "./groups.controller.js"
import { validate } from "../../middleware/validate.middleware.js";
import { CreateGroupSchema } from "./dtos/create-group.dto.js";
import { authenticate } from "../../middleware/auth.middleware.js";
import { AddOrRemoveMemberSchema } from "./dtos/add-member.dto.js";

const router = Router();

router.post('/create',authenticate,validate(CreateGroupSchema),controller.createGroup);
router.get('/:group_id',authenticate,controller.getGroupById);
router.post('/:group_id/members',authenticate,validate(AddOrRemoveMemberSchema),controller.addMember);
router.delete('/:group_id/members',authenticate,validate(AddOrRemoveMemberSchema),controller.removeMember);
router.delete('/:group_id',authenticate,controller.deleteGroup);

export default router;
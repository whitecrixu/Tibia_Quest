local textPositions = {
	Position(3149, 4160, 6),
	Position(3150, 4160, 6),
	Position(3151, 4160, 6),
}

local rewardRoomText = MoveEvent()

function rewardRoomText.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player or player:getStorageValue(Storage.TheInquisition.RewardRoomText) == 1 then
		return true
	end

	player:setStorageValue(Storage.TheInquisition.RewardRoomText, 1)
	player:say("You can choose exactly one of these chests. Choose wisely!", TALKTYPE_MONSTER_SAY)
	return true
end

for _, pos in ipairs(textPositions) do
	rewardRoomText:position(pos)
end

rewardRoomText:register()

local textPos = {
	{x = 3149, y = 4160, z = 6},
	{x = 3150, y = 4160, z = 6},
	{x = 3151, y = 4160, z = 6},
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

for a = 1, #textPos do
	rewardRoomText:position(textPos[a])
end
rewardRoomText:register()

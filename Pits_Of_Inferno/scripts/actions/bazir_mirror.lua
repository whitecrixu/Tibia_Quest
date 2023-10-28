local config = {
	[39511] = {
		fromPosition = Position(2539, 2601, 14),
		toPosition = Position(2539, 2600, 14),
	},
	[39512] = {
		teleportPlayer = true,
		fromPosition = Position(2539, 2601, 14),
		toPosition = Position(2539, 2600, 14),
	},
}

local pitsOfInfernoBlackMirror = Action()
function pitsOfInfernoBlackMirror.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local useItem = config[item.actionid]
	if not useItem then
		return true
	end

	if useItem.teleportPlayer then
		player:teleportTo(Position(2540, 2601, 13))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say("Beauty has to be rewarded! Muahahaha!", TALKTYPE_MONSTER_SAY)
	end

	local tapestry = Tile(useItem.fromPosition):getItemById(6433)
	if tapestry then
		tapestry:moveTo(useItem.toPosition)
	end
	return true
end

pitsOfInfernoBlackMirror:aid(39511, 39512)
pitsOfInfernoBlackMirror:register()

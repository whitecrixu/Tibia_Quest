local setting = {
	[16772] = Position(2554, 2574, 15),
	[16773] = Position(2525, 2590, 15),
	[16774] = Position(2627, 2450, 12),
	[50082] = Position(2545, 2603, 14),
	[50083] = Position(2545, 2603, 14),
}

local bazirTile = MoveEvent()

function bazirTile.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local targetPosition = setting[item.actionid]
	if not targetPosition then
		return true
	end

	player:teleportTo(targetPosition)
	return true
end

bazirTile:type("stepin")

for index, value in pairs(setting) do
	bazirTile:aid(index)
end

bazirTile:register()

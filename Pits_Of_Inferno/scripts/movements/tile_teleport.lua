local destinations = {
	[28810] = Position(2638, 2513, 9),
	[28811] = Position(2639, 2529, 9),
	[28812] = Position(2644, 2519, 9),
	[28813] = Position(2647, 2516, 9),
	[28814] = Position(2656, 2515, 9),
	[28815] = Position(2627, 2517, 9),
	[28816] = Position(2640, 2526, 9),
	[28817] = Position(2655, 2505, 9),
	[28818] = Position(2657, 2516, 9),
	[28819] = Position(2656, 2498, 9),
	[28820] = Position(2643, 2522, 9),
	[28821] = Position(2661, 2529, 9),
	[28822] = Position(2641, 2532, 9),
	[28823] = Position(2647, 2496, 9),
	[28824] = Position(2654, 2532, 9),
	[28825] = Position(2655, 2513, 9),
	[28826] = Position(2641, 2532, 9),
	[28827] = Position(2644, 2516, 9),
	[28828] = Position(2627, 2523, 9),
	[28829] = Position(2658, 2505, 9),
	[28830] = Position(2661, 2510, 9),
	[28831] = Position(2655, 2530, 9),
	[28832] = Position(2655, 2529, 9),
	[28833] = Position(2655, 2527, 9),
	[28834] = Position(2655, 2528, 9),
}

local tileTeleport = MoveEvent()

function tileTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	player:teleportTo(destinations[item.actionid])
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

tileTeleport:type("stepin")

for index, value in pairs(destinations) do
	tileTeleport:aid(index)
end

tileTeleport:register()

-- Configuration table for wall positions and item IDs
local config = {
	[1006] = {
		wallPositions = {
			{3146, 4245, 5}, {3147, 4245, 5}, {3148, 4245, 5}, {3149, 4245, 5},
			{3150, 4245, 5}, {3151, 4245, 5}, {3152, 4245, 5}, {3153, 4245, 5},
			{3154, 4245, 5}, {3155, 4245, 5}, {3156, 4245, 5}, {3157, 4245, 5},
			{3158, 4245, 5}
		},
		wallDown = 2162,
		wallUp = 1295,
	},
	[1007] = {
		wallPositions = {
			{3143, 4248, 5}, {3143, 4249, 5}, {3143, 4250, 5}, {3143, 4251, 5},
			{3143, 4252, 5}, {3143, 4253, 5}, {3143, 4254, 5}, {3143, 4255, 5},
			{3143, 4256, 5}
		},
		wallDown = 2164,
		wallUp = 1294,
	},
	[1008] = {
		wallPositions = {
			{3146, 4259, 5}, {3147, 4259, 5}, {3148, 4259, 5}, {3149, 4259, 5},
			{3150, 4259, 5}, {3151, 4259, 5}, {3152, 4259, 5}, {3153, 4259, 5},
			{3154, 4259, 5}, {3155, 4259, 5}, {3156, 4259, 5}, {3157, 4259, 5},
			{3158, 4259, 5}
		},
		wallDown = 2162,
		wallUp = 1295,
	},
	[1009] = {
		wallPositions = {
			{3161, 4248, 5}, {3161, 4249, 5}, {3161, 4250, 5}, {3161, 4251, 5},
			{3161, 4252, 5}, {3161, 4253, 5}, {3161, 4254, 5}, {3161, 4255, 5},
			{3161, 4256, 5}
		},
		wallDown = 2164,
		wallUp = 1294,
	},
}

-- Action handler for inquisitionBrother
local inquisitionBrother = Action()

function inquisitionBrother.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetLever = config[item.uid]
	if not targetLever then
		return true
	end

	-- Determine the transformation based on the lever state
	local transformTo = (item.itemid == 2772) and targetLever.wallUp or targetLever.wallDown

	for _, pos in ipairs(targetLever.wallPositions) do
		local tile = Tile(Position(pos[1], pos[2], pos[3]))
		if tile then
			local wallItem = tile:getItemById(transformTo == targetLever.wallUp and targetLever.wallDown or targetLever.wallUp)
			if wallItem then
				wallItem:transform(transformTo)
			end
		end
	end

	-- Transform the lever itself
	item:transform(item.itemid == 2772 and 2773 or 2772)
	return true
end

-- Register the action for each unique ID in the config
for uniqueId in pairs(config) do
	inquisitionBrother:uid(uniqueId)
end

inquisitionBrother:register()

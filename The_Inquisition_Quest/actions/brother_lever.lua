local config = {
	[1006] = {
		wallPositions = {
			Position(3146, 4245, 5),
			Position(3147, 4245, 5),
			Position(3148, 4245, 5),
			Position(3149, 4245, 5),
			Position(3150, 4245, 5),
			Position(3151, 4245, 5),
			Position(3152, 4245, 5),
		  Position(3153, 4245, 5),
			Position(3154, 4245, 5),
			Position(3155, 4245, 5),
			Position(3156, 4245, 5),
			Position(3157, 4245, 5),
			Position(3158, 4245, 5),
		},
		wallDown = 2162,
		wallUp = 1295,
	},
	[1007] = {
		wallPositions = {
			Position(3143, 4248, 5),
			Position(3143, 4249, 5),
			Position(3143, 4250, 5),
			Position(3143, 4251, 5),
			Position(3143, 4252, 5),
			Position(3143, 4253, 5),
			Position(3143, 4254, 5),
			Position(3143, 4255, 5),
			Position(3143, 4256, 5),
		},
		wallDown = 2164,
		wallUp = 1294,
	},
	[1008] = {
		wallPositions = {
			Position(3146, 4259, 5),
			Position(3147, 4259, 5),
			Position(3148, 4259, 5),
			Position(3149, 4259, 5),
			Position(3150, 4259, 5),
			Position(3151, 4259, 5),
			Position(3152, 4259, 5),
			Position(3153, 4259, 5),
			Position(3154, 4259, 5),
			Position(3155, 4259, 5),
			Position(3156, 4259, 5),
			Position(3157, 4259, 5),
			Position(3158, 4259, 5),
		},
		wallDown = 2162,
		wallUp = 1295,
	},
	[1009] = {
		wallPositions = {
			Position(3161, 4248, 5),
			Position(3161, 4249, 5),
			Position(3161, 4250, 5),
			Position(3161, 4251, 5),
			Position(3161, 4252, 5),
			Position(3161, 4253, 5),
			Position(3161, 4254, 5),
			Position(3161, 4255, 5),
			Position(3161, 4256, 5),
		},
		wallDown = 2164,
		wallUp = 1294,
	},
}

local inquisitionBrother = Action()

function inquisitionBrother.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetLever = config[item.uid]
	if not targetLever then
		return true
	end

	local tile, thing
	for i = 1, #targetLever.wallPositions do
		tile = Tile(targetLever.wallPositions[i])
		if tile then
			thing = tile:getItemById(item.itemid == 2772 and targetLever.wallDown or targetLever.wallUp)
			if thing then
				thing:transform(item.itemid == 2772 and targetLever.wallUp or targetLever.wallDown)
			end
		end
	end

	item:transform(item.itemid == 2772 and 2773 or 2772)
	return true
end

for uniqueId, info in pairs(config) do
	inquisitionBrother:uid(uniqueId)
end

inquisitionBrother:register()

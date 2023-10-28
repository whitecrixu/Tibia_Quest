local lava = {
	Position(2712, 2418, 15),
	Position(2713, 2418, 15),
	Position(2712, 2419, 15),
	Position(2713, 2419, 15),
}

local pitsOfInfernoFirstThroneLever = Action()
function pitsOfInfernoFirstThroneLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local lavaTile
	for i = 1, #lava do
		lavaTile = Tile(lava[i]):getGround()
		if lavaTile and table.contains({ 410, 21477 }, lavaTile.itemid) then
			lavaTile:transform(lavaTile.itemid == 21477 and 410 or 21477)
			lava[i]:sendMagicEffect(CONST_ME_SMOKE)
		end
	end

	item:transform(item.itemid == 2772 and 2773 or 2772)
	return true
end

pitsOfInfernoFirstThroneLever:uid(50106)
pitsOfInfernoFirstThroneLever:register()

local pos = {
	[2025] = {x = 2631, y = 2542, z = 11},
	[2026] = {x = 2633, y = 2542, z = 11},
	[2027] = {x = 2633, y = 2542, z = 11},
	[2028] = {x = 2637, y = 2542, z = 11},
}

local function doRemoveFirewalls(fwPos)
	local tile = Position(fwPos):getTile()
	if tile then
		local thing = tile:getItemById(6288)
		if thing then
			thing:remove()
		end
	end
end

local pitsOfInfernoWalls = Action()
function pitsOfInfernoWalls.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 2772 then
		doRemoveFirewalls(pos[item.uid])
		Position(pos[item.uid]):sendMagicEffect(CONST_ME_FIREAREA)
	else
		Game.createItem(6288, 1, pos[item.uid])
		Position(pos[item.uid]):sendMagicEffect(CONST_ME_FIREAREA)
	end
	item:transform(item.itemid == 2772 and 2773 or 2772)
	return true
end

for unique, info in pairs(pos) do
	pitsOfInfernoWalls:uid(unique)
end

pitsOfInfernoWalls:register()

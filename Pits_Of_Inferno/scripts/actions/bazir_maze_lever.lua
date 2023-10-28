local pitsOfInfernoMazeLever = Action()
function pitsOfInfernoMazeLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local portal = Tile(Position(2616, 2554, 13)):getItemById(1949)
	if not portal then
		local item = Game.createItem(1949, 1, Position(2616, 2554, 13))
		if item:isTeleport() then
			item:setDestination(Position(2567, 2575, 15))
		end
	else
		portal:remove()
	end
	item:transform(item.itemid == 2772 and 2773 or 2772)
	return true
end

pitsOfInfernoMazeLever:uid(50105)
pitsOfInfernoMazeLever:register()

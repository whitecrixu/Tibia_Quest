local lava = {
	Position(2605, 2548, 11),
	Position(2605, 2547, 11),
	Position(2605, 2546, 11),
	Position(2606, 2546, 11),
	Position(2606, 2547, 11),
	Position(2606, 2548, 11),
	Position(2606, 2548, 11),
	Position(2607, 2546, 11),
	Position(2607, 2547, 11),
	Position(2607, 2545, 11),
	Position(2607, 2544, 11),
	Position(2607, 2543, 11),
	Position(2608, 2543, 11),
	Position(2608, 2543, 11),
	Position(2608, 2545, 11),
	Position(2608, 2546, 11),
	Position(2608, 2547, 11),
	Position(2609, 2547, 11),
	Position(2609, 2546, 11),
	Position(2609, 2545, 11),
	Position(2609, 2544, 11),
	Position(2609, 2543, 11),
	Position(2609, 2542, 11),
	Position(2610, 2542, 11),
	Position(2610, 2543, 11),
	Position(2610, 2544, 11),
	Position(2610, 2545, 11),
	Position(2610, 2546, 11),
	Position(2610, 2547, 11),
	Position(2610, 2548, 11),
	Position(2610, 2548, 11),
	Position(2611, 2546, 11),
	Position(2611, 2545, 11),
	Position(2611, 2544, 11),
	Position(2611, 2543, 11),
	Position(2611, 2542, 11),
	Position(2611, 2542, 11),
	Position(2612, 2543, 11),
	Position(2613, 2543, 11),
	Position(2614, 2543, 11),
	Position(2608, 2544, 11),
	Position(2609, 2548, 11),
	Position(2611, 2547, 11),
	Position(2612, 2542, 11),
	Position(2613, 2542, 11),
	Position(2614, 2542, 11),
	Position(2614, 2544, 11),
	Position(2613, 2544, 11),
}

--- Add this in /data-server/scripts/lib/register_actions.lua

	elseif target.itemid == 1791 then
		-- The Pits of Inferno Quest
		if toPosition == Position(2608, 2543, 11) then
			for i = 1, #lava do
				Game.createItem(5815, 1, lava[i])
			end
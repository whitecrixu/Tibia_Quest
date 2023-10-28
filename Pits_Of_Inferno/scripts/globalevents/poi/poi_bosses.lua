local spawns = {
	[1] = { position = Position(2676, 2479, 15), monster = "Massacre" },
	[2] = { position = Position(2637, 2517, 15), monster = "Dracola" },
	[3] = { position = Position(2707, 2423, 15), monster = "The Imperor" },
	[4] = { position = Position(2560, 2452, 15), monster = "Mr. Punish" },
	[5] = { position = Position(2601, 2541, 15), monster = "Countess Sorrow" },
	[6] = { position = Position(2645, 2542, 15), monster = "The Plasmother" },
	[7] = { position = Position(2585, 2498, 15), monster = "The Handmaiden" },
}

local pitsOfInfernoBosses = GlobalEvent("PitsOfInfernoBosses")
function pitsOfInfernoBosses.onThink(interval, lastExecution)
	local spawn = spawns[math.random(#spawns)]
	local monster = Game.createMonster(spawn.monster, spawn.position, true, true)

	if not monster then
		logger.error("[PitsOfInfernoBosses] - Failed to spawn {}", rand.bossName)
		return true
	end
	return true
end

pitsOfInfernoBosses:interval(46800000)
pitsOfInfernoBosses:register()

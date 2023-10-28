local setting = {
	[2080] = {
		storage = Storage.PitsOfInferno.ThroneInfernatil,
		text = "You have touched Infernatil's throne and absorbed some of his spirit.",
		effect = CONST_ME_FIREAREA,
		toPosition = Position(2709, 2419, 15),
	},
	[2081] = {
		storage = Storage.PitsOfInferno.ThroneTafariel,
		text = "You have touched Tafariel's throne and absorbed some of his spirit.",
		effect = CONST_ME_MORTAREA,
		toPosition = Position(2559, 2452, 15),
	},
	[2082] = {
		storage = Storage.PitsOfInferno.ThroneVerminor,
		text = "You have touched Verminor's throne and absorbed some of his spirit.",
		effect = CONST_ME_POISONAREA,
		toPosition = Position(2640, 2537, 15),
	},
	[2083] = {
		storage = Storage.PitsOfInferno.ThroneApocalypse,
		text = "You have touched Apocalypse's throne and absorbed some of his spirit.",
		effect = CONST_ME_EXPLOSIONAREA,
		toPosition = Position(2675, 2476, 15),
	},
	[2084] = {
		storage = Storage.PitsOfInferno.ThroneBazir,
		text = "You have touched Bazir's throne and absorbed some of his spirit.",
		effect = CONST_ME_MAGIC_GREEN,
		toPosition = Position(2517, 2594, 13),
	},
	[2085] = {
		storage = Storage.PitsOfInferno.ThroneAshfalor,
		text = "You have touched Ashfalor's throne and absorbed some of his spirit.",
		effect = CONST_ME_FIREAREA,
		toPosition = Position(2639, 2517, 15),
	},
	[2086] = {
		storage = Storage.PitsOfInferno.ThronePumin,
		text = "You have touched Pumin's throne and absorbed some of his spirit.",
		effect = CONST_ME_MORTAREA,
		toPosition = Position(2585, 2487, 15),
	},
}

local throne = MoveEvent()

function throne.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local throne = setting[item.uid]
	if not throne then
		return true
	end

	if player:getStorageValue(throne.storage) ~= 1 then
		player:setStorageValue(throne.storage, 1)
		player:setStorageValue(Storage.PitsOfInferno.ShortcutHubDoor, 1)
		player:getPosition():sendMagicEffect(throne.effect)
		player:say(throne.text, TALKTYPE_MONSTER_SAY)
	else
		player:teleportTo(throne.toPosition)
		player:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
		player:say("Begone!", TALKTYPE_MONSTER_SAY)
	end
	return true
end

throne:type("stepin")

for index, value in pairs(setting) do
	throne:uid(index)
end

throne:register()

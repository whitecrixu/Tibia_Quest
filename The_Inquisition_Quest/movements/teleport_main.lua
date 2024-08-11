local teleports = {
	-- Teleport configurations
	[2150] = {text = "Entering Ushuriel's ward.", newPos = Position(3103, 4219, 5), storage = 0, alwaysSetStorage = true},
	[2151] = {text = "Entering the Crystal Caves.", bossStorage = 200, newPos = Position(3178, 4142, 5), storage = 1},
	[2152] = {text = "Escaping back to the Retreat.", newPos = Position(3068, 4088, 7)},
	[2153] = {text = "Entering the Crystal Caves.", newPos = Position(3178, 4142, 5), storage = 1},
	[2154] = {text = "Entering the Sunken Caves.", newPos = Position(3190, 4072, 5)},
	[2155] = {text = "Entering the Mirror Maze of Madness.", newPos = Position(3172, 4124, 2)},
	[2156] = {text = "Entering Zugurosh's ward.", newPos = Position(3135, 4218, 5)},
	[2157] = {text = "Entering the Blood Halls.", bossStorage = 201, newPos = Position(3134, 4155, 5), storage = 2},
	[2158] = {text = "Escaping back to the Retreat.", newPos = Position(3068, 4088, 7)},
	[2159] = {text = "Entering the Blood Halls.", newPos = Position(3134, 4155, 5), storage = 2},
	[2160] = {text = "Entering the Foundry.", newPos = Position(3153, 4132, 5)},
	[2161] = {text = "Entering Madareth's ward.", newPos = Position(3117, 4258, 5)},
	[2162] = {text = "Entering the Vats.", bossStorage = 202, newPos = Position(3050, 4210, 6), storage = 3},
	[2163] = {text = "Escaping back to the Retreat.", newPos = Position(3068, 4088, 7)},
	[2164] = {text = "Entering the Vats.", newPos = Position(3050, 4210, 6), storage = 3},
	[2165] = {text = "Entering the Battlefield.", newPos = Position(3048, 4138, 6)},
	[2166] = {text = "Entering the Vats.", newPos = Position(3118, 4183, 6)},
	[2167] = {text = "Entering the Demon Forge.", newPos = Position(3152, 4257, 5)},
	[2168] = {text = "Entering the Arcanum.", bossStorage = 203, newPos = Position(3157, 4200, 6), storage = 4},
	[2169] = {text = "Escaping back to the Retreat.", newPos = Position(3068, 4088, 7)},
	[2170] = {text = "Entering the Arcanum.", newPos = Position(3157, 4200, 6), storage = 4},
	[2171] = {text = "Entering the Soul Wells.", newPos = Position(3245, 4144, 6)},
	[2172] = {text = "Entering the Arcanum.", newPos = Position(3231, 4150, 6)},
	[2173] = {text = "Entering the Annihilon's ward.", newPos = Position(3189, 4217, 5)},
	[2174] = {text = "Entering the Hive.", bossStorage = 204, newPos = Position(3252, 4301, 5), storage = 5},
	[2175] = {text = "Escaping back to the Retreat.", newPos = Position(3068, 4088, 7)},
	[2176] = {text = "Entering the Hive.", newPos = Position(3252, 4301, 5), storage = 5},
	[2177] = {text = "Entering the Hellgorak's ward.", newPos = Position(3196, 4260, 5)},
	[2178] = {text = "Entering the Shadow Nexus. Abandon all Hope.", bossStorage = 205, newPos = Position(3070, 4313, 6), storage = 6},
	[2179] = {text = "Escaping back to the Retreat.", newPos = Position(3068, 4088, 7)},
	[2180] = {text = "Entering the Blood Halls.", newPos = Position(3119, 4132, 3)},
}

local teleportMain = MoveEvent()

function teleportMain.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local teleport = teleports[item.uid]
	if not teleport then
		return true
	end

	-- Handle setting the storage value if required
	if teleport.alwaysSetStorage and player:getStorageValue(Storage.TheInquisition.EnterTeleport) < teleport.storage then
		player:setStorageValue(Storage.TheInquisition.EnterTeleport, teleport.storage)
	end

	-- Handle boss storage logic
	if teleport.bossStorage then
		if Game.getStorageValue(teleport.bossStorage) >= 2 then
			if player:getStorageValue(Storage.TheInquisition.EnterTeleport) < teleport.storage then
				player:setStorageValue(Storage.TheInquisition.EnterTeleport, teleport.storage)
				player:setStorageValue(teleport.bossStorage, 0)
			end
		else
			-- Teleport the player back if the boss is not defeated
			player:teleportTo(Position(33165, 31709, 14))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:say("Escaping back to the Retreat.", TALKTYPE_MONSTER_SAY)
			return true
		end
	elseif teleport.storage and player:getStorageValue(Storage.TheInquisition.EnterTeleport) < teleport.storage then
		-- Teleport the player back if they haven't unlocked this teleport
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say("You don't have enough energy to enter this portal", TALKTYPE_MONSTER_SAY)
		return true
	end

	-- Teleport the player to the new position and display the message
	player:teleportTo(teleport.newPos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:say(teleport.text, TALKTYPE_MONSTER_SAY)
	return true
end

teleportMain:type("stepin")

-- Register the MoveEvent for each teleport UID
for uid in pairs(teleports) do
	teleportMain:uid(uid)
end

teleportMain:register()

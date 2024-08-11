local internalNpcName = "Henricus"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {
	name = internalNpcName,
	description = internalNpcName,
	health = 100,
	maxHealth = 100,
	walkInterval = 2000,
	walkRadius = 2,
	outfit = {
		lookType = 132,
		lookHead = 79,
		lookBody = 0,
		lookLegs = 96,
		lookFeet = 0,
		lookAddons = 0,
	},
	flags = { floorchange = false },
}

-- Keyword handler and NPC handler initialization
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

-- Link NPC events to the npcHandler methods
npcType.onThink = function(npc, interval) npcHandler:onThink(npc, interval) end
npcType.onAppear = function(npc, creature) npcHandler:onAppear(npc, creature) end
npcType.onDisappear = function(npc, creature) npcHandler:onDisappear(npc, creature) end
npcType.onMove = function(npc, creature, fromPosition, toPosition) npcHandler:onMove(npc, creature, fromPosition, toPosition) end
npcType.onSay = function(npc, creature, type, message) npcHandler:onSay(npc, creature, type, message) end
npcType.onCloseChannel = function(npc, creature) npcHandler:onCloseChannel(npc, creature) end

local flaskCost = 1000

-- Function to handle NPC dialogues and interactions
local function creatureSayCallback(npc, creature, type, message)
	local player = creature:getPlayer()
	if not npcHandler:checkInteraction(npc, creature) then return false end

	local playerId = player:getId()
	local missing, totalBlessPrice = Blessings.getInquisitionPrice(player)

	if MsgContains(message, "inquisitor") then
		npcHandler:say("The churches of the gods entrusted me with the enormous and responsible task to lead the inquisition. I leave the field work to inquisitors who I recruit from fitting people that cross my way.", npc, creature)
	elseif MsgContains(message, "join") then
		npcHandler:say("Do you want to join the inquisition?", npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif MsgContains(message, "blessing") or MsgContains(message, "bless") then
		if player:getStorageValue(Storage.TheInquisition.Questline) == 25 then
			npcHandler:say("Do you want to receive the blessing of the inquisition - which means " .. (missing == 5 and "all five available" or missing) .. " blessings - for " .. totalBlessPrice .. " gold?", npc, creature)
			npcHandler:setTopic(playerId, 7)
		else
			npcHandler:say("You cannot get this blessing unless you have completed The Inquisition Quest.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "flask") or MsgContains(message, "special flask") then
		if player:getStorageValue(Storage.TheInquisition.Questline) >= 12 then
			npcHandler:say("Do you want to buy the special flask of holy water for " .. flaskCost .. " gold?", npc, creature)
			npcHandler:setTopic(playerId, 8)
		else
			npcHandler:say("You do not need this flask right now.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "mission") or MsgContains(message, "report") then
		local questline = player:getStorageValue(Storage.TheInquisition.Questline)
		if questline < 1 then
			npcHandler:say("Do you want to join the inquisition?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif questline == 1 then
			npcHandler:say({
				"Let's see if you are worthy. Take an inquisitor's field guide from the box in the back room. ...",
				"Follow the instructions in the guide to talk to the Thaian guards that protect the walls and gates of the city and test their loyalty. Then report to me about your {mission}.",
			}, npc, creature)
			player:setStorageValue(Storage.TheInquisition.Mission07, 1)
			player:addItem(133, 1)
			npcHandler:setTopic(playerId, 0)
		elseif questline == 21 or questline == 22 then
			npcHandler:say("Your current mission is to destroy the shadow nexus in the Demon Forge. Are you done with that mission?", npc, creature)
			npcHandler:setTopic(playerId, 6)
		end
	elseif MsgContains(message, "yes") then
		local topic = npcHandler:getTopic(playerId)
		if topic == 2 then
			npcHandler:say("So be it. Now you are a member of the inquisition. You might ask me for a {mission} to raise in my esteem.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif topic == 8 then
			if player:removeMoneyBank(flaskCost) then
				npcHandler:say("Here is your new flask!", npc, creature)
				player:addItem(133, 1)
			else
				npcHandler:say("Come back when you have enough money.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif topic == 7 then
			if missing == 0 then
				npcHandler:say("You already have been blessed!", npc, creature)
			elseif player:removeMoneyBank(totalBlessPrice) then
				npcHandler:say("You have been blessed by all five gods!", npc, creature)
				player:addMissingBless(false)
				player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
			else
				npcHandler:say("Come back when you have enough money.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

-- Adding dialogue keywords and their respective responses
keywordHandler:addKeyword({ "paladin" }, StdModule.say, { npcHandler = npcHandler, text = "It's a shame that only a few paladins still use their abilities to further the cause of the gods of good. Too many paladins have become selfish and greedy." })
keywordHandler:addKeyword({ "knight" }, StdModule.say, { npcHandler = npcHandler, text = "Nowadays, most knights seem to have forgotten the noble cause to which all knights were bound in the past. Only a few have remained pious, serve the gods and follow their teachings." })
keywordHandler:addKeyword({ "sorcerer" }, StdModule.say, { npcHandler = npcHandler, text = "Those who wield great power have to resist great temptations. We have the burden to eliminate all those who give in to the temptations." })
keywordHandler:addKeyword({ "druid" }, StdModule.say, { npcHandler = npcHandler, text = "The druids here still follow the old rules. Sadly, the druids of Carlin have left the right path in the last years." })
keywordHandler:addKeyword({ "dwarf" }, StdModule.say, { npcHandler = npcHandler, text = "The dwarfs are allied with Thais but follow their own obscure religion. Although dwarfs keep mostly to themselves, we have to observe this alliance closely." })
keywordHandler:addKeyword({ "kazordoon" }, StdModule.say, { npcHandler = npcHandler, text = "The dwarfs are allied with Thais but follow their own obscure religion. Although dwarfs keep mostly to themselves, we have to observe this alliance closely." })
keywordHandler:addKeyword({ "elves" }, StdModule.say, { npcHandler = npcHandler, text = "Those elves are hardly any more civilised than orcs. They can become a threat to mankind at any time." })
keywordHandler:addKeyword({ "ab'dendriel" }, StdModule.say, { npcHandler = npcHandler, text = "Those elves are hardly any more civilised than orcs. They can become a threat to mankind at any time." })
keywordHandler:addKeyword({ "venore" }, StdModule.say, { npcHandler = npcHandler, text = "Venore is somewhat difficult to handle. The merchants have a close eye on our activities in their city and our authority is limited there. However, we will use all of our influence to prevent a second Carlin." })
keywordHandler:addKeyword({ "drefia" }, StdModule.say, { npcHandler = npcHandler, text = "Drefia used to be a city of sin and heresy, just like Carlin nowadays. One day, the gods decided to destroy this town and to erase all evil there." })
keywordHandler:addKeyword({ "darashia" }, StdModule.say, { npcHandler = npcHandler, text = "Darashia is a godless town full of mislead fools. One day, it will surely share the fate of its sister town Drefia." })
keywordHandler:addKeyword({ "demon" }, StdModule.say, { npcHandler = npcHandler, text = "Demons exist in many different shapes and levels of power. In general, they are servants of the dark gods and command great powers of destruction." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "Carlin is a city of sin and heresy. After the reunion of Carlin with the kingdom, the inquisition will have much work to purify the city and its inhabitants." })
keywordHandler:addKeyword({ "zathroth" }, StdModule.say, { npcHandler = npcHandler, text = "We can see his evil influence almost everywhere. Keep your eyes open or the dark one will lead you on the wrong way and destroy you." })
keywordHandler:addKeyword({ "crunor" }, StdModule.say, { npcHandler = npcHandler, text = "The church of Crunor works closely together with the druid guild. This makes a cooperation sometimes difficult." })
keywordHandler:addKeyword({ "gods" }, StdModule.say, { npcHandler = npcHandler, text = "We owe to the gods of good our creation and continuing existence. If it weren't for them, we would surely fall prey to the minions of the vile and dark gods." })
keywordHandler:addKeyword({ "church" }, StdModule.say, { npcHandler = npcHandler, text = "The churches of the gods united to fight heresy and dark magic. They are the shield of the true believers, while the inquisition is the sword that fights all enemies of virtuousness." })
keywordHandler:addKeyword({ "inquisitor" }, StdModule.say, { npcHandler = npcHandler, text = "The churches of the gods entrusted me with the enormous and responsible task to lead the inquisition. I leave the field work to inquisitors who I recruit from fitting people that cross my way." })
keywordHandler:addKeyword({ "believer" }, StdModule.say, { npcHandler = npcHandler, text = "Belive on the gods and they will show you the path." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "By edict of the churches I'm the Lord Inquisitor." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I'm Henricus, the Lord Inquisitor." })

-- Setting NPC messages
npcHandler:setMessage(MESSAGE_GREET, "Greetings, fellow {believer} |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Always be on guard, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "This ungraceful haste is most suspicious!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

-- NPC shop configuration
npcConfig.shop = {
	{ itemName = "holy water", clientId = 133, buy = 1000 },
}

-- On buy item event for the shop
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end

-- On sell item event for the shop
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end

-- On check item event for the shop (item inspection)
npcType.onCheckItem = function(npc, player, clientId, subType) end

-- Registering the NPC with the npcConfig table
npcType:register(npcConfig)

-- Configuration table for rewards
local rewards = {
	[1300] = 8062,
	[1301] = 8090,
	[1302] = 8053,
	[1303] = 8060,
	[1304] = 8023,
	[1305] = 8096,
	[1306] = 8100,
	[1307] = 8102,
	[1308] = 8026,
}

-- Action handler for inquisition rewards
local inquisitionRewards = Action()

function inquisitionRewards.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- Check if the player has already received the reward
	if player:getStorageValue(Storage.TheInquisition.Reward) < 1 then
		-- Update the player's storage values
		player:setStorageValue(Storage.TheInquisition.Reward, 1)
		player:setStorageValue(Storage.TheInquisition.Questline, 25)
		player:setStorageValue(Storage.TheInquisition.Mission07, 5) -- Update quest log for "Mission 7: The Shadow Nexus"

		-- Give the reward item to the player
		local rewardItemId = rewards[item.uid]
		if rewardItemId then
			player:addItem(rewardItemId, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found " .. ItemType(rewardItemId):getName() .. ".")
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Something went wrong, reward item not found.")
			return true
		end

		-- Grant the player achievements and outfit addons
		player:addAchievement("Master of the Nexus")

		-- Adding both addons at once
		player:addOutfitAddon(288, 1) -- Male Outfit
		player:addOutfitAddon(288, 2)
		player:addOutfitAddon(289, 1) -- Female Outfit
		player:addOutfitAddon(289, 2)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")
	end
	return true
end

-- Register the action for each unique ID in the rewards table
for uniqueId in pairs(rewards) do
	inquisitionRewards:uid(uniqueId)
end

inquisitionRewards:register()

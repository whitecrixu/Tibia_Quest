-- Define the position of the shadow nexus
local shadowNexusPosition = Position(3074, 4333, 6)

-- Define the positions for visual effects
local effectPositions = {
    Position(3073, 4333, 6),
    Position(3075, 4333, 6),
}

-- Function to revert an item at a specific position
local function revertItem(position, itemId, transformId)
    local item = Tile(position):getItemById(itemId)
    if item then
        item:transform(transformId)
    end
end

-- Function to send a message to all spectators around the shadow nexus
local function nexusMessage(player, message)
    local spectators = Game.getSpectators(shadowNexusPosition, false, true, 3, 3)
    for i = 1, #spectators do
        player:say(message, TALKTYPE_MONSTER_YELL, false, spectators[i], shadowNexusPosition)
    end
end

-- Configuration table for item IDs
local config = {
    antler_talisman = 22008,
    sacred_antler_talisman = 22009,
}

-- Define the action for the holy water item
local othersHolyWater = Action()

-- Function to handle the usage of the holy water item
function othersHolyWater.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Transform antler talisman into sacred antler talisman
    if target.itemid == config.antler_talisman then
        item:transform(config.sacred_antler_talisman)
        item:remove(1)
        target:remove(1)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You besprinkle the antler talisman with holy water. It glitters faintly.")
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
        return true
    end

    -- Handle shadow nexus interaction
    if table.contains({7925, 7927, 7929}, target.itemid) then
        if target.itemid == 7929 then
            Game.setStorageValue(GlobalStorage.Inquisition, math.random(4, 5))
        end
        local newShadowNexus = Game.createItem(target.itemid + 1, 1, shadowNexusPosition)
        if newShadowNexus then
            target:remove()
            newShadowNexus:decay()
        end
        nexusMessage(player, player:getName() .. " damaged the shadow nexus! You can't damage it while it's burning.")
        toPosition:sendMagicEffect(CONST_ME_ENERGYHIT)
    elseif target.itemid == 7931 then
        if Game.getStorageValue(GlobalStorage.Inquisition) > 0 then
            Game.setStorageValue(GlobalStorage.Inquisition, Game.getStorageValue(GlobalStorage.Inquisition) - 1)
            if player:getStorageValue(Storage.TheInquisition.Questline) < 22 then
                -- Update the quest log for 'Mission 7: The Shadow Nexus'
                player:setStorageValue(Storage.TheInquisition.Mission07, 2)
                player:setStorageValue(Storage.TheInquisition.Questline, 22)
            end
            for i = 1, #effectPositions do
                effectPositions[i]:sendMagicEffect(CONST_ME_HOLYAREA)
            end
            nexusMessage(player, player:getName() .. " destroyed the shadow nexus! In 10 seconds it will return to its original state.")
            item:remove(1)
            toPosition:sendMagicEffect(CONST_ME_HOLYAREA)
        else
            target:transform(7925)
        end
    end

    return true
end

-- Register the action with the ID of the holy water item
othersHolyWater:id(133)
othersHolyWater:register()

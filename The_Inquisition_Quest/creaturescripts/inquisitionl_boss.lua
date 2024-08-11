-- Configuration table for bosses and their storage values
local bosses = {
    ["ushuriel"] = 200,
    ["zugurosh"] = 201,
    ["madareth"] = 202,
    ["latrivan"] = 203,
    ["golgordan"] = 203,
    ["annihilon"] = 204,
    ["hellgorak"] = 205,
}

-- CreatureEvent for handling Inquisition boss kills
local inquisitionBossKill = CreatureEvent("InquisitionBossKill")

function inquisitionBossKill.onKill(player, target)
    local targetMonster = target:getMonster()
    if not targetMonster then
        return true
    end

    local targetName = targetMonster:getName():lower()
    local bossStorage = bosses[targetName]

    if not bossStorage then
        return true
    end

    local currentValue = Game.getStorageValue(bossStorage)
    local newValue = (targetName == "latrivan" or targetName == "golgordan") and math.max(0, currentValue) + 1 or 2
    Game.setStorageValue(bossStorage, newValue)

    if newValue == 2 then
        player:say("You now have 10 minutes to exit this room through the teleporter. It will bring you to the next room.", TALKTYPE_MONSTER_SAY)
        addEvent(Game.setStorageValue, 10 * 60 * 1000, bossStorage, 0)
    end

    return true
end

inquisitionBossKill:register()

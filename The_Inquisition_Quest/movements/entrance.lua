local entrance = MoveEvent()

function entrance.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    if player:getLevel() >= 100 then
        local destination = Position(3072, 4062, 8)
        player:teleportTo(destination)
        position:sendMagicEffect(CONST_ME_TELEPORT)
        destination:sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end

    player:teleportTo(fromPosition, true)
    position:sendMagicEffect(CONST_ME_TELEPORT)
    fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
    return true
end

entrance:type("stepin")
entrance:uid(9014)
entrance:register()

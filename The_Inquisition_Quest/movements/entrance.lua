local entrance = MoveEvent()

function entrance.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    local destination = player:getLevel() >= 100 and Position(3072, 4062, 8) or fromPosition
    player:teleportTo(destination, true)

    local teleportEffect = CONST_ME_TELEPORT
    position:sendMagicEffect(teleportEffect)
    destination:sendMagicEffect(teleportEffect)

    return true
end

entrance:type("stepin")
entrance:uid(9014)
entrance:register()

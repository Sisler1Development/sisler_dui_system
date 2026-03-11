-- SISLER DEVELOPMENT DUI SYSTEM
-- Discord: sisler0695

local myBAC = 0.0


RegisterCommand(Config.SetBACCommand, function(source,args)

    local level = tonumber(args[1])

    if level == nil then
        TriggerEvent("sisler_dui:notify","Usage: /"..Config.SetBACCommand.." 0.08")
        return
    end

    TriggerServerEvent("sisler_dui:setBAC", level)

end)



RegisterCommand(Config.TestBACCommand, function()

    local player, distance = GetClosestPlayer()

    if player == -1 or distance > Config.TestDistance then
        TriggerEvent("sisler_dui:notify","No player nearby")
        return
    end

    local serverId = GetPlayerServerId(player)

    TriggerServerEvent("sisler_dui:testPlayer", serverId)

end)



RegisterNetEvent("sisler_dui:testResult")
AddEventHandler("sisler_dui:testResult", function(bac, dui)

    TriggerEvent("chat:addMessage",{
        args = {
            "^1Breathalyzer Result",
            "BAC: "..bac.." | DUI: "..dui
        }
    })

end)



RegisterNetEvent("sisler_dui:notify")
AddEventHandler("sisler_dui:notify", function(msg)

    TriggerEvent("chat:addMessage",{
        args = {Config.Prefix, msg}
    })

end)



function GetClosestPlayer()

    local players = GetActivePlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)

    for i=1,#players do

        local target = GetPlayerPed(players[i])

        if target ~= ply then

            local targetCoords = GetEntityCoords(target)
            local distance = #(plyCoords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then

                closestPlayer = players[i]
                closestDistance = distance

            end

        end

    end

    return closestPlayer, closestDistance

end
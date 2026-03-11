-- SISLER DEVELOPMENT DUI SYSTEM
-- Discord: sisler0695

local PlayerBAC = {}

RegisterServerEvent("sisler_dui:setBAC")
AddEventHandler("sisler_dui:setBAC", function(level)

    local src = source

    if not IsPlayerAceAllowed(src, Config.AcePermissions.CivSetBAC) then
        TriggerClientEvent("sisler_dui:notify", src, "You are not allowed to use this command.")
        return
    end

    local bac = tonumber(level)

    if not bac then
        TriggerClientEvent("sisler_dui:notify", src, "Invalid BAC value.")
        return
    end

    PlayerBAC[src] = bac

    TriggerClientEvent("sisler_dui:notify", src, "Your BAC level is now "..bac)

end)


RegisterServerEvent("sisler_dui:testPlayer")
AddEventHandler("sisler_dui:testPlayer", function(target)

    local src = source

    if not IsPlayerAceAllowed(src, Config.AcePermissions.Police) then
        TriggerClientEvent("sisler_dui:notify", src, "You are not authorized.")
        return
    end

    local bac = PlayerBAC[target] or 0.00
    local dui = "NO"

    if bac >= Config.DUILimit then
        dui = "YES"
    end

    TriggerClientEvent("sisler_dui:testResult", src, bac, dui)

end)


AddEventHandler("playerDropped", function()

    local src = source
    PlayerBAC[src] = nil

end)
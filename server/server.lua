-- HUB

ESX = nil
ESX = exports["es_extended"]:getSharedObject()

RegisterCommand("hub", function(source)
    local xPlayer = ESX.GetPlayerFromId(source) 
    local PlayerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(PlayerPed)
    local distance = #(playerCoords - Config.HubCenter)  -- Utilizamos Config.HubCenter aquí

    FreezeEntityPosition(source, true)
    TriggerClientEvent("esx:showNotification", source, "Serás teletransportado al hub en 1 segundos.")
    Citizen.Wait(1000)
    -- TriggerClientEvent('frazz:componenti', source)
    -- TriggerClientEvent('frazzsmontaarmi:disarm', source)
    FreezeEntityPosition(source, false)
    SetPlayerRoutingBucket(source, 2000)
    SetEntityCoords(source, Config.HubCenter.x, Config.HubCenter.y, Config.HubCenter.z, true, true, true, false)  -- Utilizamos Config.HubCenter aquí
    TriggerClientEvent("esx:showNotification", source, "Te has conectado al Lobby #2000")
end)

ESX = nil
ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
    SpawnNPC(Config.LNPCTP.modelo, Config.LNPCTP.x, Config.LNPCTP.y, Config.LNPCTP.z, Config.LNPCTP.h)
end)

Citizen.CreateThread(function()
    while true do
        local _lockserwait = 250
        local _char = PlayerPedId()
        local _charPos = GetEntityCoords(_char)
        
        if GetDistanceBetweenCoords(_charPos, Config.LNPCTP.x, Config.LNPCTP.y, Config.LNPCTP.z, false) < 2 then
            _lockserwait = 0
            ESX.ShowHelpNotification(Config.NotificationMessage, vector3(Config.LNPCTP.x, Config.LNPCTP.y, Config.LNPCTP.z))
            if IsControlJustPressed(0, 38) then
                ExecuteCommand('hub')
                end
            end
        Citizen.Wait(_lockserwait)
    end
end)

-- SPAWNNPC
SpawnNPC = function (modelo, x, y, z, h)
    hash = GetHashKey(modelo)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(1)
    end
    crearNPC = CreatePed(5, hash, x, y, z, h, false, true)
    FreezeEntityPosition(crearNPC, true)
    SetEntityInvincible(crearNPC, true)
    SetBlockingOfNonTemporaryEvents(crearNPC, true)
end

-- HOLOGRAMA
Citizen.CreateThread(function()
    Holograms()
end)


function Holograms()
    while true do
        Citizen.Wait(0)			
        if GetDistanceBetweenCoords(Config.LNPCTP.x, Config.LNPCTP.y, Config.LNPCTP.z, GetEntityCoords(GetPlayerPed(-1))) < 10.0 then
            Draw3DText(Config.LNPCTP.x, Config.LNPCTP.y, Config.LNPCTP.z, Config.TextoNPC, 4, 0.1, 0.1)
        end	
    end
end

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
     local px,py,pz=table.unpack(GetGameplayCamCoords())
     local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
     local scale = (1/dist)*20
     local fov = (1/GetGameplayCamFov())*100
     local scale = scale*fov   
     SetTextScale(scaleX*scale, scaleY*scale)
     SetTextFont(fontId)
     SetTextProportional(1)
     SetTextColour(250, 250, 250, 255)		-- You can change the text color here
     SetTextDropshadow(1, 1, 1, 1, 255)
     SetTextEdge(2, 0, 0, 0, 150)
     SetTextDropShadow()
     SetTextOutline()
     SetTextEntry("STRING")
     SetTextCentre(1)
     AddTextComponentString(textInput)
     SetDrawOrigin(x,y,z+2, 0)
     DrawText(0.0, 0.0)
     ClearDrawOrigin()
    end

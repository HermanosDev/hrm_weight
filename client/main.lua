local gros = 0
local disabledKeys = {
	{group = 2, key = 37},
	{group = 0, key = 24},
	{group = 0, key = 69},
	{group = 0, key = 92},
	{group = 0, key = 106},
	{group = 0, key = 168},
	{group = 0, key = 160},
	{group = 0, key = 160},
}

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if gros == 1 or gros == 2 then 
            DisableControlAction(0,21,true)
            DisableControlAction(0,22,true)
            SetTextFont(0)
            SetTextProportional(1)
            SetTextScale(0.0, 0.3)
            SetTextColour(255, 0, 0, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            if gros == 1 then 
                AddTextComponentString("Vous êtes trop lourd vous ne pouvez pas courir/sauter.")
            elseif gros == 2 then 
                DisablePlayerFiring(PlayerPedId(), true)

                for i = 1, #disabledKeys, 1 do
                    DisableControlAction(disabledKeys[i].group, disabledKeys[i].key, true)
                    if IsDisabledControlJustPressed(disabledKeys[i].group, disabledKeys[i].key) then
                        SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
                    end
                end

                AddTextComponentString("Vous avez trop d'objets vous ne pouvez plus marcher.")
            end
            DrawText(0.36, 0.9)  
        end
        BlockWeaponWheelThisFrame()
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)
        HideHudComponentThisFrame(17)
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        HideHudComponentThisFrame(13)
        DisableControlAction(0, 37, true) --Disable Tab
        for k,v in pairs(Config.HotbarKeys) do
            if IsDisabledControlJustPressed(0, v) then
                UseItemFromHotbar(tostring(k-1))
            end
        end
    end
end)


RegisterNetEvent('Poids:refresh')
AddEventHandler('Poids:refresh', function()
    ESX.TriggerServerCallback('Hermanos:getWeight', function(poid) 
        if poid == ESX.GetPlayerData().maxWeight then 
            gros = 1
        elseif poid > ESX.GetPlayerData().maxWeight then 
            gros = 2
        else
            gros = 3
        end
    end)
end)
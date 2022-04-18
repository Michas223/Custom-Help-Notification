local function ShowHelpNotification(action, msg)
    if not action then
        return
    end
    
    PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)

    SendNUIMessage({type = 'HELP', action = action, msg = msg})
end

RegisterNetEvent('michas-notification:showHelp')
AddEventHandler('michas-notification:showHelp', function(msg)
	ShowHelpNotification('SHOW', msg)
end)

RegisterNetEvent('michas-notification:hideHelp')
AddEventHandler('michas-notification:hideHelp', function()
	ShowHelpNotification('HIDE')
end)
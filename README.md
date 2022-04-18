# Custom-Help-Notification

Wchodzimy w es_extended/client/functions.lua
Szukamy linijki `ESX.ShowHelpNotification = function(msg)`

Usuwamy tą funkcje i wklejamy to
```
ESX.ShowHelpNotification = function(msg)
	TriggerEvent('michas-notification:showHelp', msg)
end

ESX.HideHelpNotification = function()
	TriggerEvent('michas-notification:hideHelp')
end
```

#

W skrypcie w którym chcemy to dodać szukamy ESX.ShowHelpNotification
*Przykładowa taka funkcja*
```
CreateThread(function()
	Citizen.Wait(2000)
	while true do
		Citizen.Wait(3)
		local found = false
		
		local coords = GetEntityCoords(PlayerPedId())
		if PlayerData.job ~= nil then
			for i=1, #Config.PoliceCount, 1 do
				if #(coords - Config.PoliceCount[i].coords) < Config.DrawDistance then
					ESX.DrawMarker(Config.PoliceCount[i].coords)
					if #(coords - Config.PoliceCount[i].coords) < 1.5 then
						found = true

						ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~, aby sprawdzić tablicę funkcjonariuszy')

						if IsControlJustReleased(0, Keys['E']) then
							ESX.TriggerServerCallback("esx_scoreboard:getConnectedCops", function(MisiaczekPlayers)
								if MisiaczekPlayers then
									ESX.ShowNotification("~b~Na służbie jest aktualnie " .. MisiaczekPlayers['police'] .. " funkcjonariuszy")
								end
							end)
						end
					end
				end
			end
			
		else
			Citizen.Wait(2000)
		end
	end
end)
```

Tam gdzie widzimy `~INPUT_...~`

Zamieniamy na `<span style="button">przycisk</span>`

#

Na początku funkcji dodajemy `local shownotify = false`

Po linijce w której jest porównanie kordów gracza do kordów markera (Przykład `if #(coords - Config.PoliceCount[i].coords) < 1.5 then`)

```
if not shownotify then
  shownotify = true

  ESX.ShowHelpNotification('tutaj treść ESX.ShowHelpNotification który mieliśmy wcześniej')
end
```

#
Po całym `for` dodajemy 
```
 if not found then
  if shownotify then 
    ESX.HideHelpNotification()
    shownotify = false
  end
end
```

# Przykładowy kod po przeróbce powinien wyglądać tak
```
CreateThread(function()
	local shownotify = false
	Citizen.Wait(2000)
	while true do
		Citizen.Wait(3)
		local found = false
		
		local coords = GetEntityCoords(PlayerPedId())
		if PlayerData.job ~= nil then
			for i=1, #Config.PoliceCount, 1 do
				if #(coords - Config.PoliceCount[i].coords) < Config.DrawDistance then
					ESX.DrawMarker(Config.PoliceCount[i].coords)
					if #(coords - Config.PoliceCount[i].coords) < 1.5 then
						found = true
						if not shownotify then
							shownotify = true

							ESX.ShowHelpNotification('Naciśnij <span class="button">E</span>, aby sprawdzić tablicę funkcjonariuszy')
						end
						if IsControlJustReleased(0, Keys['E']) then
							ESX.TriggerServerCallback("esx_scoreboard:getConnectedCops", function(MisiaczekPlayers)
								if MisiaczekPlayers then
									ESX.ShowNotification("~b~Na służbie jest aktualnie " .. MisiaczekPlayers['police'] .. " funkcjonariuszy")
								end
							end)
						end
					end
				end
			end

			if not found then
				if shownotify then 
					ESX.HideHelpNotification()
					shownotify = false
				end
			end
			
		else
			Citizen.Wait(2000)
		end
	end
end)
```

-- CONFIG --

-- The watermark text --
servername = "#REGENERATION"

-- The x and y offset (starting at the top left corner) --
-- Default: 0.005, 0.001
offset = {x = 0.875, y = 0.050}

-- Text RGB Color --
-- Default: 64, 64, 64 (gray)
rgb = {r = 255, g = 255, b = 255}
pingkuning = { r = 255, g = 128, b = 0 }
pingmerah = { r = 255, g = 0, b = 0 }

-- Text transparency --
-- Default: 255
alpha = 200

-- Text scale
-- Default: 0.4
-- NOTE: Number needs to be a float (so instead of 1 do 1.0)
scale = 0.6

-- Text Font --
-- 0 - 5 possible
-- Default: 1
font = 1

-- CODE --
local currentPing = 0

Citizen.CreateThread(function()
	while true do
		Wait(1)

		SetTextFont(font)
		SetTextScale(scale, scale)
		SetTextDropshadow(2, 2, 0, 0, 0)

		if currentPing < 60 then -- ping normal
			SetTextColour(rgb.r, rgb.g, rgb.b, alpha)
		elseif currentPing < 120 then -- ping kuning
			SetTextColour(pingkuning.r, pingkuning.g, pingkuning.b, alpha)
		elseif currentPing < 200 then -- ping merah
			SetTextColour(pingmerah.r, pingmerah.g, pingmerah.b, alpha)
		end
		SetTextWrap(0.0, 1.0)
		SetTextCentre(false)
		SetTextEdge(1, 0, 0, 0, 205)
		SetTextEntry("STRING")
		AddTextComponentString(servername)
		DrawText(offset.x, offset.y)
	end
end)

RegisterNetEvent('updatePing')
AddEventHandler('updatePing', function(ping)
    currentPing = ping
end)

Citizen.CreateThread(function()
    while true do
        TriggerServerEvent('PingUpdate')
        Citizen.Wait(5000)
    end
end)
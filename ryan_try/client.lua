local displayDuration = 5000 -- Duration to display the text in milliseconds

RegisterNetEvent('qb-try:showResult')
AddEventHandler('qb-try:showResult', function(source, message, success)
    local playerPed = GetPlayerPed(GetPlayerFromServerId(source))
    local displayText = success and ("~g~Successful: ~s~" .. message) or ("~r~Unsuccessful: ~s~" .. message)
    
    DisplayTextAbovePlayer(playerPed, displayText, displayDuration)
end)

function DisplayTextAbovePlayer(playerPed, text, duration)
    local endTime = GetGameTimer() + duration
    Citizen.CreateThread(function()
        while GetGameTimer() < endTime do
            local coords = GetEntityCoords(playerPed)
            DrawText3D(coords.x, coords.y, coords.z + 1.2, text)
            Citizen.Wait(0)
        end
    end)
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local scale = 0.35

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextCentre(1)

        local color = { r = 255, g = 255, b = 255, a = 215 }
        local newText = ""
        local inTag = false
        for i = 1, #text do
            local c = text:sub(i, i)
            if c == "^" then
                inTag = true
            elseif inTag then
                if c == "1" then
                    color = { r = 255, g = 0, b = 0, a = 215 }
                elseif c == "2" then
                    color = { r = 0, g = 255, b = 0, a = 215 }
                elseif c == "7" then
                    color = { r = 255, g = 255, b = 255, a = 215 }
                end
                inTag = false
            else
                newText = newText .. c
            end
        end

        SetTextColour(color.r, color.g, color.b, color.a)
        SetTextEntry("STRING")
        AddTextComponentString(newText)
        DrawText(_x, _y)
        local factor = (string.len(newText)) / 370
        DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
    end
end

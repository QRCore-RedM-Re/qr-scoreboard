local Key = QRCore.Shared.GetKey(Config.OpenKey)
local scoreboardOpen = false
local PlayerOptin = {}

local function DrawText3D(x, y, z, text)
	local onScreen, screenX, screenY = GetScreenCoordFromWorldCoord(x, y, z)

	SetTextScale(0.35, 0.35)
	SetTextFontForCurrentCommand(1)
	SetTextColor(255, 255, 255, 223)
	SetTextCentre(1)
	DisplayText(CreateVarString(10, "LITERAL_STRING", text), screenX, screenY)
end

RegisterNetEvent('qr-scoreboard:client:SetActivityBusy')
AddEventHandler('qr-scoreboard:client:SetActivityBusy', function(activity, busy)
    Config.IllegalActions[activity].busy = busy
end)

CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustReleased(0, Key) and IsInputDisabled(0) then
            if not scoreboardOpen then
                local playerList, players, lawmen = lib.callback.await('qr-scoreboard:server:GetScoreboardData', false)

                PlayerOptin = players
                Config.CurrentCops = lawmen

                SendNUIMessage({
                    action = "open",
                    players = playerList,
                    maxPlayers = Config.MaxPlayers,
                    requiredCops = Config.IllegalActions,
                    currentCops = Config.CurrentCops,
                })
                scoreboardOpen = true
            else
                SendNUIMessage({action = "close"})
                scoreboardOpen = false
            end
        end

        if scoreboardOpen then
            local nearby = lib.getNearbyPlayers(GetEntityCoords(cache.ped), 10, true)
            for _, player in pairs(nearby) do
                local PlayerID = GetPlayerServerId(player.id)
                local PlayerCoords = GetEntityCoords(player.ped)

                if Config.ShowAllID or PlayerOptin[PlayerID].permission then
                    DrawText3D(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z + 1.0, '[' .. PlayerID .. ']')
                end
            end
        end
    end
end)
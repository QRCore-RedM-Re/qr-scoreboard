local QRCore = exports['qr-core']:GetCoreObject()


QRCore.Functions.CreateCallback('qr-scoreboard:server:GetCurrentPlayers', function(source, cb)
    local TotalPlayers = 0
    for k, v in pairs(QRCore.Functions.GetPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)

QRCore.Functions.CreateCallback('qr-scoreboard:server:GetActivity', function(source, cb)
    local PoliceCount = 0
    local AmbulanceCount = 0

    for k, v in pairs(QRCore.Functions.GetPlayers()) do
        local Player = QRCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                PoliceCount = PoliceCount + 1
            end

            if ((Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") and Player.PlayerData.job.onduty) then
                AmbulanceCount = AmbulanceCount + 1
            end
        end
    end

    cb(PoliceCount, AmbulanceCount)
end)

QRCore.Functions.CreateCallback('qr-scoreboard:server:GetConfig', function(source, cb)
    cb(Config.IllegalActions)
end)

QRCore.Functions.CreateCallback('qr-scoreboard:server:GetPlayersArrays', function(source, cb)
    local players = {}
    for k, v in pairs(QRCore.Functions.GetPlayers()) do
        local Player = QRCore.Functions.GetPlayer(v)
        if Player ~= nil then
            players[Player.PlayerData.source] = {}
            players[Player.PlayerData.source].permission = QRCore.Functions.IsOptin(Player.PlayerData.source)
        end
    end
    cb(players)
end)

RegisterServerEvent('qr-scoreboard:server:SetActivityBusy')
AddEventHandler('qr-scoreboard:server:SetActivityBusy', function(activity, bool)
    Config.IllegalActions[activity].busy = bool
    TriggerClientEvent('qr-scoreboard:client:SetActivityBusy', -1, activity, bool)
end)

lib.callback.register('qr-scoreboard:server:GetScoreboardData', function(source)
    local totalPlayers = 0
    local lawmenCount = 0
    local players = {}

    for _, v in pairs(QRCore.Functions.GetQRPlayers()) do
        if v then
            totalPlayers += 1

            if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
                lawmenCount += 1
            end

            players[v.PlayerData.source] = {}
            players[v.PlayerData.source].permission = QRCore.Functions.IsOptin(v.PlayerData.source)
        end
    end
    return totalPlayers, players, lawmenCount
end)

RegisterServerEvent('qr-scoreboard:server:SetActivityBusy')
AddEventHandler('qr-scoreboard:server:SetActivityBusy', function(activity, bool)
    Config.IllegalActions[activity].busy = bool
    TriggerClientEvent('qr-scoreboard:client:SetActivityBusy', -1, activity, bool)
end)

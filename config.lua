Config = Config or {}

-- Open scoreboard key
Config.OpenKey = 'UP'

-- Show ALL IDs --
Config.ShowAllID = true

-- Max Server Players
Config.MaxPlayers = GetConvarInt('sv_maxclients', 64) -- It returnes 64 if it cant find the Convar Int

-- Minimum Police for Actions
Config.IllegalActions = {
    ["storerobbery"] = { minimum = 2, busy = false },
    ["trainrobbery"] = { minimum = 3, busy = false },
    ["bankrobbery"] = { minimum = 3, busy = false },
    ["wagonrobbery"] = { minimum = 5, busy = false }
}

-- Current Cops Online
Config.CurrentCops = 0

---------------------------------------------

QRCore = exports['qr-core']:GetCoreObject()
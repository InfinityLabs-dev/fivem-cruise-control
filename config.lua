--[[
██╗███╗░░██╗███████╗██╗███╗░░██╗██╗████████╗██╗░░░██╗  ██╗░░░░░░█████╗░██████╗░░██████╗
██║████╗░██║██╔════╝██║████╗░██║██║╚══██╔══╝╚██╗░██╔╝  ██║░░░░░██╔══██╗██╔══██╗██╔════╝
██║██╔██╗██║█████╗░░██║██╔██╗██║██║░░░██║░░░░╚████╔╝░  ██║░░░░░███████║██████╦╝╚█████╗░
██║██║╚████║██╔══╝░░██║██║╚████║██║░░░██║░░░░░╚██╔╝░░  ██║░░░░░██╔══██║██╔══██╗░╚═══██╗
██║██║░╚███║██║░░░░░██║██║░╚███║██║░░░██║░░░░░░██║░░░  ███████╗██║░░██║██████╦╝██████╔╝
╚═╝╚═╝░░╚══╝╚═╝░░░░░╚═╝╚═╝░░╚══╝╚═╝░░░╚═╝░░░░░░╚═╝░░░  ╚══════╝╚═╝░░╚═╝╚═════╝░╚═════╝░
 ]]

Config = {}

Config.SpeedLimiter = {
    enabled = true,                -- enable/disable speed limiter feature
    command = 'setspeed',          -- command to set speed limit
    useMPH = true,                -- true = MPH, false = KM/H
    minSpeed = 0,                  -- minimum speed that can be set (0 = disable limiter)
    maxSpeed = 200,                -- maximum speed that can be set (in selected unit)
    showNotifications = true       -- show notifications when limiter is activated/deactivated
}

--[[
██╗███╗░░██╗███████╗██╗███╗░░██╗██╗████████╗██╗░░░██╗  ██╗░░░░░░█████╗░██████╗░░██████╗
██║████╗░██║██╔════╝██║████╗░██║██║╚══██╔══╝╚██╗░██╔╝  ██║░░░░░██╔══██╗██╔══██╗██╔════╝
██║██╔██╗██║█████╗░░██║██╔██╗██║██║░░░██║░░░░╚████╔╝░  ██║░░░░░███████║██████╦╝╚█████╗░
██║██║╚████║██╔══╝░░██║██║╚████║██║░░░██║░░░░░╚██╔╝░░  ██║░░░░░██╔══██║██╔══██╗░╚═══██╗
██║██║░╚███║██║░░░░░██║██║░╚███║██║░░░██║░░░░░░██║░░░  ███████╗██║░░██║██████╦╝██████╔╝
╚═╝╚═╝░░╚══╝╚═╝░░░░░╚═╝╚═╝░░╚══╝╚═╝░░░╚═╝░░░░░░╚═╝░░░  ╚══════╝╚═╝░░╚═╝╚═════╝░╚═════╝░
 ]]

-- CLIENT SIDE FILE --

local QBCore = exports['qb-core']:GetCoreObject()
local speedLimit = 0
local isLimiterActive = false

local function convertSpeed(speed, toMPH)
    if toMPH then
        return speed * 2.23694
    else
        return speed * 3.6
    end
end

local function convertToGameSpeed(speed, fromMPH)
    if fromMPH then
        return (speed - 0.5) / 2.23694
    else
        return (speed - 0.5) / 3.6
    end
end

local function startSpeedLimiter(limitSpeed)
    if isLimiterActive then
        return
    end

    isLimiterActive = true
    speedLimit = limitSpeed

    CreateThread(function()
        while isLimiterActive and speedLimit > 0 do
            Wait(100)

            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped, false)

            if vehicle == 0 or GetPedInVehicleSeat(vehicle, -1) ~= ped then
                isLimiterActive = false
                speedLimit = 0
                if Config.SpeedLimiter.showNotifications then
                    QBCore.Functions.Notify('Speed limiter deactivated - not in vehicle', 'error')
                end
                break
            end

            SetVehicleMaxSpeed(vehicle, speedLimit)
        end
    end)
end

local function stopSpeedLimiter()
    isLimiterActive = false
    speedLimit = 0

    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)

    if vehicle ~= 0 then
        SetVehicleMaxSpeed(vehicle, 0.0)
    end
end

RegisterCommand(Config.SpeedLimiter.command, function(source, args)
    if not Config.SpeedLimiter.enabled then return end

    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)

    if vehicle == 0 then
        QBCore.Functions.Notify('You must be in a vehicle to use the speed limiter', 'error')
        return
    end

    if GetPedInVehicleSeat(vehicle, -1) ~= ped then
        QBCore.Functions.Notify('You must be the driver to use the speed limiter', 'error')
        return
    end

    if not args[1] then
        local unit = Config.SpeedLimiter.useMPH and 'MPH' or 'KM/H'
        QBCore.Functions.Notify('Usage: /' .. Config.SpeedLimiter.command .. ' [speed in ' .. unit .. '] or 0 to disable', 'error')
        return
    end

    local targetSpeed = tonumber(args[1])

    if not targetSpeed then
        QBCore.Functions.Notify('Invalid speed value', 'error')
        return
    end

    if targetSpeed == 0 then
        stopSpeedLimiter()
        if Config.SpeedLimiter.showNotifications then
            QBCore.Functions.Notify('Speed limiter disabled', 'success')
        end
        return
    end

    if targetSpeed < Config.SpeedLimiter.minSpeed and targetSpeed ~= 0 then
        QBCore.Functions.Notify('Speed too low. Minimum: ' .. Config.SpeedLimiter.minSpeed, 'error')
        return
    end

    if targetSpeed > Config.SpeedLimiter.maxSpeed then
        QBCore.Functions.Notify('Speed too high. Maximum: ' .. Config.SpeedLimiter.maxSpeed, 'error')
        return
    end

    local gameSpeed = convertToGameSpeed(targetSpeed, Config.SpeedLimiter.useMPH)

    stopSpeedLimiter()

    local unit = Config.SpeedLimiter.useMPH and 'MPH' or 'KM/H'
    if Config.SpeedLimiter.showNotifications then
        QBCore.Functions.Notify('Speed limiter set to ' .. targetSpeed .. ' ' .. unit, 'success')
    end

    startSpeedLimiter(gameSpeed)
end, false)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        stopSpeedLimiter()
    end
end)

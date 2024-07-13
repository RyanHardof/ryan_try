QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('try', function(source, args, rawCommand)
    local message = table.concat(args, " ")
    if message == "" then
        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"System", "Usage: /try [message]"}
        })
        return
    end

    local success = math.random() < 0.5

    if success then
        TriggerClientEvent('qb-try:showResult', -1, source, message, true)
    else
        TriggerClientEvent('qb-try:showResult', -1, source, message, false)
    end
end, false)

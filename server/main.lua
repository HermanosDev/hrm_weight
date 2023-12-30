ESX.RegisterServerCallback('Hermanos:getWeight', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getWeight()) 
end)
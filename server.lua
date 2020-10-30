--[[
 		___      _                          _    _                         
       / _ \    | |                        | |  | |                        
   ___| | | | __| | _____  __    ______    | |__| | __ _ ___  __ _ _ __    
  / __| | | |/ _` |/ _ \ \/ /   |______|   |  __  |/ _` / __|/ _` | '_ \   
 | (__| |_| | (_| |  __/>  <               | |  | | (_| \__ \ (_| | | | |_ 
  \___|\___/ \__,_|\___/_/\_\              |_|  |_|\__,_|___/\__,_|_| |_(_)
                                                                           
]]

local PlayerData = {}

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('zx3', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('c0dex:client:UseItem', source)
end)

ESX.RegisterUsableItem('zx3remover', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('c0dex:client:removeZX3', source)
end)

ESX.RegisterUsableItem('zx3checker', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('c0dex:client:checkZx3', source)
end)

RegisterServerEvent('c0dex:server:rmvItem')
AddEventHandler('c0dex:server:rmvItem', function()
    local src = source
    local ply = ESX.GetPlayerFromId(src)

	ply.removeInventoryItem('zx3', 1)
end)

RegisterServerEvent('c0dex:server:insertPlate')
AddEventHandler('c0dex:server:insertPlate', function(vehPlate)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier
	local plate = vehPlate

	MySQL.Async.execute('INSERT INTO material_zx3 (plate) VALUES (@plate)',{['@plate'] = plate})
end)

RegisterServerEvent('c0dex:server:giveItem')
AddEventHandler('c0dex:server:giveItem', function()
    local src = source
    local ply = ESX.GetPlayerFromId(src)

	ply.addInventoryItem('zx3', 1)
end)

RegisterServerEvent('c0dex:server:removePlate')
AddEventHandler('c0dex:server:removePlate', function(vehPlate)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier
	local plate = vehPlate

	MySQL.Async.execute('DELETE FROM material_zx3 WHERE plate = (@plate)',{['@plate'] = plate})
end)

ESX.RegisterServerCallback("c0dex:server:getPlate",function(source,cb,plate)
	local pl = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM material_zx3  WHERE plate = @plate', {
		['@plate'] = plate,
	  }, function(result)
		if result[1] == nil then
			cb(false)
		else
			cb(true)
		end
	end)
end)

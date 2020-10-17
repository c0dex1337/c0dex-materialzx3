--[[
 		___      _                          _    _                         
       / _ \    | |                        | |  | |                        
   ___| | | | __| | _____  __    ______    | |__| | __ _ ___  __ _ _ __    
  / __| | | |/ _` |/ _ \ \/ /   |______|   |  __  |/ _` / __|/ _` | '_ \   
 | (__| |_| | (_| |  __/>  <               | |  | | (_| \__ \ (_| | | | |_ 
  \___|\___/ \__,_|\___/_/\_\              |_|  |_|\__,_|___/\__,_|_| |_(_)
                                                                           
]]


ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('c0dex:client:UseItem')
AddEventHandler('c0dex:client:UseItem', function()

local ply		= PlayerPedId()
local coords	= GetEntityCoords(ply)
local shouldplay = false


if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 2.5) then
	local vehicle 	= GetClosestVehicle(coords.x, coords.y, coords.z, 2.5, 0, 71)
	local vehicleheading = GetEntityHeading(vehicle)

	if DoesEntityExist(vehicle) then

		if not IsPedInAnyVehicle(ply) then

		Citizen.CreateThread(function()
			while true do
			
				if shouldplay then
					RequestAnimDict("amb@world_human_vehicle_mechanic@male@base")

					while not HasAnimDictLoaded("amb@world_human_vehicle_mechanic@male@base") do
						Wait(1)
					end

					if not IsEntityPlayingAnim(ply, "amb@world_human_vehicle_mechanic@male@base", "base", 3) then
						TaskPlayAnim(ply, "amb@world_human_vehicle_mechanic@male@base", "base", 1.0, -1.0, -1, 0, 1, true, true, true)
						Wait(1500)
					end

				end
				Wait(0)
			end
		end)

	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)


	ESX.TriggerServerCallback("c0dex:server:getPlate",function(ac)

		if not ac then
			shouldplay = true

			TaskTurnPedToFaceEntity(ply, vehicle, 1500)
			Wait(1500)
			SetEntityHeading(ply, -180.0)

			TriggerEvent("mythic_progbar:client:progress", {
				name = "sport_mode",
				duration = Config.BaglamaSuresi,
				label = "Spor Mod Araca Bağlanıyor... [PGUP]",
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = "",
					anim = "",
				},
				prop = {
					model = "",
				}
			}, function(status)
				if not status then
					exports['mythic_notify']:SendAlert('inform', 'Sport mode araca başarıyla bağlandı.', 5500)
					ClearPedSecondaryTask(ply)
					local vehplate = GetVehicleNumberPlateText(vehicle)
					TriggerServerEvent('c0dex:server:insertPlate',vehplate)
					TriggerServerEvent('c0dex:server:rmvItem')
					shouldplay = false
				else
					exports['mythic_notify']:SendAlert('inform', 'İşlem iptal edildi.', 3500)
					ClearPedSecondaryTask(ply)
					shouldplay = false
				end
			end)
		else
			exports['mythic_notify']:SendAlert('inform', 'Bu araçta zaten spor mode takılı.', 5500)
		end
	end,vehicleProps.plate)
end

else
	exports['mythic_notify']:SendAlert('inform', 'Aracın içindeyken spor modunu bağlayamazsın.', 3500)
end

else
	exports['mythic_notify']:SendAlert('inform', 'Yakında araç yok.', 3500)
end

end)

RegisterNetEvent('c0dex:client:removeSportMode')
AddEventHandler('c0dex:client:removeSportMode', function()

	local ply		= PlayerPedId()
	local coords	= GetEntityCoords(ply)
	local shouldplay2 = false

if Config.Cikartilabilir then

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 2.5) then
			local vehicle 	= GetClosestVehicle(coords.x, coords.y, coords.z, 2.5, 0, 71)
			local vehicleheading = GetEntityHeading(vehicle)

			if DoesEntityExist(vehicle) then

				if not IsPedInAnyVehicle(ply) then

				Citizen.CreateThread(function()
					while true do
					
						if shouldplay2 then
							RequestAnimDict("amb@world_human_vehicle_mechanic@male@base")

							while not HasAnimDictLoaded("amb@world_human_vehicle_mechanic@male@base") do
								Wait(1)
							end

							if not IsEntityPlayingAnim(ply, "amb@world_human_vehicle_mechanic@male@base", "base", 3) then
								TaskPlayAnim(ply, "amb@world_human_vehicle_mechanic@male@base", "base", 1.0, -1.0, -1, 0, 1, true, true, true)
								Wait(1500)
							end

						end
						Wait(0)
					end
				end)

			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)


			ESX.TriggerServerCallback("c0dex:server:getPlate",function(ac)

				if ac then
					shouldplay2 = true

					TaskTurnPedToFaceEntity(ply, vehicle, 1500)
					Wait(1500)
					SetEntityHeading(ply, -180.0)

					TriggerEvent("mythic_progbar:client:progress", {
						name = "sport_mode",
						duration = Config.CikarmaSuresi,
						label = "Spor Mod Araçtan Çıkartılıyor... [PGUP]",
						useWhileDead = false,
						canCancel = true,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						},
						animation = {
							animDict = "",
							anim = "",
						},
						prop = {
							model = "",
						}
					}, function(status)
						if not status then
							exports['mythic_notify']:SendAlert('inform', 'Sport mode araçtan çıkartıldı.', 5500)
							ClearPedSecondaryTask(ply)
							local vehplate = GetVehicleNumberPlateText(vehicle)
							TriggerServerEvent('c0dex:server:removePlate',vehplate)
							TriggerServerEvent('c0dex:server:giveItem')
							shouldplay2 = false
						else
							exports['mythic_notify']:SendAlert('inform', 'İşlem iptal edildi.', 3500)
							ClearPedSecondaryTask(ply)
							shouldplay2 = false
						end
					end)
				else
					exports['mythic_notify']:SendAlert('inform', 'Bu araçta zaten sport mode yok.', 5500)
				end
			end,vehicleProps.plate)
		end

		else
			exports['mythic_notify']:SendAlert('inform', 'Aracın içindeyken spor modunu çıkartamazsın.', 3500)
		end

		else
			exports['mythic_notify']:SendAlert('inform', 'Yakında araç yok.', 3500)
		end
	end
end)



local toggle = true
local block = false
Citizen.CreateThread(function()
	while true do
	local veh = GetVehiclePedIsIn(PlayerPedId(), false)

		if IsControlJustReleased(0, Config.ModTusu) and IsPedInAnyVehicle(PlayerPedId()) then
			local vehicleProps = ESX.Game.GetVehicleProperties(veh)
				ESX.TriggerServerCallback("c0dex:server:getPlate",function(ac)
				if ac then
					if not toggle then
						SetVehicleEnginePowerMultiplier(veh, Config.HizMiktari)
						SetVehicleEngineTorqueMultiplier(veh, Config.HizMiktari)
						SetEntityMaxSpeed(veh, Config.MaxHizMiktari)
						exports['mythic_notify']:SendAlert('inform', 'Sport mode aktif edildi.')
						toggle = true
						block = true
						Citizen.Wait(Config.BeklemeSuresi)
						block = false
					elseif toggle then
						SetVehicleEnginePowerMultiplier(veh, LastEngineMultiplier)
						SetVehicleEngineTorqueMultiplier(veh, 1.0)
						exports['mythic_notify']:SendAlert('inform', 'Eco mode aktif edildi.')
						toggle = false
						block = true
						Citizen.Wait(Config.BeklemeSuresi)
						block = false
					end
				end
			end,vehicleProps.plate)
		elseif block then
			DisableControlAction(0, Config.ModTusu)
		end
	Wait(0)
	end
end)
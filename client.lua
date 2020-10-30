--[[
 		___      _                          _    _                         
       / _ \    | |                        | |  | |                        
   ___| | | | __| | _____  __    ______    | |__| | __ _ ___  __ _ _ __    
  / __| | | |/ _` |/ _ \ \/ /   |______|   |  __  |/ _` / __|/ _` | '_ \   
 | (__| |_| | (_| |  __/>  <               | |  | | (_| \__ \ (_| | | | |_ 
  \___|\___/ \__,_|\___/_/\_\              |_|  |_|\__,_|___/\__,_|_| |_(_)
                                                                           
]]


local PlayerData = {}



Citizen.CreateThread(function()

    while ESX == nil do

        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

        Citizen.Wait(0)

    end

    while ESX.GetPlayerData().job == nil do

        Citizen.Wait(10)

    end

    PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent('esx:setJob')

AddEventHandler('esx:setJob', function(job)

  PlayerData.job = job

end)

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

			if not IsVehicleSeatFree(vehicle,-1) then return exports['mythic_notify']:SendAlert('inform', 'Aracın içinde birisi varken zx3 maddesini benzine dökemezsin.', 7500) end

		Citizen.CreateThread(function()
			while true do
			
				if shouldplay then

					RequestAnimDict("weapon@w_sp_jerrycan")
					while not HasAnimDictLoaded("weapon@w_sp_jerrycan") do
						Wait(1)
					end

					if not IsEntityPlayingAnim(ply, "weapon@w_sp_jerrycan", "fire", 3) then
						TaskPlayAnim(ply,"weapon@w_sp_jerrycan","fire", -1, -1, -1,49, 0, 0, 0, 0)
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

			local x,y,z = table.unpack(GetEntityCoords(ply))
			local prop = CreateObject(GetHashKey("prop_bucket_01a"), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(ply, 18905)
			AttachEntityToEntity(prop, ply, boneIndex, 0.12, 0.028, 0.501, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			TaskTurnPedToFaceEntity(ply, vehicle, 1500)
			Wait(1500)
			SetEntityHeading(ply, -180.0)

			TriggerEvent("mythic_progbar:client:progress", {
				name = "zx3_useitem",
				duration = Config.DokmeSuresi,
				label = "ZX3 Maddesi Benzine Dökülüyor.. [PGUP]",
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
					exports['mythic_notify']:SendAlert('inform', 'Zx3 maddesi benzine döküldü. (Modlar arasında geçiş yapmak için left ctrl\'ye bas.)', 12500)
					ClearPedSecondaryTask(ply)
					local vehplate = GetVehicleNumberPlateText(vehicle)
					TriggerServerEvent('c0dex:server:insertPlate',vehplate)
					TriggerServerEvent('c0dex:server:rmvItem')
					DeleteEntity(prop)
					shouldplay = false
				else
					exports['mythic_notify']:SendAlert('inform', 'İşlem iptal edildi.', 3500)
					ClearPedSecondaryTask(ply)
					DeleteEntity(prop)
					shouldplay = false
				end
			end)
		else
			exports['mythic_notify']:SendAlert('inform', 'Bu araçta zaten zx3 maddesi var.', 5500)
		end
	end,vehicleProps.plate)
end

else
	exports['mythic_notify']:SendAlert('inform', 'Aracın içindeyken zx3 maddesini dökemezsin.', 3500)
end

else
	exports['mythic_notify']:SendAlert('inform', 'Yakında araç yok.', 3500)
end

end)

RegisterNetEvent('c0dex:client:removeZX3')
AddEventHandler('c0dex:client:removeZX3', function()

	local ply		= PlayerPedId()
	local coords	= GetEntityCoords(ply)
	local shouldplay2 = false

if Config.Cikartilabilir then

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 2.5) then
			local vehicle 	= GetClosestVehicle(coords.x, coords.y, coords.z, 2.5, 0, 71)
			local vehicleheading = GetEntityHeading(vehicle)

			if DoesEntityExist(vehicle) then

				if not IsPedInAnyVehicle(ply) then

					if not IsVehicleSeatFree(vehicle,-1) then return exports['mythic_notify']:SendAlert('inform', 'Aracın içinde birisi varken zx3 maddesini benzinden çıkartamazsın.', 7500) end

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
						name = "zx3_remove",
						duration = Config.CikarmaSuresi,
						label = "ZX3 Maddesi Benzinden Çıkartılıyor.. [PGUP]",
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
							exports['mythic_notify']:SendAlert('inform', 'Zx3 maddesi benzinden ayrıştırıldı.', 5500)
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
					exports['mythic_notify']:SendAlert('inform', 'Bu araçta zaten zx3 maddesi yok.', 5500)
				end
			end,vehicleProps.plate)
		end

		else
			exports['mythic_notify']:SendAlert('inform', 'Aracın içindeyken zx3 maddesini çıkartamazsın.', 3500)
		end

		else
			exports['mythic_notify']:SendAlert('inform', 'Yakında araç yok.', 3500)
		end
	else
		exports['mythic_notify']:SendAlert('inform', 'Zx3 maddesini benzinden ayrıştırmayı denedin fakat işe yaramadı.', 7500)
	end
end)

RegisterNetEvent('c0dex:client:checkZx3')
AddEventHandler('c0dex:client:checkZx3', function()

	local ply		= PlayerPedId()
	local coords	= GetEntityCoords(ply)
	local shouldplay3 = false
	local PlayerData = ESX.GetPlayerData(source)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 2.5) then
			local vehicle 	= GetClosestVehicle(coords.x, coords.y, coords.z, 2.5, 0, 71)
			local vehicleheading = GetEntityHeading(vehicle)

			if DoesEntityExist(vehicle) then

				if not IsPedInAnyVehicle(ply) then

					if not IsVehicleSeatFree(vehicle,-1) then exports['mythic_notify']:SendAlert('inform', 'Aracın içinde birisi varken zx3 maddesini kontrol edemezsin.', 7500) end

					if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job and PlayerData.job.name == 'sheriff' then

				Citizen.CreateThread(function()
					while true do
					
						if shouldplay3 then
							RequestAnimDict("missheistdockssetup1clipboard@idle_a")

							while not HasAnimDictLoaded("missheistdockssetup1clipboard@idle_a") do
								Wait(1)
							end

							if not IsEntityPlayingAnim(ply, "missheistdockssetup1clipboard@idle_a", "idle_a", 3) then
								TaskPlayAnim(ply, "missheistdockssetup1clipboard@idle_a", "idle_a", 1.0, -1.0, -1, 0, 1, true, true, true)
								Wait(1500)
							end

						end
						Wait(0)
					end
				end)

			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

					shouldplay3 = true

					TaskTurnPedToFaceEntity(ply, vehicle, 1500)
					Wait(1500)
					SetEntityHeading(ply, -180.0)

					TriggerEvent("mythic_progbar:client:progress", {
						name = "zx3_check",
						duration = Config.KontrolSuresi,
						label = "ZX3 Maddesi Kontrol Ediliyor.. [PGUP]",
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
							local vehplate = GetVehicleNumberPlateText(vehicle)
							ESX.TriggerServerCallback("c0dex:server:getPlate",function(ac)
								if ac then
									exports['mythic_notify']:SendAlert('inform', vehplate.." plakalı araçta zx3 maddesi bulundu.", 5500)
								else
									exports['mythic_notify']:SendAlert('inform', vehplate.." plakalı araçta zx3 maddesi bulunamadı.", 5500)
								end
							end,vehicleProps.plate)

							ClearPedSecondaryTask(ply)
							shouldplay3 = false
						else
							exports['mythic_notify']:SendAlert('inform', 'İşlem iptal edildi.', 3500)
							ClearPedSecondaryTask(ply)
							shouldplay3 = false
						end
					end)
				else 
					exports['mythic_notify']:SendAlert('inform', 'Zx3 maddesini benzinden ayrıştırmayı denedin fakat işe yaramadı.', 7500) 
				end
		end

		else
			exports['mythic_notify']:SendAlert('inform', 'Aracın içindeyken araçta zx3 maddesi olup olmadığını kontrol edemezsin.', 7500)
		end

		else
			exports['mythic_notify']:SendAlert('inform', 'Yakında araç yok.', 3500)
		end
end)


local toggle = false
local block = false
Citizen.CreateThread(function()
	while true do
	local veh = GetVehiclePedIsIn(PlayerPedId(), false)
		if block and IsDisabledControlJustReleased(0, Config.ModTusu) then
			exports['mythic_notify']:SendAlert('inform', 'Modlar arası geçiş yapabilmek için 5 saniye beklemelisin.', 3500)
		end
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

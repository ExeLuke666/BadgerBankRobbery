-------------------------
--- BadgerBankRobbery ---
-------------------------
--- Server ---
local robberyActive = false
NDCore = exports["ND_Core"]

RegisterNetEvent('BadgerBankRobbery:IsActive')
AddEventHandler('BadgerBankRobbery:IsActive', function()
	TriggerClientEvent('BadgerBankRobbery:IsActive:Return', source, robberyActive)
end)

RegisterNetEvent("BadgerBankRobbery.getIsAllowed")
AddEventHandler("BadgerBankRobbery.getIsAllowed", function()
	local src = source
	local player = NDCore.getPlayer(src)
	if player and IsPlayerAceAllowed(src, "badgerbank.rob") then
		TriggerClientEvent("BadgerBankRobbery.returnIsAllowed", src, true)
	else
		TriggerClientEvent("BadgerBankRobbery.returnISAllowed", src, false)
	end
end)

RegisterNetEvent('BadgerBankRobbery:SetActive')
AddEventHandler('BadgerBankRobbery:SetActive', function(bool)
	robberyActive = bool
	if bool then
		Wait(1000 * 60 * config.robberyCooldown)
		robberyActive = false
end)

RegisterNetEvent('Print:PrintDebug')
AddEventHandler('Print:PrintDebug', function(msg)
	print(msg)
	TriggerClientEvent('chatMessage', -1, "^7[^1Badger's Scripts^7] ^1DEBUG ^7" .. msg)
end)

RegisterNetEvent('PrintBR:PrintMessage')
AddEventHandler('PrintBR:PrintMessage', function(msg)
    TriggerClientEvent('chatMessage', -1, msg)
end)

RegisterNetEvent("Bank:Finished")
AddEventHandler("Bank:Finished", function()
	local src = source
	local player = NDCore.getPlayer(src)
	if player then
		player.addMoney("cash", config.amount)
	end
end)

RegisterNetEvent("Store:Finished")
AddEventHandler("Store:Finished", function()
	local src = source
	local player = NDCore.getPlayer(src)
	if player then
		player.addMoney("cash", config.storeAmount)
	end
end)
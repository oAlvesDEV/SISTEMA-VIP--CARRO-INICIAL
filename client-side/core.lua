-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("initial")
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("vip",function()
	TriggerEvent("initial:Open")
	if vSERVER.CheckInit() then
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)		
		SendNUIMessage({ name = "Open" })
	end	
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITIAL:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("initial:Open")
AddEventHandler("initial:Open",function()
	if vSERVER.CheckInit() then
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)		
		SendNUIMessage({ name = "Open" })
	end	
end)
RegisterNetEvent("initial:close")
AddEventHandler("initial:close",function()
		SetNuiFocus(false,false)	
		SendNUIMessage({ name = false })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Save",function(Data,Callback)
	SetNuiFocus(false,false)
	vSERVER.Save(Data["name"])
	TriggerEvent("hud:Active",true)
	Callback("Save")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("initial",Creative)
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINIT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckInit()
	local source = source
	local Passport = vRP.Passport(source)
    local License = vRP.Identities(source)
	if Passport then
        local Account = vRP.Account(License)
        if not Account.initial then
            return true
        end	
	end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Save(vehName)
	local source = source
	local Passport = vRP.Passport(source)
    local License = vRP.Identities(source)
    local Identity = vRP.Identity(Passport)
	if Passport then
        local Account = vRP.Account(License)
        if not Account.initial then
            local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
			if vehicle[1] then
				TriggerClientEvent("Notify",source,"amarelo","Já possui um <b>"..vehName.."</b>.",3000)
				return
			else
                vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, vehicle = vehName, plate = vRP.GeneratePlate(), work = "false" })
                vRP.Query("accounts/AddInitial",{ id = Account.id })
                if NotifyConfig then
                    TriggerClientEvent("Notify", source, "azul","Nossa equipe da administração está muito feliz em ter você conosco, trabalhamos incansavelmente para desenvolver o melhor ambiente para sua diversão, conte conosco e saiba que o nosso discord está aberto para dúvidas, sugestões e afins. <br><br>Tenha uma ótima estadia e um bom jogo.<br>Divirta-se! Bem-vindo(a) " .. Identity["name"] .. " " ..Identity["name2"], 10000)
                TriggerClientEvent("Notify",source,"verde","Veiculo "..vehName.." adicionado em sua garagem!!!",10000)
                end
			end
        else
            if NotifyConfig then
            TriggerClientEvent("Notify",source,NotifyFailed,10000)
            end
        end	
	end
end
local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

-----------------------------------------------------------------
-- anti-spam table (prevents double-triggering)
-----------------------------------------------------------------
local isProcessing = {}

-----------------------------------------------------------------
-- check if player is near any fishmonger
-----------------------------------------------------------------
local function IsNearFishmonger(playerCoords)
    for _, loc in pairs(Config.FishMongerLocations) do
        if #(playerCoords - loc.coords) < 6.0 then
            return true
        end
    end
    return false
end

-----------------------------------------------------------------
-- sell fish
-----------------------------------------------------------------
RegisterServerEvent('rex-fishmonger:server:sellfish', function()
    local src = source
    if isProcessing[src] then return end
    isProcessing[src] = true

    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then isProcessing[src] = nil return end

    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)

    if Config.RequireNearNPC and not IsNearFishmonger(coords) then
        TriggerClientEvent('ox_lib:notify', src, { title = locale('sv_lang_7'), description = locale('sv_lang_8'), type = 'error' })
        isProcessing[src] = nil
        return
    end

    local totalPrice = 0
    local hasSold = false

    for _, itemData in pairs(Player.PlayerData.items or {}) do
        if itemData and itemData.amount > 0 and Config.SellableFish[itemData.name] then
            local pricePer = Config.SellableFish[itemData.name]
            local amount = itemData.amount
            totalPrice = totalPrice + (pricePer * amount)

            Player.Functions.RemoveItem(itemData.name, amount)
            TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[itemData.name], "remove", amount)
            hasSold = true
        end
    end

    if hasSold then
        Player.Functions.AddMoney('cash', totalPrice, "fishmonger-sell")
        TriggerClientEvent('ox_lib:notify', src, {
            title = locale('sv_lang_5'),
            description = (locale('sv_lang_6')):format(totalPrice),
            type = 'success'
        })
        TriggerEvent('rsg-log:server:CreateLog', Config.WebhookName, Config.WebhookTitle, Config.WebhookColour, ('%s sold fish for $%s'):format(GetPlayerName(src), totalPrice), false)
    else
        TriggerClientEvent('ox_lib:notify', src, {
            title = locale('sv_lang_1'),
            description = locale('sv_lang_2'),
            type = 'error'
        })
    end

    Wait(3000) -- anti-spam
    isProcessing[src] = nil
end)

-----------------------------------------------------------------
-- process fish → raw_fish + trapbait
-----------------------------------------------------------------
RegisterServerEvent('rex-fishmonger:server:processfish', function()
    local src = source
    if isProcessing[src] then return end
    isProcessing[src] = true

    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then isProcessing[src] = nil return end

    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)

    if Config.RequireNearNPC and not IsNearFishmonger(coords) then
        TriggerClientEvent('ox_lib:notify', src, { title = locale('sv_lang_7'), description = locale('sv_lang_8'), type = 'error' })
        isProcessing[src] = nil
        return
    end

    local rawFishAmount = 0
    local hasProcessed = false

    for _, itemData in pairs(Player.PlayerData.items or {}) do
        if itemData and itemData.amount > 0 and Config.ProcessableFish[itemData.name] then
            local amountPerFish = Config.ProcessableFish[itemData.name]
            local totalRaw = amountPerFish * itemData.amount
            rawFishAmount = rawFishAmount + totalRaw

            Player.Functions.RemoveItem(itemData.name, itemData.amount)
            TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[itemData.name], "remove", itemData.amount)
            hasProcessed = true
        end
    end

    if hasProcessed then
        Player.Functions.AddItem('raw_fish', rawFishAmount)
        Player.Functions.AddItem('trapbait', rawFishAmount)
        TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items['raw_fish'], "add", rawFishAmount)
        TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items['trapbait'], "add", rawFishAmount)
        TriggerClientEvent('ox_lib:notify', src, {
            title = locale('sv_lang_9'),
            description = (locale('sv_lang_10')):format(rawFishAmount),
            type = 'success'
        })
    else
        TriggerClientEvent('ox_lib:notify', src, {
            title = locale('sv_lang_1'),
            description = locale('sv_lang_3'),
            type = 'error'
        })
    end

    Wait(3000) -- anti-spam
    isProcessing[src] = nil
end)

-----------------------------------------------------------------
-- shop registration
-----------------------------------------------------------------
CreateThread(function()
    exports['rsg-inventory']:CreateShop({
        name = 'fishmonger',
        label = locale('sv_lang_11'),
        slots = #Config.FishmongerShopItems,
        items = Config.FishmongerShopItems,
        persistentStock = Config.PersistStock == true,
    })
end)

RegisterNetEvent('rex-fishmonger:server:openShop', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    exports['rsg-inventory']:OpenShop(src, 'fishmonger')
end)

-----------------------------------------------------------------
-- clean up on player drop
-----------------------------------------------------------------
AddEventHandler('playerDropped', function()
    local src = source
    if isProcessing[src] then
        isProcessing[src] = nil
    end
end)

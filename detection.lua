local ciLootDespawn = 20 -- Seconds into the future that the callback that checks if an item entity is still around is set to. Used to remove despawned or otherwise glitched out items

local ciLootGhost = 2 -- Seconds to wait before the onetime ghost check.

local identityCounter = 1

--[[
    Identify(entityId, [targetInfo], [itemInfo])
    Identifies entity, adding it to a list of items that have been seen
]]--
function Identify(entityId, targetInfo, itemInfo)
    -- We must have an entityId
    if not entityId then
        Debug.Error('Identify called without an entityId')
    -- If we don't have targetInfo, we must have an entityId that references a valid target, so that we can retrieve the information
    elseif not targetInfo then
        if not Game.IsTargetAvailable(entityId) then
            Debug.Error('Identify called without targetInfo, and entityId does not reference an available entity.')
        end
    end

    -- Be sure we haven't already identified this
    if IsIdentified(entityId) then
        Debug.Warn('Attempted to identify an already identified item.')
        return
    end

    -- Setup targetInfo and itemInfo
    targetInfo = targetInfo or Game.GetTargetInfo(entityId)
    itemInfo = itemInfo or Game.GetItemInfoByType(targetInfo.itemTypeId, Game.GetItemAttributeModifiers(targetInfo.itemTypeId, targetInfo.quality))
    targetInfo.name = targetInfo.name or itemInfo.name -- This reduces the amount of data needed to be stored in the test function.

    -- Test our data before we get started
    Debug.Table({'Identify', entityId = entityId, targetInfo = targetInfo, itemInfo = itemInfo})
    if not targetInfo or not itemInfo then
        Debug.Error('Identify was unable to acquire the neccessary data')
    end

    -- Unify data
    local loot = {
        entityId       = entityId, 
        identityId     = nil,
        easyId         = nil,
        itemTypeId     = targetInfo.itemTypeId,
        quality        = targetInfo.quality or 0,
        itemInfo       = itemInfo,
        craftingTypeId = itemInfo.craftingTypeId,
        name           = targetInfo.name,
        pos            = {
                            x = targetInfo.lootPos.x,
                            y = targetInfo.lootPos.y,
                            z = targetInfo.lootPos.z,
        },
        assignedTo     = nil,
        panel          = nil,
        waypoint       = nil,
        timer          = nil,
        rollData       = nil,
    }

    if not loot.itemInfo.tier then
        loot.itemInfo.tier = {level = 0}
    end

    -- Force stage out of quality -- Fixme:
    if loot.itemInfo.tier.level == 0 and loot.quality ~= 0 then
        if loot.quality <= 150 then
            loot.itemInfo.tier.level = 1
        elseif loot.quality <= 250 then
            loot.itemInfo.tier.level = 2
        elseif loot.quality <= 500 then
            loot.itemInfo.tier.level = 3
        elseif loot.quality <= 1000 then
            loot.itemInfo.tier.level = 4
        end
    end

    -- If squad leader, generate identity and easy ids
    if bIsSquadLeader then
        Debug.Log('Generating identityId')
        local player = Player.GetInfo()
        local time = tonumber(System.GetLocalUnixTime())
        loot.identityId = tostring(player)..tostring(time)..tostring(identityCounter)
        identityCounter = identityCounter + 1
        Communication.SendItemIdentity(loot)

        Debug.Log('Generating easyId')

        local easyId = 0
        local easyInUse = true

        while easyInUse do
            easyId = easyId + 1

            easyInUse = false

            for i, item in ipairs(aIdentifiedLoot) do
                if item.easyId == tostring(easyId) then -- Just work with strings since it is intended to be parsed from chat
                    easyInUse = true
                end
            end
        end

        loot.easyId = tostring(easyId) -- Just work with strings since it is intended to be parsed from chat
    end

    -- Optionally create waypoint
    if (Options['Waypoints']['Enabled'] and ItemPassesFilter(loot, Options['Waypoints'])) then
        loot.waypoint = CreateWaypoint(loot)
    end

    Debug.Log(tostring(ItemPassesFilter(loot, Options['Panels'])))

    -- Optionally create panel
    if (Options['Panels']['Enabled'] and ItemPassesFilter(loot, Options['Panels'])) then
        loot.panel = CreatePanel(targetInfo, itemInfo)
    end

    -- Create timer
    loot.timer = GTimer.Create(function(time) if loot.panel ~= nil then loot.panel.panel_rt:GetChild('Panel'):GetChild('Content'):GetChild('IconBar'):GetChild('timer'):SetText(time) end end, '%02iq60p:%02iq1p', 1) -- TODO: Avoid code dependant on structure of panel as much as possible
        
    -- Setup despawn alarm
    loot.timer:SetAlarm('despawn', ciLootDespawn, LootDespawn, {item = loot})

    -- Setup ghost alarm
    if tonumber(entityId) > 1000 then -- Note: entityIds given out by the client are never this low, by checking for that we can use fake entityIds for testing purposes below this value.
        loot.timer:SetAlarm('ghost', ciLootGhost, LootGhost, {item = loot})
    end

    -- Start timer
    loot.timer:StartTimer()

    -- Save data
    table.insert(aIdentifiedLoot, loot)
    
    -- Fire event
    OnIdentify({item=loot})
end

--[[
    LootDespawn(args)
    Triggered by a timer alarm, checks if loot is still up and resets alarm in that case.
    Otherwise, makes sure item is removed cleanly.
]]--
function LootDespawn(args)
    -- Check that it really despawned
    if Game.IsTargetAvailable(args.item.entityId) then
        if Options['Debug']['Enabled'] then
            SendFilteredMessage('system', '%i has not despawned yet, resetting despawn timer.', {item=args.item})
        end
        args.item.timer:SetAlarm('despawn', args.item.timer:GetTime() + ciLootDespawn, LootDespawn, {item=args.item})
        return

    -- If it did despawn, then send the despawn event now, before we remove the item.
    else
        OnLootDespawn({item=args.item})
    end

    -- If currently rolling for this item, cancel the roll
    if args.item.identityId and RollTracker.IsBeingRolled(args.item.identityId) then
        RollCancel({identity = args.item.identityId, reason='The item has despawned.'})
    end

    -- Remove item
    RemoveIdentifiedItem(args.item)
end

--[[
    LootGhost(args)
    Triggered by a timer alarm, a bit of a clone of LootDespawn for the purposes of catching "ghost" items.
    Sometimes the client simply seems to fire OnEntityAvailable events for items that aren't actually available, and the loot despawn check will take 20 seconds to figure that out. The ghost check is only done once.
]]--
function LootGhost(args)  
    if not Game.IsTargetAvailable(entityId) then
        Debug.Warn('Ghost Item Detected')
        if Options['Debug']['Enabled'] then
            SendChatMessage('system', 'Ghost Item Detected')
        end
        RemoveIdentifiedItem(args.item)
    end
end
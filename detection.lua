local ciLootDespawn = 20 -- Seconds into the future that the callback that checks if an item entity is still around is set to. Used to remove despawned or otherwise glitched out items

local identityCounter = 1

--[[
    Identify(entityId, [targetInfo])
    Identifies entity, adding it to a list of items that have been seen
]]--
function Identify(entityId, targetInfo)
    -- Get data if we don't have it
    targetInfo = targetInfo or Game.GetTargetInfo(entityId)
    local itemInfo = Game.GetItemInfoByType(targetInfo.itemTypeId, Game.GetItemAttributeModifiers(targetInfo.itemTypeId, targetInfo.quality))
    Debug.Log('Identifying '..tostring(entityId)..','..targetInfo.name)
    Debug.Log('targetInfo: ')
    Debug.Table(targetInfo)
    Debug.Log('itemInfo: ')
    Debug.Table(itemInfo)

    -- Unify data
    local loot = {entityId=entityId, itemTypeId=targetInfo.itemTypeId, craftingTypeId=itemInfo.craftingTypeId, itemInfo=itemInfo, assignedTo=nil, quality=targetInfo.quality, name=targetInfo.name, pos={x=targetInfo.lootPos.x, y=targetInfo.lootPos.y, z=targetInfo.lootPos.z}, panel=nil, waypoint=nil, timer=nil, rollData=nil, identityId=nil}

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
        
    -- Setup despawn timer
    loot.timer:SetAlarm('despawn', ciLootDespawn, LootDespawn, {item=loot})
    loot.timer:StartTimer()

    -- If squad leader, generate identity
    if bIsSquadLeader then
        local player = Player.GetInfo()
        local time = tonumber(System.GetLocalUnixTime())
        item.identityId = tostring(player)..tostring(time)..tostring(identityCounter)
        identityCounter = identityCounter + 1
    end

    -- Save data
    table.insert(aIdentifiedLoot, loot)
    Debug.Log('Identified: '..tostring(loot.entityId)..', '..loot.name)
    
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
            SendChatMessage('system', args.item.name..' has not despawned yet, reseting despawn timer')
        end
        args.item.timer:SetAlarm('despawn', args.item.timer:GetTime() + ciLootDespawn, LootDespawn, {item=args.item})
        return
    else
        OnLootDespawn({item=args.item})
    end

    -- If currently rolling for this item, cancel the roll
    if mCurrentlyRolling and mCurrentlyRolling.entityId == args.item.entityId then
        RollCancel()
    end

    -- Remove item
    RemoveIdentifiedItem(args.item)
end

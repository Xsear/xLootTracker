Tracker = {}

local Private = {
    trackedLoot = {},
    identityByEntity = {},

    lootEventHistory = {},

    CYCLE_Refresh = nil,
    CYCLE_LootEventHistoryCleanup = nil,
}


--[[
    Tracker.Setup()
    Performs OnComponentLoad tasks.
    Initiates the Tracker.Refresh callback cycle.
--]]
function Tracker.Setup()
    --Private.CYCLE_Refresh = Callback2.CreateCycle(Tracker.Refresh)
    --Private.CYCLE_Refresh:Run(TrackerRefreshInterval)
    Private.CYCLE_LootEventHistoryCleanup = Callback2.CreateCycle(Private.LootEventHistoryCleanup)
    Private.CYCLE_LootEventHistoryCleanup:Run(Options['Tracker']['LootEventHistoryCleanupInterval'])
end

function Private.LootEventHistoryCleanup()

    if not _table.empty(Private.lootEventHistory) then
        
        local currentTime = tonumber(System.GetClientTime())
        
        for itemTypeId, events in pairs(Private.lootEventHistory) do
            -- Go trough events if not empty
            if not _table.empty(events) then

                local i=1
                while i <= #events do
                    local event = events[i]

                    -- If has lived longer than life, remove
                    if (currentTime - event.occuredAt > Options['Tracker']['LootEventHistoryLifetime']) then
                        table.remove(events, i)
                    else
                        i = i + 1
                    end
                end

            -- Remove table if empty
            else
                Private.lootEventHistory[itemTypeId] = nil
            end

        end
    end
end



--[[
    Tracker.GetLoot()
    Gives out the table of tracked loot. Please don't change it, everyone else D':
--]]
function Tracker.GetLoot()
    return Private.trackedLoot
end

function Tracker.GetAvailableLoot()
    local result = {}
    for id, loot in pairs(Private.trackedLoot) do
        if loot:GetState() == LootState.Available then
            result[#result + 1] = loot
        end
    end
    return result
end


--[[
    Tracker.Refresh()
    Updates all tracked items.
--]]
function Tracker.Refresh()
    if not _table.empty(Private.trackedLoot) then
        local refresh = Tracker.Update
        for id, loot in pairs(Private.trackedLoot) do
            refresh(loot)
        end
    end
end

--[[
    Tracker.OnLootableEntity(args)
    Checks if the entity should be added to Tracker, and does so if deemed appropriate.
    Call when an OnEntityAvailable with type 'loot' has occured.
--]]
function Tracker.OnEntityAvailable(args)
    -- Do we have an entityId?
    if not args.entityId then
        return -- You were useless!
    -- Is it loot?
    elseif args.type ~= "loot" then
        return -- Nobody cares!
    -- Are we tracking this?
    elseif Tracker.IsTrackedEntity(args.entityId) then
        return -- This is old news!
    end

    -- Sweet, a new entity. Track it!
    Callback2.FireAndForget(Tracker.Track, args, Options['Tracker']['TrackDelay'])
end


function Tracker.OnEntityLost(args)
    --Debug.Log("Tracker.OnEntityLost on entityId " .. tostring(args.entityId))
    -- Do we have an entityId?
    if not args.entityId then
        return -- Nothing we could do!

    -- Are we tracking this?
    elseif not Tracker.IsTrackedEntity(args.entityId) then
        return -- Not one of ours  
    end


    -- Okay, let's see what we know about this
    local loot = Tracker.GetLootByEntityId(args.entityId)
    
    Debug.Log('Tracker.OnEntityLost for '..loot:ToString())

    -- Do we have any loot events for this kinda item?
    if Private.lootEventHistory[loot:GetTypeId()] and #Private.lootEventHistory[loot:GetTypeId()] > 0 then

        -- Ooh I like this. We'll assume they picked up the oldest one we've got.
        local event = nil
        for i, e in ipairs(Private.lootEventHistory[loot:GetTypeId()]) do
            if not event or e.occuredAt < event.occuredAt then
                event = e
            end
        end

        if event == nil then
            Debug.Error('Tracker.OnEntityLost somehow failed to find an event after counting a positive number of events')
        end

        -- Get that shit.
        Debug.Log('Tracker.OnEntityLost found a previous loot event that matches! Assuming looted by '..tostring(event.lootedBy)..' and to '..tostring(event.lootedTo)..', detected through '..tostring(event.event))
        Private.SetLooted({loot = loot, lootedTo = event.lootedTo, lootedBy = event.lootedBy})
    end

    -- Since we've lost the entity, we gotta update.
    Callback2.FireAndForget(Tracker.Update, loot:GetId(), Options['Tracker']['UpdateDelay'])
end





--[[
    Tracker.OnLootEvent(args)
    When an OnLootCollected or OnLootPickup has occured.

    Determines whether some form of OnLoot event should occur.    
]]--
function Tracker.OnLootEvent(args)
    -- Requires args.itemTypeId, otherwise we can't get item info
    if not args.itemTypeId then return end

    -- Get itemInfo
    local itemInfo = Game.GetItemInfoByType(args.itemTypeId)

    -- Is it loot that we care about?
    if itemInfo and IsTrackableItem(itemInfo) then

        -- Debug
        if Options['Debug']['LogLootableCollection'] then Debug.Table('Tracker.OnLootEvent', {itemInfo = itemInfo}) end

        -- Okay, do we have any identified loot?
        if not _table.empty(Private.trackedLoot) then

            -- So we should try to find a match.
            local loot = nil
            local matches = {}
            -- So, are we tracking anything like this?
            Debug.Log("Scanning for match: Available and typeId " .. tostring(args.itemTypeId))
            for id, item in pairs(Private.trackedLoot) do
                if item.state == LootState.Available and tostring(item:GetTypeId()) == tostring(args.itemTypeId) then
                    loot = item
                    matches[#matches + 1] = item
                end
            end

            Debug.Log("Scan Result: " .. tostring(#matches))

            -- Do we have more than one matches?
            if #matches > 1 then
                -- Shit.
                Debug.Log("Tracker.OnLootEvent Multiple potential matches (" .. tostring(count) .. ") for " .. tostring(itemInfo.name) .. ', ' .. tostring(args.itemTypeId))
                
                if not Private.lootEventHistory[args.itemTypeId] then
                    Private.lootEventHistory[args.itemTypeId] = {}
                end

                table.insert(Private.lootEventHistory[args.itemTypeId], {occuredAt = tonumber(System.GetClientTime()), lootedBy = args.lootedBy, lootedTo = args.lootedTo})

                for i, item in ipairs(matches) do
                    Callback2.FireAndForget(Tracker.Update, item:GetId(), i)
                end

            elseif #matches == 1 then
                -- Aww yeah! Get that shit.
                Debug.Log('Tracker.OnLootEvent for '..loot:GetName()..', '..tostring(loot:GetEntityId())..', '..loot:GetId())
                Debug.Log('It is being looted by '..tostring(args.lootedBy)..' and to '..tostring(args.lootedTo)..' and it was detected through '..tostring(args.event))

                -- Set the looted status
                Callback2.FireAndForget(Private.SetLooted, {loot = loot, lootedTo = args.lootedTo, lootedBy = args.lootedBy}, 0)

                -- Force update.
                Callback2.FireAndForget(Tracker.Update, loot:GetId(), Options['Tracker']['UpdateDelay'])
            else
                -- Hmm, so we weren't tracking this item
                Debug.Log("Tracker.OnLootEvent found no matches for " .. tostring(itemInfo.name) .. ', ' .. tostring(args.itemTypeId))
            end
        end
    end
end


--[[
    Tracker.Track(entityId, [targetInfo], [itemInfo])
    Identifies entity, adding it to a list of items that have been seen
]]--
function Tracker.Track(args)

    -- Setup vars from args
    local entityId     = args.entityId
    local targetInfo   = args.targetInfo
    local itemInfo     = args.itemInfo

    -- Check entityId
    if not entityId then
        -- We should have an entityId
        Debug.Warn("Loot.Create called without an entityId")
    end

    -- Be sure it still exists
    if not Game.IsTargetAvailable(entityId) then
        return
    end

    -- Setup targetInfo
    if not targetInfo then
        -- Do we have a valid entityId?
        if Game.IsTargetAvailable(entityId) then

            -- Get targetInfo by entityId
            targetInfo = Game.GetTargetInfo(entityId)

            -- Verify success
            if not targetInfo then
                Debug.Error('Loot.Create unable to acquire targetInfo for entityId '..tostring(entityId))
                return
            end

        -- If we don't have targetInfo, we must have an entityId that references a valid target, so that we can retrieve information.
        else
            Debug.Error('Loot.Create called without targetInfo, and lacks available entity.')
            return
        end
    end

    -- Setup itemInfo
    if not itemInfo then

        -- Do we have a valid itemTypeId?
        if targetInfo.itemTypeId then

            -- Get itemInfo by itemTypeId
            itemInfo = Game.GetItemInfoByType(targetInfo.itemTypeId)

            -- Verify success
            if not itemInfo then
                Debug.Error('Loot.Create was unable to acquire itemInfo for itemTypeId '..tostring(targetInfo.itemTypeId))
                return
            end

        -- We don't have a valid itemTypeId? Then what do we do...
        else
            Debug.Log("Loot.Create called without itemInfo, and lacks target with itemTypeId")
            Debug.Table({entityId, targetInfo, itemInfo})
            return
        end
    end

    -- Simplify testing a little -- Note: Still?
    targetInfo.name = targetInfo.name or itemInfo.name

    -- Be sure we haven't already identified this
    if Tracker.IsTrackedEntity(entityId) then
        Debug.Warn('Attempted to identify an already identified item.')
        return
    end

    -- Be sure we want this
    if not IsTrackableItem(itemInfo) then
        return
    end

    -- Prep data
    args.entityId = entityId
    args.targetInfo = targetInfo
    args.itemInfo = itemInfo

    -- Create loot
    local loot = Loot.Create(args)

    -- Setup update cycle
    loot.CYCLE_Update = Callback2.CreateCycle(Tracker.Update, loot:GetId())

    -- Save loot
    Private.trackedLoot[loot:GetId()] = loot
    Private.identityByEntity[loot:GetEntityId()] = loot:GetId()

    -- Fire event
    Component.GenerateEvent("XLT_ON_TRACKER_NEW", {lootId = loot:GetId()})

    -- Start update cycle
    loot.CYCLE_Update:Run(Options['Tracker']['LootUpdateInterval'])
end



function Tracker.Update(lootArg)
    local loot = nil
    if type(lootArg) == "table" then
        loot = lootArg
    else
        loot = Tracker.GetLootById(lootArg)
    end

    if not loot then
        Debug.Warn("Tracker.Update called with invalid loot argument " .. tostring(lootArg))
        return
    end

    local previousState = loot:GetState()

    loot:Update()

    local newState = loot:GetState()

    if newState ~= previousState then
        Component.GenerateEvent("XLT_ON_TRACKER_UPDATE", {lootId = loot:GetId(), previousState = previousState, newState = newState})
        

        if previousState == LootState.Available and newState == LootState.Looted then
            Component.GenerateEvent("XLT_ON_TRACKER_LOOTED", {lootId = loot:GetId(), previousState = previousState, newState = newState})
        end

        -- Trigger removal from Tracker
        if previousState == LootState.Available and not loot.markedForDeletion then
            loot.markedForDeletion = true
            Callback2.FireAndForget(Tracker.Remove, loot, Options['Tracker']['RemoveDelay'])
        end
    end

end

function Tracker.Remove(lootArg)
    local loot = nil
    if type(lootArg) == "table" then
        loot = lootArg
    else
        loot = Tracker.GetLootById(lootId)
    end

    if not loot then
        Debug.Warn("Tracker.Remove called with invalid loot argument " .. tostring(lootArg))
        return
    end

    Debug.Log("Tracker.Remove called for " ..loot:GetId().. " "..loot:GetName())

    local lootId = loot:GetId()

    -- Clear update cycle
    loot.CYCLE_Update:Stop()
    loot.CYCLE_Update:Release()

    -- Clear ent to id reference
    if loot:GetState() == LootState.Available then
        Private.identityByEntity[loot:GetEntityId()] = nil
    end

    -- Clear tracker reference
    Private.trackedLoot[loot:GetId()] = nil

    -- Self destruct
    loot:Destroy()

    -- Fire Event
    Component.GenerateEvent("XLT_ON_TRACKER_REMOVE", {lootId = lootId})
end







function Tracker.IsTrackedEntity(entityId) 
    local id = Private.identityByEntity[entityId]

    if id then
        return (Private.trackedLoot[id] ~= nil)
    end

    return false
end



function Tracker.GetLootById(id)
    local loot = Private.trackedLoot[id]

    if not loot then
        Debug.Log("Tracker.GetLootById returning nil because it did not find any matching loot")
    end

    return loot
end

function Tracker.GetLootByEntityId(entityId)
    local loot = Private.trackedLoot[Private.identityByEntity[entityId]]

    if not loot then
        Debug.Log("Tracker.GetLootByEntityId returning nil because it did not find any matching loot")
    end

    return loot
end



function Tracker.Stat()
    Debug.Table("trackedLoot", Private.trackedLoot)
    Debug.Table("lootEventHistory", Private.lootEventHistory)
end

function Tracker.Clear()
    for i, loot in pairs(Private.trackedLoot) do
        loot:Destroy()
    end

    for i, array in pairs(Private.lootEventHistory) do
        array = nil
    end

    for i, id in pairs(Private.identityByEntity) do
        id = nil
    end

    Private.trackedLoot = {}
    Private.lootEventHistory = {}
    Private.identityByEntity = {}
end




function Private.SetLooted(args)
    args.loot:SetLootedBy(tostring(args.lootedBy))
    args.loot:SetLootedTo(tostring(args.lootedTo))
end








--[[
    IsTrackableItem(itemInfo)
    Whether or not an item (post pickup) was a lootable target (ish)
]]--
function IsTrackableItem(itemInfo)
    -- Verify that the looted item is of a type that we care about
    return (IsEquipment(itemInfo) or IsModule(itemInfo) or IsSalvage(itemInfo) or IsComponent(itemInfo) or IsConsumable(itemInfo))
end



function IsEquipment(itemInfo)
    local EquipmentItemTypes = {
        'frame_module',
        'ability_module',
        'weapon',
    }

    for i, v in ipairs(EquipmentItemTypes) do
        if itemInfo.type == v then
            return true
        end
    end

    return false
end



function IsComponent(itemInfo)
    local old = (itemInfo.type == "crafting_component")
    local new = (itemInfo.type == "resource_item" and not itemInfo.flags.is_salvageable) -- Note: Uncertain, might be too broad

    local cc = (itemInfo.type == "basic" and itemInfo.flags.resource and itemInfo.flags.is_tradable)

    return (new or old or cc)
end



function IsSalvage(itemInfo)
    local cond1 = (itemInfo.type == "basic" or itemInfo.type == "resource_item")
    local cond2 = (itemInfo.rarity == "salvage")
    local cond3 = (itemInfo.flags.is_salvageable)

    return ((cond1 or cond2) and cond3)
end


function IsModule(itemInfo)
    return (itemInfo.type == "item_module")
end

function IsConsumable(itemInfo)
    return (itemInfo.type == "consumable")
end




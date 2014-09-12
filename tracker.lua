--[[
    Tracker
    The Tracking system. Detects and tracks loot drops. Stores data and triggers events to be used by the rest of the addon.
--]]
Tracker = {}

local Private = {
    trackedLoot = {},
    identityByEntity = {},

    lootEventHistory = {},

    CYCLE_Refresh = nil,
    CYCLE_LootEventHistoryCleanup = nil,

    canSendLimitWarning = true,
    limitWarningTimeout = 60, -- seconds before canSendLimitWarning is reset

    crystiteTypeId = tostring(10),


    trackedLootCounter = 0,
}


--[[
    Tracker.Setup()
    Performs OnComponentLoad tasks.
--]]
function Tracker.Setup()
    if Options['Tracker']['UpdateMode'] == TrackerUpdateMode.Global then
        Private.CYCLE_Refresh = Callback2.CreateCycle(Tracker.Refresh)
        Private.CYCLE_Refresh:Run(tonumber(Options['Tracker']['RefreshInterval']))
    end 
    Private.CYCLE_LootEventHistoryCleanup = Callback2.CreateCycle(Private.LootEventHistoryCleanup)
    Private.CYCLE_LootEventHistoryCleanup:Run(tonumber(Options['Tracker']['LootEventHistoryCleanupInterval']))
end

--[[
    Tracker.OnOptionChange(id, value)
    Called by Options when a Tracker Option is changed.
    Used to handle switching of tracking modes cleanly.
--]]
function Tracker.OnOptionChange(id, value)
    if id == 'Tracker_UpdateMode' then
        -- Switching from global to indivudal update mode
        if value == TrackerUpdateMode.Individual then
            -- Clear global refresh cycle
            if Private.CYCLE_Refresh then
                Private.CYCLE_Refresh:Stop()
                Private.CYCLE_Refresh:Release()
                Private.CYCLE_Refresh = nil
            end

            -- Create individual update cycles for each existing loot
            if not _table.empty(Private.trackedLoot) then
                for id, loot in pairs(Private.trackedLoot) do
                    if not loot.CYCLE_Update then
                        -- Setup update cycle
                        loot.CYCLE_Update = Callback2.CreateCycle(Tracker.Update, loot:GetId())

                        -- Start update cycle
                        loot.CYCLE_Update:Run(tonumber(Options['Tracker']['LootUpdateInterval']))
                    end
                end 
            end

        -- Switching from indivudal update to global
        elseif value == TrackerUpdateMode.Global then
            -- Clear indivudal updates
            if not _table.empty(Private.trackedLoot) then
                for id, loot in pairs(Private.trackedLoot) do
                    if loot.CYCLE_Update then
                        loot.CYCLE_Update:Stop()
                        loot.CYCLE_Update:Release()
                        loot.CYCLE_Update = nil
                    end
                end
            end

            -- Create global refresh cycle
            if not Private.CYCLE_Refresh then
                Private.CYCLE_Refresh = Callback2.CreateCycle(Tracker.Refresh)
                Private.CYCLE_Refresh:Run(tonumber(Options['Tracker']['RefreshInterval']))
            end
        end

    elseif id == 'Tracker_LootUpdateInterval' then

        if Options['Tracker']['UpdateMode'] == TrackerUpdateMode.Global then
            for id, loot in pairs(Private.trackedLoot) do
                if loot.CYCLE_Update then
                    loot.CYCLE_Update:Stop()
                    loot.CYCLE_Update:Run(tonumber(Options['Tracker']['LootUpdateInterval']))
                end
            end
        end

    elseif id == 'Tracker_RefreshInterval' then

        if Private.CYCLE_Refresh then
            Private.CYCLE_Refresh:Stop()
            Private.CYCLE_Refresh:Run(tonumber(Options['Tracker']['RefreshInterval']))
        end

    elseif id == 'LootEventHistoryCleanupInterval' then

        if Private.CYCLE_LootEventHistoryCleanup then
            Private.CYCLE_LootEventHistoryCleanup:Stop()
            Private.CYCLE_LootEventHistoryCleanup:Run(tonumber(Options['Tracker']['LootEventHistoryCleanupInterval']))
        end

    else
        --Debug.Log("Unhandled Option Id "..tostring(id))
    end
end




--[[
    Tracker.GetLoot()
    Returns a copy of all current loot data.
--]]
function Tracker.GetLoot()
    return _table.copy(Private.trackedLoot)
end

--[[
    Tracker.GetAvailableLoot()
    Returns a table of all loot that is currently available.
--]]
function Tracker.GetAvailableLoot()
    local result = {}
    for id, loot in pairs(Private.trackedLoot) do
        if loot:GetState() == LootState.Available then
            result[#result + 1] = loot
        end
    end
    return _table.copy(result)
end

--[[
    Tracker.GetCount()
    Returns the number of currently tracked items.
--]]
function Tracker.GetCount()
    local count = Private.trackedLootCounter
    return count
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
    -- Do we have room for it?
    elseif Private.trackedLootCounter >= tonumber(Options['Tracker']['Limit']) then
        if Private.canSendLimitWarning then
            Messages.SendSystemMessage(Lokii.GetString('SystemMessage_Tracker_HitLimit'))
            Private.canSendLimitWarning = false
            Callback2.FireAndForget(function(refPrivate) refPrivate.canSendLimitWarning = true end, Private, Private.limitWarningTimeout)
        end
        return -- Fire second thruster! Full ahead!
    end

    -- Sweet, a new entity. Track it!
    Callback2.FireAndForget(Tracker.Track, args, Options['Tracker']['TrackDelay'])
end


--[[
    Tracker.OnLootableEntity(args)
    Checks if the entity was being tracked. If it was, try to figure out if it despawned or not. Trigger an update so that the loot will eventually be removed.
    Call when an OnEntityLost has occured.
--]]
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
    
    --Debug.Log('Tracker.OnEntityLost for '..loot:ToString())

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
        --Debug.Log('Tracker.OnEntityLost found a previous loot event that matches! Assuming looted by '..tostring(event.lootedBy)..' and to '..tostring(event.lootedTo)..', detected through '..tostring(event.event))
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

    -- Ignore Crystite
    if args.itemTypeId == Private.crystiteTypeId and Options['Tracker']['IgnoreCrystite'] then
        return
    end

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
            --Debug.Log("Scanning for match: Available and typeId " .. tostring(args.itemTypeId))
            for id, item in pairs(Private.trackedLoot) do
                if item.state == LootState.Available and tostring(item:GetTypeId()) == tostring(args.itemTypeId) then
                    loot = item
                    matches[#matches + 1] = item
                end
            end

            --Debug.Log("Scan Result: " .. tostring(#matches))

            -- Do we have more than one matches?
            if #matches > 1 then
                -- Shit.
                -- Okay, we're gonna have to store this lootevent for now.
                --Debug.Log("Tracker.OnLootEvent Multiple potential matches (" .. tostring(count) .. ") for " .. tostring(itemInfo.name) .. ', ' .. tostring(args.itemTypeId))
                
                -- If we haven't recently stored any lootevents of this type, create the table
                if not Private.lootEventHistory[args.itemTypeId] then
                    Private.lootEventHistory[args.itemTypeId] = {}
                end

                -- Setup lootevent
                local lootEvent = {
                    occuredAt = tonumber(System.GetClientTime()),
                    lootedBy = args.lootedBy,
                    lootedTo = args.lootedTo
                }

                -- Insert lootevent into history
                table.insert(Private.lootEventHistory[args.itemTypeId], lootEvent)

                --[[
                -- Not sure if this was reasonable but it seems somewhat unneccessary now
                for i, item in ipairs(matches) do
                    Callback2.FireAndForget(Tracker.Update, item:GetId(), i)
                end
                --]]

            -- Is this the one?
            elseif #matches == 1 then
                -- Aww yeah! Get that shit.
                --Debug.Log('Tracker.OnLootEvent for '..loot:GetName()..', '..tostring(loot:GetEntityId())..', '..loot:GetId())
                --Debug.Log('It is being looted by '..tostring(args.lootedBy)..' and to '..tostring(args.lootedTo)..' and it was detected through '..tostring(args.event))

                -- Set the looted status
                Private.SetLooted({loot = loot, lootedTo = args.lootedTo, lootedBy = args.lootedBy})

                -- Force update.
                Callback2.FireAndForget(Tracker.Update, loot:GetId(), Options['Tracker']['UpdateDelay'])

            -- No matches?
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
    args.event = "Tracker.Track"
    --Debug.Event(args)

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
    if not Game.IsTargetAvailable(entityId) and not (Options['Debug']['Enabled'] and tonumber(entityId) <= 2000) then
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

            -- Control types
            targetInfo.itemTypeId = tostring(targetInfo.itemTypeId)

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
            itemInfo = Game.GetItemInfoByType(targetInfo.itemTypeId, targetInfo.modules)

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

    -- Ignore Crystite
    if targetInfo.itemTypeId == Private.crystiteTypeId and Options['Tracker']['IgnoreCrystite'] then
        return
    end

    -- Ignore Blacklisted typeIds
    if Options['Blacklist']['Tracker'][tostring(targetInfo.itemTypeId)] then
        return
    end

    -- Ignore Metals in Tornado
    if Options['Tracker']['IgnoreMetalsTornado'] and Loot.DetermineCategory(targetInfo, itemInfo) == LootCategory.Metals then
        for i, tornadoZoneId in ipairs(TornadoPocketZoneIds) do
            if State.zoneId == tornadoZoneId then
                return
            end
        end
    end


    -- Create loot
    --Debug.Log("About to create loot")
    local loot = Loot(entityId, targetInfo, itemInfo)

    --Debug.Log("Created new loot!" .. loot:ToString())

    -- Save loot
    Private.trackedLoot[loot:GetId()] = loot
    Private.identityByEntity[loot:GetEntityId()] = loot:GetId()

    -- Increment counter
    Private.trackedLootCounter = Private.trackedLootCounter + 1

    -- Fire event
    --Component.GenerateEvent("XLT_ON_TRACKER_NEW", {lootId = loot:GetId()})
    OnTrackerNew({lootId = loot:GetId()})

    -- Setup indivdual updates
    if Options['Tracker']['UpdateMode'] == 'individual' then
        -- Setup update cycle
        loot.CYCLE_Update = Callback2.CreateCycle(Tracker.Update, loot:GetId())

        -- Start update cycle
        loot.CYCLE_Update:Run(Options['Tracker']['LootUpdateInterval'])
    end
end


--[[
    Tracker.Update(lootArg)
    Updates the state of a loot instance.
    Fires the OnTrackerUpdate event if the state of the loot has changed.
    Additionally, if the item was looted, fires the OnTrackerLooted event.
    Additionally, queues the removal of items that are no longer available.
]]--
function Tracker.Update(lootArg)
    -- Handle argument
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

    -- Store pre-update state
    local previousState = loot:GetState()

    -- Call update
    loot:Update()

    -- Get post-update state
    local newState = loot:GetState()

    -- Has the state changed? If so, trigger events
    if newState ~= previousState then

        -- XLT_ON_TRACKER_UPDATE is always triggered when the state changes
        --Component.GenerateEvent("XLT_ON_TRACKER_UPDATE", {lootId = loot:GetId(), previousState = previousState, newState = newState})
        OnTrackerUpdate({lootId = loot:GetId(), previousState = previousState, newState = newState})
        
        -- XLT_ON_TRACKER_LOOTED is triggered when an item that was available changes to having been looted
        if previousState == LootState.Available and newState == LootState.Looted then
            --Component.GenerateEvent("XLT_ON_TRACKER_LOOTED", {lootId = loot:GetId(), previousState = previousState, newState = newState})
            OnTrackerLooted({lootId = loot:GetId(), previousState = previousState, newState = newState})
        end

        -- Trigger internal removal from Tracker
        if previousState == LootState.Available and not loot.markedForDeletion then
            loot.markedForDeletion = true
            Callback2.FireAndForget(Tracker.Remove, loot, Options['Tracker']['RemoveDelay'])
        end
    end

end

--[[
    Tracker.Remove(lootArg)
    Removes a tracked loot instance cleanly.
    Fires the OnTrackerRemove event.
--]]
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

    local lootId = loot:GetId()

    -- Clear update cycle
    if loot.CYCLE_Update then
        loot.CYCLE_Update:Stop()
        loot.CYCLE_Update:Release()
        loot.CYCLE_Update = nil
    end

    -- Clear ent to id reference
    if loot:GetState() == LootState.Available or Private.identityByEntity[loot:GetEntityId()] then
        Private.identityByEntity[loot:GetEntityId()] = nil
    end

    -- Clear tracker reference
    Private.trackedLoot[loot:GetId()] = nil

    -- Decrement counter
    Private.trackedLootCounter = Private.trackedLootCounter - 1

    -- Self destruct
    loot:Destroy()

    -- Fire Event
    --Component.GenerateEvent("XLT_ON_TRACKER_REMOVE", {lootId = lootId})
    OnTrackerRemove({lootId = lootId})
end

--[[
    Tracker.IsTrackedEntity(entityId) 
    Returns true if entityId is currently being tracked.
--]]
function Tracker.IsTrackedEntity(entityId) 
    local id = Private.identityByEntity[entityId]

    if id then
        return (Private.trackedLoot[id] ~= nil)
    end

    return false
end


--[[
    Tracker.GetLootById(id) 
    Returns the loot instance with the matching lootId.
--]]
function Tracker.GetLootById(lootId)
    local loot = Private.trackedLoot[lootId]

    if not loot then
        Debug.Log("Tracker.GetLootById returning nil because it did not find any matching loot for lootId: " .. tostring(lootId))
    end

    return loot
end

--[[
    Tracker.GetLootByEntityId(entityId)
    Returns the loot instance with the matching entityId.
--]]
function Tracker.GetLootByEntityId(entityId)
    local loot = Private.trackedLoot[Private.identityByEntity[entityId]]

    if not loot then
        Debug.Log("Tracker.GetLootByEntityId returning nil because it did not find any matching loot for entityId " .. tostring(entityId))
    end

    return loot
end

--[[
    Tracker.Clear()
    Clears trackedLoot and the lootEventHistory as cleanly as possible.
--]]
function Tracker.Clear()
    for i, loot in pairs(Private.trackedLoot) do
        Tracker.Remove(loot)
    end

    for i, array in pairs(Private.lootEventHistory) do
        array = nil
    end

    Private.trackedLoot = {}
    Private.lootEventHistory = {}
    Private.identityByEntity = {}
end


--[[
    Tracker.Stat()
    Debug output for the Stat slash command.
--]]
function Tracker.Stat()
    --Debug.Table("trackedLoot", Private.trackedLoot)
    --Debug.Table("lootEventHistory", Private.lootEventHistory)
    Debug.Log("Tracker.GetCount(): " .. tostring(Tracker.GetCount()))
end

--[[
    Private.SetLooted(args)
    Sets the lootedBy/To properties of a loot instance.
--]]
function Private.SetLooted(args)
    args.loot:SetLootedBy(tostring(args.lootedBy))
    args.loot:SetLootedTo(tostring(args.lootedTo))
end

--[[
    Private.LootEventHistoryCleanup()
    Removes aged entries in the lootEventHistory.
--]]
function Private.LootEventHistoryCleanup()

    if not _table.empty(Private.lootEventHistory) then
        
        local remove = table.remove -- I don't know if this helps
        local asnumber = tonumber -- But give me that performance pls
        local emptyTable = _table.empty -- This looks so bad
        local currentTime = asnumber(System.GetClientTime())
        local lifetime = asnumber(Options['Tracker']['LootEventHistoryLifetime'])


        for itemTypeId, events in pairs(Private.lootEventHistory) do

            -- Go trough events if not empty
            if not emptyTable(events) then

                local i=1
                while i <= #events do
                    local event = events[i]

                    -- If has lived longer than life, remove
                    if (currentTime - asnumber(event.occuredAt) > lifetime) then
                        remove(events, i)
                    else
                        i = i + 1
                    end
                end
            end

            -- Remove table if empty (second check, in case events have been removed)
            if emptyTable(events) then
                Private.lootEventHistory[itemTypeId] = nil
            end

        end
    end
end











--[[
    IsTrackableItem(itemInfo)
    Whether or not an item can be tracked by the addon.
]]--
function IsTrackableItem(itemInfo)
    -- Verify that the looted item is of a type that we care about
    return (IsEquipment(itemInfo) or IsModule(itemInfo) or IsSalvage(itemInfo) or IsConsumable(itemInfo) or IsMetal(itemInfo) or IsComponent(itemInfo) or IsCurrency(itemInfo))
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
    -- SubTypeIds.Resource should be 15 and represent Crafting Components
    local old = (itemInfo.type == "crafting_component")
    local new = (itemInfo.type == "resource_item" and itemInfo.subTypeId and Game.IsItemOfType(itemInfo.itemTypeId, SubTypeIds.Resource))

    local extra = (itemInfo.type == "basic" and itemInfo.flags.resource and itemInfo.flags.is_tradable)

    return (new or extra or old)
end

function IsMetal(itemInfo)
    local rawMetalsSubTypeId = 3288

    local metals = (itemInfo.type == "resource_item" and itemInfo.flags.resource and itemInfo.subTypeId and Game.IsItemOfType(itemInfo.itemTypeId, rawMetalsSubTypeId))

    return (metals)
end

function IsBioMaterial(itemInfo)
    local rawBioMaterialsSubTypeId = 3291

    local biomaterials = (itemInfo.type == "resource_item" and itemInfo.flags.resource and itemInfo.subTypeId and Game.IsItemOfType(itemInfo.itemTypeId, rawBioMaterialsSubTypeId))

    return (biomaterials)
end

function IsCurrency(itemInfo)
    -- SubTypeIds.Currency should be 207 and represent Currency
    return (itemInfo.subTypeId and Game.IsItemOfType(itemInfo.itemTypeId, SubTypeIds.Currency))
end

function IsSalvage(itemInfo)
    local cond1 = (itemInfo.type == "basic" or itemInfo.type == "resource_item")
    local cond2 = (itemInfo.rarity == "salvage")
    local cond3 = (itemInfo.flags and itemInfo.flags.is_salvageable)

    return ((cond1 or cond2) and cond3)
end

function IsModule(itemInfo)
    return (itemInfo.type == "item_module")
end

function IsConsumable(itemInfo)
    return (itemInfo.type == "consumable")
end




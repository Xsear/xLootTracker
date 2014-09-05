--[[
    Waypoints
    Handles the waypoints.
--]]
WaypointManager = {
    
}

local Private = {
    waypointList = {},
    visibility = true,
}

MarkerType = {
    Loot = "loot",
    Group = "group",
}

--[[
    WaypointManager.OnTrackerNew(args)
    Called when Tracker has added a new item.
    Triggers the creation of a waypoint for that item.
--]]
function WaypointManager.OnTrackerNew(args)
    if not Options['Waypoints']['Enabled'] then return end
    
    local loot = Tracker.GetLootById(args.lootId)

    if Options['Blacklist']['Waypoints'][tostring(loot:GetTypeId())] then
        return
    end

    if LootFiltering(loot, Options['Waypoints']) then
        WaypointManager.Create(loot)
    end
end

--[[
    WaypointManager.OnTrackerLooted(args)
    Called when Tracker thinks an item was looted.
    Triggers the removal of the Waypoint for that item.
--]]
function WaypointManager.OnTrackerLooted(args)
    if not Options['Waypoints']['Enabled'] then return end
    WaypointManager.Remove(args.lootId)
end

--[[
    WaypointManager.OnTrackerRemove(args)
    Called when Tracker has removed an item.
    Triggers the removal of the Waypoint for that item.
--]]
function WaypointManager.OnTrackerRemove(args)
    if not Options['Waypoints']['Enabled'] then return end
    WaypointManager.Remove(args.lootId)
end

--[[
    WaypointManager.Create(loot)
    Creates a Waypoint for loot.
--]]
function WaypointManager.Create(loot)
    -- Check Args
    if not loot or type(loot) ~= "table" then
        Debug.Log("WaypointManager.Create called with invalid argument: " .. tostring(loot))
        return
    end

    -- Check Available
    if loot:GetState() ~= LootState.Available then
        Debug.Log("Cannot create waypoint for unavailable " .. loot:ToString())
        return
    end

    -- Check Entity
    --[[
    if not loot:GetEntityId() or not Game.IsTargetAvailable(loot:GetEntityId()) then
        Debug.Warn("Attempt to create waypoint for loot with state available but no available entity")
        return
    end
    --]]

    -- Create Marker
    local markerId = "xlt_"..tostring(loot:GetEntityId()).."_waypoint"
    local MARKER = MapMarker.Create(markerId)

    -- Bind to loot entity
    if Game.IsTargetAvailable(loot:GetEntityId()) then
        MARKER:BindToEntity(loot:GetEntityId())
    else
        local modPos = _table.copy(loot:GetPos())
        modPos.z = modPos.z + 1
        MARKER:BindToPosition(modPos)
    end

    -- Text
    MARKER:SetTitle(Private.GetWaypointTitle(loot))
    MARKER:SetSubtitle(Lokii.GetString('UI_Waypoints_Subtitle'))

    -- Color ?
    MARKER:SetThemeColor(loot:GetColor())

    -- Icon
    local MULTIART = MARKER:GetIcon()
    MULTIART:SetUrl(loot:GetWebIcon())

    -- Visibility
    MARKER:ShowOnHud(Options['Waypoints']['ShowOnHud'] and Private.visibility)
    --MARKER:SetHudPriority(Options['Waypoints']['HudPriority'])
    MARKER:ShowOnWorldMap(Options['Waypoints']['ShowOnWorldMap'])
    MARKER:ShowOnRadar(Options['Waypoints']['ShowOnRadar']) 
    MARKER:SetRadarEdgeMode(Options['Waypoints']['RadarEdgeMode'])

    -- Insert
    Private.waypointList[#Private.waypointList + 1] = {MARKER = MARKER, markerType = MarkerType.Loot, lootId = loot:GetId()}
end

--[[
    WaypointManager.Remove(lootId)
    Removes the Waypoint for the specified lootId.
--]]
function WaypointManager.Remove(lootId)
    for i, waypoint in ipairs(Private.waypointList) do
        if waypoint.markerType == MarkerType.Loot then
            if waypoint.lootId == lootId then
                waypoint.MARKER:Destroy()
                table.remove(Private.waypointList, i)
                break
            end
        end 
    end
end

--[[
    WaypointManager.Stat()
    Debug output for the Stat slash command.
--]]
function WaypointManager.Stat()
    Debug.Log('WaypointManager is tracking ' .. tostring(#Private.waypointList) .. ' waypoints.')
end

--[[
    Private.GetWaypointTitle(loot)
    Returns a formatted title for the Waypoint matching the filters of the loot.
--]]
function Private.GetWaypointTitle(loot)
    local categoryKey, rarityKey = GetLootFilteringOptionsKeys(loot, Options['Waypoints']['Filtering'])
    local formatString = Options['Waypoints']['Filtering'][categoryKey][rarityKey]['WaypointTitle']
    return Messages.TextFilters(formatString, {loot=loot})
end












--[[
    WaypointManager.ToggleVisibility
    This totally doesn't work. Fixme: dafaq you doing here.
--]]
function WaypointManager.ToggleVisibility(show)
    Private.visibility = show or not Private.visibility
    for i, waypoint in ipairs(Private.waypointList) do
        waypoint.MARKER:ShowOnHud(Private.visibility)
    end
end


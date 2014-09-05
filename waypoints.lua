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


function WaypointManager.Stat()
    Debug.Table("WaypointManager Private.waypointList", Private.waypointList)
end

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

function WaypointManager.OnTrackerLooted(args)
    if not Options['Waypoints']['Enabled'] then return end
    WaypointManager.OnLootStateChange(args)
end


function WaypointManager.OnTrackerRemove(args)
    if not Options['Waypoints']['Enabled'] then return end
    args.newState = "silly"
    WaypointManager.OnLootStateChange(args)
end


function WaypointManager.Create(loot)
    -- Check Args
    if not loot or type(loot) ~= "table" then
        Debug.Log("WaypointManager.Create called with invalid argument: " .. tostring(loot))
        return
    end

    -- Check Loot State
    if loot:GetState() ~= LootState.Available then
        Debug.Log("Cannot create waypoint for unavailable " .. Loot:ToString())
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
    MARKER:SetTitle(GetWaypointTitle(loot))
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

function WaypointManager.ToggleVisibility(show)
    Private.visibility = show or not Private.visibility
    for i, waypoint in ipairs(Private.waypointList) do
        waypoint.MARKER:ShowOnHud(Private.visibility)
    end
end


function WaypointManager.OnLootStateChange(args)
    if args.newState ~= LootState.Available then
        for i, waypoint in ipairs(Private.waypointList) do
            if waypoint.markerType == MarkerType.Loot then
                if waypoint.lootId == args.lootId then
                    waypoint.MARKER:Destroy()
                    table.remove(Private.waypointList, i)
                    break
                end
            
            elseif args.markerType == MarkerType.Group then
                -- Todo:
            end 
        end

    end
end

function GetWaypointTitle(loot)
    local categoryKey, rarityKey = GetLootFilteringOptionsKeys(loot, Options['Waypoints']['Filtering'])
    local formatString = Options['Waypoints']['Filtering'][categoryKey][rarityKey]['WaypointTitle']
    return Messages.TextFilters(formatString, {loot=loot})
end

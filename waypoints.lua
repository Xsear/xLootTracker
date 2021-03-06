--[[
    Waypoints
    Handles the waypoints.
--]]
WaypointManager = {
    
}

local Private = {
    waypointList = {},
    hudVisible = true,
}

MarkerType = {
    Loot = 'loot',
    Group = 'group',
}


function WaypointManager.Enable()
    -- Create waypoints for available loot
    local availableLoot = Tracker.GetAvailableLoot()
    if not _table.empty(availableLoot) then
        for i, loot in ipairs(availableLoot) do 
            WaypointManager.OnTrackerNew({lootId = loot:GetId()})
        end
    end
end

function WaypointManager.Disable()
    -- Clear existing waypoints
    if not _table.empty(Private.waypointList) then
        for i, waypoint in ipairs(Private.waypointList) do

            if waypoint.MARKER then
                waypoint.MARKER:Destroy()
            end

        end

        Private.waypointList = {}
    end
end

function WaypointManager.OnOptionChange(id, value)
    if id == 'Waypoints_Enabled' then
        -- Enabled
        if value then
            WaypointManager.Enable()

        -- Disabled
        else
            WaypointManager.Disable()
        end
    
    else
        -- Todo: Add support for updating Waypoints on the fly as their options are being changed.
    end
end






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

    if Filtering.Filter(loot, Options['Waypoints']) then
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
    if not loot or type(loot) ~= 'table' then
        Debug.Log('WaypointManager.Create called with invalid argument: ' .. tostring(loot))
        return
    end

    -- Check Available
    if loot:GetState() ~= LootState.Available then
        Debug.Log('Cannot create waypoint for unavailable ' .. loot:ToString())
        return
    end

    -- Check Entity
    --[[
    if not loot:GetEntityId() or not Game.IsTargetAvailable(loot:GetEntityId()) then
        Debug.Warn('Attempt to create waypoint for loot with state available but no available entity')
        return
    end
    --]]

    -- Create Marker
    local markerId = 'xlt_'..tostring(loot:GetEntityId())..'_waypoint'
    local MARKER = MapMarker.Create(markerId)

    -- Setup waypoint table
    local waypoint = {MARKER = MARKER, markerType = MarkerType.Loot, lootId = loot:GetId()}

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
    local webIcon = loot:GetWebIcon()
    if type(webIcon) == "string" then
        MULTIART:SetUrl(webIcon)
    else
        MULTIART:SetIcon(webIcon)
    end

    -- Visibility
    Private.SetHudVisibility(waypoint)

    --MARKER:SetHudPriority(Options['Waypoints']['HudPriority'])
    MARKER:ShowOnWorldMap(Options['Waypoints']['ShowOnWorldMap'])
    MARKER:ShowOnRadar(Options['Waypoints']['ShowOnRadar']) 
    MARKER:SetRadarEdgeMode(Options['Waypoints']['RadarEdgeMode'])

    -- Insert
    Private.waypointList[#Private.waypointList + 1] = waypoint
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
    local categoryKey, rarityKey = Filtering.GetFilteringOptionsKeys(loot, Options['Waypoints']['Filtering'])
    local formatString = Options['Waypoints']['Filtering'][categoryKey][rarityKey]['WaypointTitle']
    return Messages.TextFilters(formatString, {loot=loot})
end












--[[
    WaypointManager.ToggleVisibility
    First call - Hides all waypoints that are not of the same rarity as the rarest item in the tracker. Second call (when such a threhsold is set) - reset to 0, show all.
--]]
function WaypointManager.ToggleVisibility(args)
    -- Toggle hudVisible
    Private.hudVisible = not Private.hudVisible

    -- Update visibilty
    for i, waypoint in ipairs(Private.waypointList) do
        Private.SetHudVisibility(waypoint)
    end
end

function Private.SetHudVisibility(waypoint)
    -- Saftey check
    if not waypoint.lootId or not waypoint.MARKER then
        return
    end

    -- Determine if visible or not
    local isVisible = Options['Waypoints']['ShowOnHud'] and Private.hudVisible

    -- Set visibility
    waypoint.MARKER:ShowOnHud(isVisible)
end

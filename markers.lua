

WaypointManager = {
    
}

PanelManager = {
    
}

local Private = {
    waypointList = {},
    panelList = {},
    visibility = true,

    waypointGroups = {}
}

MarkerType = {
    Loot = "loot",
    Group = "group",
}


local optionEnableGrouping = true
local optionGroupRadius = 15

function WaypointManager.Stat()
    Debug.Table("WaypointManager Private.waypointList", Private.waypointList)
end

function WaypointManager.OnTrackerNew(args)
    if not Options['Waypoints']['Enabled'] then return end
    
    local loot = Tracker.GetLootById(args.lootId)

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


function WaypointManager.UpdateGroup(groupId)
    
    -- Removal of waypoint
    for i, waypoint in ipairs(Private.waypointList) do
        if waypoint.markerType == MarkerType.Group then
            if waypoint.groupId == groupId then
                waypoint.MARKER:Destroy()
                table.remove(Private.waypointList, i)
                break
            end
        end 
    end

    -- Get our group
    local ourGroup = nil
    for i, group in ipairs(Private.waypointGroups) do
        if group.groupId == groupId then
            ourGroup = group
            break
        end
    end
    if not ourGroup then Debug.Error("Couldnt find group to break watafak") return end

    local ourMembersAsLoot = Private.GetGroupMembersAsLoot(ourGroup)

    local ourMasterAsLoot = Tracker.GetLootById(ourGroup.master) -- Xsear pls

    -- Calculate quantity
    local groupQuantity = 0 + ourMasterAsLoot:GetQuantity()
    for i, loot in ipairs(ourMembersAsLoot) do
        groupQuantity = groupQuantity + loot:GetQuantity()
    end


    -- Create Marker
    local MARKER = MapMarker.Create(groupId)

    -- Bind to master loot entity
    MARKER:BindToEntity(ourMasterAsLoot:GetEntityId())

    -- Text
    local title
    if not _table.empty(ourGroup.members) then
        title = GetWaypointTitle(ourMasterAsLoot)
    else
        title = "Group: " .. tostring(groupQuantity) .. " (" .. tostring(#ourGroup.members + 1) .. ") of " .. ourMasterAsLoot:GetName()
    end
    MARKER:SetTitle(title)
    MARKER:SetSubtitle(Lokii.GetString('UI_Waypoints_Subtitle'))

    -- Color ?
    MARKER:SetThemeColor(ourMasterAsLoot:GetColor())

    -- Icon
    local MULTIART = MARKER:GetIcon()
    MULTIART:SetUrl(ourMasterAsLoot:GetWebIcon())

    -- Visibility
    MARKER:ShowOnHud(Options['Waypoints']['ShowOnHud'] and Private.visibility)
    --MARKER:SetHudPriority(Options['Waypoints']['HudPriority'])
    MARKER:ShowOnWorldMap(Options['Waypoints']['ShowOnWorldMap'])
    MARKER:ShowOnRadar(Options['Waypoints']['ShowOnRadar']) 
    MARKER:SetRadarEdgeMode(Options['Waypoints']['RadarEdgeMode'])

    -- Insert
    Private.waypointList[#Private.waypointList + 1] = {MARKER = MARKER, markerType = MarkerType.Group, groupId = ourGroup.groupId}

end


function Private.GetGroupMembersAsLoot(ourGroup)
    local ourMembersAsLoot = {}
    for i, member in ipairs(ourGroup.members) do
        ourMembersAsLoot[i] = Tracker.GetLootById(member)
    end
    return ourMembersAsLoot
end


-- needs new master
function WaypointManager.BreakGroup(groupId)
    -- Get our group
    local ourGroup = nil
    for i, group in ipairs(Private.waypointGroups) do
        if group.groupId == groupId then
            ourGroup = group
            break
        end
    end
    if not ourGroup then Debug.Error("Couldnt find group to break watafak") return end


    -- First off, let's try to bleed some members into other groups
    for i, otherGroup in ipairs(Private.waypointGroups) do

        -- If the type matches
        if otherGroup.typeId == ourGroup.typeId then

            -- We should probably get our members here too or something rather than regetting them each itteration, but w/e
            local otherMaster = Tracker.GetLootById(otherGroup.master)
       
            -- Itterate our members checking if they can join the othergroup
            local n=1
            while n <= #ourGroup.members do


                -- Get loot
                local member = ourGroup.members[n]
                local ourMember = Tracker.GetLootById(member)

                Debug.Table("Break Group OurGroup ", ourGroup)

                -- If it can join, sayonara
                if Private.CanLootJoin(otherMaster, ourMember) then
                    otherGroup.members[#otherGroup.members] = ourMember:GetId()
                    table.remove(ourGroup.members, n)
                    WaypointManager.UpdateGroup(otherGroup.groupId)
                else
                    n = n + 1
                end
            end

        end
    end


    -- Do we still have members?
    if not _table.empty(ourGroup.members) then

        -- Argh, well, can they form a group themselves?
        
        

        local ourMembersAsLoot = Private.GetGroupMembersAsLoot(ourGroup)

        -- legit code
        local function buildPotentialGroups(ourGroup, ourMembersAsLoot)
            local potentialGroups = {}
            for i, potentialMaster in ipairs(ourGroup.members) do
                for n, otherMember in ipairs(ourGroup.members) do
                    if i ~= n then -- Ignore ourselves
                        if Private.CanLootJoin(ourMembersAsLoot[i], ourMembersAsLoot[n]) then
                            if not potentialGroups[i] then
                                potentialGroups[i] = {master = potentialMaster, typeId = ourGroup.typeId, members={otherMember}}
                            else
                                potentialGroups[i].members[#potentialGroups[i].members] = otherMember
                            end
                        end
                    end
                end
            end
            return potentialGroups
        end

        -- yeaa
        local potentialGroups = buildPotentialGroups(ourGroup, ourMembersAsLoot)

        -- If there are potential groups
        while not _table.empty(potentialGroups) do

            -- Find best group
            local bestGroup = nil
            for i, group in ipairs(potentialGroups) do
                if not bestGroup then
                    bestGroup = group
                else
                    if #bestGroup.members < #group.members then
                        bestGroup = group
                    end
                end
            end
            if not bestGroup then
                Debug.Error("no best group dafaq")
                return
            end


            -- We're gonna make the best group, so remove members from other potential groups
            for i, bestMember in ipairs(bestGroup) do
                for n, member in ipairs(ourGroup.members) do
                    if bestMember == member then
                        table.remove(ourGroup.members, n)
                        break
                    end
                end
            end

            -- Make official!
            bestGroup.groupId = "xlt_"..tostring(bestGroup.master).."_group_waypoint"
            table.insert(Private.waypointGroups, bestGroup)
            WaypointManager.UpdateGroup(bestGroup.groupId)

            -- Rebuild our shiz!
            ourMembersAsLoot = Private.GetGroupMembersAsLoot(ourGroup)
            potentialGroups = buildPotentialGroups(ourGroup, ourMembersAsLoot)
        end


    end
    


end


function Private.CanLootJoin(master, loot)
    -- Get positions
    local lootPos = loot:GetPos()
    local masterPos = master:GetPos()

    -- Are we in range of master?
    if (lootPos.x - masterPos.x)^2 + (lootPos.y - masterPos.y)^2 < optionGroupRadius^2 then
        return true -- We belong to this group!
    end

    -- Nope
    return false
end


function WaypointManager.RemoveGroup(groupId)
    -- Removal of waypoint
    for i, waypoint in ipairs(Private.waypointList) do
        if waypoint.markerType == MarkerType.Group then
            if waypoint.groupId == groupId then
                waypoint.MARKER:Destroy()
                table.remove(Private.waypointList, i)
                break
            end
        end 
    end

    -- Removal of group
    for i, group in ipairs(Private.waypointGroups) do
        if group.groupId == groupId then
            table.remove(Private.waypointGroups, i)
        end
    end
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
    if not loot:GetEntityId() or not Game.IsTargetAvailable(loot:GetEntityId()) then
        Debug.Warn("Attempt to create waypoint for loot with state available but no available entity")
        return
    end


    -- Should we group?
    if optionEnableGrouping and loot:GetCategory() == LootCategory.Components or loot:GetCategory() == LootCategory.Salvage then

        -- If there are groups, attempt to join one
        if not _table.empty(Private.waypointGroups) then

            -- Get our position
            local lootTypeId = loot:GetTypeId()
            local lootPos = loot:GetPos()

            -- For each group
            for i, group in ipairs(Private.waypointGroups) do

                -- Is it a group we can join?
                if lootTypeId == group.typeId then

                    -- Get master
                    local groupMaster = Tracker.GetLootById(group.master)

                    -- Get masters position
                    local masterPos = groupMaster:GetPos()

                    -- Are we in range of master?
                    if (lootPos.x - masterPos.x)^2 + (lootPos.y - masterPos.y)^2 < optionGroupRadius^2 then
                        -- We belong to this group!
                        group.members[#group.members + 1] = loot:GetId()
                        WaypointManager.UpdateGroup(group.groupId)
                        return -- End the function here
                    end

                end
            end

        end 

        -- Couldn't find a group to join, make one
        local group = {
            groupId = "xlt_"..tostring(loot:GetId()).."_group_waypoint",
            master = loot:GetId(),
            typeId = loot:GetTypeId(),
            members = {},
        }

        table.insert(Private.waypointGroups, group)
        WaypointManager.UpdateGroup(group.groupId)

    else

        -- Create Marker
        local markerId = "xlt_"..tostring(loot:GetEntityId()).."_waypoint"
        local MARKER = MapMarker.Create(markerId)

        -- Bind to loot entity
        MARKER:BindToEntity(loot:GetEntityId())

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

    
end

function WaypointManager.ToggleVisibility(show)
    Private.visibility = show or not Private.visibility
    for i, waypoint in ipairs(Private.waypointList) do
        waypoint.MARKER:ShowOnHud(Private.visibility)
    end
end


function WaypointManager.OnLootStateChange(args)
    if args.newState ~= LootState.Available then



        -- Group waypoint search
        if optionEnableGrouping then

            for i, group in ipairs(Private.waypointGroups) do

                -- Check if the item that was looted/despawned was the master of a group
                if group.master == args.lootId then

                    -- If there were no other members, we can just remove the group
                    if _table.empty(group.members) then
                        WaypointManager.RemoveGroup(group.groupId)

                    -- Othewise Oh dear...
                    else
                        WaypointManager.BreakGroup(group.groupId)
                    end

                -- Check if it was a member of a group
                else
                    for n, member in ipairs(group.members) do
                        if member == args.lootId then
                            -- Remove member from group
                            table.remove(group.members, n)
                            WaypointManager.UpdateGroup(group.groupId)
                        end
                    end
                end

            end
        end

        -- Normal waypoint search
   
            for i, waypoint in ipairs(Private.waypointList) do
                if waypoint.markerType == MarkerType.Loot then
                    if waypoint.lootId == args.lootId then
                        waypoint.MARKER:Destroy()
                        table.remove(Private.waypointList, i)
                        break
                    end
                end 
            end


    end
end

function WaypointManager.GetYourShitTogether()
    Debug.Log("Sorry :(")
    Private.waypointList = {}
end

function GetWaypointTitle(loot)
    local categoryKey, rarityKey = GetLootFilteringOptionsKeys(loot, Options['Waypoints']['Filtering'])
    local formatString = Options['Waypoints']['Filtering'][categoryKey][rarityKey]['WaypointTitle']
    return Messages.TextFilters(formatString, {loot=loot})
end











function PanelManager.Stat()
    Debug.Table("PanelManager Private.panelList", Private.panelList)
end

function PanelManager.OnTrackerNew(args)
    if not Options['Panels']['Enabled'] then return end

    local loot = Tracker.GetLootById(args.lootId)

    if LootFiltering(loot, Options['Panels']) then
        PanelManager.Create(loot)
    end
end

function PanelManager.OnTrackerLooted(args)
    if not Options['Panels']['Enabled'] then return end
    Debug.Log("PanelManager.OnTrackerLooted calling Remove")
    PanelManager.Remove(args.lootId)
end

function PanelManager.OnTrackerRemove(args)
    if not Options['Panels']['Enabled'] then return end
    Debug.Log("PanelManager.OnTrackerRemove calling Remove")
    PanelManager.Remove(args.lootId)
end




function PanelManager.Create(loot)
    -- Verify available
    if loot:GetState() ~= LootState.Available then
        Debug.Warn("PanelManager.Create called for unavailable loot!")
        return
    end

    -- Create object
    local panel = LKObjects.Create(LOOTPANEL)

    -- Setup position and orientation
    local lootPos = loot:GetPos()
    local translationVector = Vec3.New(lootPos.x, lootPos.y, lootPos.z + 2)
    panel.pos:SetParam('Translation', translationVector)
    panel.pos:SetParam('Rotation', {axis={x=0,y=0,z=1},angle=0})

    -- Get some handles
    local RenderTarget = panel.panel_rt
    local LOOT_PANEL_CONTENT = RenderTarget:GetChild('Panel'):GetChild('Content')
    local LOOT_PANEL_HEADER = LOOT_PANEL_CONTENT:GetChild('Header')
    local LOOT_PANEL_ICONBAR = LOOT_PANEL_CONTENT:GetChild('IconBar')

    -- Build Header
        -- Item Name
        LOOT_PANEL_HEADER:GetChild('itemName'):SetText(loot:GetName())

        -- Headerbar and Item Name colors

            -- Find header colors
            local qualityColor, headerBarColor, itemNameColor

            -- Get appropriate colors for item
            qualityColor = loot:GetColor()

            -- Determine which colors to use for the bar
            if Options['Panels']['ColorMode']['HeaderBar'] == ColorModes.MatchItem then
                headerBarColor = qualityColor
            else -- ColorMode.Custom
                headerBarColor = Options['Panels']['ColorMode']['HeaderBarCustomValue'].tint
            end

            -- Determine which colors to use for the item name
            if Options['Panels']['ColorMode']['ItemName'] == ColorModes.MatchItem then
                itemNameColor = qualityColor
            else -- ColorMode.Custom
                itemNameColor = Options['Panels']['ColorMode']['ItemNameCustomValue'].tint
            end

            Debug.Log('qualityColor', qualityColor, 'headerBarColor', headerBarColor, 'itemNameColor', itemNameColor)


            headerBarColor = Colors.Create(headerBarColor)
            itemNameColor = Colors.Create(itemNameColor)

            if _table.compare(headerBarColor, itemNameColor) then
                Debug.Log('HeaderBar and ItemName colors are equal')
            end

            -- Set header color
            LOOT_PANEL_HEADER:GetChild('headerBar'):SetParam("tint", headerBarColor)
            LOOT_PANEL_HEADER:GetChild('itemName'):SetTextColor(itemNameColor)


    -- Build Iconbar
        LOOT_PANEL_ICONBAR:GetChild('itemIcon'):SetUrl(loot:GetWebIcon())

   
        -- Battleframe icon
        --[[
        if itemInfo.craftingTypeId then
            local itemArchetype, itemFrame = DWFrameIDX.ItemIdxString(tostring(itemInfo.craftingTypeId))
            if itemFrame == nil then
                LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):Show(false)
            else
                LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):SetUrl(GetFrameWebIconByName(itemFrame))
                LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):Show(true)

                LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):GetChild('fb'):SetTag(itemFrame)
                LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):GetChild('fb'):BindEvent("OnMouseEnter", function(args)
                    Tooltip.Show(args.widget:GetTag())
                end);
                LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):GetChild('fb'):BindEvent("OnMouseLeave", function(args)
                    Tooltip.Show(false)
                end);
            end
        else
            LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):Show(false)
        end
        --]]

    -- Timer text
        LOOT_PANEL_ICONBAR:GetChild('timer'):SetText('00:00')

    -- Build Stat list
        --[[
        for num, stat in ipairs(xItemFormatting.getStats(itemInfo)) do
            ENTRY = Component.CreateWidget('LootPanel_Stat', LOOT_PANEL_CONTENT:GetChild('ItemStats'))
            ENTRY:SetDims('top:0; left:0; width:100%; height:32;');
            ENTRY:GetChild('statName'):SetText(tostring(stat.displayName))
            ENTRY:GetChild('statValue'):SetText(tostring(stat.value))
        end
        LOOT_PANEL_CONTENT:GetChild('ItemStats'):Show(true)
        --]]


    -- We spent all this time building, best make sure it shows
    LOOT_PANEL_CONTENT:Show(true)

    -- Insert
    Private.panelList[loot:GetId()] = panel
end













function PanelManager.Update(lootId)
    if Private.panelList[lootId] then
        local panel = Private.panelList[lootId]

        -- Todo: Update

    end
end

function PanelManager.Remove(lootId)
    if Private.panelList[lootId] then
        LKObjects.Destroy(Private.panelList[lootId])
        Private.panelList[lootId] = nil
    end
end




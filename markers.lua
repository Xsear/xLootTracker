

WaypointManager = {
    
}

PanelManager = {
    
}

local Private = {
    waypointList = {},
    panelList = {}
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
    WaypointManager.Create(loot)
end

function WaypointManager.OnTrackerUpdate(args)
    if not Options['Waypoints']['Enabled'] then return end
    WaypointManager.OnLootStateChange(args)
end

function WaypointManager.OnTrackerRemove(args)
    if not Options['Waypoints']['Enabled'] then return end
    Debug.Log("WaypointManager on Tracker Remove!")
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
    if not loot:GetEntityId() or not Game.IsTargetAvailable(loot:GetEntityId()) then
        Debug.Warn("Attempt to create waypoint for loot with state available but no available entity")
        return
    end

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
    MARKER:ShowOnHud(Options['Waypoints']['ShowOnHud'])
    --MARKER:SetHudPriority(Options['Waypoints']['HudPriority'])
    MARKER:ShowOnWorldMap(Options['Waypoints']['ShowOnWorldMap'])
    MARKER:ShowOnRadar(Options['Waypoints']['ShowOnRadar']) 
    MARKER:SetRadarEdgeMode(Options['Waypoints']['RadarEdgeMode'])

    -- Insert
    Private.waypointList[#Private.waypointList + 1] = {MARKER = MARKER, markerType = MarkerType.Loot, lootId = loot:GetId()}
end


function WaypointManager.OnLootStateChange(args)
    if args.newState ~= LootState.Available then
        Debug.Log("Looking for waypoint to remove")
        for i, waypoint in ipairs(Private.waypointList) do
            if waypoint.markerType == MarkerType.Loot then
                if type(waypoint.lootId) ~= type(args.lootId) then
                    Debug.Warn("lootId Types do not match! D: Waypoint: "..tostring(type(waypoint.lootId))..", Args: "..tostring(type(args.lootId)))
                end
                if waypoint.lootId == args.lootId then
                    Debug.Table("Found waypoint that should be removed: ", waypoint)
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

function WaypointManager.GetYourShitTogether()
    Debug.Log("Sorry :(")
    Private.waypointList = {}
end

function GetWaypointTitle(loot)

    local title = {}


    local rarity = loot:GetRarity()

    
    if loot:GetCategory() == LootCategory.Equipment or Loot:GetCategory() == LootCategory.Modules then

        if Loot.GetRarityIndex(rarity) >= Loot.GetRarityIndex(LootRarity.Rare) then
            table.insert(title, "["..Loot.GetDisplayNameOfRarity(rarity).."]")
        end 

        if loot:GetItemLevel() > 0 then
            table.insert(title, "["..loot:GetItemLevel().."]")
        end

    end

   
    table.insert(title, loot:GetName())

    return table.concat(title, " ")
end











function PanelManager.Stat()
    Debug.Table("PanelManager Private.panelList", Private.panelList)
end

function PanelManager.OnTrackerNew(args)
    if not Options['Panels']['Enabled'] then return end

    PanelManager.Create(args.lootId)
end

function PanelManager.OnTrackerUpdate(args)
    if not Options['Panels']['Enabled'] then return end

    PanelManager.Update(args.lootId)
end

function PanelManager.OnTrackerRemove(args)
    if not Options['Panels']['Enabled'] then return end

    PanelManager.Remove(args.lootId)
end




function PanelManager.Create(loot)
    -- Get loot
    local loot = Tracker.GetLootById(args.lootId)

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
        local panel = Private.panelList[lootId]
        
        LKObjects.Destroy(panel)
    end
end




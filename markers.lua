--[[
    CreatePanel(targetInfo, itemInfo)
    Setsup and returns a panel object reference for loot from the info given
]]--
function CreatePanel(targetInfo, itemInfo)
    -- Create object
    local panel = LKObjects.Create(LOOTPANEL)

    panel.pos:SetParam('Translation', Vec3.New(targetInfo.lootPos.x, targetInfo.lootPos.y, targetInfo.lootPos.z+2))
    panel.pos:SetParam('Rotation', {axis={x=0,y=0,z=1},angle=0})


    local RenderTarget = panel.panel_rt
    local LOOT_PANEL_CONTENT = RenderTarget:GetChild('Panel'):GetChild('Content')
    local LOOT_PANEL_HEADER = LOOT_PANEL_CONTENT:GetChild('Header')
    local LOOT_PANEL_ICONBAR = LOOT_PANEL_CONTENT:GetChild('IconBar')


    -- Header
    LOOT_PANEL_HEADER:GetChild('itemName'):SetText(FixItemNameTag(targetInfo.name, targetInfo.quality))

    -- Header Colours
    local qualityColor, headerBarColor, itemNameColor

    -- Get appropriate colour for item
    if targetInfo.quality then
        qualityColor = LIB_ITEMS.GetResourceQualityColor(targetInfo.quality)
    else
        qualityColor = LIB_ITEMS.GetItemColor(itemInfo)
    end

    -- Determine which colour to use for the bar
    if Options['Panels']['ColorMode']['HeaderBar'] == ColorModes.MatchItem then
        headerBarColor = qualityColor
    else -- ColorMode.Custom
        headerBarColor = Options['Panels']['ColorMode']['HeaderBarCustomValue'].tint
    end

    -- Determine which colour to use for the item name
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
    
    -- Set the colours
    LOOT_PANEL_HEADER:GetChild('headerBar'):SetParam("tint", headerBarColor)
    LOOT_PANEL_HEADER:GetChild('itemName'):SetTextColor(itemNameColor)




    -- Iconbar
    LOOT_PANEL_ICONBAR:GetChild('itemIcon'):SetUrl(itemInfo.web_icon)

   
    -- Battleframe icon
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
    
    -- Timer text
    LOOT_PANEL_ICONBAR:GetChild('timer'):SetText('00:00')

    -- Stat list
    for num, stat in ipairs(xItemFormatting.getStats(itemInfo)) do
        ENTRY = Component.CreateWidget('LootPanel_Stat', LOOT_PANEL_CONTENT:GetChild('ItemStats'))
        ENTRY:SetDims('top:0; left:0; width:100%; height:32;');
        ENTRY:GetChild('statName'):SetText(tostring(stat.displayName))
        ENTRY:GetChild('statValue'):SetText(tostring(stat.value))
    end
    LOOT_PANEL_CONTENT:GetChild('ItemStats'):Show(true)


--[[

    BUTTON1 = Button.Create(RenderTarget:GetChild('content'):GetChild('ButtonRow'))
    BUTTON1:SetText('Need')
    BUTTON1:Autosize('left')
    BUTTON1:Bind(function() 
            --System.PlaySound(Options['Sounds']['OnAssignItem_ToMe'])
        end)

    BUTTON2 = Button.Create(RenderTarget:GetChild('content'):GetChild('ButtonRow'))
    BUTTON2:SetText('Greed')
    BUTTON2:Autosize('center')
    BUTTON2:Bind(function() 
            --System.PlaySound(Options['Sounds']['OnAssignItem_ToMe'])
        end)

    BUTTON3 = Button.Create(RenderTarget:GetChild('content'):GetChild('ButtonRow'))
    BUTTON3:SetText('Pass')
    BUTTON3:Autosize('right')
    BUTTON3:Bind(function() 
            --System.PlaySound(Options['Sounds']['OnAssignItem_ToMe'])
        end)

--]]

    -- We spent all this time building, best make sure it shows
    LOOT_PANEL_CONTENT:Show(true)

    return panel
end

--[[
    UpdatePanel(loot)
    Updates the state of a loot panel
]]--
function UpdatePanel(loot)

    if loot.panel == nil then return end

    local RenderTarget = loot.panel.panel_rt
    local LOOT_PANEL_CONTENT = RenderTarget:GetChild('Panel'):GetChild('Content')
    local LOOT_PANEL_HEADER = LOOT_PANEL_CONTENT:GetChild('Header')

    if not ItemPassesFilter(loot, Options['Panels']) then 
        RenderTarget:Show(false)
    end


    -- Overall mode
    if Options['Panels']['Mode'] == LootPanelModes.Small then
        -- Small mode display settings
        LOOT_PANEL_CONTENT:GetChild('contentBackground'):Show(false)
        LOOT_PANEL_CONTENT:GetChild('IconBar'):Show(false)
        LOOT_PANEL_CONTENT:GetChild('ItemStats'):Show(false)

    else -- LootPanelModes.Standard
        -- Large/Normal mode display settings
        LOOT_PANEL_CONTENT:GetChild('contentBackground'):Show(true)
        LOOT_PANEL_CONTENT:GetChild('IconBar'):Show(true)
        LOOT_PANEL_CONTENT:GetChild('ItemStats'):Show(true)

        -- Asigned To text
        if Options['Panels']['Display']['AssignedTo'] then
            Debug.Log('Item that Panel is displaying is assigned to '..tostring(loot.assignedTo))

            -- Debug.Log(RenderTarget:GetChild('content'):GetChild('Header'):GetChild('itemName'):GetTextDims()) -- To be used to detect when title wraps
            if loot.assignedTo == nil then
                LOOT_PANEL_HEADER:GetChild('itemAssignedTo'):SetText(Lokii.GetString('UI_AssignedTo_nil'))
                LOOT_PANEL_HEADER:GetChild('itemAssignedTo'):SetTextColor(Options['Panels']['Color']['AssignedTo']['Nil'].tint)

            elseif loot.assignedTo == AssignedTo.FreeForAll then
                LOOT_PANEL_HEADER:GetChild('itemAssignedTo'):SetText(Lokii.GetString('UI_AssignedTo_true'))
                LOOT_PANEL_HEADER:GetChild('itemAssignedTo'):SetTextColor(Options['Panels']['Color']['AssignedTo']['Free'].tint)
            else
                LOOT_PANEL_HEADER:GetChild('itemAssignedTo'):SetText(Lokii.GetString('UI_AssignedTo_Prefix')..loot.assignedTo)

                if namecompare(loot.assignedTo, Player.GetInfo()) then
                    LOOT_PANEL_HEADER:GetChild('itemAssignedTo'):SetTextColor(Options['Panels']['Color']['AssignedTo']['Player'].tint)
                else
                    LOOT_PANEL_HEADER:GetChild('itemAssignedTo'):SetTextColor(Options['Panels']['Color']['AssignedTo']['Other'].tint)
                end

            end

            if Options['Panels']['Display']['AssignedToHideNil'] and loot.assignedTo == nil then
                LOOT_PANEL_HEADER:GetChild('itemAssignedTo'):Show(false)
            else
                LOOT_PANEL_HEADER:GetChild('itemAssignedTo'):Show(true)
            end

        end
    end
end

--[[
    CreateWaypoint(loot)
    Setsup and returns a waypoint marker reference for loot
]]--
function CreateWaypoint(loot)
    Debug.Log('Creating a waypoint for '..loot.name)
    MARKER = MapMarker.Create('xslm_'..tostring(loot.entityId)..'_waypoint')

    -- Bind to loot entity
    MARKER:BindToEntity(loot.entityId)

    -- Text
    MARKER:SetTitle(FixItemNameTag(loot.name, loot.quality))
    MARKER:SetSubtitle(Lokii.GetString('UI_Waypoints_Subtitle'))

    -- Color ?
    MARKER:SetThemeColor(LIB_ITEMS.GetItemColor(loot.itemInfo))

    -- Icon
    local MULTIART = MARKER:GetIcon()
    MULTIART:SetUrl(loot.itemInfo.web_icon)


    -- Visibility
    MARKER:ShowOnHud(Options['Waypoints']['ShowOnHud'])
    --MARKER:SetHudPriority(Options['Waypoints']['HudPriority'])
    MARKER:ShowOnWorldMap(Options['Waypoints']['ShowOnWorldMap'])
    MARKER:ShowOnRadar(Options['Waypoints']['ShowOnRadar']) 
    MARKER:SetRadarEdgeMode(Options['Waypoints']['RadarEdgeMode'])

    return MARKER
end

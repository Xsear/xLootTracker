local ciLootDespawn = 20 -- Seconds into the future that the callback that checks if an item entity is still around is set to. Used to remove despawned or otherwise glitched out items


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
    local loot = {entityId=entityId, itemTypeId=targetInfo.itemTypeId, craftingTypeId=itemInfo.craftingTypeId, itemInfo=itemInfo, assignedTo=nil, quality=targetInfo.quality, name=targetInfo.name, pos={x=targetInfo.lootPos.x, y=targetInfo.lootPos.y, z=targetInfo.lootPos.z}, panel=nil, waypoint=nil, timer=nil}

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
    loot.timer = GTimer.Create(function(time) if loot.panel ~= nil then loot.panel.panel_rt:GetChild('content'):GetChild('IconBar'):GetChild('timer'):SetText(time) end end, '%02iq60p:%02iq1p', 1);
        
    -- Setup despawn timer
    loot.timer:SetAlarm('despawn', ciLootDespawn, LootDespawn, {item=loot})
    loot.timer:StartTimer()

    -- Save data
    table.insert(aIdentifiedLoot, loot)
    Debug.Log('Identified: '..tostring(loot.entityId)..', '..loot.name)
    
    -- Fire event
    OnIdentify({item=loot})
end

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

            elseif loot.assignedTo == true or loot.assignedTo == false then
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

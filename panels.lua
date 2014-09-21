--[[
    Panels
    Handles the lootpanels.
--]]
PanelManager = {
    
}

local Private = {
    panelList = {},
    webAssetHost,
    webAssetURLFormat = "%s/assets/items/%s/%s.png",
}


--[[
    PanelManager.OnTrackerNew(args)
    Called when Tracker has added a new item.
    Triggers the creation of a panel for that item.
--]]
function PanelManager.OnTrackerNew(args)
    if not Options['Panels']['Enabled'] then return end

    local loot = Tracker.GetLootById(args.lootId)

    if Options['Blacklist']['Waypoints'][tostring(loot:GetTypeId())] then
        return
    end

    if LootFiltering(loot, Options['Panels']) then
        PanelManager.Create(loot)
    end
end

--[[
    PanelManager.OnTrackerLooted(args)
    Called when Tracker thinks an item was looted.
    Triggers the removal of the Panel for that item.
--]]
function PanelManager.OnTrackerLooted(args)
    if not Options['Panels']['Enabled'] then return end
    --Debug.Log('PanelManager.OnTrackerLooted calling Remove')
    PanelManager.Remove(args.lootId)
end

--[[
    PanelManager.OnTrackerRemove(args)
    Called when Tracker has removed an item.
    Triggers the removal of the Panel for that item.
--]]
function PanelManager.OnTrackerRemove(args)
    if not Options['Panels']['Enabled'] then return end
    --Debug.Log('PanelManager.OnTrackerRemove calling Remove')
    PanelManager.Remove(args.lootId)
end



--[[
    PanelManager.Create(loot)
    Creates a Panel for loot.
--]]
function PanelManager.Create(loot)
    -- Check Args
    if not loot or type(loot) ~= 'table' then
        Debug.Log('PanelManager.Create called with invalid argument: ' .. tostring(loot))
        return
    end

    -- Check Available
    if loot:GetState() ~= LootState.Available then
        Debug.Warn('PanelManager.Create called for unavailable ' .. loot:ToString())
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

    -- Setup panel timer
    if Options['Panels']['TimerMode'] == PanelsTimerMode.Countdown then
         panel.timer = GTimer.Create(function(time) if panel ~= nil then LOOT_PANEL_ICONBAR:GetChild('timer'):SetText(time) end end, '%02iq60p:%02iq1p', -1)
         panel.timer:SetTime(tonumber(Options['Panels']['TimerCountdownTime']))
    else
        panel.timer = GTimer.Create(function(time) if panel ~= nil then LOOT_PANEL_ICONBAR:GetChild('timer'):SetText(time) end end, '%02iq60p:%02iq1p', 1)
    end
    panel.timer:StartTimer()



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
            LOOT_PANEL_HEADER:GetChild('headerBar'):SetParam('tint', headerBarColor)
            LOOT_PANEL_HEADER:GetChild('itemName'):SetTextColor(itemNameColor)


    -- Build Iconbar

        -- Item Icon
        LOOT_PANEL_ICONBAR:GetChild('itemIcon'):SetUrl(loot:GetWebIcon())

        -- Category / Battleframe Icon
        local MUTLIART = MultiArt.Create(LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):GetChild('icon'))

        -- Check for battleframe
        local isUsingBattleframeIcon = false
        if loot:GetCategory() == LootCategory.Equipment then
            
            local frameCerts = loot:GetCerts()

            -- Can't get it without a cert, but if there are more than one, idk what's up, so ignore it.
            if frameCerts and #frameCerts == 1 then

                -- Get the certInfo
                local certInfo = Game.GetCertificationInfo(frameCerts[1])

                -- Note: Maybe check if cert_type is 0, not sure if that's battleframes only or just not used

                if not _table.empty(certInfo) then

                    local webIcon = certInfo.web_icon or ''
                    local webUrl = GetIconUrl(webIcon, 96)

                    local name = certInfo.name or 'I broke :('
                    local description = certInfo.description or ''

                    if webUrl and name and description then

                        MUTLIART:SetUrl(webUrl)
                        LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):Show(true)

                        LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):GetChild('fb'):SetTag(name..'\n'..description)
                        LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):GetChild('fb'):BindEvent('OnMouseEnter', function(args)
                            Tooltip.Show(args.widget:GetTag())
                        end)
                        LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):GetChild('fb'):BindEvent('OnMouseLeave', function(args)
                            Tooltip.Show(false)
                        end)
                        isUsingBattleframeIcon = true
                    end

                end
            end
        end
        
        if not isUsingBattleframeIcon then
            MUTLIART:SetTexture('icons')
            MUTLIART:SetRegion(LootCategoryIconsRegion[loot:GetCategory()])
            LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):GetChild('fb'):SetTag(ucfirst(loot:GetCategory()))
            LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):GetChild('fb'):BindEvent('OnMouseEnter', function(args)
                Tooltip.Show(args.widget:GetTag())
            end)
            LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):GetChild('fb'):BindEvent('OnMouseLeave', function(args)
                Tooltip.Show(false)
            end)
            LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):Show(true)
        end
        

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

--[[
    PanelManager.Remove(lootId)
    Removes the Panel for the specified lootId.
--]]
function PanelManager.Remove(lootId)
    if Private.panelList[lootId] then
        LKObjects.Destroy(Private.panelList[lootId])
        Private.panelList[lootId] = nil
    end
end

--[[
    PanelManager.Stat()
    Debug output for the Stat slash command.
--]]
function PanelManager.Stat()
    Debug.Table('PanelManager Private.panelList', Private.panelList)
end







function GetIconUrl(stem, size)
    size = size or 64
    return unicode.format(Private.webAssetURLFormat, GetWebAssetHost(), size, stem)
end

function GetWebAssetHost()
    if not Private.webAssetHost then
        Private.webAssetHost = System.GetOperatorSetting("web_asset_host")
    end
    return Private.webAssetHost
end

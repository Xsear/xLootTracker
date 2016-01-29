--[[
    HUDTracker
    The on-screen hud-tracker
--]]
HUDTracker = {}

-- Lots of stuff that should be in Private that isn't yet
local Private = {
    lastUpdate = 0,
    minUpdateCB = nil,
    testMode = false,
    testEntries = {},
    entries = {}
}   

-- Frames
local FRAME = Component.GetFrame('Tracker')
local SLIDER = FRAME:GetChild('Slider')
local LIST = FRAME:GetChild('List')
local SCROLLER = nil
local TOOLTIP_ITEM = nil


-- y u no options D:
local DimensionOptions = {
    ScrollerSpacing = 8,
    ScrollerSliderMarginVisible = 5,
    ScrollerSliderMarginHidden = 5,
    EntryDimsWidth = '100%',
    EntryDimsHeight = '32',

    plateLeftOverlap = 4, -- Plate is offset by the size of the icon subtracted by this value, in order to have the icon overlap the edge of the plate
    plateHeightBorderReduction = 2, -- Plate height is reduced by 2 times this value, in order to free up space for the top and bottom borders.

}




--[[
    HUDTracker.GetFrame()
    Returns a reference to the Tracker Frame.
--]]
function HUDTracker.GetFrame()
    return FRAME
end

--[[
    HUDTracker.Setup()
    Performs OnOptionsLoaded tasks.
--]]
function HUDTracker.Setup()
    -- Scroller
    SCROLLER = RowScroller.Create(LIST)
    SCROLLER:SetSlider(SLIDER)
    SCROLLER:SetSliderMargin(DimensionOptions.ScrollerSliderMarginVisible, DimensionOptions.ScrollerSliderMarginHidden)
    SCROLLER:SetSpacing(DimensionOptions.ScrollerSpacing)
    SCROLLER:ShowSlider(Options['HUDTracker']['DisplaySlider'] and 'auto' or false)
    SCROLLER:SetScrollStep(Options['HUDTracker']['EntrySize'])

    -- Tooltip
    TOOLTIP_ITEM = LIB_ITEMS.CreateToolTip(FRAME)
    TOOLTIP_ITEM.GROUP:Show(false)

    -- Apply width/height frame options
    InterfaceOptions.ChangeFrameWidth(FRAME, Options['HUDTracker']['Frame']['Width'])
    InterfaceOptions.ChangeFrameHeight(FRAME, Options['HUDTracker']['Frame']['Height'])
    SCROLLER:UpdateSize()
end


--[[
    HUDTracker.Enable()
    Called when HUDTracker is Enabled in the Options, populates the HUDTracker.
--]]
function HUDTracker.Enable()
    -- Build
    HUDTracker.Rebuild()
end

--[[
    HUDTracker.Disable()
    Called when HUDTracker is Disabled in the Options, cleans up.
--]]
function HUDTracker.Disable()
    -- Hide tooltip if is currently being displayed
    if State.tooltipActive then
        Tooltip.Show(false)
        TOOLTIP_ITEM.GROUP:Show(false)
    end

    -- Clear
    SCROLLER:Reset()
    Private.entries = {}
    HUDTracker.UpdateVisibility()
end

--[[
    HUDTracker.OnOptionChange(id, value)
    Called by Options when a HUDTracker Option is changed.
    Used to rebuild the HUDTracker so that it is always displayed as per the configuration, as well as to handle enable-disable. Calls InterfaceOptions functions to handle changing of the size of the Frame itself (might want to move some of that to Options later)
--]]
function HUDTracker.OnOptionChange(id, value)
    if id == 'HUDTracker_Enabled' then
        -- Enabled
        if value then
            HUDTracker.Enable()
        -- Disabled
        else
            HUDTracker.Disable()
        end
    
    elseif id == 'HUDTracker_Frame_Width'
    then
        Debug.Log('Updating HUDTracker Frame Width')
        InterfaceOptions.ChangeFrameWidth(FRAME, value)
        SCROLLER:UpdateSize()

    elseif id == 'HUDTracker_Frame_Height'
    then
        InterfaceOptions.ChangeFrameHeight(FRAME, value)
        SCROLLER:UpdateSize()

    elseif id == 'HUDTracker_DisplaySlider'
    then
        SCROLLER:ShowSlider(Options['HUDTracker']['DisplaySlider'] and 'auto' or false)

    -- For general options we rebuild the tracker
    else
        if id == 'HUDTracker_EntrySize' then
            SCROLLER:SetScrollStep(Options['HUDTracker']['EntrySize'])
        end

        -- Rebuild tracker
        HUDTracker.Rebuild()
    end
end

--[[
    HUDTracker.OnTrackerNew(args)
    Called when Tracker has added a new item.
    Updates the HUDTracker to reflect the new state, creating an entry if applicable.
--]]
function HUDTracker.OnTrackerNew(args)
    
    local loot = Tracker.GetLootById(args.lootId)

    if Options['Blacklist']['HUDTracker'][tostring(loot:GetTypeId())] then
        return
    end

    if Filtering.Filter(loot, Options['HUDTracker']) then

        -- Hide tooltip if is currently being displayed, whilst we are modifying stuff.
        if State.tooltipActive then
            Tooltip.Show(false)
            TOOLTIP_ITEM.GROUP:Show(false)
        end

        -- Check for existing row
        local ENTRY = Private.entries[tostring(loot:GetTypeId())]

        -- If there is an existing entry
        if ENTRY then

            --Debug.Table('OnTrackerNew found existing entry: ' , ENTRY)

            -- Retrieve existing stackInfo
            local stackInfo = ENTRY.stackInfo
            
            -- Add this new loot to the stack
            stackInfo.quantity = stackInfo.quantity + loot:GetQuantity()
            stackInfo.count = stackInfo.count + 1
            stackInfo.ids[loot:GetId()] = {quantity=loot:GetQuantity()}
            
            -- Update entry
            Private.UpdateEntry(ENTRY)

        -- There is not an existing row, create a completely new one
        else
            
            -- Create entry
            ENTRY = Private.CreateEntry(loot)

            -- Get the index of each entry in the rowscroller
            local indexList = {}
            for typeId, ENTRY_OTHER in pairs(Private.entries) do
                local index = ENTRY_OTHER.ROW:GetIdx()
                indexList[index] = ENTRY_OTHER
            end

            -- Determine which index our new entry should have
            local ourEntryIndex = nil
            for index, ENTRY_OTHER in pairs(indexList) do
                if HUDTrackerSort(ENTRY, ENTRY_OTHER) then
                    ourEntryIndex = index
                    break
                end
            end

            -- Insert entry as row
            local ROW = SCROLLER:AddRow(ENTRY.GROUP, ourEntryIndex)

            -- Save a row reference
            ENTRY.ROW = ROW
            
            -- Store entry
            Private.entries[tostring(loot:GetTypeId())] = ENTRY

            -- Fade in effect
            if Options['HUDTracker']['FadeEntry']['Enabled'] then
                ENTRY.GROUP:ParamTo("alpha", 1.0, Options['HUDTracker']['FadeEntry']['FadeIn']['Duration'], Options['HUDTracker']['FadeEntry']['FadeIn']['Animation'])
            end
        end

    end

    HUDTracker.UpdateVisibility()

end

--[[
    HUDTracker.OnTrackerUpdate(args)
    Called when Tracker thinks an item was looted.
    Updates the HUDTracker to reflect the new state, removing an entry if applicable.
--]]
function HUDTracker.OnTrackerLooted(args)

    local loot = Tracker.GetLootById(args.lootId)

    if not loot then return end

    -- Check for existing row
    local ENTRY = Private.entries[tostring(loot:GetTypeId())]

    -- If there is an existing entry
    if ENTRY then

        -- Retrieve existing stackInfo
        local stackInfo = ENTRY.stackInfo
        
        -- Check that this loot is actually in this stack
        if stackInfo.ids[loot:GetId()] then

            -- Hide tooltip if is currently being displayed, whilst we are modifying stuff.
            if State.tooltipActive then
                Tooltip.Show(false)
                TOOLTIP_ITEM.GROUP:Show(false)
            end

            -- If this is a stacked entry, we update it
            if stackInfo.count > 1 then

                -- Remove this loot from the stack
                stackInfo.quantity = stackInfo.quantity - stackInfo.ids[loot:GetId()].quantity
                stackInfo.count = stackInfo.count - 1
                stackInfo.ids[loot:GetId()] = nil

                -- Update entry
                Private.UpdateEntry(ENTRY)

            -- Otherwise, just remove
            else

                -- Fade out effect
                if Options['HUDTracker']['FadeEntry']['Enabled'] then
                    -- Start fade out effect
                    ENTRY.GROUP:ParamTo("alpha", 0.0, Options['HUDTracker']['FadeEntry']['FadeOut']['Duration'], Options['HUDTracker']['FadeEntry']['FadeOut']['Animation'])
                end

                -- Removal
                Private.entries[tostring(loot:GetTypeId())] = nil

                if Options['HUDTracker']['FadeEntry']['Enabled'] then
                    callback(function() 
                        Component.RemoveWidget(ENTRY.GROUP)
                        ENTRY.ROW:Remove()
                        ENTRY = nil
                    end, nil, Options['HUDTracker']['FadeEntry']['FadeOut']['Duration'])
                else -- I really shouldn't be repeating myself, but...
                    Component.RemoveWidget(ENTRY.GROUP)
                    ENTRY.ROW:Remove()
                    ENTRY = nil
                end
                
                
            end
        end
    end
            
    HUDTracker.UpdateVisibility()
end

--[[
    HUDTracker.OnTrackerRemove(args)
    Called when Tracker has removed an item.
    Updates the HUDTracker to reflect the new state.
--]]
function HUDTracker.OnTrackerRemove(args)
    --args.event = 'HUDTracker.OnTrackerRemove'
    --Debug.Event(args)

    --Debug.Table('HUDTracker Private.entries', Private.entries)

    for typeId, ENTRY in pairs(Private.entries) do

        local stackInfo = ENTRY.stackInfo

        --Debug.Table('Entry ' .. tostring(typeId) .. ' stackInfo', stackInfo)

        --Debug.Log('stackInfo.ids[args.lootId] : ' .. tostring(stackInfo.ids[args.lootId]))

        if stackInfo.ids[args.lootId] then

            -- Hide tooltip if is currently being displayed, whilst we are modifying stuff.
            if State.tooltipActive then
                Tooltip.Show(false)
                TOOLTIP_ITEM.GROUP:Show(false)
            end

            -- If this is a stacked entry, we update it
            if stackInfo.count > 1 then

                -- Remove this loot from the stack
                stackInfo.quantity = stackInfo.quantity - stackInfo.ids[args.lootId].quantity
                stackInfo.count = stackInfo.count - 1
                stackInfo.ids[args.lootId] = nil

                -- Update entry
                Private.UpdateEntry(ENTRY)

            -- Otherwise, just remove
            else

                -- Fade out effect
                if Options['HUDTracker']['FadeEntry']['Enabled'] then
                    -- Start fade out effect
                    ENTRY.GROUP:ParamTo("alpha", 0.0, Options['HUDTracker']['FadeEntry']['FadeOut']['Duration'], Options['HUDTracker']['FadeEntry']['FadeOut']['Animation'])
                end

                -- Removal
                Private.entries[typeId] = nil

                if Options['HUDTracker']['FadeEntry']['Enabled'] then
                    callback(function() 
                        Component.RemoveWidget(ENTRY.GROUP)
                        ENTRY.ROW:Remove()
                        ENTRY = nil
                    end, nil, Options['HUDTracker']['FadeEntry']['FadeOut']['Duration'])
                else -- I really shouldn't be repeating myself, but...
                    Component.RemoveWidget(ENTRY.GROUP)
                    ENTRY.ROW:Remove()
                    ENTRY = nil
                end

            end
            
            -- Exit
            break
        end
    end

    HUDTracker.UpdateVisibility()
end

-- For visual refresh / settings changes only
-- Breaks when size settings are changed (doesnt update row size?)
-- No longer used / to be deprecated?
function HUDTracker.Update(args)
    Debug.Log('HUDTracker.Update called, this shouldnt be often unless settings are being changed')
    for typeId, ENTRY in pairs(Private.entries) do
        Private.UpdateEntry(ENTRY)
        Private.SetEntrySize(ENTRY)
        Private.SetEntryFont(ENTRY)
        Private.SetEntryVisibility(ENTRY)
    end 
end

--[[
    HUDTracker.Rebuild(args)
    Rebuilds the HUDTracker entries, removing them and recreating entries for available loot.
    Primarily used when Options are changed.
--]]
function HUDTracker.Rebuild(args)
    args = args or {}
    args.event = 'HUDTracker.Rebuild'
    Debug.Event(args)

    -- Only update and show tracker if enabled
    if Options['HUDTracker']['Enabled'] then
        --Debug.Log('HUDTracker Update called and HUDTracker is enabled')

        -- Stop scroller updates whilst we update
        SCROLLER:LockUpdates()  

        -- Clear
        for typeId, ENTRY in pairs(Private.entries) do
            ENTRY = nil
            Private.entries[typeId] = nil
        end
        SCROLLER:Reset()

        -- Get loot
        local trackedLoot = Tracker.GetAvailableLoot()

        -- Populate
        if not _table.empty(trackedLoot) then
            for i, loot in ipairs(trackedLoot) do
                HUDTracker.OnTrackerNew({lootId = loot:GetId()})
            end
        end

        SCROLLER:UnlockUpdates()
        HUDTracker.UpdateVisibility()

        -- Fake mode extra
        if HUDTracker.IsInFakeMode() then
            HUDTracker.EnterFakeMode()
        end
    end
end

--[[
    HUDTracker.UpdateVisibility()
    Reads current state, determines and updates the visibility of the HUDTracker.
--]]
function HUDTracker.UpdateVisibility()
    if Options['HUDTracker']['Enabled'] then
     -- Should we display the tracker?
        --Debug.Log('Should we display the Tracker?')
        --Debug.Log('Options Tracker Visibility == '..Options['HUDTracker']['Visibility'])
        --Debug.Log('State.hud == '..tostring(State.hud))
        --Debug.Log('State.cursor == '..tostring(State.cursor))
        --Debug.Log('State.sin == '..tostring(State.sin))
        if SCROLLER ~= nil and SCROLLER:GetRowCount() > 0 and (
               (Options['HUDTracker']['Visibility'] == HUDTrackerVisibilityOptions.Always)
            or (Options['HUDTracker']['Visibility'] == HUDTrackerVisibilityOptions.HUD and State.hud)
            or (Options['HUDTracker']['Visibility'] == HUDTrackerVisibilityOptions.MouseMode and State.cursor and State.hud)
            or (Options['HUDTracker']['Visibility'] == HUDTrackerVisibilityOptions.SinMode and State.sin and State.hud)
            )
        then
            --Debug.Log('Yes, display the tracker')
            -- Yes, display tracker
            --FRAME:Show(true)

            if Options['HUDTracker']['FadeFrame']['Enabled'] then
                -- Fade in effect
                FRAME:ParamTo("alpha", 1.0, Options['HUDTracker']['FadeFrame']['FadeIn']['Duration'], Options['HUDTracker']['FadeFrame']['FadeIn']['Animation'])
            else
                FRAME:Show(true) 
            end

        else
            --Debug.Log('No, hide the tracker')
            -- No, hide the tracker
             if Options['HUDTracker']['FadeFrame']['Enabled'] then
                -- Fade out effect
                FRAME:ParamTo("alpha", 0.0, Options['HUDTracker']['FadeFrame']['FadeOut']['Duration'], Options['HUDTracker']['FadeFrame']['FadeOut']['Animation'])
            else
                FRAME:Show(true) 
            end

            -- Ensure no tooltip is displayed
            TOOLTIP_ITEM.GROUP:Show(false)
            Tooltip.Show(false)
            State.tooltipActive = false
        end

    -- Tracker not enabled, so do nothing but make sure it's hidden.
    else
        --Debug.Log('Tracker not enabled, hide')
        -- Hide tracker
        FRAME:Show(false)

        -- Ensure no tooltip is displayed
        TOOLTIP_ITEM.GROUP:Show(false)
        Tooltip.Show(false)
        State.tooltipActive = false
    end

end

--[[
    HUDTracker.UpdateTooltip(lootId)
    Returns updated item tooltip widget matching the provided lootId.
--]]
function HUDTracker.UpdateTooltip(lootId)
    -- Get info
    --Debug.Log('UpdateTrackerTooltip called for lootId '..tostring(lootId))
    local loot = Tracker.GetLootById(lootId)
    if HUDTracker.IsInFakeMode() then
        if Private.testEntries[lootId] then
            loot = Private.testEntries[lootId]
        end
    end
    if loot == nil or loot == false then Debug.Error('UpdateTrackerTooltip unable to get identified item') end

    -- Setup Tooltip
    TOOLTIP_ITEM:DisplayInfo(loot.itemInfo)
    TOOLTIP_ITEM.GROUP:SetDims('top:0; left:0; width:200; height:200')

    -- Add compare info
    local compare_info = LIB_ITEMS.GetMatchingEquippedItemInfo(loot.itemInfo)
    if compare_info then
        TOOLTIP_ITEM:CompareAgainst(compare_info)
    end

    -- Return Tooltip
    local tip_args = TOOLTIP_ITEM:GetBounds()
    tip_args.frame_color = loot:GetColor()

    return TOOLTIP_ITEM.GROUP, tip_args
end



-- Blueprint for the HUDTracker Entries
local bp_ENTRY = [[
    <Group name='EntryGroup' dimensions='width:100%; height:32;'>

        <!-- Plate -->
        <FocusBox name='plate' dimensions='width:100%-30; height:28; left:30; top:2;'>
            <StillArt name='bg' dimensions='width:100%-2.2; height:99%-2;' style='texture:colors; region:white; tint:#000000; alpha:0.7;'/>
            <Border name='outer' dimensions='dock:fill' class='Tracker_PlateBorder'/>
            <Border name='shade' dimensions='dock:fill' class='ButtonFade'/>
        </FocusBox>

        <!-- Box -->
        <Group name='box' dimensions='width:32; height:32; left:0; top:0;'>
            <StillArt name='bg' dimensions='width:96%; height:96%;' style='texture:colors; region:white; tint:#000000; alpha:1;'/>
            <StillArt name='backplate' dimensions='width:99%; height:99%;' style='texture:ItemPlate; region:Square;'/>
            <Border name='outer' dimensions='dock:fill;' class='ButtonBorder'/>
            <Border name='shade' dimensions='width:0;height:0;' class='ButtonFade'/>
            <Group name='icon' dimensions='dock:fill;' style='fixed-bounds:true; valign:center;'/>
        </Group>

        <!-- Text -->
        <Group name='text' dimensions='width:100%-32; height:28; left:32; top:2;'>
            <!-- Stack -->
            <Text name='stack' dimensions='width:10%; height:100%-2; top:0; left:10%;' class='Tracker_Text'/>
        
            <!-- Title -->
            <Text name='title' dimensions='width:80%; height:100%-2; top:0; left:20%;' class='Tracker_Text'/>
        </Group>    

        
    </Group>
]]

function Private.CreateEntry(loot, stackInfo)
    -- Handle arguments
    stackInfo = stackInfo or {quantity = loot:GetQuantity(), count = 1, ids = {[loot:GetId()] = {quantity = loot:GetQuantity()}}, sortProfile = {itemLevel = loot:GetItemLevel(), requiredLevel = loot:GetRequiredLevel(), rarityValue = loot:GetRarityValue(), name=loot:GetName()}}

    --Debug.Table('Private.CreatEntry stackInfo', stackInfo)

    -- Create
    local GROUP = Component.CreateWidget(bp_ENTRY, LIST)

    -- Setup entry
    local ENTRY = {
        PARENT = LIST,
        GROUP = GROUP,
        PLATE = GROUP:GetChild('plate'),
        BOX = GROUP:GetChild('box'),
        TEXT = GROUP:GetChild('text'),
        stackInfo = stackInfo,
    }
    ENTRY.STACK = ENTRY.TEXT:GetChild('stack')
    ENTRY.TITLE = ENTRY.TEXT:GetChild('title')

    -- Setup plate tooltip tag
    ENTRY.PLATE:SetTag(loot:GetId())

    -- Setup plate tooltip events
    if Options['HUDTracker']['Tooltip']['Enabled'] then
        ENTRY.PLATE:BindEvent('OnMouseEnter', function(args)
            TOOLTIP_ITEM.GROUP:Show(true)
            Tooltip.Show(HUDTracker.UpdateTooltip(args.widget:GetTag()))
            State.tooltipActive = true
        end)
        ENTRY.PLATE:BindEvent('OnMouseLeave', function(args)
            TOOLTIP_ITEM.GROUP:Show(false)
            Tooltip.Show(false)
            State.tooltipActive = false
        end)
    end

    -- Setup plate right click menu
    if Options['HUDTracker']['ContextMenu']['Enabled'] then
        local ShowContextMenu = function(args)
            -- Get loot
            local lootId = args.widget:GetTag()
            local loot = Tracker.GetLootById(lootId)
            if not loot then
                Debug.Warn('HUDTracker Context Menu could not get loot.')
                return
            end

            local MENU = ContextMenu.Create()
            MENU:BindOnRequest(function(MENU, id)
                if id == 'root' then

                    -- Waypoints
                    MENU:AddButton({id='self_waypoint', label_key='SET_WAYPOINT'})
                    
                    if State.isSquadLeader then
                        MENU:AddButton({id='squad_waypoint', label_key='SET_SQUAD_WAYPOINT'})
                    end

                    -- Append link to Chat
                    MENU:AddButton({id='add_item_link', label_key='ADD_ITEM_LINK'})

                    -- Debug
                    if Options['Debug']['Enabled'] then
                        MENU:AddButton({id='debug_remove', label='Debug - Remove'})
                    end

                end
            end)
            MENU:BindOnSelect(function(args)
                if args.menu == 'root' then

                    -- Waypoints
                    local lootPos = loot:GetPos()
                    if args.id == 'self_waypoint' then
                        Component.GenerateEvent('MY_PERSONAL_WAYPOINT_SET', {x=lootPos.x, y=lootPos.y, z=lootPos.z+1})
                    elseif args.id == 'squad_waypoint' then
                        Squad.SetWayPoint(lootPos.x, lootPos.y, lootPos.z+1)


                    -- Append link to Chat
                    elseif args.id == 'add_item_link' then
                        loot:AppendToChat()

                    -- Debug - Remove
                    elseif args.id == 'debug_remove' then
                        Tracker.Remove(lootId)
                    end
                end
            end)
            MENU:Show()
        end

        ENTRY.PLATE:BindEvent('OnMouseDown', ShowContextMenu)
        ENTRY.PLATE:BindEvent('OnRightMouse', ShowContextMenu)
    end

    -- Setup plate colors
    local lootColor = loot:GetColor()

    ENTRY.PLATE:GetChild('outer'):SetParam('tint', lootColor)
    ENTRY.PLATE:GetChild('shade'):SetParam('tint', lootColor)

    -- Setup box colors
    ENTRY.BOX:GetChild('outer'):SetParam('tint', lootColor)
    ENTRY.BOX:GetChild('shade'):SetParam('tint', lootColor)

    -- Setup box
    ENTRY.BOX:GetChild('backplate'):SetParam('tint', lootColor)

    -- Setup icon
    local ICON_PARENT = ENTRY.BOX:GetChild('icon')
    ENTRY.ICON = loot:GetMultiArt(ICON_PARENT, Options['HUDTracker']['ForceWebIcons'])
    
    -- Setup stack
    if stackInfo then

        -- We want to see the count if it is higher than 1
        -- OR if the quantity is higher than 1 (we want to see that it is 3 crystite on the ground).
        -- Since quantity can not be lower then count (quantity is either 1 or higher, there are no half items), we only check quantity here
        local stackText = ''
        if stackInfo.quantity > 1 then
            stackText = tostring(stackInfo.count)
        end

        -- Add in quantity if it is of interest
        if stackInfo.quantity > stackInfo.count then
            stackText = stackText .. ' (' .. tostring(stackInfo.quantity) .. ')'
        end

        ENTRY.STACK:SetText(stackText)
    end

    -- Setup title
    ENTRY.TITLE:SetText(GetHUDTrackerTitle(loot))

    Private.SetEntrySize(ENTRY)
    Private.SetEntryFont(ENTRY)
    Private.SetEntryVisibility(ENTRY)

    return ENTRY
end


function Private.UpdateEntry(ENTRY)

    local stackInfo = ENTRY.stackInfo

    -- Ensure tag is up to date
    if not stackInfo.ids[ENTRY.PLATE:GetTag()] then
        local key, val = next(stackInfo.ids)
        ENTRY.PLATE:SetTag(key)
    end

    -- Update stack
    if stackInfo then

        -- We want to see the count if it is higher than 1
        -- OR if the quantity is higher than 1 (we want to see that it is 3 crystite on the ground).
        -- Since quantity can not be lower then count (quantity is either 1 or higher, there are no half items), we only check quantity here
        local stackText = ''
        if stackInfo.quantity > 1 then
            stackText = tostring(stackInfo.count)
        end

        -- Add in quantity if it is of interest
        if stackInfo.quantity > stackInfo.count then
            stackText = stackText .. ' (' .. tostring(stackInfo.quantity) .. ')'
        end

        ENTRY.STACK:SetText(stackText)
    end
end


function Private.SetEntrySize(ENTRY)
    -- Get height from options
    local sizeAsNumber = tonumber(Options['HUDTracker']['EntrySize'])
    local sizeAsText = tostring(sizeAsNumber)

    -- Entry
    ENTRY.GROUP:SetDims('width:100%; height:'..sizeAsText..';')

    -- Plate
    local plateLeftOffset = tostring(0) -- tostring(sizeAsNumber - DimensionOptions.plateLeftOverlap) -- (width of box - px for overlap)
    local plateHeightReduced = tostring(sizeAsText - (2*DimensionOptions.plateHeightBorderReduction)); -- 2 top and 2 bot to free up space for the bottom borders of the plate
    ENTRY.PLATE:SetDims('width:100%-'..plateLeftOffset..'; height:'..plateHeightReduced..';top:'..tostring(DimensionOptions.plateHeightBorderReduction)..';left:'..plateLeftOffset)

    -- Box (affecting Icon)
    local boxDimms = 'width:'..sizeAsText..'; height:'..sizeAsText..';' .. 'left:0; top:0;'
    ENTRY.BOX:SetDims(boxDimms)

    -- Text
    local textDimms = 'width:100%-'..sizeAsText..'; height:'..plateHeightReduced..';top:'..tostring(DimensionOptions.plateHeightBorderReduction)..';left:'..sizeAsText
    ENTRY.TEXT:SetDims(textDimms)
end



function Private.SetEntryFont(ENTRY)
    local fontType = tostring(Options['HUDTracker']['EntryFontType'])
    local fontSize = tostring(Options['HUDTracker']['EntryFontSize'])

    local suffix = ''
    if fontType == OptionsFontTypes.Wide then
        suffix = 'B'
    end


    local font = fontType .. '_' .. fontSize..suffix 

    ENTRY.TITLE:SetFont(font)
end

function Private.SetEntryVisibility(ENTRY)
    -- Visibility
    ENTRY.STACK:Show(true)
    ENTRY.TITLE:Show(true)


    local plateMode = Options['HUDTracker']['PlateMode']
    
    ENTRY.PLATE:GetChild('bg'):Show( (plateMode ~= HUDTrackerPlateModeOptions.None ) )
    ENTRY.PLATE:GetChild('outer'):Show( (plateMode == HUDTrackerPlateModeOptions.Decorated) )
    ENTRY.PLATE:GetChild('shade'):Show( (plateMode == HUDTrackerPlateModeOptions.Decorated) )


    local boxMode = Options['HUDTracker']['IconMode']

    ENTRY.BOX:GetChild('bg'):Show( (   boxMode == HUDTrackerIconModeOptions.Decorated
                                    or boxMode == HUDTrackerIconModeOptions.Simple) )
    ENTRY.BOX:GetChild('backplate'):Show( (   boxMode == HUDTrackerIconModeOptions.Decorated
                                           or boxMode == HUDTrackerIconModeOptions.Simple) )
    ENTRY.BOX:GetChild('outer'):Show( (boxMode == HUDTrackerPlateModeOptions.Decorated) ) -- Fixme: not sure if this should really be platemodeoptions
    ENTRY.BOX:GetChild('shade'):Show( (boxMode == HUDTrackerPlateModeOptions.Decorated) ) -- ^ this too.
    ENTRY.BOX:GetChild('icon'):Show( boxMode ~= HUDTrackerIconModeOptions.None)
end



--ENTRY.ICON:Destroy()







-- Fix text size
function AutosizeText(TEXT)
    TEXT:SetDims('top:_; height:'..(TEXT:GetTextDims().height+20)) -- Fixme: Magic number
end


-- Gets filtered display name of loot from options
function GetHUDTrackerTitle(loot)
    local categoryKey, rarityKey = Filtering.GetFilteringOptionsKeys(loot, Options['HUDTracker']['Filtering'])
    local formatString = Options['HUDTracker']['Filtering'][categoryKey][rarityKey]['HUDTrackerTitle']
    return tostring(Messages.TextFilters(formatString, {loot=loot}), true)
end


-- Return true if lootA should come before lootB
function HUDTrackerSort(lootA, lootB)


    --Debug.Log('************** HUDTrackerSort *********** ')
    -- Handle nil values
    if lootA == nil and lootB == nil then
        --Debug.Log('A and B are nil, result: false')
        return false
    end
    if lootA == nil then
        --Debug.Log('A is nil, result: false')
        return false
    end
    if lootB == nil then
        --Debug.Log('B is nil, result: true')
        return true
    end

    -- Non Nil Results
    --Debug.Log('A: '..tostring(lootA:ToString())..' | Rarity:'..tostring(lootA:GetRarityValue()) .. ' | ItemLevel:' .. tostring(lootA:GetItemLevel()))
    --Debug.Log('B: '..tostring(lootB:ToString())..' | Rarity:'..tostring(lootB:GetRarityValue()) .. ' | ItemLevel:' .. tostring(lootB:GetItemLevel()))

    lootA = lootA.stackInfo.sortProfile
    lootB = lootB.stackInfo.sortProfile
    
    -- Rarer items first
    local rarityA = lootA.rarityValue
    local rarityB = lootB.rarityValue

    if rarityA ~= rarityB then
        --Debug.Log('Prioritizing rarity')
        --Debug.Log('A: Rarity ' .. tostring(rarityA))
        --Debug.Log('B: Rarity ' .. tostring(rarityB))
        --Debug.Log('A before B? : ' .. tostring((rarityA > rarityB)))
        return (rarityA > rarityB)
    end

    -- Better items second
    local ilvlA = lootA.itemLevel
    local ilvlB = lootB.itemLevel
    if ilvlA ~= ilvlB then
        --Debug.Log('Prioritizing ItemLevel')
        --Debug.Log('A: ItemLevel ' .. tostring(ilvlA))
        --Debug.Log('B: ItemLevel ' .. tostring(ilvlB))
        --Debug.Log('A before B? : ' .. tostring((ilvlA > ilvlB)))
        return (ilvlA > ilvlB)
    end

    -- Alphabetic third
    --Debug.Log('Prioritizing alphabetic')
    return (lootA.name < lootB.name)
end



function HUDTracker.IsInFakeMode()
    return Private.testMode
end

function HUDTracker.ExitFakeMode()
    Debug.Log("HUDTracker.ExitFakeMode()")


    for key, value in pairs(Private.testEntries) do
        HUDTracker.OnTrackerRemove({lootId=key})
    end

    Private.testMode = false
    HUDTracker.UpdateVisibility()
end

function HUDTracker.EnterFakeMode()
    Debug.Log("HUDTracker.EnterFakeMode()")
    if Private.testMode then HUDTracker.ExitFakeMode() end

    Private.testMode = true

    -- Make
    local fakeData = {
        {entityId=-1, targetInfo={entityId=-1, itemTypeId=125917}},
        {entityId=-2, targetInfo={entityId=-2, itemTypeId=123219}},
        {entityId=-3, targetInfo={entityId=-3, itemTypeId=123384}},
        {entityId=-4, targetInfo={entityId=-4, itemTypeId=123818}},
        {entityId=-5, targetInfo={entityId=-5, itemTypeId=123874}},
    }

    -- Generate them
    for index, lootData in ipairs(fakeData) do

        lootData.itemInfo = Game.GetItemInfoByType(lootData.targetInfo.itemTypeId)

        local loot = Loot.Create(lootData.entityId, lootData.targetInfo, lootData.itemInfo)

        -- Create entry
        local ENTRY = Private.CreateEntry(loot)

        -- Get the index of each entry in the rowscroller
        local indexList = {}
        for typeId, ENTRY_OTHER in pairs(Private.entries) do
            local index = ENTRY_OTHER.ROW:GetIdx()
            indexList[index] = ENTRY_OTHER
        end

        -- Determine which index our new entry should have
        local ourEntryIndex = nil
        for index, ENTRY_OTHER in pairs(indexList) do
            if HUDTrackerSort(ENTRY, ENTRY_OTHER) then
                ourEntryIndex = index
                break
            end
        end

        -- Insert entry as row
        local ROW = SCROLLER:AddRow(ENTRY.GROUP, ourEntryIndex)

        -- Save a row reference
        ENTRY.ROW = ROW
        
        -- Store entry
        Private.entries[tostring(loot:GetTypeId())] = ENTRY

        -- Store test entry
        Private.testEntries[tostring(loot:GetId())] = loot
    end
    HUDTracker.UpdateVisibility()
end

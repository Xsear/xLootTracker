

HUDTracker = {}


-- Frames
local FRAME = Component.GetFrame('Tracker')
local SLIDER = FRAME:GetChild('Slider')
local LIST = FRAME:GetChild('List')
local SCROLLER = nil

local TOOLTIP_ITEM = nil

local CYCLE_HUDTrackerUpdate = nil

local Private = {
    lastUpdate = 0,
    minUpdateCB = nil,
}   


local DimensionOptions = {
    ScrollerSpacing = 8,
    ScrollerSliderMarginVisible = 5,
    ScrollerSliderMarginHidden = 5,
    EntryDimsWidth = "100%",
    EntryDimsHeight = "32",
    MaxEntriesBeforeScroller = 3,
}


function HUDTracker.OnTrackerNew(args)
    HUDTracker.Update()
end

function HUDTracker.OnTrackerUpdate(args)
    HUDTracker.Update()
end

function HUDTracker.OnTrackerRemove(args)
    HUDTracker.Update()
end


function HUDTracker.GetFrame()
    return FRAME
end

function HUDTracker.Setup()
    -- Scroller
    SCROLLER = RowScroller.Create(LIST)
    SCROLLER:SetSlider(SLIDER)
    SCROLLER:SetSliderMargin(DimensionOptions.ScrollerSliderMarginVisible, DimensionOptions.ScrollerSliderMarginHidden)
    SCROLLER:SetSpacing(DimensionOptions.ScrollerSpacing)
    SCROLLER:ShowSlider(true)

    -- Tooltip
    TOOLTIP_ITEM = LIB_ITEMS.CreateToolTip(FRAME)
    TOOLTIP_ITEM.GROUP:Show(false)

    -- Start
    HUDTracker.Enable()
end

function HUDTracker.Enable()
    -- Start update cycle
    if Options['HUDTracker']['Enabled'] then
        if not CYCLE_HUDTrackerUpdate then
            Debug.Log('Starting HUDTrackerUpdate cycle with interval (s): ' .. tostring(tonumber(Options['HUDTracker']['UpdateInterval'])))
            CYCLE_HUDTrackerUpdate = Callback2.CreateCycle(HUDTracker.Update)
            CYCLE_HUDTrackerUpdate:Run(tonumber(Options['HUDTracker']['UpdateInterval']))
        end
    else
        --
    end

    -- Update
    HUDTracker.UpdateVisibility()
end

function HUDTracker.Disable()
    -- Stop update cycle
    if CYCLE_HUDTrackerUpdate then
        Debug.Log('Stopping HUDTrackerUpdate cycle')
        CYCLE_HUDTrackerUpdate:Stop()
        CYCLE_HUDTrackerUpdate:Release()
        CYCLE_HUDTrackerUpdate = nil
    end

    -- Hide tooltip if is currently being displayed
    if State.tooltipActive then
        Tooltip.Show(false)
        TOOLTIP_ITEM.GROUP:Show(false)
    end

    -- Clear
    SCROLLER:Reset()

    -- Update
    HUDTracker.UpdateVisibility()
end

function HUDTracker.OnOptionChange(id, value)
    if id == "HUDTracker_Enabled" then
        -- Enabled
        if value then
            HUDTracker.Enable()
        -- Disabled
        else
            HUDTracker.Disable()
        end
    
    elseif id == 'HUDTracker_Frame_Width'
    then
        InterfaceOptions.ChangeFrameWidth(FRAME, value)
        
    elseif id == 'HUDTracker_Frame_Height'
    then
        InterfaceOptions.ChangeFrameHeight(FRAME, value)

    elseif id ~= 'UpdateInterval'
       and id ~= 'MinimumUpdateDelay'
    then
        HUDTracker.Update()
    else
        Debug.Log("Unhandled Option Id "..tostring(id))
    end
end





local c_ENTRY_PRINT = [[
    <Group name="EntryGroup" dimensions="width:100%; height:32;">

        <!-- Plate -->
        <FocusBox name="plate" dimensions="width:100%-30; height:28; left:30; top:2;">
            <StillArt name="bg" dimensions="width:100%-2.2; height:99%-2;" style="texture:colors; region:white; tint:#000000; alpha:0.7;"/>
            <Border name="outer" dimensions="dock:fill" class="Tracker_PlateBorder"/>
            <Border name="shade" dimensions="dock:fill" class="ButtonFade"/>
        </FocusBox>

        <!-- Box -->
        <Group name="box" dimensions="width:32; height:32; left:0; top:0;">
            <StillArt name="bg" dimensions="width:96%; height:96%;" style="texture:colors; region:white; tint:#000000; alpha:1;"/>
            <StillArt name="backplate" dimensions="width:99%; height:99%;" style="texture:ItemPlates; region:common;"/>
            <Border name="outer" dimensions="dock:fill;" class="ButtonBorder"/>
            <Border name="shade" dimensions="width:0;height:0;" class="ButtonFade"/>
            <Group name="icon" dimensions="dock:fill;" style="fixed-bounds:true; valign:center;"/>
        </Group>

        <!-- Stack -->
        <Text name="stack" dimensions="width:4%; height:100%-2; top:2; left:10%;" class="Tracker_Text"/>
        
        <!-- Title -->
        <Text name="title" dimensions="width:80%; height:100%-2; top:2; left:20%;" class="Tracker_Text"/>
    </Group>
]]

function Private.CreateEntry(loot, stackInfo)
    -- Create
    local GROUP = Component.CreateWidget(c_ENTRY_PRINT, LIST)

    -- Setup entry
    local ENTRY = {
        PARENT = LIST,
        GROUP = GROUP,
        PLATE = GROUP:GetChild('plate'),
        BOX = GROUP:GetChild('box'),
        STACK = GROUP:GetChild('stack'),
        TITLE = GROUP:GetChild('title'),
    }

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
    ENTRY.PLATE:BindEvent('OnRightMouse', function(args)
        -- Todo:
    end)

    -- Setup plate colors
    local lootColor = loot:GetColor()

    ENTRY.PLATE:GetChild('outer'):SetParam('tint', lootColor)
    ENTRY.PLATE:GetChild('shade'):SetParam('tint', lootColor)

    -- Setup box colors
    ENTRY.BOX:GetChild('outer'):SetParam('tint', lootColor)
    ENTRY.BOX:GetChild('shade'):SetParam('tint', lootColor)

    -- Setup box
    ENTRY.BOX:GetChild('backplate'):SetRegion(loot:GetRarity())

    -- Setup icon
    local ICON_PARENT = ENTRY.BOX:GetChild("icon")
    ENTRY.ICON = loot:GetMultiArt(ICON_PARENT, Options['HUDTracker']['ForceWebIcons'])
    
    -- Setup stack
    if stackInfo and stackInfo.count > 1 then

        -- Normally only display count
        local stackText = tostring(stackInfo.count)

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


function Private.SetEntrySize(ENTRY)

    local newHeight = tonumber(Options['HUDTracker']['EntrySize']) -- ugh this var name

    local height = tostring(newHeight)

    -- Entry
    ENTRY.GROUP:SetDims("width:100%; height:"..height..";")

    -- Plate
    local plateLeftOffset = tostring(newHeight - 4) -- (width of box - px for overlap)
    local plateHeightReduced = tostring(height - 4); -- 2 top and 2 bot to free up space for the bottom borders of the plate
    ENTRY.PLATE:SetDims("width:100%-"..plateLeftOffset.."; height:"..plateHeightReduced..";top:2;left:"..plateLeftOffset)

    -- Box (affecting Icon)
    local boxDimms = "width:"..height.."; height:"..height..";" .. "left:0; top:0;"
    ENTRY.BOX:SetDims(boxDimms)
end



function Private.SetEntryFont(ENTRY)
    local fontType = tostring(Options['HUDTracker']['EntryFontType'])
    local fontSize = tostring(Options['HUDTracker']['EntryFontSize'])

    local suffix = ""
    if fontType == OptionsFontTypes.Wide then
        suffix = "B"
    end


    local font = fontType .. "_" .. fontSize..suffix 

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
    ENTRY.BOX:GetChild('outer'):Show( (boxMode == HUDTrackerPlateModeOptions.Decorated) )
    ENTRY.BOX:GetChild('shade'):Show( (boxMode == HUDTrackerPlateModeOptions.Decorated) )
    ENTRY.BOX:GetChild('icon'):Show( boxMode ~= HUDTrackerIconModeOptions.None)
end



--ENTRY.ICON:Destroy()




function HUDTracker.Update(args)
    args = args or {}
    args.event = "HUDTracker.Update"
    -- Only update and show tracker if enabled
    if Options['HUDTracker']['Enabled'] then
        
        -- Minimum update limiter
        local currentTime = tonumber(System.GetClientTime())
        if args.triggeredByCB then -- Ensure that the callback is cleaned up
            Private.minUpdateCB:Release()
            Private.minUpdateCB = nil
        else
            local timeSinceLastUpdate = System.GetElapsedTime(Private.lastUpdate)
            local minimumUpdateDelay = tonumber(Options['HUDTracker']['MinimumUpdateDelay'])
            -- If this is too early to update
            if timeSinceLastUpdate < minimumUpdateDelay then
                -- Schedule one if we haven't already.
                if not Private.minUpdateCB then
                    Private.minUpdateCB = Callback2.Create()
                    Private.minUpdateCB:Bind(HUDTracker.Update, {triggeredByCB = true})
                    Private.minUpdateCB:Schedule(timeSinceLastUpdate - minimumUpdateDelay)
                end
                return
            end
        end

        -- Update is actually happening!
        --Debug.Event(args)

        -- Hide tooltip if is currently being displayed, whilst we are modifying stuff.
        if State.tooltipActive then
            Tooltip.Show(false)
            TOOLTIP_ITEM.GROUP:Show(false)
        end

        -- Stop scroller updates whilst we update
        SCROLLER:LockUpdates()  

        -- Clear
        SCROLLER:Reset() 

        -- Get loot
        local trackedLoot = Tracker.GetAvailableLoot()

        -- Populate
        if not _table.empty(trackedLoot) then

            -- Parse the list, filtering and counting quantities
            local stackedEntry = {}
            local i=1
            while i <= #trackedLoot do

                -- Get loot
                local loot = trackedLoot[i]

                -- If loot does not pass filters, remove it
                if not LootFiltering(loot, Options['HUDTracker']) then
                    table.remove(trackedLoot, i)

                -- Otherwise, count
                else

                    --Debug.Log(" ** Counting " .. loot:ToString())

                    -- Count
                    if not stackedEntry[loot:GetTypeId()] then
                        stackedEntry[loot:GetTypeId()] = {quantity = loot:GetQuantity(), count = 1}
                    else
                        stackedEntry[loot:GetTypeId()].quantity = stackedEntry[loot:GetTypeId()].quantity + loot:GetQuantity()
                        stackedEntry[loot:GetTypeId()].count = stackedEntry[loot:GetTypeId()].count + 1
                    end

                    --Debug.Log("Loot with typeId " .. tostring(loot:GetTypeId()) .. " has quantity " ..tostring(quantifiedEntries[loot:GetTypeId()]))

                    -- If this isn't the only loot of this kind, remove it
                    if stackedEntry[loot:GetTypeId()].count > 1 then
                        --Debug.Log("Quantity larger than 1, removing entry")
                        table.remove(trackedLoot, i)
                    else
                        i = i + 1
                    end
                end
            end

            --Debug.Table("************** Count complete!", quantifiedEntries)

            -- Order it by rarity
            table.sort(trackedLoot, HUDTrackerSort)

            -- Add rows
            for i, loot in ipairs(trackedLoot) do

                    -- Create entry
                    local ENTRY = Private.CreateEntry(loot, stackedEntry[loot:GetTypeId()])

        
                    -- Add entry as row
                    local ROW = SCROLLER:AddRow(ENTRY.GROUP)
                
            end -- for loop

        else -- no identified items
            -- Clear?
        end

        -- Unlock Scroller
        Private.lastUpdate = tonumber(System.GetClientTime())
        SCROLLER:UnlockUpdates()
        HUDTracker.UpdateVisibility()
    end
end

function HUDTracker.UpdateVisibility()
    if Options['HUDTracker']['Enabled'] then
     -- Should we display the tracker?
        --Debug.Log('Should we display the Tracker?')
        --Debug.Log('Options Tracker Visibility == '..Options['HUDTracker']['Visibility'])
        --Debug.Log('State.hud == '..tostring(State.hud))
        --Debug.Log('State.cursor == '..tostring(State.cursor))
        if SCROLLER:GetRowCount() > 0 and (
               (Options['HUDTracker']['Visibility'] == HUDTrackerVisibilityOptions.Always)
            or (Options['HUDTracker']['Visibility'] == HUDTrackerVisibilityOptions.HUD and State.hud)
            or (Options['HUDTracker']['Visibility'] == HUDTrackerVisibilityOptions.MouseMode and State.cursor and State.hud)
            )
        then
            --Debug.Log('Yes, display the tracker')
            -- Yes, display tracker
            FRAME:Show(true)

            -- Show/hide the Slider depending on the number of rows shown.
            if SCROLLER:GetRowCount() > tonumber(DimensionOptions.MaxEntriesBeforeScroller) then
                SLIDER:Show(true)
            else
                SLIDER:Show(false)
            end

        else
            --Debug.Log('No, hide the tracker')
            -- No, hide the tracker
            FRAME:Show(false)

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

function HUDTracker.UpdateTooltip(lootId)
    -- Get info
    Debug.Log('UpdateTrackerTooltip called for lootId '..tostring(lootId))
    local loot = Tracker.GetLootById(lootId)
    if loot == nil or loot == false then Debug.Error('UpdateTrackerTooltip unable to get identified item') end

    -- Setup Tooltip
    TOOLTIP_ITEM:DisplayInfo(loot.itemInfo)
    TOOLTIP_ITEM.GROUP:SetDims("top:0; left:0; width:200; height:200")

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

-- Fix text size
function AutosizeText(TEXT)
    TEXT:SetDims("top:_; height:"..(TEXT:GetTextDims().height+20)) -- Fixme: Magic number
end


-- Gets filtered display name of loot from options
function GetHUDTrackerTitle(loot)
    local categoryKey, rarityKey = GetLootFilteringOptionsKeys(loot, Options['HUDTracker']['Filtering'])
    local formatString = Options['HUDTracker']['Filtering'][categoryKey][rarityKey]['HUDTrackerTitle']
    return tostring(Messages.TextFilters(formatString, {loot=loot}), true)
end

-- Return true if lootA should come before lootB
function HUDTrackerSort(lootA, lootB)


    --Debug.Log("************** HUDTrackerSort *********** ")
    -- Handle nil values
    if lootA == nil and lootB == nil then
        --Debug.Log("A and B are nil, result: false")
        return false
    end
    if lootA == nil then
        --Debug.Log("A is nil, result: false")
        return false
    end
    if lootB == nil then
        --Debug.Log("B is nil, result: true")
        return true
    end

    -- Non Nil Results
    --Debug.Log("A: "..tostring(lootA:ToString()).." | Rarity:"..tostring(lootA:GetRarityValue()) .. " | ItemLevel:" .. tostring(lootA:GetItemLevel()))
    --Debug.Log("B: "..tostring(lootB:ToString()).." | Rarity:"..tostring(lootB:GetRarityValue()) .. " | ItemLevel:" .. tostring(lootB:GetItemLevel()))
    
    -- Rarer items first
    local rarityA = lootA:GetRarityValue()
    local rarityB = lootB:GetRarityValue()

    if rarityA ~= rarityB then
        --Debug.Log("Prioritizing rarity")
        --Debug.Log("A: Rarity " .. tostring(rarityA))
        --Debug.Log("B: Rarity " .. tostring(rarityB))
        --Debug.Log("A before B? : " .. tostring((rarityA > rarityB)))
        return (rarityA > rarityB)
    end

    -- Better items second
    local ilvlA = lootA:GetItemLevel()
    local ilvlB = lootB:GetItemLevel()
    if ilvlA ~= ilvlB then
        --Debug.Log("Prioritizing ItemLevel")
        --Debug.Log("A: ItemLevel " .. tostring(ilvlA))
        --Debug.Log("B: ItemLevel " .. tostring(ilvlB))
        --Debug.Log("A before B? : " .. tostring((ilvlA > ilvlB)))
        return (ilvlA > ilvlB)
    end

    -- Alphabetic third
    --Debug.Log("Prioritizing alphabetic")
    return (lootA:GetName() < lootB:GetName())
end
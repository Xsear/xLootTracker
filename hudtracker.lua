

HUDTracker = {}


-- Frames
local FRAME = Component.GetFrame('Tracker')
local SLIDER = FRAME:GetChild('Slider')
local LIST = FRAME:GetChild('List')
local SCROLLER = nil

local TOOLTIP_ITEM = nil

local CYCLE_HUDTrackerUpdate = nil
   


function HUDTracker.OnTrackerNew(args)
    --HUDTracker.Update()
end

function HUDTracker.OnTrackerUpdate(args)
    --HUDTracker.Update()
end

function HUDTracker.OnTrackerRemove(args)
    --HUDTracker.Update()
end


function HUDTracker.GetFrame()
    return FRAME
end

function HUDTracker.Setup()
    -- Scroller
    SCROLLER = RowScroller.Create(LIST)
    SCROLLER:SetSlider(SLIDER)
    SCROLLER:SetSliderMargin(5, 5)
    SCROLLER:SetSpacing(8)
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
            CYCLE_HUDTrackerUpdate = Callback2.CreateCycle(HUDTracker.Update)
            CYCLE_HUDTrackerUpdate:Run(Options['HUDTracker']['UpdateInterval'])
        end
    end
end

function HUDTracker.Disable()
    -- Stop update cycle
    if CYCLE_HUDTrackerUpdate then
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
    else
        Debug.Log("Unhandled Option Id "..tostring(id))
    end
end

function HUDTracker.Update()
    -- Only update and show tracker if enabled
    if Options['HUDTracker']['Enabled'] then
       
        -- Hide tooltip if is currently being displayed, whilst we are modifying stuff.
        if State.tooltipActive then
            Tooltip.Show(false)
            TOOLTIP_ITEM.GROUP:Show(false)
        end

        -- Clear
        SCROLLER:Reset() 

        -- Get loot
        local trackedLoot = Tracker.GetLoot()

        -- Order it by rarity
        table.sort(trackedLoot, HUDTrackerSort)

        -- Populate
        if not _table.empty(trackedLoot) then

            for id, loot in pairs(trackedLoot) do

                    -- Create widget
                    local ENTRY = Component.CreateWidget('Tracker_List_Entry', LIST)
                    local ENTRY_PLATE = ENTRY:GetChild('plate')
                    local ENTRY_ITEM = ENTRY:GetChild('item')

                    -- Set dimensions
                    ENTRY:SetDims('top:0; left:0; width:100%; height:32');

                    -- Set the plate tag
                    ENTRY_PLATE:SetTag(tostring(loot:GetId()))
                    
                    -- Tooltip
                    if Options['HUDTracker']['Tooltip']['Enabled'] then
                        ENTRY_PLATE:BindEvent('OnMouseEnter', function(args)
                            TOOLTIP_ITEM.GROUP:Show(true)
                            Tooltip.Show(HUDTracker.UpdateTooltip(args.widget:GetTag()))
                            State.tooltipActive = true
                        end)
                        ENTRY_PLATE:BindEvent('OnMouseLeave', function(args)
                            TOOLTIP_ITEM.GROUP:Show(false)
                            Tooltip.Show(false)
                            State.tooltipActive = false
                        end)
                    end
                        
                    -- Colours
                    ENTRY_PLATE:GetChild('outer'):SetParam('tint', loot:GetColor())
                    ENTRY_PLATE:GetChild('shade'):SetParam('tint', loot:GetColor())
                    ENTRY_ITEM:GetChild('outer'):SetParam('tint', loot:GetColor())
                    ENTRY_ITEM:GetChild('shade'):SetParam('tint', loot:GetColor())

                    -- Item Backplate
                    ENTRY_ITEM:GetChild('backplate'):SetRegion(tostring(loot:GetRarity()))

                    -- Item Icon
                    ENTRY_ITEM:GetChild('itemIcon'):SetUrl(loot:GetWebIcon())


                    -- Setup Looted to
                    local assignedToText = ""
                    if loot:GetState() == LootState.Looted then
                        assignedtoText = tostring(loot:GetLootedTo())
                    elseif loot:GetState() == LootState.Lost then
                        assignedToText = "Lost"
                    end

                    ENTRY:GetChild('leftBar'):GetChild('assignedTo'):SetText(assignedToText)

                    -- Right
                    -- Item Name text
                    ENTRY:GetChild('itemName'):SetText(GetWaypointTitle(loot))

                    -- Determine what to display
                    -- State Dependant Stuff
                    -- Left Side
                    ENTRY:GetChild('leftBar'):GetChild('buttons'):Show(false) -- note: Watch out for when fixing buttons
                    ENTRY:GetChild('leftBar'):GetChild('assignedTo'):Show(true)

         

                    -- Right Side
                    ENTRY:GetChild('itemName'):Show(true)


                    -- Options Dependant Stuff
                    if Options['HUDTracker']['PlateMode'] == HUDTrackerPlateModeOptions.Decorated then
                        ENTRY_PLATE:GetChild('bg'):Show(true)
                        ENTRY_PLATE:GetChild('outer'):Show(true)
                        ENTRY_PLATE:GetChild('shade'):Show(true)

                    elseif Options['HUDTracker']['PlateMode'] == HUDTrackerPlateModeOptions.Simple then
                        ENTRY_PLATE:GetChild('bg'):Show(true)
                        ENTRY_PLATE:GetChild('outer'):Show(false)
                        ENTRY_PLATE:GetChild('shade'):Show(false)
                    
                    elseif Options['HUDTracker']['PlateMode'] == HUDTrackerPlateModeOptions.None then
                        ENTRY_PLATE:GetChild('bg'):Show(false)
                        ENTRY_PLATE:GetChild('outer'):Show(false)
                        ENTRY_PLATE:GetChild('shade'):Show(false)
                    end

                    if Options['HUDTracker']['IconMode'] == HUDTrackerIconModeOptions.Decorated then
                        
                        ENTRY_ITEM:GetChild('bg'):Show(true)
                        ENTRY_ITEM:GetChild('backplate'):Show(true)
                        ENTRY_ITEM:GetChild('outer'):Show(true)
                        ENTRY_ITEM:GetChild('shade'):Show(true)
                        ENTRY_ITEM:GetChild('itemIcon'):Show(true)


                    elseif Options['HUDTracker']['IconMode'] == HUDTrackerIconModeOptions.Simple then
                        
                        ENTRY_ITEM:GetChild('bg'):Show(true)
                        ENTRY_ITEM:GetChild('backplate'):Show(true)
                        ENTRY_ITEM:GetChild('outer'):Show(false)
                        ENTRY_ITEM:GetChild('shade'):Show(false)
                        ENTRY_ITEM:GetChild('itemIcon'):Show(true)
                    
                    elseif Options['HUDTracker']['IconMode'] == HUDTrackerIconModeOptions.IconOnly then                   

                        ENTRY_ITEM:GetChild('bg'):Show(false)
                        ENTRY_ITEM:GetChild('backplate'):Show(false)
                        ENTRY_ITEM:GetChild('outer'):Show(false)
                        ENTRY_ITEM:GetChild('shade'):Show(false)
                        ENTRY_ITEM:GetChild('itemIcon'):Show(true)

                    elseif Options['HUDTracker']['IconMode'] == HUDTrackerIconModeOptions.None then

                        ENTRY_ITEM:GetChild('bg'):Show(false)
                        ENTRY_ITEM:GetChild('backplate'):Show(false)
                        ENTRY_ITEM:GetChild('outer'):Show(false)
                        ENTRY_ITEM:GetChild('shade'):Show(false)
                        ENTRY_ITEM:GetChild('itemIcon'):Show(false)
                        
                        --ENTRY_PLATE:SetDims('left:0')
                    end

                    local ROW = SCROLLER:AddRow(ENTRY)
                
            end -- for loop
        else -- no identified items
            -- Clear?
        end


       HUDTracker.UpdateVisibility()
    end
end

function HUDTracker.UpdateVisibility()
    if Options['HUDTracker']['Enabled'] then
     -- Should we display the tracker?
        --Debug.Log('Should we display the Tracker?')
        --Debug.Log('Options Tracker Visibility == '..Options['Tracker']['Visibility'])
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

            -- Show/hide the Slider depending on the number of rows shown - hardcoded.
            if SCROLLER:GetRowCount() > 3 then
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

    -- Return Tooltip
    local tip_args = TOOLTIP_ITEM:GetBounds()
    tip_args.frame_color = loot:GetColor()

    return TOOLTIP_ITEM.GROUP, tip_args
end

-- Fix text size
function AutosizeText(TEXT)
    TEXT:SetDims("top:_; height:"..(TEXT:GetTextDims().height+20))
end


-- Return true if lootA should come before lootB
function HUDTrackerSort(lootA, lootB)
    -- Rarer items first
    if Loot.GetRarityIndex(lootA:GetRarity()) > Loot.GetRarityIndex(lootB:GetRarity()) then
        return true
    
    -- Better items second
    elseif lootA:GetItemLevel() > lootB:GetItemLevel() then
        return true

    -- Alphabetic third
    elseif lootA:GetName() < lootB:GetName() then
        return true

    end

    -- This part is important for sorting to work!
    return false
end
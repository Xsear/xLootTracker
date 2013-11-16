

Tracker = {}


-- Frames
local FRAME = Component.GetFrame('Tracker')
local TOOLTIP_PROG = FRAME:GetChild('Tooltip')


function Tracker.GetFrame()
    return FRAME
end

function Tracker.Update()
    -- Debug.Log('UpdateTracker')
    -- Only update and show tracker if enabled
    if Options['Tracker']['Enabled'] then

        local cTrackerEntrySize = 30 -- Fixme: Wat
        local cTrackerButtonSize = 25 -- Fixme: Explain
       
        -- Hide tooltip if is currently being displayed
        if bTooltipActive then
            Tooltip.Show(false)
            TOOLTIP_PROG:Show(false) -- No need to display tooltip info now.
        end

         -- Update List of tracked items
        RemoveAllChildren(FRAME:GetChild('List')) -- clear previous entries
        if not _table.empty(aIdentifiedLoot) then
            for num, item in ipairs(aIdentifiedLoot) do
                if ItemPassesFilter(item, Options['Tracker']) then

                    -- Create widget
                    local ENTRY = Component.CreateWidget('Tracker_List_Entry', FRAME:GetChild('List'))
                    ENTRY:SetDims('top:0; left:0; width:100%; height:'..cTrackerEntrySize..';');

                    -- Set the plate tag
                    ENTRY:GetChild('plate'):SetTag(tostring(item.entityId))
                    
                    -- Tooltip
                    if Options['Tracker']['Tooltip']['Enabled'] then
                        ENTRY:GetChild('plate'):BindEvent('OnMouseEnter', function(args)
                            TOOLTIP_PROG:Show(true)
                            Tooltip.Show(Tracker.UpdateTooltip(args.widget:GetTag()))
                            bTooltipActive = true
                        end)
                        ENTRY:GetChild('plate'):BindEvent('OnMouseLeave', function(args)
                            TOOLTIP_PROG:Show(false)
                            Tooltip.Show(false)
                            bTooltipActive = false
                        end)
                    end
                        
                    -- Colours
                    ENTRY:GetChild('plate'):GetChild('outer'):SetParam('tint', LIB_ITEMS.GetResourceQualityColor(item.quality))
                    ENTRY:GetChild('plate'):GetChild('shade'):SetParam('tint', LIB_ITEMS.GetResourceQualityColor(item.quality))
                    ENTRY:GetChild('item'):GetChild('outer'):SetParam('tint', LIB_ITEMS.GetResourceQualityColor(item.quality))
                    ENTRY:GetChild('item'):GetChild('shade'):SetParam('tint', LIB_ITEMS.GetResourceQualityColor(item.quality))

                    -- Item Backplate
                    ENTRY:GetChild('item'):GetChild('backplate'):SetRegion(tostring(item.itemInfo.rarity)..'_64')

                    -- Item Icon
                    ENTRY:GetChild('item'):GetChild('itemIcon'):SetUrl(item.itemInfo.web_icon)

                    -- Left
                    --[[
                    -- Setup Buttons
                        -- Need
                        BUTTON1 = Button.Create(ENTRY:GetChild('leftBar'):GetChild('buttons'))

                        BUTTON1_ICON = MultiArt.Create(BUTTON1:GetWidget())
                        BUTTON1_ICON:SetTexture('TrackerIcons')
                        BUTTON1_ICON:SetRegion('Need')

                        BUTTON1:GetWidget():SetDims('width:'..cTrackerButtonSize..'; height:'..cTrackerButtonSize..';')

                        BUTTON1:Bind(function() 
                                System.PlaySound('Play_UI_Beep_06')
                            end)

                        -- Greed
                        BUTTON2 = Button.Create(ENTRY:GetChild('leftBar'):GetChild('buttons'))

                        BUTTON2_ICON = MultiArt.Create(BUTTON2:GetWidget())
                        BUTTON2_ICON:SetTexture('TrackerIcons')
                        BUTTON2_ICON:SetRegion('Greed')

                        BUTTON2:GetWidget():SetDims('width:'..cTrackerButtonSize..'; height:'..cTrackerButtonSize..';')
                        BUTTON2:Bind(function() 
                                System.PlaySound('Play_UI_Beep_06')
                            end)

                        -- Pass
                        BUTTON3 = Button.Create(ENTRY:GetChild('leftBar'):GetChild('buttons'))

                        BUTTON3_ICON = MultiArt.Create(BUTTON3:GetWidget())
                        BUTTON3_ICON:SetTexture('TrackerIcons')
                        BUTTON3_ICON:SetRegion('Pass')

                        BUTTON3:GetWidget():SetDims('width:'..cTrackerButtonSize..'; height:'..cTrackerButtonSize..';')
                        BUTTON3:Bind(function() 
                                System.PlaySound('Play_UI_Beep_06')
                            end)
                    --]]
                    
                    -- Setup Assigned To text
                    if item.assignedTo == nil then
                        ENTRY:GetChild('leftBar'):GetChild('assignedTo'):SetText(Lokii.GetString('UI_AssignedTo_nil'))
                    elseif item.assignedTo == false or item.assignedTo == true then
                        ENTRY:GetChild('leftBar'):GetChild('assignedTo'):SetText(Lokii.GetString('UI_AssignedTo_true'))
                    else
                        ENTRY:GetChild('leftBar'):GetChild('assignedTo'):SetText(tostring(item.assignedTo))
                    end

                -- Right
                    -- Item Name text
                    ENTRY:GetChild('itemName'):SetText(itemPrefixShortener(FixItemNameTag(item.name, item.quality)))

                -- Determine what to display
                -- State Dependant Stuff
                    -- Left Side
                    if item.assignedTo == nil then
                        ENTRY:GetChild('leftBar'):GetChild('buttons'):Show(true)
                        ENTRY:GetChild('leftBar'):GetChild('assignedTo'):Show(false)
                    else
                        ENTRY:GetChild('leftBar'):GetChild('buttons'):Show(false)
                        ENTRY:GetChild('leftBar'):GetChild('assignedTo'):Show(true)
                    end

                    -- Right Side
                    ENTRY:GetChild('itemName'):Show(true)


                -- Options Dependant Stuff
                    if Options['Tracker']['PlateMode'] == TrackerPlateModeOptions.Decorated then
                        ENTRY:GetChild('plate'):GetChild('bg'):Show(true)
                        ENTRY:GetChild('plate'):GetChild('outer'):Show(true)
                        ENTRY:GetChild('plate'):GetChild('shade'):Show(true)

                    elseif Options['Tracker']['PlateMode'] == TrackerPlateModeOptions.Simple then
                        ENTRY:GetChild('plate'):GetChild('bg'):Show(true)
                        ENTRY:GetChild('plate'):GetChild('outer'):Show(false)
                        ENTRY:GetChild('plate'):GetChild('shade'):Show(false)
                    
                    elseif Options['Tracker']['PlateMode'] == TrackerPlateModeOptions.None then
                        ENTRY:GetChild('plate'):GetChild('bg'):Show(false)
                        ENTRY:GetChild('plate'):GetChild('outer'):Show(false)
                        ENTRY:GetChild('plate'):GetChild('shade'):Show(false)
                    end

                    if Options['Tracker']['IconMode'] == TrackerIconModeOptions.Decorated then
                        
                        ENTRY:GetChild('item'):GetChild('bg'):Show(true)
                        ENTRY:GetChild('item'):GetChild('backplate'):Show(true)
                        ENTRY:GetChild('item'):GetChild('outer'):Show(true)
                        ENTRY:GetChild('item'):GetChild('shade'):Show(true)
                        ENTRY:GetChild('item'):GetChild('itemIcon'):Show(true)


                    elseif Options['Tracker']['IconMode'] == TrackerIconModeOptions.Simple then
                        
                        ENTRY:GetChild('item'):GetChild('bg'):Show(true)
                        ENTRY:GetChild('item'):GetChild('backplate'):Show(true)
                        ENTRY:GetChild('item'):GetChild('outer'):Show(false)
                        ENTRY:GetChild('item'):GetChild('shade'):Show(false)
                        ENTRY:GetChild('item'):GetChild('itemIcon'):Show(true)
                    
                    elseif Options['Tracker']['IconMode'] == TrackerIconModeOptions.IconOnly then                   

                        ENTRY:GetChild('item'):GetChild('bg'):Show(false)
                        ENTRY:GetChild('item'):GetChild('backplate'):Show(false)
                        ENTRY:GetChild('item'):GetChild('outer'):Show(false)
                        ENTRY:GetChild('item'):GetChild('shade'):Show(false)
                        ENTRY:GetChild('item'):GetChild('itemIcon'):Show(true)

                    elseif Options['Tracker']['IconMode'] == TrackerIconModeOptions.None then

                        ENTRY:GetChild('item'):GetChild('bg'):Show(false)
                        ENTRY:GetChild('item'):GetChild('backplate'):Show(false)
                        ENTRY:GetChild('item'):GetChild('outer'):Show(false)
                        ENTRY:GetChild('item'):GetChild('shade'):Show(false)
                        ENTRY:GetChild('item'):GetChild('itemIcon'):Show(false)
                        
                        --ENTRY:GetChild('plate'):SetDims('left:0')
                    end

                end
            end
        else
            -- Clear?
        end

        -- Should we display the tracker?
        --Debug.Log('Should we display the Tracker?')
        --Debug.Log('Options Tracker Visibility == '..Options['Tracker']['Visibility'])
        --Debug.Log('bHUD == '..tostring(bHUD))
        --Debug.Log('bCursor == '..tostring(bCursor))
        if  Options['Tracker']['Visibility'] == TrackerVisibilityOptions.Always 
        or (Options['Tracker']['Visibility'] == TrackerVisibilityOptions.HUD and bHUD)
        or (Options['Tracker']['Visibility'] == TrackerVisibilityOptions.MouseMode and bCursor and bHUD)
        then
            --Debug.Log('Yes, display the tracker')
            -- Yes, display tracker
            FRAME:Show(true)
        else
            --Debug.Log('No, hide the tracker')
            -- No, hide the tracker
            FRAME:Show(false)

            -- Ensure no tooltip is displayed
            TOOLTIP_PROG:Show(false)
            Tooltip.Show(false)
            bTooltipActive = false
        end

    -- Tracker not enabled, so do nothing but make sure it's hidden.
    else
        --Debug.Log('Tracker not enabled, hide')
        -- Hide tracker
        FRAME:Show(false)

        -- Ensure no tooltip is displayed
        TOOLTIP_PROG:Show(false)
        Tooltip.Show(false)
        bTooltipActive = false
    end

end


function Tracker.UpdateTooltip(entityId)
    -- Get info
    Debug.Log('UpdateTrackerTooltip called with entityId'..tostring(entityId), 'Calling GetIdentifiedItem with '..tostring(entityId))
    local item = GetIdentifiedItem(entityId)
    if item == nil or item == false then Debug.Error('UpdateTrackerTooltip unable to get identified item') end

    -- Refs
    local TOOLTIP_PROG_HEADER = TOOLTIP_PROG:GetChild("header")
    local TOOLTIP_PROG_ICON = TOOLTIP_PROG:GetChild("header.icon")
    local TOOLTIP_PROG_NAME = TOOLTIP_PROG:GetChild("header.name")
    local TOOLTIP_PROG_SUBNAME = TOOLTIP_PROG:GetChild("header.subname")
    local TOOLTIP_PROG_YIELDS = TOOLTIP_PROG:GetChild("yields")
    local TOOLTIP_PROG_REQS = TOOLTIP_PROG:GetChild("requirements")
    local TOOLTIP_PROG_DESC= TOOLTIP_PROG:GetChild("desc")


    -- Icon
    if item.itemInfo.web_icon then
        TOOLTIP_PROG_ICON:SetUrl(item.itemInfo.web_icon)
        TOOLTIP_PROG_ICON:Show(true)
    else
        TOOLTIP_PROG_ICON:Show(false)
    end
    
    -- Name
    TOOLTIP_PROG_NAME:SetText(FixItemNameTag(item.itemInfo.name, item.quality))
    TOOLTIP_PROG_NAME:SetTextColor(LIB_ITEMS.GetResourceQualityColor(item.quality))


    -- Fixme: This should be "if itemtype == equipment items" or something.
    -- Equipment Items
    if item.itemInfo.type ~= 'crafting_component' then

        -- Stats
        xItemFormatting.PrintLines(xItemFormatting.getStatLines(item.itemInfo), TOOLTIP_PROG_YIELDS)

        -- Requirements
        xItemFormatting.PrintLines(xItemFormatting.getRequirementLines(item.itemInfo), TOOLTIP_PROG_REQS)

        -- Description
        TOOLTIP_PROG_DESC:SetText(item.itemInfo.description)

    -- Crafting Components
    else
        -- Stats
        xItemFormatting.PrintLines(xItemFormatting.getStatLines(item.itemInfo), TOOLTIP_PROG_YIELDS)

        -- Requirements
        xItemFormatting.PrintLines(xItemFormatting.getRequirementLines(item.itemInfo), TOOLTIP_PROG_REQS)

        -- Description
        -- Fixme: Stop the hardsauce~
        local interestingCraftingComponents = {

            ['Fire Gland'] = {
                itemTypeId  = '85235',
                description = 'Can be used to craft Burning Cryo Grenade\nAdds a Frost Burner to Cryo Grenade, which increases Cryo Grenade damage. Applies a DoT that burns he target ontop of slowing them.\nFire Gland quality modifies damage.\n'..'Can be used to craft Dragonborn Plasma Cannon.\nReplaces Scattershot Alt Fire with \"Dragon\'s Breath\", shooting a burst of fire forward in a cone.\nFire Gland quality modifies Dragon\'s Breath range.',
            },
            ['Drone Module'] = {
                itemTypeId  = '10014',
                description = 'Can be used to craft Advanced Decoy.\nAdds AI behavior to Decoy which allows Decoy to move and shoot before it explodes.\nDrone Module quality modifies AI damage.\n'..'Can be used to craft Shielded Crater.\nAdds Blast Shield to Crater. Blast Shield spawns centered on the impact site of Crater.\nDrone Module quality modifies Blast Shield health.'
            },
            ['Culex Wings'] = {
                itemTypeId  = '10024',
                description = 'Can be used to craft Soaring Afterburner.\nAdds Quick-Deploying Gliding Gear to Afterburner. Glider wings sprout from the Assault at the end of Afterburner.\nWings quality modifies Quick-Deploying Gliding Gear duration.',
            },
            ['Poison Gland'] = {
                itemTypeId  = '10012',
                description = 'Can be used to craft Noxious Needler.\nReplaces alt fire with Plague Blaster, which increases the amount of damage enemies take when hit by the alt fire. This effect also spreads to nearby targets.\nPoison Gland quality modifies the % of increased damage taken.',
            },
            ['Ink Sack'] = {
                itemTypeId  = '85626',
                description = 'Can be used to craft Toxic Poison Trail.\nAdds Blinding Fumes to Poison Trail, decreasing enemies\' accuracy while in Poison Trail.\nInk Sac quality modifies the enemy accuracy reduction.',
            },
            ['Space Manipulator'] = {
                itemTypeId  = '85627',
                description = 'Can be used to craft Attracting Repulsor Blast.\nAdds a Magnetic Attractor to Repulsor Blast, drawing enemies in to the Dreadnaught before Repulsor Blast is fired.\nSpace Manipulator quality modifies pull-in range.\n'..'Can be used to craft Ghostly Triage.\nAdds a Phase Unit to Triage, which allows the player to be able to pass through enemies/allies causing damage to enemies and healing allies.\nSpace Manipulator quality modifies duration.',
            },
            ['Brontodon Ivory'] = {
                itemTypeId = '10010',
                description = 'Can be used to craft Barrier HMG.\nAdds an Upgraded Forward Shield to the HMG alt fire, creating an improved shield. Full body shield.\nBrontodon Ivory quality modifies shield health.',
            },
            ['Shell Fragment'] = {
                itemTypeId = '82500',
                description = 'Can be used to craft Spiny Heavy Armor.\nAdds a Damage Reflector which harms enemies that hit the Dreadnaught while Heavy Armor is active.\nShell Fragment quality modifies the percentage of damage returned.',
            },
            ['Brinewyrm Goo'] = {
                itemTypeId = '10011',
                description = 'Can be used to craft Burrowing Sticky Grenade Launcher.\nAdds Burrowing Explosives to Sticky Grenade Launcher which applies a Damage over Time effect to the area that they were detonated on.\nBrinewyrm Goo quality modifies the damage of the Damage over Time.',
            },
            ['Hypercapacitor'] = {
                itemTypeId = '10015',
                description = 'Can be used to craft HKM Supply Station.\nAdds High Capacity Arcfold Tech to the Supply Station, replacing health pickups with HKM powerups.\nHypercapacitor quality modifies amount of HKM charge given.',
            },
            ['Explosive Device'] = {
                itemTypeId = '10016',
                description = 'Can be used to craft Rocket Turret.\nAdds Rocket Turrets to Heavy Turret. Rockets fire ontop of the normal firing projectile.\nExplosive Device quality modifies rocket damage.',
            },
            ['Cornea'] = {
                itemTypeId = '10009',
                description = 'Can be used to craft Sharpeyed R36.\nAdds tech to increase the magnification when zooming with the R36.\nCornea quality modifies magnification.',
            },
        }

        for key, value in pairs(interestingCraftingComponents) do
            if value.itemTypeId == item.itemInfo.itemTypeId then
                TOOLTIP_PROG_DESC:SetText(value.description)
                break
            end
        end


    end


    -- Fix text size
    local function AutosizeText(TEXT)
        TEXT:SetDims("top:_; height:"..(TEXT:GetTextDims().height+20))
    end
    
    AutosizeText(TOOLTIP_PROG_YIELDS)
    AutosizeText(TOOLTIP_PROG_REQS)
    AutosizeText(TOOLTIP_PROG_DESC)

    -- Return Tooltip
    local tip_args = {height=0}
    tip_args.height = TOOLTIP_PROG:GetLength()
    tip_args.frame_color = LIB_ITEMS.GetResourceQualityColor(item.quality)
    
    return TOOLTIP_PROG, tip_args
end

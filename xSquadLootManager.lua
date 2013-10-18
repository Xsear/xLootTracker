-- Requires
-- Standard
require 'math' -- In order to generate random numbers
require 'string' -- Because why not

-- Firefall
require 'lib/lib_Debug' -- Debug library, used for logging
require 'lib/lib_InterfaceOptions' -- Interface Options
require 'lib/lib_Items' -- Item library, used to get color-by-quality, and item tooltips
require 'lib/lib_MapMarker' -- Map Marker library, used for waypoint creation.
require 'lib/lib_Slash' -- Slash commands
require 'lib/lib_Vector' -- Vector coordinates
require 'lib/lib_Button' -- Buttons used by Tracker
require 'lib/lib_ToolTip' -- ToolTip used by Tracker
require 'lib/lib_ChatLib' -- Used to send some chat messages
require 'lib/lib_table'

-- Custom
require './lib/Lokii' -- Localization
require './lib/lib_GTimer' -- Timer for rolltimeout
require './lib/lib_LKObjects' -- 3d markers
require './obj/panel/panel' -- 3d marker template
require './util/DWFrameIdx' -- Database to determine which frame/s that any ability module belongs to
require './util/xSounds' -- Database of sounds
require './util/xItemFormatting' -- Awesome functions from lib_Items that weren't available for use. Used by tracker when generating tooltips.

-- Frames
TRACKER = Component.GetFrame('Tracker')
TRACKER_TOOLTIP = TRACKER:GetChild('Tooltip')

-- Constants
csVersion = '0.85'
ciSaveVersion = 0.67

local ciLootDespawn = 20 -- Seconds into the future that the callback that checks if an item entity is still around is set to. Used to remove despawned or otherwise glitched out items
local ciSquadMessageLengthLimit = 255 -- Character limit of Squad chat messages. Used to split too long messages into multiple. One character reserved for alerts.

-- Variables
local aSquadRoster = {} -- The latest squad roster
local aIdentifiedLoot = {} -- Currently tracked items

local bLoaded = false -- Set by the __LOADED message through options, allowing me to hold back sounds when the addon loads all the settings
local bInSquad = false -- Whether we are currently in a squad or not
local bIsSquadLeader = false -- Whether we are currently the squad leader or not

local bHUD = false -- Whether game wants HUD to be displayed or not, updated by OnHudShow
local bCursor = false -- Whether game is in cursor mode or not, updated by OnInputModeChanged

local bToolTipActive = false -- Whether addon is currently utilizing the ToolTip. Updated manually within the addon when ToolTip.Show is called. There are situations unrelated to mouse location where I might want to hide the tooltip if it is displaying. Just calling ToolTip.Show(false) could interfere with other addons, so I use this addon to keep track of when I've called it. As long as no other addon/ui element randomly calls ToolTip.Show (without mine being unfocused) it should serve its purpose.

local mCurrentlyRolling = false -- false if not rolling, table otherwise, all the wtfs you want
local aCurrentlyRolling = {} -- During a need-before-greed roll, stores data of squadroster with additional fields like rolltype, rollvalue etc. Merge this with mCurrentlyRolling sometime for awesomeness

local iRoundRobinIndex = 1 -- Used to traverse the squad roster when distributing loot in round-robin mode

-- Addon
require './options' -- Everything options related

-- Functions
--[[
    OnComponentLoad()
    Callback on ComponentLoad
    Sets up Interace options, slash commands and prints a version message
]]--
function OnComponentLoad()
    -- Setup Lokii
    Lokii.AddLang("en", "./lang/EN");
    Lokii.SetBaseLang("en");
    Lokii.SetToLocale();

    -- Setup Debug
    Debug.EnableLogging(Component.GetSetting('Debug_Enabled'))

    -- Setup Interface Options
    SetupInterfaceOptions()

    -- Best make sure option visibility is set up quickly
    SetOptionsAvailability()

    -- Best make sure to update the squad roster so we set the var
    OnSquadRosterUpdate()

    -- Setup Slash Commands
    LIB_SLASH.BindCallback({slash_list='slm', description='/slm : Xsear\'s Squad Loot Manager', func=OnSlash})

    -- Setup In game Objects
    LKObjects.SetMemoryWarning(20) -- should be about 5 panels

    -- Best make sure the tracker is set up
    UpdateTracker()

    -- Print version message
    if Component.GetSetting('Core_VersionMessage') then
        SendChatMessage('system', 'Xsear\'s Squad Loot Manager v'..csVersion..' Loaded')
    end
end

--[[
    OnHudShow(args)
    Callback for MY_HUD_SHOW event.
    Used to determine if the tracker should be displayed or not.
]]--
function OnHudShow(args)
    --Debug.Log('OnHudShow')
    local hide = args.loading_screen or args.logout_bonus or args.freecamera
    bHUD = not hide
    UpdateTracker()
end

--[[
    OnInputModeChanged(args)
    Callback for ON_INPUT_MODE_CHANGED event.
    Used to determine if the tracker should be displayed or not.
]]--
function OnInputModeChanged(args)
    --Debug.Log('OnInputModeChanged')
    bCursor = (args.mode == 'cursor')
    UpdateTracker()
end

--[[
    OnSquadRosterUpdate()
    Callback for when the Squad Roster updates.
    Keeps our roster and whether or not we're the squad leader up to date.
]]--
function OnSquadRosterUpdate()
    -- Remember previous number of squad members
    local previousRosterMemberCount = 0
    if aSquadRoster ~= nil and not _table.empty(aSquadRoster) then
        previousRosterMemberCount = #aSquadRoster.members
    end

    -- Update squad roster
    aSquadRoster = Squad.GetRoster()

    -- If in Squad
    if aSquadRoster ~= nil and not _table.empty(aSquadRoster) then
        -- Update Squad status
        bInSquad = true

        -- Update Squad Leader status
        if Options['Distribution']['AlwaysSquadLeader'] then
            bIsSquadLeader = true
        else
            bIsSquadLeader = IsSquadLeader(Player.GetInfo())
        end

        -- Reset Round Robin if members changed
        if previousRosterMemberCount ~= #aSquadRoster.members then
            iRoundRobinIndex = 1
            Debug.Log('OnSquadRosterUpdate restting iRoundRobinIndex to '..tostring(iRoundRobinIndex))
        end


    -- Not in Squad
    else
        -- Update Squad status
        if Options['Debug']['Enabled'] and Options['Debug']['FakeOnSquadRoster'] then
            bInSquad = true
            Debug.Log('OnSquadRosterUpdate faking a squad roster')
            aSquadRoster = {members={{name=Player.GetInfo(), battleframe='medic'}, {name='SquadRosterUpdateFake1', battleframe='berzerker'}, {name='SquadRosterUpdateFake2', battleframe='recon'}}}
            iRoundRobinIndex = 1
            Debug.Log('OnSquadRosterUpdate restting iRoundRobinIndex to '..tostring(iRoundRobinIndex))
        else
            bInSquad = false
        end

        -- Update Squad leader status
        if Options['Distribution']['AlwaysSquadLeader'] then
            bIsSquadLeader = true
        else
            bIsSquadLeader = false
        end
    end

    -- Update tracker
    UpdateTracker()

end

--[[
    OnSlash(args)
    Callback function for Slash commands
]]--
function OnSlash(args)
    if args.text == '' or args.text == 'help' or args.text == '?' then
        SendSystemMessage('Xsear\'s Squad Loot Manager v'..csVersion)
        SendSystemMessage('Command list')
        SendSystemMessage('/slm [help|?]: Version message and command list')
        SendSystemMessage('/slm <enable|disable|toggle> : Turn addon on or off')
        SendSystemMessage('/slm <distribute|roll> : Distribute first rollable item')
        SendSystemMessage('/slm list : List rollable items')
        SendSystemMessage('/slm clear : Clears list of identified items')
    elseif args.text == 'test' then
        Test()
    elseif args.text == 'ut' then
        UpdateTracker()
    elseif args.text == 'clear' then
        ClearIdentified()
    elseif args.text == 'enable' or args.text == 'disable' or args.text == 'toggle' then
        ToggleEnabled(args.text)
    elseif args.text == 'distribute' or args.text == 'roll' then
        DistributeItem()
    elseif args.text == 'list' then
        ListUnAssigned()
    end
end

--[[
    OnEntityAvailable(args)
    Callback function for when new entities are available to the UI
    Used to detect loot
]]--
function OnEntityAvailable(args)
    -- Requires that Core and Detection is enabled
    if not (Options['Core']['Enabled'] and Options['Detection']['Enabled']) then return end

    -- Filter away any entities that are not loot
    if args.type == 'loot' then
        -- Get more info about the entity
        local targetInfo = Game.GetTargetInfo(args.entityId)
        local itemInfo = Game.GetItemInfoByType(targetInfo.itemTypeId, Game.GetItemAttributeModifiers(targetInfo.itemTypeId, targetInfo.quality))

        -- Debug
        if Options['Debug']['LogLootableTargets'] and IsLootableTarget(targetInfo) then
            Debug.Log('Lootable Target Available')
            Debug.Log('targetInfo')
            Debug.Table(targetInfo)
            Debug.Log('itemInfo')
            Debug.Table(itemInfo)
        end

        -- Determine if it is a lootable entity
        if IsLootableTarget(targetInfo) and IsTrackableItemType(itemInfo) then

            -- If we're not tracking it already, track it!
            if not IsIdentified(args.entityId) then
                Identify(args.entityId, targetInfo)
            end
        end
    end
end

--[[
    OnChatMessage(args)
    Callback function for when player receives chat messages
    Identifies messages
    Todo: Move logic into separate functions
    Fixme: holy shit this function is a clusterfuck
]]--
function OnChatMessage(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    --[[
        FindFirstKeyInText(text, key)
        Chat parsing helper function
    ]]--
    local function FindFirstKeyInText(text, key)
        return string.find(text, key, 0, string.len(key))
    end

    --[[
        FilterFirstKeyFromText(text, key)
        Chat parsing helper function
    ]]--
    local function FilterFirstKeyFromText(text, key)
        --FindFirstKeyInText(text, key),
        return string.sub(text, string.len(key) + 1)
    end

    -- Filter for only Squad messages
    if args.channel == 'squad' then

        -- Filter for only addon communication messages
        -- We only listen to messages from the squad leader, and only if we're not the squad leader ourselves (that has to be some fake squad leader fooshu!)
        if IsSquadLeader(args.author) and not bIsSquadLeader and FindFirstKeyInText(args.text, Options['Messages']['Communication']['Prefix']) ~= nil then
            Debug.Log('Squad Communication Message')
            Debug.Log(args.text)
            -- Strip away prefix
            local message = FilterFirstKeyFromText(args.text, Options['Messages']['Communication']['Prefix'])

            -- Hardcoded for Assign message
            -- Todo: Should just grab first part to determine command before grabbing rest
            local _, _, command, itemTypeId, quality, playerName = string.find(message, '^(%a):(%d+):(%d+):(.*)$')
            
            -- Assign Command
            if command == 'A' then

                -- Okay, so there is no unique property that I can share, so I have to with what I got
                -- We have the itemTypeId and quality, two unique properties that are unlikely to be the exact same for two lootable entities in the world at once.
                -- Check all identified entities, pick the first match.
                -- Todo: If we don't find matching entity, attempt to identify
                local localItem = nil
                for num, item in ipairs(aIdentifiedLoot) do
                    Debug.Log('Checking if it is '..item.name..' with typeid '..tostring(item.itemTypeId)..' and quality '..tostring(item.quality))
                    if tostring(item.itemTypeId) == tostring(itemTypeId) and tostring(item.quality) == tostring(quality) then
                        localItem = item
                        Debug.Log('It is! Selected entityId: '..tostring(localItem.entityId))
                        break
                    end
                end

                -- If we don't know about this item we won't get info from it anyway, so just abort
                if localItem.entityId == nil then Debug.Error('Unable to find locally identified item that Squad Leader wants to assign.\nItemTypeId: '..tostring(itemTypeId)..'\nQuality: '..tostring(quality)) return end

                -- But if we do, loop dat shit
                local wasAssigned = false
                for num, member in ipairs(aSquadRoster.members) do

                    if namecompare(member.name, playerName) then
                        -- Because it matters yo
                        if IsAssigned(localItem.entityId) then
                            SendChatMessage('system', 'Squad Leader is reassigning '..FixItemNameTag(localItem.name, localItem.quality)..' from '..localItem.assignedTo..' to '..playerName)
                        end

                        -- Assign item
                        AssignItem(localItem.entityId, playerName)
                        wasAssigned = true
                        break
                    end
                end

                if not wasAssigned then Debug.Error('Attempted to heed assign command but couldn\'t find the squad member') end

                -- Exit eitherway, if we got this far shit's legit and we don't care about anything else.
                return
            end

        end


        -- If we are looking for roll decisions
        if mCurrentlyRolling and bIsSquadLeader then
            local rollType = nil
            args.text = string.lower(args.text)
            if args.text == 'n' or string.find(string.lower(args.text), '^nee+d$') ~= nil then
                rollType = RollType.Need
            elseif args.text == 'g' or string.find(string.lower(args.text), '^gree+d$') ~= nil then
                rollType = RollType.Greed
            elseif args.text == 'p' or args.text == 'pass' then
                rollType = RollType.Pass
            end

            if rollType ~= nil then
                RollDecision({author=args.author, rollType=rollType})
            end
        end
    end
end


--[[
    OnLootCollected(args)
    Callback for when someone loots something.
    Used to detect ninja lootaz!
    
]]--
function OnLootCollected(args)
    -- Requires Core and Detection enabled
    if not (Options['Core']['Enabled'] and Options['Detection']['Enabled']) then return end

    -- Requires args.itemTypeId, otherwise we can't get item info
    -- Fixme: Is this check needed? Is this error needed? Does it trigger on Powerups for example?
    if not args.itemTypeId then Debug.Error('OnLootCollected args.itemTypeId is nil') return end

    -- Get item info
    local itemInfo = Game.GetItemInfoByType(args.itemTypeId, Game.GetItemAttributeModifiers(args.itemTypeId, args.quality))

    if itemInfo.type == 'crafting_component' then
        Debug.Log('OnLootCollected - Crafting Component')
        Debug.Log('iteminfo')
        Debug.Table(itemInfo)
    end

    -- Is it loot that we care about?
    if IsTrackableItemType(itemInfo) then

        -- Debug Log
        if Options['Debug']['LogLootableCollection'] then
            Debug.Log('OnLootCollected')
            Debug.Log('iteminfo')
            Debug.Table(itemInfo)
        end


        -- Todo: Check if we have assigned any items, if not just skip to Claimed ?

        -- Okay, do we have any identified loot?
        if not _table.empty(aIdentifiedLoot) then

            -- Grab the first identified item that this item could be, checking that the entity is no longer available
            local loot = nil
            for num, item in ipairs(aIdentifiedLoot) do 
                if item.itemTypeId == args.itemTypeId and item.quality == args.quality then
                    if not Game.IsTargetAvailable(item.entityId) then
                        loot = item
                        break
                    end
                end
            end

            -- If we found the item, we will return from this function within this block after firing the appropriate event function.
            if loot ~= nil then

                -- If we care about this item, trigger relevant event
                local eventArgs = {lootedTo=args.lootedTo, assignedTo=loot.assignedTo, item=loot}

                -- If the item had not been assigned
                if loot.assignedTo == nil then
                    Component.GenerateEvent('XSLM_ON_LOOT_SNATCHED', eventArgs)

                -- Else if the item was looted by the person it was assigned to
                elseif namecompare(loot.assignedTo, args.lootedTo) then
                    Component.GenerateEvent('XSLM_ON_LOOT_RECEIVED', eventArgs)

                -- Else it was a ninja
                else
                    Component.GenerateEvent('XSLM_ON_LOOT_STOLEN', eventArgs)
                end

                -- End the function, we're done here.
                RemoveIdentifiedItem(loot)
                return

            end
        end

        -- This item wasn't being tracked.
        Component.GenerateEvent('XSLM_ON_LOOT_CLAIMED', {lootedTo=args.lootedTo, item={name=itemInfo.name, quality=args.quality}})
    end
end


--[[
    ItemPassesFilter(item, moduleOptions)
    Determines whether the provided itemInfo is sufficient to pass the provided moduleOptions.
    Where moduleOptions is for example Options['Detection']
]]--
function ItemPassesFilter(item, moduleOptions)
    -- Vars
    local typeKey = nil
    local stageKey = nil

    -- Determine type
    if item.itemInfo.type == 'crafting_component' then
        typeKey = 'CraftingComponents'

    elseif item.itemInfo.type == 'frame_module' or
           item.itemInfo.type == 'ability_module' or
           item.itemInfo.type == 'weapon' then
        typeKey = 'EquipmentItems'
    end

    -- Verify that type passes filter
    if typeKey ~= nil and moduleOptions[typeKey]['Enabled'] then
        -- Determine stage
        if moduleOptions[typeKey]['Mode'] == TriggerModeOptions.Simple then
            stageKey = 'Simple'
        else -- TriggerModeOptions.Advanced
            if        item.itemInfo.tier.level == 1 then stageKey = 'Stage1'
            elseif    item.itemInfo.tier.level == 2 then stageKey = 'Stage2'
            elseif    item.itemInfo.tier.level == 3 then stageKey = 'Stage3'
            elseif    item.itemInfo.tier.level == 4 then stageKey = 'Stage4'   
            end
        end
        if stageKey == nil then Debug.Error('ItemPassesFilter() does not recognize tier!', item.itemInfo.tier) end
        
        -- Verify that stage passes filter
        -- WontFixMe: Bluuurgh --------------------------| wtf this coder can't plan for shit
        if (stageKey == 'Simple' and item.itemInfo.tier.level >= tonumber(moduleOptions[typeKey]['Simple']['TierThreshold'])) 
        or moduleOptions[typeKey][stageKey]['Enabled'] then
            -- Determine quality threshold
            local qualityThreshold
            local option = moduleOptions[typeKey][stageKey]['QualityThreshold'] -- Just saving some characters~ :3

            if option == QualityOptions.Any then
                qualityThreshold = 0

            elseif option == QualityOptions.Custom then
                qualityThreshold = moduleOptions[typeKey][stageKey]['QualityThresholdCustomValue'] 

            elseif option == QualityOptions.Common then
                qualityThreshold = 1

            elseif option == QualityOptions.Uncommon then
                qualityThreshold = 401

            elseif option == QualityOptions.Rare then
                qualityThreshold = 701
                
            elseif option == QualityOptions.Epic then
                qualityThreshold = 901

            elseif option == QualityOptions.Legendary then
                qualityThreshold = 1000
            end

            -- Verify that quality passes threshold
            --Debug.Log(tostring(tonumber(item.quality))..' >= '..tostring(qualityThreshold))
            if tonumber(item.quality) >= qualityThreshold then
                -- Passed all filters
                return true
            end
        end
    end
    return false
end


--[[
    IsLootableTarget(targetInfo)
    Whether or not an entity target is lootable
]]--
function IsLootableTarget(targetInfo)
    -- By the current standards, anything that is interactToLoot is obviously something we want to track.
    if targetInfo.interactToLoot == true then
        return true
    else
        return false
    end
end

--[[
    IsTrackableItemType([itemInfo(table)|itemType])
    Whether or not an item (post pickup) was a lootable target (ish)
]]--
function IsTrackableItemType(info)
    -- Handle arguments
    local itemType
    if type(info) == 'table' then itemType = info.type
    else itemType = tostring(info) end

    -- Verify that the looted item is of a type that we care about
    if  itemType == 'frame_module' or
        itemType == 'ability_module' or
        itemType == 'weapon' or
        itemType == 'crafting_component' then
        return true
    end

    return false
end

--[[
    IsPastThreshold(quality)
    Returns true if quality is past current minimum threshold setting, false if below
    Eg 701+ returns true if setting is blue.
    At somepoint I'd like to delegate this logic to some API, this feels hackish.

]]--
function IsPastThreshold(quality)
    if quality == nil then Debug.Warn('IsPastThreshold called with nil quality') return false end
    if     Options['Distribution']['LootThreshold'] == 'any'    then return true
    elseif Options['Distribution']['LootThreshold'] == 'green'  and quality > 300   then return true
    elseif Options['Distribution']['LootThreshold'] == 'blue'   and quality > 700   then return true
    elseif Options['Distribution']['LootThreshold'] == 'purple' and quality > 900   then return true
    elseif Options['Distribution']['LootThreshold'] == 'orange' and quality == 1000 then return true end
    return false
end

--[[
    IsSquadLeader(player)
    Determine whether player is the current squad leader or not
]]--
function IsSquadLeader(localPlayer)
    if aSquadRoster.leader == nil then OnSquadRosterUpdate() end -- If we're doomed from the start, try to resolve
    if aSquadRoster.leader ~= nil then
        if namecompare(localPlayer, aSquadRoster.leader) then
            return true
        else
            return false
        end
    else
        Debug.Warn('IsSquadLeader called but we\'re forever alone! Returning false.')
        return false
    end
end

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
    Component.GenerateEvent('XLSM_ON_IDENTIFY', {item=loot})
end

--[[
    CreatePanel(targetInfo, itemInfo)
    Setsup and returns a panel object reference for loot from the info given
]]--
function CreatePanel(targetInfo, itemInfo)
    -- Create object
    local panel = LKObjects.Create(PANEL)

    panel.pos:SetParam('Translation', Vec3.New(targetInfo.lootPos.x, targetInfo.lootPos.y, targetInfo.lootPos.z+2))
    panel.pos:SetParam('Rotation', {axis={x=0,y=0,z=1},angle=0})


    local RenderTarget = panel.panel_rt
    local LOOT_PANEL_CONTENT = RenderTarget:GetChild('content')
    local LOOT_PANEL_HEADER = LOOT_PANEL_CONTENT:GetChild('Header')
    local LOOT_PANEL_ICONBAR = LOOT_PANEL_CONTENT:GetChild('IconBar')


    -- Header
    LOOT_PANEL_HEADER:GetChild('itemName'):SetText(FixItemNameTag(targetInfo.name, targetInfo.quality))

    local qualityColor, headerBarColor, itemNameColor
    if targetInfo.quality then
        qualityColor = LIB_ITEMS.GetResourceQualityColor(targetInfo.quality)
    else
        qualityColor = LIB_ITEMS.GetItemColor(itemInfo)
    end

    if Options['Panels']['ColorMode']['HeaderBar'] == ColorModes.MatchQuality then
        headerBarColor = qualityColor
    else -- ColorMode.Custom
        headerBarColor = Options['Panels']['ColorMode']['HeaderBarCustomValue'].tint
    end

    if Options['Panels']['ColorMode']['ItemName'] == ColorModes.MatchQuality then
        itemNameColor = qualityColor
    else -- ColorMode.Custom
        itemNameColor = Options['Panels']['ColorMode']['ItemNameCustomValue'].tint
    end

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
                ToolTip.Show(args.widget:GetTag())
            end);
            LOOT_PANEL_ICONBAR:GetChild('battleframeIcon'):GetChild('fb'):BindEvent("OnMouseLeave", function(args)
                ToolTip.Show(false)
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
            System.PlaySound(Options['Sounds']['OnAssignItem_ToMe'])
        end)

    BUTTON2 = Button.Create(RenderTarget:GetChild('content'):GetChild('ButtonRow'))
    BUTTON2:SetText('Greed')
    BUTTON2:Autosize('center')
    BUTTON2:Bind(function() 
            System.PlaySound(Options['Sounds']['OnAssignItem_ToMe'])
        end)

    BUTTON3 = Button.Create(RenderTarget:GetChild('content'):GetChild('ButtonRow'))
    BUTTON3:SetText('Pass')
    BUTTON3:Autosize('right')
    BUTTON3:Bind(function() 
            System.PlaySound(Options['Sounds']['OnAssignItem_ToMe'])
        end)

--]]

    -- We spent all this time building, best make sure it shows
    LOOT_PANEL_CONTENT:Show(true)


--xItemFormatting.PrintLines( xItemFormatting.getStatLines(itemInfo), TRACKER_TOOLTIP_YIELDS)

    return panel
end

--[[
    UpdatePanel(loot)
    Updates the state of a loot panel
]]--
function UpdatePanel(loot)

    ItemPassesFilter(loot, Options['Panels'])

    if loot.panel == nil then return end

    local RenderTarget = loot.panel.panel_rt
    local LOOT_PANEL_CONTENT = RenderTarget:GetChild('content')
    local LOOT_PANEL_HEADER = LOOT_PANEL_CONTENT:GetChild('Header')

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

            -- Debug.Log(RenderTarget:GetChild('content'):GetChild('Header'):GetChild('itemName'):GetTextDims()) -- To be used to detect when title wraps
            if loot.assignedTo == nil then
                LOOT_PANEL_HEADER:GetChild('itemAssignedTo'):SetText(Lokii.GetString('UI_AssignedTo_nil'))
                LOOT_PANEL_HEADER:GetChild('itemAssignedTo'):SetTextColor(Options['Panels']['Color']['AssignedTo']['Nil'].tint)

                if Options['Panels']['Display']['AssignedToHideNil'] then
                    LOOT_PANEL_HEADER:GetChild('itemAssignedTo'):Show(false)
                else
                    LOOT_PANEL_HEADER:GetChild('itemAssignedTo'):Show(true)
                end

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


--[[
    IsIdentified(entityId)
    Whether or not an entity has been found and identified before
]]--
function IsIdentified(entityId)
    if aIdentifiedLoot ~= nil and not _table.empty(aIdentifiedLoot) then
        for num, item in ipairs(aIdentifiedLoot) do 
            if item.entityId == entityId then
                return true
            end
        end
    end
    return false
end

--[[
    GetIdentifiedItem(entityId)
    Takes the entityId of an already Identify:ed item, returning the item data.    
]]--
function GetIdentifiedItem(entityId)
    if aIdentifiedLoot ~= nil then
        for num, item in ipairs(aIdentifiedLoot) do 
            if item.entityId == entityId then 
                return item
            end
        end
        Debug.Warn('GetIdentifiedItem called but didn\'t find any item with a matching entityId')
    else
        Debug.Warn('GetIdentifiedItem called but we don\'t have any identified items')
    end
    return false
end

--[[
    IsAssigned(entityId)
    Whether or not given entityId is an Identified Item that has been assigned to a player
]]--
function IsAssigned(entityId)
    if aIdentifiedLoot ~= nil then
        for num, item in ipairs(aIdentifiedLoot) do 
            if item.entityId == entityId and item.assignedTo ~= nil then
                return true
            end
        end
    end

    return false
end

--[[
    RemoveIdentifiedItem(item)
    Removes an identified item from the table, making sure to clean up all the potential references
]]--
function RemoveIdentifiedItem(loot)
    if loot == nil then Debug.Error('RemoveIdentifiedItem called without an item') return end

    -- Remove from list of identified items
    local wasRemoved = false
    for num, item in ipairs(aIdentifiedLoot) do 
        if item.entityId == loot.entityId then 
            table.remove(aIdentifiedLoot, num)
            wasRemoved = true
            break
        end
    end
    if not wasRemoved then Debug.Warn('RemoveIdentifiedItem didn\'t find the item in the list of identified items! Item was: '..tostring(loot.name)..' with entityId '..tostring(loot.entityId)) end

    -- Kill despawn alarm
    loot.timer:KillAlarm('despawn')

    -- Kill timer
    loot.timer:Destroy()

    -- If currently rolling for this item, kill the roll
    if mCurrentlyRolling == loot.entityId then RollCancel() end

    -- Kill the panel object
    if loot.panel ~= nil then
        LKObjects.Destroy(loot.panel)
    end

    -- Kill the map waypoint
    if loot.waypoint ~= nil then
        loot.waypoint:ShowOnHud(false)
        loot.waypoint:ShowOnWorldMap(false)
        loot.waypoint:Destroy()
    end

    UpdateTracker()
end

--[[
    DistributeItem
    Main logic.
]]--
function DistributeItem()
    -- Check that we are allowed to distribute loot
    if not bIsSquadLeader or not Options['Core']['Enabled'] then return end

    -- Check that we have any loot at all
    if not _table.empty(aIdentifiedLoot) then

        -- Get the first unrolled item from the list of identified loot
        local loot = nil

        for num, item in ipairs(aIdentifiedLoot) do 
            if not IsAssigned(item.entityId) and IsPastThreshold(item.quality) then 
                loot = item
                break
            end
        end

        if loot ~= nil then

            local weightedRoster = GetEntitled(loot)

            -- Random looting mode
            if Options['Distribution']['LootMode'] == 'random' then
                local winner = weightedRoster[math.random(#weightedRoster)].name

                OnDistributeItem({item=loot})
                AssignItem(loot.entityId, winner)

            -- dice looting mode
            elseif Options['Distribution']['LootMode'] == 'dice' then
                local highest = nil
                local winner = ''
                local rolls = {}
                -- Roll for each member in order to determine winner
                for num, member in ipairs(weightedRoster) do

                    -- Calc roll
                    roll = math.random(Options['Distribution']['RollMin'], Options['Distribution']['RollMax'])

                    -- Determine if highest roll
                    if highest == nil -- First roll automatically becomes the highest 
                    or roll > highest -- Subsequent rolls must be larger than the highest in order to become the highest (Yeah!)
                    then
                        highest = roll
                        winner = member.name -- Determine winner as we roll
                    end

                    -- Append to rolls table
                    table.insert(rolls, {roll=roll, rolledBy=member.name})
                end

                OnDistributeItem({item=loot, rolls=rolls})
                AssignItem(loot.entityId, winner)

            -- round-robin looting mode
            elseif Options['Distribution']['LootMode'] == 'round-robin' then
                
                Debug.Log('Round Robin')
                Debug.Log('iRoundRobinIndex: '..tostring(iRoundRobinIndex))
                Debug.Log('#aSquadRoster.members: '..tostring(#aSquadRoster.members))
                local winner = ''
                -- Determine winner
                for num, member in ipairs(aSquadRoster.members) do
                    if num == iRoundRobinIndex then
                        winner = aSquadRoster.members[iRoundRobinIndex].name
                        Debug.Log('Squad Member '..tostring(num)..', '..tostring(winner)..' is the winner.')
                        break
                    end
                end

                -- Setup for next winner
                Debug.Log('Setting up for next winner, should index be reset?')
                if iRoundRobinIndex + 1 > #aSquadRoster.members then
                    Debug.Log('true')
                    iRoundRobinIndex = 1
                    Debug.Log('Reseting iRoundRobinIndex to '..tostring(iRoundRobinIndex))
                else
                    Debug.Log('false')
                    iRoundRobinIndex = iRoundRobinIndex + 1
                    Debug.Log('Increasing iRoundRobinIndex to '..tostring(iRoundRobinIndex))
                end

                -- Distribute
                OnDistributeItem({item=loot})
                AssignItem(loot.entityId, winner)
            elseif Options['Distribution']['LootMode'] == 'need-before-greed' then

                -- Check that we're not busy rolling something else
                if mCurrentlyRolling then
                    OnRollBusy({item=loot})
                    return
                end

                -- Okay, lock us down while we roll
                mCurrentlyRolling = loot

                -- Use a list from the global scope to store data for this roll
                aCurrentlyRolling = aSquadRoster.members

                Debug.Log('Pre Setup: ')
                Debug.Log('aCurrentlyRolling')
                Debug.Table(aCurrentlyRolling)
                Debug.Log('weightedRoster')
                Debug.Table(weightedRoster)

                -- Prep roll list
                local eligibleNames = '' -- used for output later on, comma separated string of names eligible for need

                for num, row in ipairs(aCurrentlyRolling) do
                    -- Setup new fields
                    row.hasRolled = false
                    row.rollType = false
                    row.rollValue = nil
                    row.canNeed = false

                    -- Determine if this person can need under current weighting settings
                    for i, v in ipairs(weightedRoster) do
                        if namecompare(row.name, v.name) then
                            row.canNeed = true

                            if eligibleNames ~= '' then
                                eligibleNames = eligibleNames..', '..row.name
                            else
                                eligibleNames = row.name
                            end
                        end
                    end
                end

                if eligibleNames == '' then eligibleNames = Lokii.GetString('UI_Messages_Distribution_NobodyEligible') end

                -- Start roll timeout timer
                mCurrentlyRolling.timer:SetAlarm('roll_timeout', mCurrentlyRolling.timer:GetTime() + Options['Distribution']['RollTimeout'], RollTimeout, {item=loot})

                -- Announce that we're rolling
                OnAcceptingRolls({item=loot, eligibleNames=eligibleNames})

            end
        else
            Debug.Log(Lokii.GetString('UI_Messages_System_NoRollableForDistribute'))
        end
    else
        Debug.Log(Lokii.GetString('UI_Messages_System_NoIdentifiedForDistribute'))
    end
end

--[[
    RollTimeout(args)
    Behavior for when a roll has timed out.
    Triggered by timer alarm when a roll has timed out.
]]--
function RollTimeout(args)
    if mCurrentlyRolling then
        SendSystemMessage('RollTimeout for '..mCurrentlyRolling.name)
        RollFinish()
    end
end

--[[
    RollCancel(args)
    Behavior for when a roll is cancelled.
    Calls neccesary functions to clean up.
]]--
function RollCancel(args)
    if mCurrentlyRolling then
        SendSystemMessage('RollCancel for '..mCurrentlyRolling.name)
        RollCleanup()
    end
end

--[[
    RollCleanup()
    Resets roll variables so that we are ready to start a new roll.
]]--
function RollCleanup()
    if mCurrentlyRolling then
        mCurrentlyRolling.timer:KillAlarm('roll_timeout')
        Debug.Log('RollCleanup killing roll timeout alarm')
        mCurrentlyRolling = false
        aCurrentlyRolling = {}
    end
end


--[[
    RollDecision(args)
    Called by OnChatMessage when somebody declares their rolltype (if there is an active roll)
    Checks that author is eligible for rolltype, corrects it if not and then stores rolltype in list of rolls.

    Calls RollFinish() If the roll declaration is the final one
    Calls OnRollChange if the rolltype is changed (because author was not eligible for the rollType)
    Calls OnRollAccept when the rolltype is saved to the list of rolls
]]--
function RollDecision(args)

    if mCurrentlyRolling then 
        -- Let's see if the author is actually allowed to roll
        local totalRemaining = 0
        local needRemaining = 0
        -- Go through all the people who can roll
        for num, row in ipairs(aCurrentlyRolling) do
            -- If we've found the person who sent this message and he has not yet selected rollType
            if args.author == row.name and row.rollType == false then
                -- If he wants to roll need but isn't allowed to, change his roll to greed (y bastard)
                if args.rollType == RollType.Need and row.canNeed == false then
                    args.rollType = RollType.Greed
                    OnRollChange({rollType=args.rollType, playerName=args.author})
                end

                -- Set the roll type and acknowledge
                row.rollType = args.rollType
                OnRollAccept({rollType=args.rollType, playerName=args.author})
            end

            -- If the rollType is not yet set, this is a person who has yet to roll
            if row.rollType == false then 
                totalRemaining = totalRemaining + 1

                -- If this user can need roll, this is a person who has yet to roll and could need
                if row.canNeed then
                    needRemaining = needRemaining + 1
                end

            end

        end

        -- If this was the last call needed, do rolls
        if totalRemaining == 0 or needRemaining == 0 then
            RollFinish()
        end
    end
end

--[[
    RollFinish()
    Executes rolls, determines winner, assigns item, cleans up.
]]--
function RollFinish()

    if mCurrentlyRolling then
        mCurrentlyRolling.timer:KillAlarm('roll_timeout') -- Prevent timeout callback
        Debug.Log('RollFinish killing roll timeout alarm')

        -- Declare vars
        local winner = ''
        local highest = nil
        local rolls = {}

        -- Figure out if someone has need rolled, and set any un-decided roll types to the default
        local someoneHasNeeded = false
        for num, row in ipairs(aCurrentlyRolling) do
            if row.rollType == RollType.Need then
                someoneHasNeeded = true
            elseif row.rollType == false then
                row.rollType = Options['Distribution']['RollTypeDefault']
            end
        end

        -- Go through rolls
        for num, row in ipairs(aCurrentlyRolling) do
            -- Inverted logic because Lua doesn't have continue
            -- Skip greed rolls if someone has needed, as well as any pass rolls
            if not(someoneHasNeeded and row.rollType == RollType.Greed) and not (row.rollType == RollType.Pass or row.rollType == false) then

                -- Calc roll
                roll = math.random(Options['Distribution']['RollMin'], Options['Distribution']['RollMax'])

                -- Determine if highest roll
                if highest == nil -- First roll automatically becomes the highest 
                or roll > highest -- Subsequent rolls must be larger than the highest in order to become the highest (Yeah!)
                then
                    highest = roll
                    winner = row.name -- Determine winner as we roll
                end

                -- Append to rolls table
                table.insert(rolls, {roll=roll, rolledBy=row.name})

            end
            
        end

        if next(rolls) == nil then
            OnRollNobody({item=mCurrentlyRolling})
            mCurrentlyRolling.assignedTo = true -- Fixme: wtf
        else
            OnDistributeItem({item=mCurrentlyRolling, rolls=rolls})
            AssignItem(mCurrentlyRolling.entityId, winner)
        end

        -- Update loot panels
        UpdatePanel(mCurrentlyRolling)

        -- Clean up after this roll
        RollCleanup()

        -- If auto distribute start next roll
        if Options['Distribution']['AutoDistribute'] then DistributeItem() end

    else
        Debug.Warn('RollFinish but not currently rolling')
    end
end

--[[
    AssignItem(loot, winner)
    Assigns an item to a player.
]]--
function AssignItem(entityId, winner)
    if aIdentifiedLoot ~= nil then
        for num, item in ipairs(aIdentifiedLoot) do 
            if item.entityId == entityId then
                item.assignedTo = winner
                OnAssignItem({item=item, assignedTo=winner, playerName=winner})
                return
            end
        end
    end
    Debug.Warn('AssignItem failed to assign item :( '..tostring(entityId)..' to '..winner)
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
            SendSystemMessage(args.item.name..' has not despawned yet, reseting despawn timer')
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

--[[
    GetEntitled(loot)
    Returns a list of people able to roll for loot under the current loot weighing settings
]]--
function GetEntitled(loot)
    if Options['Distribution']['LootWeighting'] ~= 'disabled' then 
        local entitledRoster = {}
        local itemArchetype, itemFrame = DWFrameIDX.ItemIdxString(tostring(loot.craftingTypeId))

        --if Options['Distribution']['LootWeighting'] == 'frame' then
        --end
        --if Options['Distribution']['LootWeighting'] == 'archetype' or #entitledRoster == 0 then
            for num, member in ipairs(aSquadRoster.members) do
                if member.battleframe == itemArchetype then
                    table.insert(entitledRoster, member)
                end
            end
        --end

        if #entitledRoster > 0 then
            return entitledRoster
        end
    end
    return aSquadRoster.members
end


--[[
    ListUnAssigned()
    Shitty function for chat command, lists identified items that can be rolled based on whether or not they've been assigned.
    This functionality should be replaced by the UI tracker but may come in handy for loot master mode.
]]--
function ListUnAssigned()
    if not _table.empty(aIdentifiedLoot) then
        Debug.Table(aIdentifiedLoot)
        local unAssignedLoot = {}

        for num, item in ipairs(aIdentifiedLoot) do 
            vardump(item)
            if not IsAssigned(item.entityId) then
                table.insert(unAssignedLoot, item)
            end
        end

        if unAssignedLoot ~= nil then
            for num, item in ipairs(unAssignedLoot) do
                SendSystemMessage(num..' '..item.name..tostring(item.quality))
            end
        else
            SendSystemMessage(Lokii.GetString('UI_Messages_System_NoRollableForDistribute'))
        end
    else
        SendSystemMessage(Lokii.GetString('UI_Messages_System_NoIdentifiedForDistribute'))
    end
end

function UpdateTrackerTooltip(entityId)
    -- Get info
    local item = GetIdentifiedItem(tonumber(entityId))
    if item == nil then Debug.Error('UpdateTrackerTooltip unable to get identified item') end

    -- Refs
    local TRACKER_TOOLTIP_HEADER = TRACKER_TOOLTIP:GetChild("header")
    local TRACKER_TOOLTIP_ICON = TRACKER_TOOLTIP:GetChild("header.icon")
    local TRACKER_TOOLTIP_NAME = TRACKER_TOOLTIP:GetChild("header.name")
    local TRACKER_TOOLTIP_SUBNAME = TRACKER_TOOLTIP:GetChild("header.subname")
    local TRACKER_TOOLTIP_YIELDS = TRACKER_TOOLTIP:GetChild("yields")
    local TRACKER_TOOLTIP_REQS = TRACKER_TOOLTIP:GetChild("requirements")
    local TRACKER_TOOLTIP_DESC= TRACKER_TOOLTIP:GetChild("desc")


    -- Icon
    if item.itemInfo.web_icon then
        TRACKER_TOOLTIP_ICON:SetUrl(item.itemInfo.web_icon)
        TRACKER_TOOLTIP_ICON:Show(true)
    else
        TRACKER_TOOLTIP_ICON:Show(false)
    end
    
    -- Name
    TRACKER_TOOLTIP_NAME:SetText(FixItemNameTag(item.itemInfo.name, item.itemInfo.quality))
    TRACKER_TOOLTIP_NAME:SetTextColor(item.itemInfo.rarity)

    -- Fixme: This should be "if itemtype == equipment items" or something.
    -- Equipment Items
    if item.itemInfo.type ~= 'crafting_component' then

        -- Stats
        xItemFormatting.PrintLines(xItemFormatting.getStatLines(item.itemInfo), TRACKER_TOOLTIP_YIELDS)

        -- Requirements
        xItemFormatting.PrintLines(xItemFormatting.getRequirementLines(item.itemInfo), TRACKER_TOOLTIP_REQS)

        -- Description
        TRACKER_TOOLTIP_DESC:SetText(item.itemInfo.description)

    -- Crafting Components
    else
        -- Stats
        xItemFormatting.PrintLines(xItemFormatting.getStatLines(item.itemInfo), TRACKER_TOOLTIP_YIELDS)

        -- Requirements
        xItemFormatting.PrintLines(xItemFormatting.getRequirementLines(item.itemInfo), TRACKER_TOOLTIP_REQS)

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
                TRACKER_TOOLTIP_DESC:SetText(value.description)
                break
            end
        end


    end


    -- Fix text size
    local function AutosizeText(TEXT)
        TEXT:SetDims("top:_; height:"..(TEXT:GetTextDims().height+20))
    end
    
    AutosizeText(TRACKER_TOOLTIP_YIELDS)
    AutosizeText(TRACKER_TOOLTIP_REQS)
    AutosizeText(TRACKER_TOOLTIP_DESC)

    -- Return ToolTip
    local tip_args = {height=0}
    tip_args.height = TRACKER_TOOLTIP:GetLength()
    tip_args.frame_color = item.itemInfo.rarity
    
    return TRACKER_TOOLTIP, tip_args
end


--[[
    UpdateTracker()
    Updates the UI tracker view.
]]--
function UpdateTracker()
    --Debug.Log('UpdateTracker')
    -- Only update and show tracker if enabled
    if Options['Tracker']['Enabled'] then

        local cTrackerEntrySize = 30 -- Fixme: Wat
        local cTrackerButtonSize = 25 -- Fixme: Explain
       
        -- Hide tooltip if is currently being displayed
        if bToolTipActive then
            ToolTip.Show(false)
            TRACKER_TOOLTIP:Show(false) -- No need to display tooltip info now.
        end

         -- Update List of tracked items
        RemoveAllChildren(TRACKER:GetChild('List')) -- clear previous entries
        if not _table.empty(aIdentifiedLoot) then
            for num, item in ipairs(aIdentifiedLoot) do
                if ItemPassesFilter(item, Options['Tracker']) then

                    -- Create widget
                    local ENTRY = Component.CreateWidget("Tracker_List_Entry", TRACKER:GetChild('List'))
                    ENTRY:SetDims('top:0; left:0; width:100%; height:'..cTrackerEntrySize..';');

                    ENTRY:GetChild('plate'):SetTag(tostring(item.entityId))
                    
                    ENTRY:GetChild('plate'):BindEvent("OnMouseEnter", function(args)
                        TRACKER_TOOLTIP:Show(true)
                        ToolTip.Show(UpdateTrackerTooltip(args.widget:GetTag()))
                        bToolTipActive = true

                    end);
                    ENTRY:GetChild('plate'):BindEvent("OnMouseLeave", function(args)
                        TRACKER_TOOLTIP:Show(false)
                        ToolTip.Show(false)
                        bToolTipActive = false
                    end);
                    

                    ENTRY:GetChild('plate'):GetChild('outer'):SetParam("tint", LIB_ITEMS.GetResourceQualityColor(item.quality))
                    ENTRY:GetChild('plate'):GetChild('shade'):SetParam("tint", LIB_ITEMS.GetResourceQualityColor(item.quality))
                    ENTRY:GetChild('item'):GetChild('outer'):SetParam("tint", LIB_ITEMS.GetResourceQualityColor(item.quality))
                    ENTRY:GetChild('item'):GetChild('shade'):SetParam("tint", LIB_ITEMS.GetResourceQualityColor(item.quality))

                    -- Icon
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
                    if item.assignedTo == nil then
                        ENTRY:GetChild('leftBar'):GetChild('buttons'):Show(true)
                        ENTRY:GetChild('leftBar'):GetChild('assignedTo'):Show(false)
                    else
                        ENTRY:GetChild('leftBar'):GetChild('buttons'):Show(false)
                        ENTRY:GetChild('leftBar'):GetChild('assignedTo'):Show(true)
                    end

                    ENTRY:GetChild('itemName'):Show(true)
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
        or (Options['Tracker']['Visibility'] == TrackerVisibilityOptions.MouseMode and bCursor)
        then
            --Debug.Log('Yes, display the tracker')
            -- Yes, display tracker
            TRACKER:Show(true)
        else
            --Debug.Log('No, hide the tracker')
            -- No, hide the tracker
            TRACKER:Show(false)

            -- Ensure no tooltip is displayed
            TRACKER_TOOLTIP:Show(false)
            ToolTip.Show(false)
            bToolTipActive = false
        end

    -- Tracker not enabled, so do nothing but make sure it's hidden.
    else
        --Debug.Log('Tracker not enabled, hide')
        -- Hide tracker
        TRACKER:Show(false)

        -- Ensure no tooltip is displayed
        TRACKER_TOOLTIP:Show(false)
        ToolTip.Show(false)
        bToolTipActive = false
    end
end

--[[
    SendChatMessage(channel, message, [alert])
    For normal chat messages.
]]--
function SendChatMessage(channel, message, alert)
    -- Requires that Core and Messages are Enabled
    if not (Options['Core']['Enabled'] and Options['Messages']['Enabled']) then return end

    -- Requires that you are the squad leader in order to send messages on squad channel
    if channel == 'squad' and not bIsSquadLeader then return end

    -- Handle optional arguments
    alert = alert or false

    -- Setup prefixe
    local prefix = Options['Messages']['Prefix']

    -- Function to handle the actual sending of messages
    local function SendMessageToChat(channel, message, alert)
        channel = string.lower(channel)
        local alertprefix = ''
        if alert then alertprefix = '!' end
        if channel == 'system' then
            ChatLib.SystemMessage({text=message})
        elseif channel == 'notification' or channel == 'notifications' then
            ChatLib.Notification({text=message})
        else
            Chat.SendChannelText(channel, alertprefix..message)
        end
    end

    -- Calculate message content length limit
    local messageContentLengthLimit = ciSquadMessageLengthLimit - string.len(Options['Messages']['Prefix'])

    -- If the message is to long to send in one go, attempt to split lines into multiple messages
    if string.len(message) > messageContentLengthLimit then
        -- Explode the message on each new line
        local messages = explode('\n', message)
        local currentMessage = ''

        -- For each line in the message
        for num, line in ipairs(messages) do
            Debug.Log(tostring(num)..' : Length: '..string.len(message)..'/'..tostring(messageContentLengthLimit)..' : Line: '..line)
            Debug.Log('Message: '..currentMessage)

            -- Warn if line is too long
            if string.len(line) > messageContentLengthLimit then 
                Debug.Warn('Unable to properly accommodate for message length, too many characters on line '..tostring(num))
            end

            -- On the very first iteration, just add message
            if currentMessage == '' then
                currentMessage = line

            -- On subsequent iterations, we're gonna do some shit
            else
                -- If adding the next line exceeds the character limit
                if string.len(currentMessage..'\n'..line) > messageContentLengthLimit then
                    -- Send the current line and start a new message for the next line
                    SendMessageToChat(channel, prefix..currentMessage, alert)
                    currentMessage = line

                -- Otherwise
                else
                    -- Add the next line to the current line
                    currentMessage = currentMessage..'\n'..line
                end
            end
        end
        -- Make sure we send the last message
        if currentMessage ~= '' then SendMessageToChat(channel, prefix..currentMessage, alert) end

    -- Otherwise, send message normally
    else
        Debug.Log('Sending Chat Message: '..prefix..message)
        Debug.Log('Message Length: '..string.len(prefix..message))
        SendMessageToChat(channel, prefix..message, alert)
    end
end

--[[
    CommunicationEvent(type, eventArgs)
    For addon-to-addon communication events.
--]]
function CommunicationEvent(type, eventArgs)
    -- Requires that Core and Messages are Enabled
    if not (Options['Core']['Enabled'] and Options['Messages']['Enabled']) then return end

    -- Requires that you are the squad leader
    if not bIsSquadLeader then return end

    -- Requires that args.type is supplied
    if args.type == nil then 
        Debug.Error('CommunicationEvent called without a type supplied')
        return
    end

    -- Warn if custom communication settings are enabled
    if Options['Communication']['Custom'] then
        Debug.Warn('Custom Communication Settings are enabled')
    end

    -- Requires that this communication message is enabled
    if not Options['Messages']['Communication'][type]['Enabled'] then return end

    -- Send message
    Chat.SendChannelText('squad', Options['Messages']['Communication']['Prefix']..RunMessageFilters(Options['Messages']['Communication'][type]['Format'], eventArgs))
end

--[[
    MessageEvent(eventClass, eventName, eventArgs, [canSend])
    Generic function used to handle the process of sending messages in response to events, based on specific options.
    Use the optional canSend argument to override bIsSquadLeader when determining whether or not to do anything.
--]]
function MessageEvent(eventClass, eventName, eventArgs, canSend)
    canSend = canSend or bIsSquadLeader
    if canSend and Options['Messages']['Events'][eventClass][eventName]['Enabled'] then
        for channelKey, channelValue in pairs(Options['Messages']['Events'][eventClass][eventName]['Channels']) do
            if Options['Messages']['Events'][eventClass][eventName]['Channels'][channelKey]['Enabled'] then
                local message = RunMessageFilters(Options['Messages']['Events'][eventClass][eventName]['Channels'][channelKey]['Format'], eventArgs)

                if eventArgs.rolls and eventArgs.item and Options['Messages']['Events']['Distribution']['OnRolls']['Enabled'] then
                    message = message..'\n'..RollsFormater(Options['Messages']['Events']['Distribution']['OnRolls']['Format'], eventArgs.rolls, eventArgs.item)
                end

                SendChatMessage(channelKey, message, eventArgs)              
            end
        end
    end
end

--[[
    RollFormater
    Helper function to generate the proper format for multi-line roll messages
]]--
function RollsFormater(format, rolls, item)
    local message = ''
    for num, row in ipairs(rolls) do
        if message ~= '' then
            message = message..'\n'..RunMessageFilters(format, {roll=row.roll, playerName=row.rolledBy, item=item})
        else
            message = RunMessageFilters(format, {roll=row.roll, playerName=row.rolledBy, item=item})
        end
    end
    return message
end

--[[
    RunMessageFilters(message, args)
    Runs gsub filters for message formats.
    Pretty poorly implemented at the moment.
]]--
function RunMessageFilters(message, args)
    -- Fix undefined arguments
    args.item                = args.item or {}
    args.item.name           = args.item.name               or 'NOT_SET'
    args.item.quality        = args.item.quality            or 'NOT_SET'
    args.item.entityId       = args.item.entityId           or 'NOT_SET'
    args.item.itemTypeId     = args.item.itemTypeId         or 'NOT_SET'
    args.item.craftingTypeId = args.item.craftingTypeId     or 'NOT_SET'
    args.playerName          = args.playerName              or 'NOT_SET'
    args.roll                = args.roll                    or 'NOT_SET'
    args.rollType            = args.rollType                or 'NOT_SET'
    args.lootedTo            = args.lootedTo                or 'NOT_SET'
    args.assignedTo          = args.assignedTo              or 'NOT_SET'
    args.eligible            = args.eligibleNames           or 'NOT_SET'

    -- Create local mixes
    local itemNameQuality = FixItemNameTag(args.item.name, args.item.quality)

    -- Adjust item name
    local itemNameClean = FixItemNameTag(args.item.name)

    -- Archetype/Frame replacements
    local itemForArchetype, itemForFrame = 'NOT_SET'
    if args.item.craftingTypeId ~= 'NOT_SET' then
        itemForArchetype, itemForFrame = DWFrameIDX.ItemIdxString(args.item.craftingTypeId)
    end

    -- Start building the output
    local output = message

    -- Loot mode
    output = string.gsub(output, '%%m', Options['Distribution']['LootMode'])

    -- Item name with quality
    output = string.gsub(output, '%%iq', itemNameQuality)

    -- Item name
    output = string.gsub(output, '%%i', itemNameClean)

    -- Item quality
    output = string.gsub(output, '%%q', args.item.quality)

    -- Item entityId
    output = string.gsub(output, '%%eId', tostring(args.item.entityId))

    -- Item itemTypeId
    output = string.gsub(output, '%%tId', tostring(args.item.itemTypeId))

    -- Item craftingTypeId
    output = string.gsub(output, '%%cId', tostring(args.item.craftingTypeId))

    -- Item For Archetype
    output = string.gsub(output, '%%fA', itemForArchetype)

    -- Item For Frame
    output = string.gsub(output, '%%fF', itemForFrame)

    -- Player name
    output = string.gsub(output, '%%n', args.playerName)

    -- Roll
    output = string.gsub(output, '%%r', args.roll) 

    -- Roll type
    output = string.gsub(output, '%%t', args.rollType) 

    -- Looted To
    output = string.gsub(output, '%%l', args.lootedTo) 

    -- Assigned To
    output = string.gsub(output, '%%a', args.assignedTo)

    -- Eligible (super hardcoded)
    output = string.gsub(output, '%%e', args.eligibleNames)

   return output
end

--[[
    FixItemNameTag(name, quality)
    Firefall sometimes returns item names with ^Q in the name, which is supposed to be replaced with the item quality wherever it is used.
    This is a cheeky helper function to resolve this.
    Name must be provided. If quality is provided, replaces ^Q with quality. If not, removes ^Q. In either case, and regardless of whether ^Q is actually present, returns a possibly fixed name.

]]--
function FixItemNameTag(name, quality)
    quality = quality or ''

    if quality ~= ' ' then quality = ' '..quality end

    return string.gsub(name, '%^Q', tostring(quality))
end


--[[
    OnIdentify(args)
    Callback for when a new item is identified.
    args.loot - the newly identified item
    We use this to start automatic item distribution
]]--
function OnIdentify(args)
    -- Require Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Update the tracker
    UpdateTracker()

    -- Update the panel
    UpdatePanel(args.item)

    -- Play Sound
    -- Todo: SoundEvent
    if not Options['Sounds']['Mute'] and Options['Sounds']['OnIdentify'] then
        System.PlaySound(Options['Sounds']['OnIdentify'])
    end

    -- Messages
    MessageEvent('Detection', 'OnIdentify', args)

    -- Squad Leader only stuff
    if bIsSquadLeader then
        -- If auto distribute is enabled, distribute the item
        if Options['Distribution']['AutoDistribute'] then
            DistributeItem()
        end
    end
end

--[[
    OnLootDespawn(args)
]]--
function OnLootDespawn(args)
    -- Require Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Update the tracker
    UpdateTracker() -- Fixme: Is this call needed

    -- Messages
    MessageEvent('Detection', 'OnLootDespawn', args)
end

--[[
    OnLootReceived(args)
]]--
function OnLootReceived(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Messages
    MessageEvent('Detection', 'OnLootReceived', args)
end

--[[
    OnLootStolen(args)
]]--
function OnLootStolen(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Messages
    MessageEvent('Detection', 'OnLootStolen', args)
end

--[[
    OnLootSnatched(args)
]]--
function OnLootSnatched(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Messages
    MessageEvent('Detection', 'OnLootSnatched', args)
end

--[[
    OnLootClaimed(args)
]]--
function OnLootClaimed(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Messages
    MessageEvent('Detection', 'OnLootClaimed', args)
end

--[[
    OnDistributeItem(args)
]]--
function OnDistributeItem(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Messages
    MessageEvent('Distribution', 'OnAssignItem', args)
end

--[[
    OnAssignItem(args)
    args.assignedTo
    args.item
]]--
function OnAssignItem(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Update tracker
    UpdateTracker()

    -- Update panel
    UpdatePanel(args.item)

    -- Play Sound
    if not (Options['Sounds']['Enabled'] and Options['Sounds']['Mute']) then
        -- If assigned to me
        if namecompare(args.assignedTo, Player.GetInfo()) then
            System.PlaySound(Options['Sounds']['OnAssignItemToMe'])

        -- Else
        else
            System.PlaySound(Options['Sounds']['OnAssignItemToOther'])
        end
    end

    -- Fiddle with the waypoint
    if Options['Waypoints']['Enabled'] and namecompare(args.assignedTo, Player.GetInfo()) then
        if Options['Waypoints']['TrailAssigned'] then
            args.item.waypoint:ShowTrail(true)
        end
        if Options['Waypoints']['PingAssigned'] then
            args.item.waypoint:Ping()
        end
    end

    -- Communicate Assign Item
    CommunicationEvent('Assign', args)

    -- Messages
    MessageEvent('Distribution', 'OnAssignItem', args)
end

--[[
    OnAcceptingRolls(args)
]]--
function OnAcceptingRolls(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Messages
    MessageEvent('Distribution', 'OnAcceptingRolls', args)
end

--[[
    OnRollAccept(args)
]]--
function OnRollAccept(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Messages
    MessageEvent('Distribution', 'OnRollAccept', args)
end

--[[
    OnRollChange(args)
]]--
function OnRollChange(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Messages
    MessageEvent('Distribution', 'OnRollChange', args)
end

--[[
    OnRollBusy(args)
]]--
function OnRollBusy(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Messages
    MessageEvent('Distribution', 'OnRollBusy', args)
end

--[[
    OnRollNobody(args)
]]--
function OnRollNobody(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Messages
    MessageEvent('Distribution', 'OnRollNobody', args)
end




-- Shitty stuff below

function itemPrefixShortener(itemName)

    -- Keys to prefix
    -- Lua sorts these differently than inputed
    local prefixes = {
        ['Surplus'] = 'S.',
        ['Recovered'] = 'R.',
        ['Chosen'] = 'C.',
        ['Accord'] = 'A.',
        ['Accord Prototype'] = 'A.P.',
        ['Accord Elite'] = 'A.E.',
    }

    --Debug.Table(prefixes)

    for key, prefix in pairs(prefixes) do
        --Debug.Log('Checking for '..key..' in '..itemName)
        if string.find(itemName, key, 0, string.len(key)) then
            --Debug.Log('Found '..key..' in '..itemName..', replacing with '..prefix)
            itemName = prefix..string.sub(itemName, string.len(key) + 1)
            break
        end
    end

    return itemName
end



--[[
    RemoveAllChildren(PARENT)
    UI Helper function, removes children of a frame node~
]]--
function RemoveAllChildren(PARENT)
    for i = PARENT:GetChildCount(), 1, -1 do
        Component.RemoveWidget(PARENT:GetChild(i))
    end
end



--[[
    ToggleEnabled(cmd)
    Toggles whether xSquadLootManager is enabled.
    If cmd == disable, sets Enabled to false
    If cmd == toggle, inverts Enabled
    Any other value sets Enabled to true
]]--
function ToggleEnabled(cmd)

    local newStatus = true

    if cmd == 'disable' then
        newStatus = false
    elseif cmd == 'toggle' then
        newStatus = not Options['Core']['Enabled']
    end

    OnOptionChange({'Core_Enabled', newStatus})
end

--[[
    ClearIdentified()
    Clears the aIdentifiedLoot list.
]]--
function ClearIdentified()

    RollCancel()

    -- YOLO
    while not _table.empty(aIdentifiedLoot) do
        for num, item in ipairs(aIdentifiedLoot) do 
            RemoveIdentifiedItem(item)
        end
    end
    --aIdentifiedLoot = {}
    
    UpdateTracker()
end


--[[
    Test()
    Testing function please ignore
]]--
function Test()
    SendChatMessage('system', 'Test')

    Debug.Log('test')
    Debug.Log('bIsSquadLeader: '..tostring(bIsSquadLeader))
    Debug.Log('Options[\'Enabled\']: '..tostring(Options['Core']['Enabled']))
    Debug.Log('Options[\'AlwaysSquadLeader\']: '..tostring(Options['Distribution']['AlwaysSquadLeader']))


    -- Entity id is set to player because we have no real options here
    local entityId = Player.GetTargetId()


    --targetInfo = targetInfo or Game.GetTargetInfo(entityId)

    -- Target info must be faked because we have no real entity
    local targetInfoData = {
        -- Equipment Items
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=85050, quality=500},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=85017, quality=500},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=85099, quality=500},

        -- Crossbows ftw
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=79061, quality=401},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=83241, quality=501},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=83575, quality=601},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=84443, quality=701},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=84985, quality=901},

        -- Crafting Components
        

        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=10009, quality=1},
        --[[
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=10010, quality=101},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=10011, quality=201},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=10012, quality=301},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=10014, quality=401},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=10015, quality=501},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=10016, quality=601},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=10024, quality=701},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=82500, quality=801},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=85235, quality=901},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=85626, quality=1001},
        {lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=85627, quality=1101},
        --]]
    }


    -- Create some pannelz
    --for num, targetInfo in ipairs(targetInfoData) do
    for num = 1,3 do
        targetInfo = targetInfoData[math.random(#targetInfoData)]
        -- hax the location
        entityId = num
        targetInfo.lootPos.x = targetInfo.lootPos.x - 2*num

        if not IsIdentified(entityId) then

            local itemInfo = Game.GetItemInfoByType(targetInfo.itemTypeId, Game.GetItemAttributeModifiers(targetInfo.itemTypeId, targetInfo.quality))

            local loot = {entityId=entityId, itemTypeId=targetInfo.itemTypeId, craftingTypeId=itemInfo.craftingTypeId, itemInfo=itemInfo, assignedTo=nil, quality=targetInfo.quality, name=itemInfo.name, pos={x=targetInfo.lootPos.x, y=targetInfo.lootPos.y, z=targetInfo.lootPos.z}, panel=nil, waypoint=nil, timer=nil}

            targetInfo.name = itemInfo.name

            if Options['Panels']['Enabled'] and ItemPassesFilter(loot, Options['Panels']) then
                loot.panel = CreatePanel(targetInfo, itemInfo)
            end

            -- Create timer
            loot.timer = GTimer.Create(function(time) if loot.panel ~= nil then loot.panel.panel_rt:GetChild('content'):GetChild('IconBar'):GetChild('timer'):SetText(time) end end, '%02iq60p:%02iq1p', 1);
            
            -- Setup despawn timer
            loot.timer:SetAlarm('despawn', ciLootDespawn, LootDespawn, {item=loot})
            loot.timer:StartTimer()


            loot.waypoint = CreateWaypoint(loot)


            table.insert(aIdentifiedLoot, loot)
            OnIdentify({item=loot})

        end

    end


end


-- Todo: Comment (what can I say, does exactly what it looks like), figure out what to do if we don't know the frame or potential universal frame icon or something
function GetFrameWebIconByName(frameName)

    local data = {
        ['Assault'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/AccordAssault.png",
        ['Firecat'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Firecat.png",
        ['Tigerclaw'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Tigerclaw.png",
        ['Dreadnaught'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/AccordDread.png",
        ['Rhino'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Rhino.png",
        ['Mammoth'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Mammoth.png",
        ['Arsenal'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Arsenal.png",
        ['Engineer'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/AccordEngineer.png",
        ['Electron'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Electron.png",
        ['Bastion'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Bastion.png",
        ['Biotech'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/AccordBiotech.png",
        ['Recluse'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Recluse.png",
        ['Dragonfly'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Dragonfly.png",
        ['Recon'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/AccordRecon.png",
        ['Raptor'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Raptor.png",
        ['Nighthawk'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Nighthawk.png",
    }

    return data[frameName]

end 






-- Why the fucking fuck are these not standard functions
function _table.empty(table)
    if next(table) == nil then
       return true
    end
    return false
end

function _table.length(table)
  local count = 0
  for _ in pairs(table) do count = count + 1 end
  return count
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function vardump(value, depth, key)
  local linePrefix = ""
  local spaces = ""
  
  if key ~= nil then
    linePrefix = "["..key.."] = "
  end
  
  if depth == nil then
    depth = 0
  else
    depth = depth + 1
    for i=1, depth do spaces = spaces .. "  " end
  end
  
  if type(value) == 'table' then
    mTable = getmetatable(value)
    if mTable == nil then
      log(spaces ..linePrefix.."(table) ")
    else
      log(spaces .."(metatable) ")
        value = mTable
    end     
    for tableKey, tableValue in pairs(value) do
      vardump(tableValue, depth, tableKey)
    end
  elseif type(value)    == 'function' or 
      type(value)   == 'thread' or 
      type(value)   == 'userdata' or
      value     == nil
  then
    log(spaces..tostring(value))
  else
    log(spaces..linePrefix.."("..type(value)..") "..tostring(value))
  end
end

-- Source: http://lua-users.org/wiki/MakingLuaLikePhp
-- Credit: http://richard.warburton.it/
function explode(div,str)
    if (div=='') then return false end
    local pos,arr = 0,{}
    for st,sp in function() return string.find(str,div,pos,true) end do
        table.insert(arr,string.sub(str,pos,st-1))
        pos = sp + 1
    end
    table.insert(arr,string.sub(str,pos))
    return arr
end
-- Standard Libs
require 'math' -- In order to generate random numbers
require 'unicode' -- Because why not

-- Firefall Libs
require 'lib/lib_Debug' -- Debug library, used for logging
require 'lib/lib_InterfaceOptions' -- Interface Options
require 'lib/lib_Items' -- Item library, used to get color-by-quality, and item tooltips
require 'lib/lib_MapMarker' -- Map Marker library, used for waypoint creation.
require 'lib/lib_Slash' -- Slash commands
require 'lib/lib_Vector' -- Vector coordinates
require 'lib/lib_Button' -- Buttons used by Tracker
require 'lib/lib_Tooltip' -- Tooltip used by Tracker
require 'lib/lib_ChatLib' -- Used to send some chat messages
require 'lib/lib_table' -- Common table functions
require 'lib/lib_UserKeybinds' -- User keybinds
require 'lib/lib_Colors' -- Colors, used by markers
require 'lib/lib_RowScroller' -- Row Scroller, used by Tacker

-- Custom Libs
require './lib/Lokii' -- Localization
require './lib/lib_GTimer' -- Timer for rolltimeout
require './lib/lib_LKObjects' -- Trivialize objects

-- Custom Utils
require './util/xSounds' -- Soundfiles for options

-- Custom Objects
require './lootpanel'

-- Addon Meta
AddonInfo = {
    release  = "2014-08-13",
    version = "1.10",
    patch = "1.0.1793",
    save = 1.0,
}

-- Global state
State = {
    loaded        = false, -- Set by the __LOADED message through options, allowing me to hold back sounds when the addon loads all the settings
    hud           = false, -- Whether game wants HUD to be displayed or not, updated by OnHudShow
    cursor        = false, -- Whether game is in cursor mode or not, updated by OnInputModeChanged
    tooltipActive = false, -- Whether addon is currently utilizing the Tooltip. Updated manually within the addon when Tooltip.Show is called. There are situations unrelated to mouse location where I might want to hide the tooltip if it is displaying. Just calling Tooltip.Show(false) could interfere with other addons, so I use this variable to keep track of when I've called it. As long as no other addon/ui element randomly calls Tooltip.Show (without mine being unfocused first!) it should serve its purpose.
    inSquad       = false, -- Whether we are currently in a squad or not
    isSquadLeader = false, -- Whether we are currently the squad leader or not
    zoneId        = -1,
}

-- Addon
require './util' -- To be deprecated
require './types'   -- Types
require './options' -- Options
require './loot'-- Loot
require './messages' -- Messages
require './tracker' -- Tracker
require './markers' -- Markers (Panels / Waypoints)
require './hudtracker' -- HUDTracker

-- Functions
--[[
    OnComponentLoad()
    Callback for ON_COMPONENT_LOAD
    Sets up Interace options, slash commands and prints a version message
]]--
function OnComponentLoad()
    -- Setup Lokii
    Lokii.AddLang('en', './lang/EN');
    Lokii.SetBaseLang('en');
    Lokii.SetToLocale();

    -- Setup LKObjects
    --LKObjects.SetMemoryWarning(20) -- Ehh, the amount of panels is too high now!
        
    -- Setup Debug
    Debug.EnableLogging(Component.GetSetting('Debug_Enabled'))

    -- Setup Options
    Options.Setup()    
end

function OnOptionsLoaded()
    -- Setup Slash
    LIB_SLASH.BindCallback({slash_list=Options['Core']['SlashHandles'], description='Xsear\'s Loot Tracker', func=OnSlash})

    -- Setup Tracker
    Tracker.Setup()

    -- Setup HUDTracker
    HUDTracker.Setup()

    -- Print version message
    if Options['Core']['VersionMessage'] then
        Messages.SendChatMessage('system', 'Xsear\'s Loot Tracker v'..AddonInfo.version..' p'..AddonInfo.patch..' r'..AddonInfo.release..' Loaded')
    end
end

function OnEnterZone(args)
    State.zoneId = tonumber(args.zoneId)
end

--[[
    OnHudShow(args)
    Callback for MY_HUD_SHOW
    Used to determine if the tracker should be displayed or not.
]]--
function OnHudShow(args)
    local hide = args.loading_screen or args.logout_bonus or args.freecamera or args.sinvironment
    State.hud = not hide
end

--[[
    OnHudShow(args)
    Callback for MY_HUD_HIDE_REQUEST
]]--
function OnHideHudRequest(args)
    State.hud = not args.hide
end

--[[
    OnInputModeChanged(args)
    Callback for ON_INPUT_MODE_CHANGED
]]--
function OnInputModeChanged(args)
    State.cursor = (args.mode == 'cursor')
end

--[[
    OnInputModeChanged(args)
    Callback for ON_SQUAD_ROSTER_UPDATE
]]--
function OnSquadRosterUpdate(args)
    local roster = Squad.GetRoster()
    State.inSquad = (roster ~= nil and not _table.empty(roster))
    State.isSquadLeader = (State.inSquad and namecompare(Player.GetInfo(), roster.leader))
end

--[[
    OnSlash(args)
]]--
function OnSlash(args)
    -- Help / command list
    if args.text == '' or args.text == 'help' or args.text == '?' then
        Messages.SendChatMessage('system', 'Xsear\'s Loot Tracker r'..AddonInfo.release)
        Messages.SendChatMessage('system', 'Slash Commands')
        Messages.SendChatMessage('system', '/slm [help|?]: Version message and command list.')

        if Options['Debug']['Enabled'] then
            Messages.SendChatMessage('system', 'Debug Commands')
            Messages.SendChatMessage('system', '/slm test [filter|any] [number|any] : Fake detection of items.')
            Messages.SendChatMessage('system', '/slm stat : Log variables.')
        end

    -- Debug/testing commands, subject to change
    elseif args[1] == 'test' then
        Test({args[2], args[3]})

    elseif args.text == 'stat' then
        Stat(args)

    elseif args.text == 'refresh' then
        Tracker.Refresh()

    elseif args.text == 'clear' then
        Clear(args)

    elseif args.text == 'waymanpls' then
        WaypointManager.GetYourShitTogether()

    elseif args.text == 'wayman' then
        WaypointManager.ToggleVisibility()

    elseif args.text == 'no' or args.text == 'stfu' or args.text == 'silence' then
        Options['Messages']['Enabled'] = false
        Messages.SendChatMessage('system', 'Forcefully disabled Messages and Distribution. Reload the UI to reset.')
    end

end

--[[
    OnEntityAvailable(args)
    Callback function for ON_UI_ENTITY_AVAILABLE
]]--
function OnEntityAvailable(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Control types
    args.entityId = tostring(args.entityId)

    -- Forward
    Tracker.OnEntityAvailable(args)
end

--[[
    OnEntityAvailable(args)
    Callback function for ON_UI_ENTITY_LOST
]]--
function OnEntityLost(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Control types
    args.entityId = tostring(args.entityId)

    -- Forward
    Tracker.OnEntityLost(args)
end

--[[
    OnLootPickup(args)
    Callback function for ON_LOOT_PICKUP
]]--
function OnLootPickup(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Control types
    args.itemTypeId = tostring(args.itemTypeId)

    -- Forward
    Tracker.OnLootEvent(args)
end

--[[
    OnLootCollected(args)
    Callback function for ON_LOOT_COLLECTED
--]]
function OnLootCollected(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Control types
    args.itemTypeId = tostring(args.itemTypeId)

    -- Ignore the event if it is for the local player, since then OnLootPickup should have occured.
    if namecompare(args.lootedTo, Player.GetInfo()) and namecompare(args.lootedBy, Player.GetInfo()) then 
        --Debug.Log('Skipping OnLootCollected event for '..tostring(args.itemTypeId)..' under the assumption that OnLootPickup occurs.')
        return 
    end

    -- Forward
    Tracker.OnLootEvent(args)
end







function OnTrackerNew(args)
    Debug.Event(args)

    -- Sounds
    if Options['Sounds']['Enabled'] and Options['Sounds']['OnIdentify'] then
        System.PlaySound(Options['Sounds']['OnIdentify'])
    end

    -- Waypoints
    Callback2.FireAndForget(WaypointManager.OnTrackerNew, args, 0)

    -- Panels
    Callback2.FireAndForget(PanelManager.OnTrackerNew, args, 0)

    -- HUDTracker
    Callback2.FireAndForget(HUDTracker.OnTrackerNew, args, 0)

    -- Messages
    Callback2.FireAndForget(Messages.OnTrackerNew, args, 0)
end

function OnTrackerUpdate(args)
    Debug.Event(args)

    -- HUDTracker
    Callback2.FireAndForget(HUDTracker.OnTrackerUpdate, args, 0)

    -- Messages
    Callback2.FireAndForget(Messages.OnTrackerUpdate, args, 0)
end

function OnTrackerLooted(args)
    Debug.Event(args)

    -- Waypoints
    Callback2.FireAndForget(WaypointManager.OnTrackerLooted, args, 0)

    -- Panels
    Callback2.FireAndForget(PanelManager.OnTrackerLooted, args, 0)
end

function OnTrackerRemove(args)
    Debug.Event(args)

    -- Waypoints
    Callback2.FireAndForget(WaypointManager.OnTrackerRemove, args, 0)

    -- Panels
    Callback2.FireAndForget(PanelManager.OnTrackerRemove, args, 0)

    -- HUDTracker
    Callback2.FireAndForget(HUDTracker.OnTrackerRemove, args, 0)
end







--[[

function GetItemByIdentity(identityId)
    local localItem
    for num, item in ipairs(aIdentifiedLoot) do
        if tostring(item.identityId) == tostring(identityId) then
            localItem = item
            break
        end
    end

    -- If we don't know about this item we won't get info from it anyway, so just abort
    if not localItem then Debug.Warn('No matching item for identityId: '..tostring(identityId)) end
    return localItem
end


function GetIdentifiedItem(entityId)
    Debug.Log('GetIdentifiedItem called with entityId: '..tostring(entityId))
    local stringType = (type(entityId) == 'string')
    if not _table.empty(aIdentifiedLoot) then
        for num, item in ipairs(aIdentifiedLoot) do 
            if (stringType and tostring(item.entityId) == entityId) or (item.entityId == entityId) then 
                return item
            end
        end
        Debug.Warn('GetIdentifiedItem called but didn\'t find any item with a matching entityId')
    else
        Debug.Warn('GetIdentifiedItem called but we don\'t have any identified items')
    end
    return false
end

--]]







function Test(args)
    Debug.Log('Test')
    Debug.Log('args[1]: '..tostring(args[1]))
    Debug.Log('args[2]: '..tostring(args[1]))

    Messages.SendChatMessage('system', 'Test')


    if false then

        -- 86682 Bone Fragments (Uncommon)
        -- 98622 (BioRifle) Valerian Two (Common)
        -- 99979 Charging Module (Common)


        local idsOfInterest = {
            86695,
            99979,
        }

        for i, typeId in ipairs(idsOfInterest) do

            local itemInfo = Game.GetItemInfoByType(typeId)

            Debug.Log(tostring(itemInfo.name) .. " is of rarity " .. tostring(itemInfo.rarity) .. " which has the value " .. tostring(LIB_ITEMS.GetRarityValue(itemInfo.rarity)))

        end




    elseif true then


        local numberOfItems = 3

        local targetInfoData = {
            {itemTypeId = 86681},
            {itemTypeId = 86682},
            {itemTypeId = 86695},
            {itemTypeId = 86698},
            {itemTypeId = 77344},
            {itemTypeId = 52206},
            {itemTypeId = 30408},
            {itemTypeId = 100061},
            {itemTypeId = 100479},
            {itemTypeId = 103075},
            {itemTypeId = 105253},
            {itemTypeId = 106163},
            {itemTypeId = 114314},
            {itemTypeId = 114020},
            {itemTypeId = 114176},
            {itemTypeId = 113722},
            {itemTypeId = 99979},
            {itemTypeId = 99899},
            {itemTypeId = 98622},
            {itemTypeId = 95088},
            {itemTypeId = 99659},
            {itemTypeId = 98937, modules = {94145}},
        }


        for num = 1, tonumber(numberOfItems) do

            -- Setup args
            local args = {}

            -- Get random targetInfo
            args.targetInfo = targetInfoData[math.random(#targetInfoData)]

            -- Generate fake entityId
            args.entityId = tonumber(tostring(num)..tostring(math.random(0, 10)))

            -- Set location
            args.targetInfo.lootPos = {x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}
            local posMod = (1*(num-(1*(num%2)))) * (-1 + (2*(num%2))) 
            args.targetInfo.lootPos.x = args.targetInfo.lootPos.x - posMod

            -- Set loot property
            args.type = "loot"
            args.targetInfo.type = "loot"

            -- Call
            OnEntityAvailable(args)
        end

        


    end


  

--[[



"targetInfo" : {
            "damageable" : false, 
            "type" : "loot", 
            "lootPos" : {
                "y" : -1778.966919, 
                "x" : 113.551292, 
                "z" : 518.921387
            }, 
            "quantity" : 1, 
            "itemTypeId" : 86682, 
            "bounds" : {
                "height" : 0.614168, 
                "length" : 0.441926, 
                "width" : 0.353914
            }, 
            "hostile" : false, 
            "faction" : "unknown", 
            "interactToLoot" : false, 
            "level" : 0, 
            "modules" : [], 
            "name" : "Bone Fragments"
        }, 
"itemInfo" : {
            "flags" : {
                "resource" : true, 
                "is_tradable" : true
            }, 
            "stack_size" : 5, 
            "rarity" : "uncommon", 
            "certifications" : [], 
            "web_icon_stem" : "BoneFragments", 
            "constraints" : {
                "cpu" : 0, 
                "mass" : 0, 
                "power" : 0
            }, 
            "character_scalars" : [], 
            "tier" : {
                "level" : 2, 
                "description" : "Tier 2", 
                "name" : "Tier 2"
            }, 
            "itemTypeId" : "86682", 
            "type" : "resource_item", 
            "name" : "Bone Fragments", 
            "required_level" : 0, 
            "item_level" : 1, 
            "subTypeId" : "3291", 
            "description" : "Bones and other Carbon-based materials. Gathered from creatures levels 20-29.", 
            "web_icon" : "http://d2ja7bjtwj8eb0.cloudfront.net/assets/items/64/BoneFragments.png"
        }, 




--]]

end


function Stat(args)
    Debug.Log('Stat')
    Debug.Table(State)
    Debug.Table('Features', {
                panels = Options['Panels']['Enabled'],
                waypoints = Options['Waypoints']['Enabled'],
                hudtracker = Options['HUDTracker']['Enabled'],
                messages = Options['Messages']['Enabled'],
                })
    Tracker.Stat()
    WaypointManager.Stat()
end

function Clear(args)
    -- Fixme: This command does not work properly.
    Debug.Log('Clear')
    Tracker.Clear()
end

function Slash_Refresh(args)
    Debug.Log("Refresh")
    Tracker.Refresh()
end








function LootFiltering(loot, moduleOptions)
    -- Vars
    local categoryKey = nil
    local rarityKey = nil
    moduleOptions = moduleOptions['Filtering'] -- Note: this is gonna bite me in the ass someday

    -- Determine keys
    categoryKey, rarityKey = GetLootFilteringOptionsKeys(loot, moduleOptions)

    -- Verify that type passes filter
    if moduleOptions[categoryKey]['Enabled'] then
        
        -- Verify that rarity passes filter
        -- Simple Mode: Rarity of Loot must be at or above Rarity Threshold
        if (rarityKey == 'Simple' and Loot.GetRarityIndex(loot:GetRarity()) >= Loot.GetRarityIndex(moduleOptions[categoryKey][rarityKey]['RarityThreshold']))
        -- Advanced Mode: The specific Rarity of the Loot must be Enabled
        or (rarityKey ~= 'Simple' and moduleOptions[categoryKey][rarityKey]['Enabled']) then

            -- Determine ItemLevel Threshold
            local itemLevelThreshold = tonumber(moduleOptions[categoryKey][rarityKey]['ItemLevelThreshold'])

            -- Determine RequiredLevel Threshold
            local requiredLevelThreshold = tonumber(moduleOptions[categoryKey][rarityKey]['RequiredLevelThreshold'])

            -- Verify that loot passes level thresholds
            if loot:GetItemLevel() >= itemLevelThreshold and loot:GetRequiredLevel() >= requiredLevelThreshold then
                -- Passed all filters
                return true
            end
        end

    elseif not moduleOptions[categoryKey] then
        Debug.Table('LootFiltering for ' .. loot:ToString() .. ' ran aground because there weren\'t any options for its categoryKey ' .. tostring(categoryKey) .. ' in the module options that were provided (no name to log here, so dumping table.): ', moduleOptions)
    end
    return false
end



function GetLootFilteringOptionsKeys(loot, moduleOptions) 
    -- Vars
    local categoryKey = nil
    local rarityKey = nil

    -- Determine typeKey
    categoryKey = loot:GetCategory()

    -- Determine rarityKey
    if moduleOptions[categoryKey]['Mode'] == TriggerModeOptions.Simple then
        rarityKey = 'Simple'
    else -- TriggerModeOptions.Advanced
        rarityKey = loot:GetRarity()
    end
    
    -- Return
    return categoryKey, rarityKey
end

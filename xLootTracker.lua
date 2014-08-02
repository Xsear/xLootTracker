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

require './lootpanel'

-- Addon Meta
AddonInfo = {
    release  = "ALPHA 2014-07-28",
    revision = 0.99,
    save = 1.0,
}

State = {
    loaded        = false, -- Set by the __LOADED message through options, allowing me to hold back sounds when the addon loads all the settings
    hud           = false, -- Whether game wants HUD to be displayed or not, updated by OnHudShow
    cursor        = false, -- Whether game is in cursor mode or not, updated by OnInputModeChanged
    tooltipActive = false, -- Whether addon is currently utilizing the Tooltip. Updated manually within the addon when Tooltip.Show is called. There are situations unrelated to mouse location where I might want to hide the tooltip if it is displaying. Just calling Tooltip.Show(false) could interfere with other addons, so I use this variable to keep track of when I've called it. As long as no other addon/ui element randomly calls Tooltip.Show (without mine being unfocused first!) it should serve its purpose.
    inSquad       = false, -- Whether we are currently in a squad or not
    isSquadLeader = false, -- Whether we are currently the squad leader or not
}




-- Util

-- Data


-- Addon
require './util' -- To be deprecated
require './types'   -- Types
require './options' -- Options

require './loot'-- Loot

require './messages' -- Messages
require './tracker' -- Tracker

require './markers' -- Markers (Panels / Waypoints)

require './hudtracker' -- HUdTracker

-- Functions
--[[
    OnComponentLoad()
    Callback for ON_COMPONENT_LOAD
    Sets up Interace options, slash commands and prints a version message
]]--
function OnComponentLoad()
    -- Install
    if not Component.GetSetting('INSTALLED') then
        Component.SaveSetting('INSTALLED', true)
        Component.SaveSetting('Core_VersionMessage', true)
    end

    -- Setup Debug
    Debug.EnableLogging(Component.GetSetting('Debug_Enabled'))
    
    -- Setup Lokii
    Lokii.AddLang('en', './lang/EN');
    Lokii.SetBaseLang('en');
    Lokii.SetToLocale();

    -- Setup LKObjects
    --LKObjects.SetMemoryWarning(20)
    
    -- Setup Options
    Options.Setup()

    -- Setup Slash
    LIB_SLASH.BindCallback({slash_list=Component.GetSetting('Core_SlashHandles'), description='Xsear\'s Loot Tracker', func=OnSlash})

    -- Setup Tracker
    Tracker.Setup()

    -- Setup HUDTracker
    HUDTracker.Setup()

    -- Print version message
    if Component.GetSetting('Core_VersionMessage') then
        Messages.SendChatMessage('system', 'Xsear\'s Loot Tracker r'..AddonInfo.release..' Loaded')
    end
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
    WaypointManager.OnTrackerNew(args)

    -- Panels
    PanelManager.OnTrackerNew(args)

    -- HUDTracker
    HUDTracker.OnTrackerNew(args)

    -- Messages
    if Options['Messages']['Enabled'] then
        local loot = Tracker.GetLootById(args.lootId)
        local rarity = loot:GetRarity()
        if rarity == LootRarity.Epic then
            Chat.SendChannelText("squad", "Epic: "..tostring(loot:GetName()))
        end
    end
end

function OnTrackerUpdate(args)
    Debug.Event(args)

    -- HUDTracker
    HUDTracker.OnTrackerUpdate(args)

    -- Messages
    Messages.OnTrackerUpdate(args)
end

function OnTrackerLooted(args)
    Debug.Event(args)

    -- Waypoints
    WaypointManager.OnTrackerLooted(args)

    -- Panels
    PanelManager.OnTrackerLooted(args)
end

function OnTrackerRemove(args)
    Debug.Event(args)

    -- Waypoints
    WaypointManager.OnTrackerRemove(args)

    -- Panels
    PanelManager.OnTrackerRemove(args)

    -- HUDTracker
    HUDTracker.OnTrackerRemove(args)
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
end


function Stat(args)
    Debug.Log('Stat')
    Debug.Table(State)
    Tracker.Stat()
    WaypointManager.Stat()
end

function Clear(args)
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

-- Standard Libs
require 'math'                     -- In order to generate random numbers
require 'unicode'                  -- Should be used primarily for string handling. Note that the string library is included elsewhere...

-- Firefall Libs
require 'lib/lib_Debug'            -- Debug library, used for logging
require 'lib/lib_InterfaceOptions' -- Interface Options
require 'lib/lib_Items'            -- Item library, used to get color-by-quality, and item tooltips
require 'lib/lib_MapMarker'        -- Map Marker library, used for waypoint creation.
require 'lib/lib_Slash'            -- Slash commands
require 'lib/lib_Vector'           -- Vector coordinates
require 'lib/lib_Button'           -- Buttons used by Tracker
require 'lib/lib_Tooltip'          -- Tooltip used by Tracker
require 'lib/lib_ChatLib'          -- Used to send some chat messages
require 'lib/lib_table'            -- Common table functions
require 'lib/lib_UserKeybinds'     -- User keybinds
require 'lib/lib_Colors'           -- Colors, used by markers
require 'lib/lib_RowScroller'      -- Row Scroller, used by Tacker
require 'lib/lib_MultiArt'         -- Used for icons
require 'lib/lib_SubTypeIds'       -- Used for determining loot categories
require 'lib/lib_ContextMenu'      -- Used for hudtracker context menu
require 'lib/lib_HudManager'       -- Used to handle HUD visibility state

-- Custom Libs
require './lib/Lokii'              -- Localization
require './lib/lib_GTimer'         -- Timer for rolltimeout
require './lib/lib_LKObjects'      -- Trivialize objects

-- Custom Utils
require './util/xSounds'           -- Soundfiles for options

-- Custom Objects
require './lootpanel'              -- Loot Panel object

-- Addon Meta
AddonInfo = {
    release  = '2014-12-10',
    version = '1.19',
    patch = '1.2.1843',
    save = 1.0,
}

-- Global State
State = {
    loaded        = false,   -- Set by the __LOADED message through options, allowing me to hold back sounds when the addon loads all the settings
    hud           = true,   -- Whether game wants HUD to be displayed or not, updated by OnHudShow
    cursor        = false,   -- Whether game is in cursor mode or not, updated by OnInputModeChanged
    sin           = false,   -- Whether game is in Sin view or not, updated by OnSinView
    tooltipActive = false,   -- Whether addon is currently utilizing the Tooltip. Updated manually within the addon when Tooltip.Show is called. There are situations unrelated to mouse location where I might want to hide the tooltip if it is displaying. Just calling Tooltip.Show(false) could interfere with other addons, so I use this variable to keep track of when I've called it. As long as no other addon/ui element randomly calls Tooltip.Show (without mine being unfocused first!) it should serve its purpose.
    inSquad       = false,   -- Whether we are currently in a squad or not
    isSquadLeader = false,   -- Whether we are currently the squad leader or not
    inPlatoon     = false,   -- Whether we are currently in a platoon or not
    isPlatoonLeader = false, -- Whether we are currently the platoon leader or not
    zoneId        = -1,      -- The local zone id
    playerName    = '',      -- The name of the local player
}

-- Addon
require './util'       -- Various functions that need to be cleaned up.
require './types'      -- Types
require './options'    -- Options
require './loot'       -- Loot
require './messages'   -- Messages
require './tracker'    -- Tracker
require './panels'     -- Panels
require './waypoints'  -- Waypoints
require './hudtracker' -- HUDTracker
require './sounds'     -- Sounds

-- Functions
--[[
    OnComponentLoad()
    Event handler for ON_COMPONENT_LOAD
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

    -- Setup HudManager
    --HudManager.WhitelistReasons({})
    --HudManager.BlacklistReasons({})
    HudManager.BindOnShow(OnHudShow)

    -- Setup Options
    Options.Setup() 

    -- Setup Blacklist - Fix for bug in versions 1.13 to v1.15
    if Component.GetSetting('Core_Blacklist') then
        Options['Blacklist'] = Component.GetSetting('Core_Blacklist')

        local blacklistStructure = {
                ['Tracker'] = {},
                ['Panels'] = {},
                ['Sounds'] = {},
                ['HUDTracker'] = {},
                ['Messages'] = {},
                ['Waypoints'] = {},
        }

        for key, table in pairs(blacklistStructure) do
            if not Options['Blacklist'][key] then
                Debug.Log('Restoring Blacklist Structure: Adding key ' .. tostring(key))
                Options['Blacklist'][key] = {}
            end
        end

        Component.SaveSetting('Core_Blacklist', Options['Blacklist'])
    end
end

--[[
    OnOptionsLoaded()
    Called when Interface Options sends the __LOADED signal.
]]--
function OnOptionsLoaded()
    -- Setup Slash
    LIB_SLASH.BindCallback({slash_list=Options['Core']['SlashHandles'], description='Xsear\'s Loot Tracker', func=OnSlash})

    -- Setup Tracker
    Tracker.Setup()

    -- Setup HUDTracker
    HUDTracker.Setup()

    -- Print version message
    if Options['Core']['VersionMessage'] then
        Messages.SendSystemMessage('Xsear\'s Loot Tracker v'..AddonInfo.version..' p'..AddonInfo.patch..' r'..AddonInfo.release..' Loaded')
    end
end

--[[
    OnEnterZone(args)
    Event handler for ON_ENTER_ZONE
]]--
function OnEnterZone(args)
    State.zoneId = tonumber(args.zoneId)
end

--[[
    OnPlayerReady(args)
    Event handler for ON_PLAYER_READY
]]--
function OnPlayerReady(args)
    State.playerName = Player.GetInfo()
end

--[[
    OnHudShow(args)
    Handler for HudManager.BindOnShow
]]--
function OnHudShow(show, dur)
    State.hud = show
    if State.loaded then
        HUDTracker.UpdateVisibility()
    end
end

--[[
    OnInputModeChanged(args)
    Event handler for ON_INPUT_MODE_CHANGED
]]--
function OnInputModeChanged(args)
    State.cursor = (args.mode == 'cursor')
    if State.loaded then
        HUDTracker.UpdateVisibility()
    end
end

--[[
    OnInputModeChanged(args)
    Event handler for ON_SIN_VIEW
]]--
function OnSinView(args)
    State.sin = args.sinView
    if State.loaded then
        HUDTracker.UpdateVisibility()
    end
end

--[[
    OnInputModeChanged(args)
    Event handler for ON_SQUAD_ROSTER_UPDATE
]]--
function OnSquadRosterUpdate(args)
    State.inSquad = Squad.IsInSquad()
    State.inPlatoon = Platoon.IsInPlatoon()

    if State.inSquad and State.inPlatoon then
        State.inSquad = false
    end

    State.isSquadLeader = (State.inSquad and namecompare(State.playerName, Squad.GetLeader()))
    State.isPlatoonLeader = (State.inPlatoon and namecompare(State.playerName, Platoon.GetLeader()))
end

--[[
    OnSlash(args)
    Callback handler for LIB_SLASH.
]]--
function OnSlash(args)
    -- Help / command list
    if not args[1] or args[1] == 'help' or args[1] == '?' then
        Messages.SendSystemMessage('Xsear\'s Loot Tracker v'..AddonInfo.version)
        Messages.SendSystemMessage('Slash Commands')
        Messages.SendSystemMessage('/lt : Version message and command list.')
        Messages.SendSystemMessage('/lt clear : Force the tracker to remove all loot.')
        Messages.SendSystemMessage('/lt blacklist <action> <scope> [itemName|itemTypeId].')
        Messages.SendSystemMessage('/lt refresh : Force the tracker to update all loot.')

        if Options['Debug']['Enabled'] then
            Messages.SendSystemMessage('Debug Commands')
            Messages.SendSystemMessage('/lt test [filter|any] [number|any] : Fake detection of items.')
            Messages.SendSystemMessage('/lt stat : Log variables.')
        end

    -- Refresh
    elseif args[1] == 'refresh' then
        Slash_Refresh(args)

    -- Clear
    elseif args[1] == 'clear' then
        Slash_Clear(args)

    -- Blacklist
    elseif args[1] == 'blacklist' then
        Slash_Blacklist(args)


    -- Debug/testing commands, subject to change
    elseif args[1] == 'test' then
        Slash_Test(args)

    elseif args[1] == 'stat' then
        Slash_Stat(args)

    elseif args[1] == 'wp' or args[1] == 'wps' or args[1] == 'waypoints' or args[1] == 'wayman' or args[1] == 'way' then
        if not args[2] then
            WaypointManager.ToggleVisibility()
        end

    elseif args[1] == 't' or args[1] == 'toggle' then
        if not args[2] then
            Options['Core']['Enabled'] = not Options['Core']['Enabled']

        elseif args[2] == 'wp' or args[2] == 'wps' or args[2] == 'waypoints' or args[2] == 'wayman' or args[2] == 'way' then
            Options['Waypoints']['Enabled'] = not Options['Waypoints']['Enabled']

        elseif args[2] == 'hud' or args[2] == 'hudtracker' or args[2] == 'tracker' then
            Options['HUDTracker']['Enabled'] = not Options['HUDTracker']['Enabled']

        elseif args[2] == 'sound' or args[2] == 'sounds' or args[2] == 'snd' then
            Options['Sounds']['Enabled'] = not Options['Sounds']['Enabled']

        elseif args[2] == 'messages' or args[2] == 'msg' or args[2] == 'msgs' or args[2] == 'message' then
            Options['Messages']['Enabled'] = not Options['Messages']['Enabled']

        elseif args[2] == 'panels' or args[2] == 'pan' or args[2] == 'panman' or args[2] == 'pans' then
            Options['Panels']['Enabled'] = not Options['Panels']['Enabled']

        end
        -- local respKey
        Messages.SendSystemMessage('Toggled.')

    elseif args[1] == 'stop' then
        Messages.SendSystemMessage('Stopping')
        Options['Core']['Enabled'] = false
        Options['Tracker']['Enabled'] = false
        Options['Waypoints']['Enabled'] = false
        Options['HUDTracker']['Enabled'] = false
        Options['Sounds']['Enabled'] = false
        Options['Messages']['Enabled'] = false
        Options['Panels']['Enabled'] = false

    elseif args[1] == 'no' or args[1] == 'stfu' or args[1] == 'silence' then
        Messages.SendSystemMessage('Forcefully disabling Messages.')
        Options['Messages']['Enabled'] = false
    end

end

--[[
    OnEntityAvailable(args)
    Event handler for ON_UI_ENTITY_AVAILABLE
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
    Event handler for ON_UI_ENTITY_LOST
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
    Event handler for ON_LOOT_COLLECTED and MY_LOOT_COLLECTED
]]--
function OnLootCollected(args)
    -- Requires Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Control types
    args.itemTypeId = tostring(args.itemTypeId)

    -- Forward
    Tracker.OnLootEvent(args)
end

--[[
    OnTrackerNew(args)
    Event handler for XLT_ON_TRACKER_NEW
    Called by the Tracker when it has added a new item.
--]]
function OnTrackerNew(args)
    --Debug.Event(args)

    -- Sounds
    Sounds.OnTrackerNew(args)

    -- Waypoints
    WaypointManager.OnTrackerNew(args)

    -- Panels
    PanelManager.OnTrackerNew(args)

    -- HUDTracker
    HUDTracker.OnTrackerNew(args)

    -- Messages
    Messages.OnTrackerNew(args)
end

--[[
    OnTrackerUpdate(args)
    Event handler for XLT_ON_TRACKER_UPDATE
    Called by the Tracker when an item has been updated.
--]]
function OnTrackerUpdate(args)
    --Debug.Event(args)

    -- Messages
    Messages.OnTrackerUpdate(args)
end

--[[
    OnTrackerLooted(args)
    Event handler for XLT_ON_TRACKER_LOOTED
    Called by the Tracker when an item has been looted.
--]]
function OnTrackerLooted(args)
    --Debug.Event(args)

    -- Waypoints
    WaypointManager.OnTrackerLooted(args)

    -- Panels
    PanelManager.OnTrackerLooted(args)

    -- HUDTracker
    HUDTracker.OnTrackerLooted(args)
end

--[[
    OnTrackerRemove(args)
    Event handler for XLT_ON_TRACKER_REMOVE
    Called by the Tracker when an item is about to be removed.
--]]
function OnTrackerRemove(args)
    --Debug.Event(args)

    -- Waypoints
    WaypointManager.OnTrackerRemove(args)

    -- Panels
    PanelManager.OnTrackerRemove(args)

    -- HUDTracker
    HUDTracker.OnTrackerRemove(args)
end











--[[
    Slash_Clear(args)
    The Clear Slash Command.
    Attempts to remove all tracked items cleanly.
--]]
function Slash_Clear(args)
    Debug.Log('Slash_Clear')
    Tracker.Clear()
    Messages.SendSystemMessage('Clear')
end

--[[
    Slash_Blacklist(args)
    The Blacklist Slash Command.
    Allows for blacklisting specific items from specific parts of the addon.
--]]
function Slash_Blacklist(args)
    Debug.Table('Slash_Blacklist', args)
    Messages.SendSystemMessage('Blacklist')
    -- args[2] == action
    -- args[3] == scope
    -- args[4+] == itemTypeId or string to use to find itemTypeId
    -- args.text entire thing

    if not args[2] or not args[3] then
        Messages.SendSystemMessage('Incorrect syntax. First, provide an action (add, remove, view, clear). Then, specify (one) scope (all, panels, sounds, hudtracker, messages, waypoints). Finally, for add and remove, provide either the exact item name, or the itemTypeId.')
        return
    end

    local success = false
    local reason = ''
    local itemInfo = nil

    -- Validate actionKey
    local actionKey = unicode.lower(args[2])
    
    if actionKey == 'add' or actionKey == 'rem' or actionKey == 'remove' or actionKey == 'view' or actionKey == 'list' or actionKey == 'clear' then -- didn't think this through did I now I've fallen into the wrapped second line <3 sublime

        -- Determine scopeKey
        local scope = unicode.lower(args[3])
        local scopeKey = false

        local scopeKeyTable = {
            ['Tracker'] = {
                'tracker', 'core', 'all',
            },

            ['Panels'] = {
                'panels', 'panel', 'pan',
            },

            ['Sounds'] = {
                'sounds', 'sound', 'snd',
            },

            ['HUDTracker'] = {
                'hudtracker', 'hud', 'ht',
            },

            ['Messages'] = {
                'messages', 'message', 'msg',
            },

            ['Waypoints'] = {
                'waypoints', 'waypoint', 'way', 'wp',
            },
        }

        for key, matchTable in pairs(scopeKeyTable) do
            for i, entry in ipairs(matchTable) do
                if entry == scope then
                    scopeKey = key
                    break
                end
            end
        end

        -- If we have the scopeKey, move on to the itemTypeId
        if scopeKey then


            if actionKey == 'list' or actionKey == 'view' then

                if not _table.empty(Options['Blacklist'][scopeKey]) then
                    local results = {'Viewing blacklist entries in scope ' .. tostring(scopeKey)}

                    Debug.Table(Options['Blacklist'][scopeKey])

                    for itemTypeId, value in pairs(Options['Blacklist'][scopeKey]) do
                        local itemInfo = Game.GetItemInfoByType(itemTypeId)
                        if not itemInfo then
                            Debug.Warn('Invalid itemTypeId in blacklist') 
                        else
                            results[#results + 1] = tostring(itemInfo.name) .. ' (' .. tostring(itemInfo.itemTypeId) ..')'
                        end

                    end

                    local message = table.concat(results, '\n')

                    Messages.SendChatMessage('system', message)
                    return

                else
                    reason = 'Nothing to list.'

                end

            elseif actionKey == 'clear' then

                if not _table.empty(Options['Blacklist'][scopeKey]) then
                    local count = 0
                    for itemTypeId, value in pairs(Options['Blacklist'][scopeKey]) do
                        Options['Blacklist'][scopeKey][itemTypeId] = nil
                        count = count + 1
                    end
                        
                    -- Save
                    Component.SaveSetting('Core_Blacklist', Options['Blacklist'])

                    Messages.SendSystemMessage('Success! Cleared ' .. tostring(count) .. ' entries from the ' .. tostring(scopeKey) .. ' scope.')
                    return
                else
                    reason = 'The scope is bloody empty!'
                end


            else

                if not args[4] then
                    reason = 'Missing itemName or itemTypeId argument.'

                else


                    local haveItemTypeId = false

                    local lookupString = ''
                    

                    if not args[5] then
                        itemInfo = Game.GetItemInfoByType(args[4])
                        if itemInfo and not _table.empty(itemInfo) then
                            haveItemTypeId = true
                        end
                    end

                    -- Itterate all ids and see if the name exactly matches? ;3
                    if not haveItemTypeId then
                        local previousArgs = args[1] .. ' ' .. args[2] .. ' ' .. args[3] .. ' '
                        Debug.Log('PreviousArgs: ' .. previousArgs)
                        Debug.Log('unicode.len(previousArgs): ' .. tostring(unicode.len(previousArgs)))
                        searchName = unicode.sub(args.text, unicode.len(previousArgs) + 1)
                        
                        local maxNum = 300000
                        local getItemInfo = Game.GetItemInfoByType 

                        for num = 1, maxNum do

                            local itemInfoQuery = getItemInfo(num)

                            if itemInfoQuery and not _table.empty(itemInfoQuery) then
                                if itemInfoQuery.name == searchName then
                                    itemInfo = itemInfoQuery
                                    break
                                end
                            end

                        end

                        if not itemInfo then
                            reason = 'Could not get itemInfo, unable to find an item with the name ' .. tostring(searchName)
                        end

                    end

                    -- If we have itemInfo, add to blacklist.
                    if itemInfo then

                        if actionKey == 'add' then
                            if not Options['Blacklist'][scopeKey][tostring(itemInfo.itemTypeId)] then
                                Options['Blacklist'][scopeKey][tostring(itemInfo.itemTypeId)] = true
                                success = true
                            else
                                reason = 'Already blacklisted in this scope'
                            end
                        elseif actionKey == 'remove' or actionKey == 'rem' then
                            if Options['Blacklist'][scopeKey][tostring(itemInfo.itemTypeId)] then
                                Options['Blacklist'][scopeKey][tostring(itemInfo.itemTypeId)] = nil
                                success = true
                            else
                                reason = 'This typeId was not blacklisted in this scope'
                            end
                        end
                    end

                    if success then
                        -- Save
                        Component.SaveSetting('Core_Blacklist', Options['Blacklist'])

                        if actionKey == 'add' then
                            Messages.SendSystemMessage('Success! Added ' .. tostring(itemInfo.name) .. '(' .. tostring(itemInfo.itemTypeId) .. ') to the ' .. tostring(scopeKey) .. ' blacklist.')

                        elseif actionKey == 'remove' or actionKey == 'rem' then
                            Messages.SendSystemMessage('Success! Removed ' .. tostring(itemInfo.name) .. ' (' .. tostring(itemInfo.itemTypeId) .. ') from the ' .. tostring(scopeKey) .. ' blacklist.')
                        end
                        return
                    end
                end

            end



        -- If we don't have the scopeKey, invalid input!
        else
            reason = 'Invalid scope argument'
        end

    else
        reason = 'Invalid actionKey. Use add or remove.'
    end


    Messages.SendSystemMessage('Failure. Reason: ' .. reason)
end

--[[
    Slash_Refresh(args)
    The Refresh Slash Command.
    Attempts to update all tracked items so that their status is refreshed.
--]]
function Slash_Refresh(args)
    Debug.Log('Slash_Refresh')
    Tracker.Refresh()
    Messages.SendSystemMessage('Refresh')
end






function Slash_Test(args)
    table.remove(args, 1)

    Debug.Log('Slash_Test')
    Debug.Log('args[1]: '..tostring(args[1]))
    Debug.Log('args[2]: '..tostring(args[2]))

    Messages.SendSystemMessage('Test')


    if true then


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
            {itemTypeId = 99659},
            {itemTypeId = 98622},
            {itemTypeId = 95088},

            -- Moduled Item
            {itemTypeId = 98937, modules = {94145}},

            -- Salvage
            {itemTypeId = 52206}, -- Recovered Chosen Tech
            {itemTypeId = 30408}, -- Broken Bandit Gear
            {itemTypeId = 86398}, -- Half Digested Module

            -- Epics
            {itemTypeId = 116407}, -- Necro Crossbow
            {itemTypeId = 116378}, -- Thermal Needler (Epic)
            {itemTypeId = 107786}, -- Thermal Needler (Rare)
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
            args.type = 'loot'
            args.targetInfo.type = 'loot'


            --Messages.SendSystemMessage('Test Loot: ' .. tostring(args.targetInfo.itemTypeId))

            -- Call
            OnEntityAvailable(args)
        end

        


    end

end


function Slash_Stat(args)
    Debug.Log('Slash_Stat')
    Debug.Table(State)
    Debug.Table('Features', {
                tracker = Options['Tracker']['Enabled'],
                waypoints = Options['Waypoints']['Enabled'],
                hudtracker = Options['HUDTracker']['Enabled'],
                sounds = Options['Sounds']['Enabled'],
                messages = Options['Messages']['Enabled'],
                panels = Options['Panels']['Enabled'],
                })
    Tracker.Stat()
    WaypointManager.Stat()
    Messages.SendSystemMessage('Stat')
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

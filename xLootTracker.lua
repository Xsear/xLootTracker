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
require 'lib/lib_Tooltip'          -- Tooltip used by Tracker
require 'lib/lib_ChatLib'          -- Used to send some chat messages
require 'lib/lib_table'            -- Common table functions
require 'lib/lib_UserKeybinds'     -- User keybinds
require 'lib/lib_Colors'           -- Colors, used by markers
require 'lib/lib_RowScroller'      -- Row Scroller, used by Tracker
require 'lib/lib_MultiArt'         -- Used for icons
require 'lib/lib_SubTypeIds'       -- Used for determining loot categories
require 'lib/lib_ContextMenu'      -- Used for hudtracker context menu
require 'lib/lib_HudManager'       -- Used to handle HUD visibility state
require 'lib/lib_UserKeybinds'     -- Used by keybinder
require 'lib/lib_InputIcon'        -- Used to display keybinds

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
    release  = '2016-04-29',
    version = '1.22',
    patch = '1.7.1957',
    save = 1.0,
}

-- Global State
State = {
    inOptions     = false,   -- Set by the __DISPLAY message from lib_InterfaceOptions, whether the user is viewing the options.
    loaded        = false,   -- Set by the __LOADED message from lib_InterfaceOptions, allowing me to hold back sounds when the addon loads all the settings
    hud           = true,    -- Whether game wants HUD to be displayed or not, updated by OnHudShow
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

-- Constants
RELOADUI_FLAG = "_ReloadUI"

-- Addon
require './util'       -- Various functions that need to be cleaned up.
require './types'      -- Types
require './options'    -- Options
require './blacklist'  -- Blacklist
require './loot'       -- Loot
require './filtering'  -- Filtering
require './messages'   -- Messages
require './tracker'    -- Tracker
require './panels'     -- Panels
require './waypoints'  -- Waypoints
require './hudtracker' -- HUDTracker
require './sounds'     -- Sounds
require './KeyBinder'

-- Functions
--[[
    OnComponentLoad()
    Event handler for ON_COMPONENT_LOAD
]]--
function OnComponentLoad()
    -- Setup Debug
    Debug.EnableLogging(Component.GetSetting('Debug_Enabled'))

    -- Setup Lokii
    Lokii.AddLang('en', './lang/EN');
    Lokii.AddLang('zh', './lang/ZH');
    --[[
        To enable another language, you must do the following:
        Uncomment one of the lines below or make your own if your language isn't listed.
        Copy the ./lang/EN.lua file into the appropriate ./lang/XX.lua file, as declared in the line below.
        Finally, in types.lua, your language needs to be in the Locale and OptionsLocaleDropdown tables. In the case of one of the listed languages here, you only need to uncomment the appropriate line in OptionsLocaleDropdown.
    --]]
    --Lokii.AddLang('de', './lang/DE');
    --Lokii.AddLang('fr', './lang/FR');
    --Lokii.AddLang('es', './lang/ES');
    Lokii.SetBaseLang('en');
    local locale = Component.GetSetting('Core_Locale')
    if locale and locale ~= Locale.SystemDefault then
        Lokii.SetLang(locale)
    else
        Lokii.SetToLocale()
    end

    -- Setup HudManager
    HudManager.BindOnShow(OnHudShow)

    -- Setup Options
    Options.Setup() 

    -- Setup Blacklist
    Blacklist.Setup()

    -- Handle ReloadUI
    if Component.GetSetting(RELOADUI_FLAG) then OnPostReloadUI() end
end

--[[
    OnComponentUnload()
    Event handler for ON_COMPONENT_UNLOAD
]]--
function OnComponentUnload()
    -- Unbind Slash
    LIB_SLASH.UnbindCallback(Options['Core']['SlashHandles'])
end

--[[
    OnPreReloadUI()
    Event handler for ON_PRE_RELOADUI
]]--
function OnPreReloadUI()
    Component.SaveSetting(RELOADUI_FLAG, true)
end

--[[
    OnPostReloadUI()
    Called by OnComponentLoad if we just experienced a ReloadUI.
]]--
function OnPostReloadUI()
    Component.SaveSetting(RELOADUI_FLAG, false)
end


--[[
    OnOptionsLoaded()
    Called when Interface Options sends the __LOADED signal.
]]--
function OnOptionsLoaded()
    -- Setup Slash
    LIB_SLASH.BindCallback({slash_list=Options['Core']['SlashHandles'], description=Lokii.GetString('UI_Slash_Description'), func=OnSlash})

    -- Setup Tracker
    Tracker.Setup()

    -- Setup HUDTracker
    HUDTracker.Setup()

    -- Setup KeyBinder
    KeyBinder_Setup()

    -- Print version message
    if Options['Core']['VersionMessage'] then
        Messages.SendSystemMessage(Lokii.GetString('SystemMessage_Core_Version'), AddonInfo)
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
    State.inPlatoon = Platoon.IsInPlatoon()
    State.inSquad = Squad.IsInSquad() and not State.inPlatoon
    State.isPlatoonLeader = (State.inPlatoon and namecompare(State.playerName, Platoon.GetLeader()))
    State.isSquadLeader = (State.inSquad and namecompare(State.playerName, Squad.GetLeader()))
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
    LootPanelManager.OnTrackerNew(args)

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
    Debug.Event(args)

    -- Waypoints
    WaypointManager.OnTrackerLooted(args)

    -- Panels
    LootPanelManager.OnTrackerLooted(args)

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
    LootPanelManager.OnTrackerRemove(args)

    -- HUDTracker
    HUDTracker.OnTrackerRemove(args)
end

--[[
    OnClose()
    Called when user presses close or escape button on filtering ui.
]]--
function OnClose(args)
    Options.ToggleFilteringUI(false);
end

--[[
    OnSlash(args)
    Callback handler for LIB_SLASH.
]]--
function OnSlash(args)
    -- Help / command list
    if not args[1] or args[1] == 'help' or args[1] == '?' then
        Messages.SendSystemMessage(Lokii.GetString('SystemMessage_Core_Version'), AddonInfo)
        Messages.SendSystemMessage(Lokii.GetString('SystemMessage_Slash_Help_TitleStandard'))
        Messages.SendSystemMessage('/lt : '..Lokii.GetString('SystemMessage_Slash_Help_Command_Help'))
        Messages.SendSystemMessage('/lt blacklist : '..Lokii.GetString('SystemMessage_Slash_Help_Command_Blacklist'))
        Messages.SendSystemMessage('/lt clear : '..Lokii.GetString('SystemMessage_Slash_Help_Command_Clear'))
        Messages.SendSystemMessage('/lt refresh : '..Lokii.GetString('SystemMessage_Slash_Help_Command_Refresh'))
        Messages.SendSystemMessage('/lt wp : '..Lokii.GetString('SystemMessage_Slash_Help_Command_WaypointVisibility'))

        if Options['Debug']['Enabled'] then
            Messages.SendSystemMessage(Lokii.GetString('SystemMessage_Slash_Help_TitleDebug'))
            Messages.SendSystemMessage('/lt fake : Toggle HUDTracker fake mode.')
            Messages.SendSystemMessage('/lt stat : Log state.')
            Messages.SendSystemMessage('/lt test [number|any] : Fake detection of items.')
        end

    -- Refresh
    elseif args[1] == 'refresh' then
        Slash_Refresh(args)

    -- Clear
    elseif args[1] == 'clear' then
        Slash_Clear(args)

    -- Waypoint Visiblity
    elseif args[1] == 'wp' or args[1] == 'wps' or args[1] == 'waypoints' or args[1] == 'wayman' or args[1] == 'way' then
        if not args[2] then
            WaypointManager.ToggleVisibility()
        end

    -- Blacklist
    elseif args[1] == 'blacklist' then
        Slash_Blacklist(args)

    -- Filtering
    elseif args[1] == 'filtering' or args[1] == 'f2' then
        Slash_Filtering(args)


    -- Debug/testing commands, subject to change
    elseif args[1] == 'test' then
        Slash_Test(args)

    elseif args[1] == 'stat' then
        Slash_Stat(args)

    elseif args[1] == 'fake' or args[1] == 'htFake' then
        if HUDTracker.IsInFakeMode() then
            HUDTracker.ExitFakeMode()
        else
            HUDTracker.EnterFakeMode()
        end

    -- Note: To be removed
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
        Messages.SendSystemMessage('Toggled a feature in-memory (maybe).')

    -- Note: To be removed
    elseif args[1] == 'stop' then
        Messages.SendSystemMessage('Setting features to disabled in-memory.')
        Options['Core']['Enabled'] = false
        Options['Tracker']['Enabled'] = false
        Options['Waypoints']['Enabled'] = false
        Options['HUDTracker']['Enabled'] = false
        Options['Sounds']['Enabled'] = false
        Options['Messages']['Enabled'] = false
        Options['Panels']['Enabled'] = false

    -- Note: To be removed
    elseif args[1] == 'no' or args[1] == 'stfu' or args[1] == 'silence' then
        Messages.SendSystemMessage('Setting messages to disabled in-memory.')
        Options['Messages']['Enabled'] = false
    end
end

--[[
    Slash_Clear(args)
    The Clear Slash Command.
    Attempts to remove all tracked items cleanly.
--]]
function Slash_Clear(args)
    Debug.Log('Slash_Clear')
    Tracker.Clear()
    Messages.SendSystemMessage(Lokii.GetString('SystemMessage_Slash_Clear'))
end

--[[
    Slash_Blacklist(args)
    The Blacklist Slash Command.
    Allows for blacklisting specific items from specific parts of the addon.
--]]
function Slash_Blacklist(args)
    Debug.Table('Slash_Blacklist', args)
    Messages.SendSystemMessage(Lokii.GetString('SystemMessage_Slash_Blacklist'))
    -- args[2] == action
    -- args[3] == scope
    -- args[4+] == itemTypeId or string to use to find itemTypeId
    -- args.text entire thing

    if not args[2] or not args[3] then
        Messages.SendSystemMessage(Lokii.GetString('SystemMessage_Slash_Blacklist_Syntax'))
        Messages.SendSystemMessage(Lokii.GetString('SystemMessage_Slash_Blacklist_Error_NoArgs'))
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

                local data = Blacklist.Get({scopeKey=scopeKey})
                if not _table.empty(data) then
                    Debug.Table('blacklist list', data)

                    local results = {Messages.GetFormattedMessage(Lokii.GetString('SystemMessage_Slash_Blacklist_View'), {scope=scopeKey})}

                    for itemTypeId, value in pairs(data) do
                        local itemInfo = Game.GetItemInfoByType(itemTypeId)
                        if not itemInfo then
                            Debug.Warn('Invalid itemTypeId in blacklist') 
                        else
                            results[#results + 1] = tostring(itemInfo.name) .. ' (' .. tostring(itemInfo.itemTypeId) ..')'
                        end
                    end

                    local message = table.concat(results, '\n')

                    Messages.SendSystemMessage(message)
                    return
                else
                    reason = Lokii.GetString('SystemMessage_Slash_Blacklist_View_Error_Empty')
                end

            elseif actionKey == 'clear' then

                local count = Blacklist.Clear({scopeKey=scopeKey})
                if count > 0 then
                    Messages.SendSystemMessage(Lokii.GetString('SystemMessage_Slash_Blacklist_Clear'), {count=tostring(count), scope=scopeKey})
                    return
                else
                    reason = Lokii.GetString('SystemMessage_Slash_Blacklist_Clear_Error_Empty')
                end

            else

                if not args[4] then
                    reason = Lokii.GetString('SystemMessage_Slash_Blacklist_AddOrRem_Error_NoArg')

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
                            reason = Messages.GetFormattedMessage(Lokii.GetString('SystemMessage_Slash_Blacklist_AddOrRem_Error_NoItemInfo'), {query=searchName})
                        elseif _table.empty(itemInfo) then
                            reason = Messages.GetFormattedMessage(Lokii.GetString('SystemMessage_Slash_Blacklist_AddOrRem_Error_BadItemInfo'), {query=searchName})
                        end

                    end

                    -- If we have itemInfo, add to blacklist.
                    if itemInfo and not _table.empty(itemInfo) then

                        if actionKey == 'add' then
                            local result = Blacklist.Add({scopeKey=scopeKey, itemTypeId=itemInfo.itemTypeId})
                            if result then
                                success = true
                            elseif result == false then
                                reason = Lokii.GetString('SystemMessage_Slash_Blacklist_Add_Error_AlreadyExists')
                            else
                                reason = Lokii.GetString('SystemMessage_Slash_Blacklist_AddOrRem_Error_UnknownError')
                            end
                        elseif actionKey == 'remove' or actionKey == 'rem' then
                            local result = Blacklist.Remove({scopeKey=scopeKey, itemTypeId=itemInfo.itemTypeId})
                            if result then
                                success = true
                            elseif result == false then
                                reason = Lokii.GetString('SystemMessage_Slash_Blacklist_Rem_Error_NotListed')
                            else
                                reason = Lokii.GetString('SystemMessage_Slash_Blacklist_AddOrRem_Error_UnknownError')
                            end
                        end
                    end

                    if success then
                        if actionKey == 'add' then
                            Messages.SendSystemMessage(Lokii.GetString('SystemMessage_Slash_Blacklist_Add'), {name=tostring(itemInfo.name), typeId=tostring(itemInfo.itemTypeId), scope=scopeKey})

                        elseif actionKey == 'remove' or actionKey == 'rem' then
                            Messages.SendSystemMessage(Lokii.GetString('SystemMessage_Slash_Blacklist_Rem'), {name=tostring(itemInfo.name), typeId=tostring(itemInfo.itemTypeId), scope=scopeKey})
                        end
                        return
                    end
                end

            end



        -- If we don't have the scopeKey, invalid input!
        else
            reason = Lokii.GetString('SystemMessage_Slash_Blacklist_Error_NoScope')
        end

    else
        reason = Lokii.GetString('SystemMessage_Slash_Blacklist_Error_NoAction')
    end



    Messages.SendSystemMessage(Lokii.GetString('SystemMessage_Slash_Blacklist_Error_Reason'), {reason=reason})
end

--[[
    Slash_Refresh(args)
    The Refresh Slash Command.
    Attempts to update all tracked items so that their status is refreshed.
--]]
function Slash_Refresh(args)
    Debug.Log('Slash_Refresh')
    Tracker.Refresh()
    Messages.SendSystemMessage(Lokii.GetString('SystemMessage_Slash_Refresh'))
end


function Slash_Filtering(args)
    Debug.Log('Slash_Filtering')
    Options.ToggleFilteringUI(true)
    Messages.SendSystemMessage('Filtering')
end




function Slash_Test(args)
    table.remove(args, 1)

    Debug.Log('Slash_Test')
    Debug.Log('args[1]: '..tostring(args[1]))
    Debug.Log('args[2]: '..tostring(args[2]))

    Messages.SendSystemMessage('Test')


    if true then


        local numberOfItems = 3
        if args[1] ~= nil then numberOfItems = tonumber(args[1]) end

        local targetInfoData = {

            -- Equipment
            {itemTypeId = 116407}, -- Necro Crossbow
            {itemTypeId = 114020}, -- Smart Blaster
            {itemTypeId = 114314}, -- Assault Rifle Secondary
            {itemTypeId = 114176}, -- Remote Explosive

            {itemTypeId = 114075}, -- epic bolt driver
            {itemTypeId = 98732}, -- blue bolt driver
            {itemTypeId = 97936}, -- epic marksman rifle
            {itemTypeId = 98122}, -- green fusion cannon

            {itemTypeId = 129494}, -- aux energy sword
            {itemTypeId = 130224}, -- aux chem grenade
            {itemTypeId = 129640}, -- aux scan hammer

            {itemTypeId = 125917}, -- epic headgear
            {itemTypeId = 125683}, -- blue headgear
            {itemTypeId = 125550}, -- green headger

            {itemTypeId = 113517}, -- ability
            {itemTypeId = 114120}, -- hkm

            -- Modules
            {itemTypeId = 123219}, -- green module
            {itemTypeId = 123384}, -- crap module
            {itemTypeId = 123818}, -- legendary module
            {itemTypeId = 123874}, -- blue module



            {itemTypeId = 54003}, -- sonic detonator


            -- Moduled Item
            --{itemTypeId = 98937, modules = {94145}},

            -- Components
            --[[
            {itemTypeId = 86695}, -- Biomass Samples
            {itemTypeId = 86681},
            {itemTypeId = 86682},
            {itemTypeId = 86698}, -- Crystatic Bio fluids?
            --]]

            -- Salvage
            --[[
            {itemTypeId = 52206}, -- Recovered Chosen Tech
            {itemTypeId = 30408}, -- Broken Bandit Gear
            {itemTypeId = 86398}, -- Half Digested Module
            --]]
            
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








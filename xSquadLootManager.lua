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

-- Custom Libs
require './lib/Lokii' -- Localization
require './lib/lib_GTimer' -- Timer for rolltimeout
require './lib/lib_LKObjects' -- Trivialize objects

-- Constants
csVersion = '0.91 Janstone T1'
ciSaveVersion = 0.90

-- Global Variables
aSquadRoster = {} -- The latest squad roster
aIdentifiedLoot = {} -- Currently tracked items

bLoaded = false -- Set by the __LOADED message through options, allowing me to hold back sounds when the addon loads all the settings
bInSquad = false -- Whether we are currently in a squad or not
bIsSquadLeader = false -- Whether we are currently the squad leader or not
bHUD = false -- Whether game wants HUD to be displayed or not, updated by OnHudShow
bCursor = false -- Whether game is in cursor mode or not, updated by OnInputModeChanged
bTooltipActive = false -- Whether addon is currently utilizing the Tooltip. Updated manually within the addon when Tooltip.Show is called. There are situations unrelated to mouse location where I might want to hide the tooltip if it is displaying. Just calling Tooltip.Show(false) could interfere with other addons, so I use this variable to keep track of when I've called it. As long as no other addon/ui element randomly calls Tooltip.Show (without mine being unfocused) it should serve its purpose.

mCurrentlyRolling = false -- Reference to an item in the aIdentifiedLoot table when that item is being rolled, false when no item is being rolled.

iRoundRobinIndex = 1 -- Used to traverse the squad roster when distributing loot in round-robin mode

-- LK Objects
require './object/lootpanel' -- Loot Panel

-- Util
require './util/DWFrameIdx' -- Database to determine which frame/s that any ability module belongs to
require './util/xSounds' -- Database of sounds
require './util/xItemFormatting' -- Awesome functions from lib_Items that weren't available for use. Used by tracker when generating tooltips.
require './util/xBattleframes' -- Battleframe stuff

-- Data
require './data/CraftingComponents'
require './data/FrameWebIcons'
require './data/ItemNamePrefixes'

-- Addon Core
require './types'   -- Types
require './options' -- Options

-- Addon Modules
require './communication' -- Communication
require './markers' -- Markers (Panels / Waypoints)
require './detection' -- Detection
require './distribution' -- Distribution
require './messages' -- Messages
require './tracker' -- Tracker

-- Functions
--[[
    OnComponentLoad()
    Callback on ComponentLoad
    Sets up Interace options, slash commands and prints a version message
]]--
function OnComponentLoad()
    -- Setup Lokii
    Lokii.AddLang('en', './lang/EN');
    Lokii.SetBaseLang('en');
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
    LIB_SLASH.BindCallback({slash_list='xslm,slm', description='/slm : Xsear\'s Squad Loot Manager', func=OnSlash})

    -- Setup In game Objects
    LKObjects.SetMemoryWarning(20) -- should be about 5 panels

    -- Best make sure the tracker is set up
    Tracker.Update()

    -- Setup Communication links
    Communication.Setup()

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
    local hide = args.loading_screen or args.logout_bonus or args.freecamera or args.sinvironment
    bHUD = not hide
    Tracker.Update()
end

--[[
    OnHudShow(args)
    Callback for MY_HUD_HIDE_REQUEST
    Used to determine if the tracker should be displayed or not.
]]--
function OnHideHudRequest(args)
    bHUD = not args.hide
    Tracker.Update()
end

--[[
    OnInputModeChanged(args)
    Callback for ON_INPUT_MODE_CHANGED event.
    Used to determine if the tracker should be displayed or not.
]]--
function OnInputModeChanged(args)
    --Debug.Log('OnInputModeChanged')
    bCursor = (args.mode == 'cursor')
    Tracker.Update()
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
        if Options['Debug']['AlwaysSquadLeader'] then
            bIsSquadLeader = true
        else
            bIsSquadLeader = IsSquadLeader(Player.GetInfo())
        end

        -- Reset Round Robin if members changed
        if previousRosterMemberCount ~= #aSquadRoster.members then
            iRoundRobinIndex = 1
            Debug.Log('OnSquadRosterUpdate resetting iRoundRobinIndex to '..tostring(iRoundRobinIndex))
        end


    -- Not in Squad
    else
        -- Update Squad status
        if Options['Debug']['Enabled'] and Options['Debug']['FakeOnSquadRoster'] then
            bInSquad = true
            Debug.Log('OnSquadRosterUpdate faking a squad roster')
            aSquadRoster = {members={{name=Player.GetInfo(), battleframe='medic'}, {name='SquadRosterUpdateFake1', battleframe='berzerker'}, {name='SquadRosterUpdateFake2', battleframe='recon'}}}
            iRoundRobinIndex = 1
            Debug.Log('OnSquadRosterUpdate resetting iRoundRobinIndex to '..tostring(iRoundRobinIndex))
        else
            bInSquad = false
        end

        -- Update Squad leader status
        if Options['Debug']['AlwaysSquadLeader'] then
            bIsSquadLeader = true

            if Options['Debug']['FakeOnSquadRoster'] then
                aSquadRoster.leader = Player.GetInfo()
            end

        else
            bIsSquadLeader = false
        end
    end

    --Debug.Log('OnSquadRosterUpdate','| bInSquad: '..tostring(bInSquad), '| bIsSquadLeader: '..tostring(bIsSquadLeader), '| aSquadRoster: '..tostring(aSquadRoster))

    -- Update tracker
    Tracker.Update()

end

--[[
    OnSlash(args)
    Callback function for Slash commands
]]--
function OnSlash(args)
    -- Help / command list
    if args.text == '' or args.text == 'help' or args.text == '?' then
        SendChatMessage('system', 'Xsear\'s Squad Loot Manager v'..csVersion)
        SendChatMessage('system', 'Slash Commands')
        SendChatMessage('system', '/slm [help|?]: Version message and command list.')
        SendChatMessage('system', '/slm <enable|disable|toggle> : Turn addon on or off.')
        SendChatMessage('system', '/slm <distribute|roll|next> : Distribute first rollable item.')
        SendChatMessage('system', '/slm cancel : Cancel an ongoing roll.')
        SendChatMessage('system', '/slm list : List rollable items.')
        SendChatMessage('system', '/slm clear : Clear tracked items.')

        if Options['Debug']['Enabled'] then
            SendChatMessage('system', 'Debug Commands')
            SendChatMessage('system', '/slm test [filter|any] [number|any] : Fake detection of items.')
            SendChatMessage('system', '/slm assign <entityId> <playerName> : Assign an item to a player.')
            SendChatMessage('system', '/slm <stfu|silence|no> : Forcefully disables Messages and Distribution.')
            SendChatMessage('system', '/slm ut : Force Tracker.Update()')
            SendChatMessage('system', '/slm us : Force OnSquadRosterUpdate()')
        end

    -- Toggle
    elseif args.text == 'enable' or args.text == 'disable' or args.text == 'toggle' then
        ToggleEnabled(args.text)

    -- Distribute
    elseif args.text == 'distribute' or args.text == 'roll' or args.text == 'next' then
        DistributeNextItem()

    -- Cancel
    elseif args[1] == 'cancel' then
        RollCancel({reason=args[2]})

    -- List
    elseif args.text == 'list' then
        ListUnAssigned()

    -- Clear
    elseif args.text == 'clear' then
        ClearIdentified()

    -- Debug/testing commands, subject to change
    elseif args[1] == 'test' then
        Test({args[2], args[3]})

    elseif (args[1] == 'assign' or args[1] == 'a') and args[2] and args[3] then
        Distribution.AssignItem(args[2], args[3])

    elseif args.text == 'no' or args.text == 'stfu' or args.text == 'silence' then
        Options['Messages']['Enabled'] = false
        Options['Distribution']['Enabled'] = false
        SendChatMessage('system', 'Forcefully disabled Messages and Distribution. Reload the UI to reset.')

    elseif args.text == 'ut' then
        Tracker.Update()

    elseif args.text == 'us' then
        OnSquadRosterUpdate()
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
        if Options['Debug']['Enabled'] and Options['Debug']['LogLootableTargets'] and IsSquadLoot(targetInfo) then
            Debug.Table({'Lootable Target Available', targetInfo = targetInfo, itemInfo = itemInfo})
        end

        -- Determine if it is a lootable entity
        if IsSquadLoot(targetInfo) and IsTrackableItem(itemInfo) then

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
    Used to handle Roll Decisions from non-SLM members.
]]--
function OnChatMessage(args)
    -- Requires Core and Distribution enabled
    if not Options['Core']['Enabled'] or not Options['Distribution']['Enabled'] then return end

    -- Filter for only Squad messages
    if args.channel == 'squad' then

        -- If we are looking for roll decisions
        if mCurrentlyRolling and bIsSquadLeader then
            local rollType = nil
            args.text = unicode.lower(args.text)
            if args.text == 'n' or unicode.find(unicode.lower(args.text), '^nee+d$') ~= nil then
                rollType = RollType.Need
            elseif args.text == 'g' or unicode.find(unicode.lower(args.text), '^gree+d$') ~= nil then
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
    OnLootPickup(args)
    This event is called when other players loot things.
    Currently just redirecting to OnLootCollected should be fine.
]]--
function OnLootPickup(args)
    -- Don't send if the item was looted by and to the local player - preventing double messages.
    if namecompare(args.lootedTo, Player.GetInfo()) and namecompare(args.lootedBy, Player.GetInfo()) then 
        --Debug.Log('Skipping OnLootPickup event because conditions ensure OnLootCollected.')
        return 
    end

    -- Redirect to OnLootCollected
    OnLootCollected(args)
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
    if not args.itemTypeId then 
        Debug.Event(args)
        Debug.Error('OnLootCollected requires args.itemTypeId') 
        return 
    end

    -- Fix quality argument if nonexistant
    if not args.quality then
        args.quality = 0
    end


    -- Get item info
    local itemInfo = Game.GetItemInfoByType(args.itemTypeId, Game.GetItemAttributeModifiers(args.itemTypeId, args.quality))

    -- Is it loot that we care about?
    if itemInfo and IsTrackableItem(itemInfo) then

        -- Debug Log
        if Options['Debug']['Enabled'] and Options['Debug']['LogLootableCollection'] then
            Debug.Table({'OnLootCollected', itemInfo = itemInfo})
        end


        -- Todo: Check if we have assigned any items, if not just skip to Claimed ?

        -- Okay, do we have any identified loot?
        if not _table.empty(aIdentifiedLoot) then

            -- Grab the first identified item that this item could be, checking that the entity is no longer available
            local loot = nil
            for num, item in ipairs(aIdentifiedLoot) do 
                Debug.Table({'Is it this item?', item})
                Debug.Log('item.itemTypeId == args.itemTypeId : '..tostring(item.itemTypeId == args.itemTypeId))
                Debug.Log('item.quality ('..tostring(item.quality)..') == args.quality ('..tostring(args.quality)..') : '..tostring(item.quality == args.quality))
                if item.itemTypeId == args.itemTypeId and item.quality == args.quality then
                    if Game.IsTargetAvailable(item.entityId) then
                        Debug.Log('Found looted item but target is still available ')
                        Debug.Table(Game.GetTargetInfo(item.entityId))
                    end
                    loot = item
                    break
                end
            end

            -- If we found the item, we will return from this function within this block after firing the appropriate event function.
            if loot ~= nil then

                -- If we care about this item, trigger relevant event
                local eventArgs = {
                    lootedTo   = args.lootedTo,
                    assignedTo = loot.assignedTo,
                    item       = loot
                }

                -- If the item had not been assigned
                if loot.assignedTo == nil then
                    OnLootSnatched(eventArgs)

                -- Else if the item was looted by the person it was assigned to
                elseif namecompare(loot.assignedTo, args.lootedTo) then
                    OnLootReceived(eventArgs)

                -- Else it was a ninja
                else
                    OnLootStolen(eventArgs)
                end

                -- End the function, we're done here.
                RemoveIdentifiedItem(loot)
                return

            end
        end

        -- This item wasn't being tracked.
        OnLootClaimed({
            lootedTo = args.lootedTo,
            item     = {
                name = itemInfo.name,
                itemTypeId = itemInfo.itemTypeId,
                quality = args.quality,
                itemInfo = itemInfo
            }
        })
    end
end

--[[
    OnIdentify(args)
    Callback for when a new item is identified.
    args.item - the newly identified item
    We use this to start automatic item distribution
]]--
function OnIdentify(args)
    Debug.Table(args)
    -- Require Core enabled
    if not Options['Core']['Enabled'] then return end

    -- Update the tracker
    Tracker.Update()

    -- Update the panel
    UpdatePanel(args.item)

    -- Play Sound
    -- Todo: SoundEvent
    if Options['Sounds']['Enabled'] and Options['Sounds']['OnIdentify'] then
        System.PlaySound(Options['Sounds']['OnIdentify'])
    end

    -- Messages
    MessageEvent('Detection', 'OnIdentify', args)

    -- Squad Leader only stuff
    if bIsSquadLeader then
        -- If auto distribute is enabled, distribute the item
        if Options['Distribution']['AutoDistribute'] then

            if not IsAssigned(args.item.entityId) and ItemPassesFilter(args.item, Options['Distribution']) then
                local typeKey, stageKey = GetItemOptionsKeys(args.item, Options['Distribution'])

                local distributionMode = DistributionMode.RoundRobin
                local weightingMode = WeightingOptions.None

                if typeKey and stageKey then
                    distributionMode = Options['Distribution'][typeKey][stageKey]['LootMode']
                    weightingMode = Options['Distribution'][typeKey][stageKey]['Weighting']
                end

                Distribution.DistributeItem(args.item, distributionMode, weightingMode)
            end
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
    Tracker.Update() -- Fixme: Is this call needed

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
    MessageEvent('Distribution', 'OnDistributeItem', args)
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
    Tracker.Update()

    -- Update panel
    UpdatePanel(args.item)

    -- Play Sound
    if Options['Sounds']['Enabled'] then
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





--[[
    ItemPassesFilter(item, moduleOptions)
    Determines whether the provided itemInfo is sufficient to pass the provided moduleOptions.
    Where moduleOptions is for example Options['Detection']
]]--
function ItemPassesFilter(item, moduleOptions)
    --Debug.Log('ItemPassesFilter called')

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
    elseif item.itemInfo.type == 'basic' and item.itemInfo.rarity == 'salvage' then
        typeKey = 'SalvageModules'
    end

    -- Verify that type passes filter
    if typeKey ~= nil and moduleOptions[typeKey]['Enabled'] then
        -- Determine stage
        if moduleOptions[typeKey]['Mode'] == TriggerModeOptions.Simple then
            stageKey = 'Simple'
        else -- TriggerModeOptions.Advanced
            if        item.itemInfo.tier.level == 0 then stageKey = 'Unstaged'
            elseif    item.itemInfo.tier.level == 1 then stageKey = 'Stage1'
            elseif    item.itemInfo.tier.level == 2 then stageKey = 'Stage2'
            elseif    item.itemInfo.tier.level == 3 then stageKey = 'Stage3'
            elseif    item.itemInfo.tier.level == 4 then stageKey = 'Stage4'   
            end
        end
        if stageKey == nil then Debug.Error('ItemPassesFilter() does not recognize tier!', item.itemInfo.tier) end
        
        -- Verify that stage passes filter
        -- WontFixMe: Bluuurgh --------------------------| wtf this coder can't plan for shit
        if (stageKey == 'Simple' and item.itemInfo.tier.level >= tonumber(moduleOptions[typeKey]['Simple']['TierThreshold'])) 
        or (stageKey ~= 'Simple' and moduleOptions[typeKey][stageKey]['Enabled']) then
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

    elseif not typeKey then
        Debug.Log('ItemPassesFilter unable to determine options typeKey for '..tostring(item.name)..', '..tostring(item.itemTypeId))
        return true -- Best chance of future compatability. Unrelated items shouldn't ever get here, since detection filters differently.
    end
    return false
end

--[[
    GetItemOptionsKeys(item, moduleOptions) 
    Returns type and stage key for an item
    shiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiit
]]--
function GetItemOptionsKeys(item, moduleOptions) 
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
    
    elseif item.itemInfo.type == 'basic' and item.itemInfo.rarity == 'salvage' then
        typeKey = 'SalvageModules'
    end


    if typeKey == nil then Debug.Warn('GetItemOptionsKeys() does not recognize type! (Why are you passing incorrect items)', item.itemInfo.type) return nil, nil end

    -- Determine stage
    if moduleOptions[typeKey]['Mode'] == TriggerModeOptions.Simple then
        stageKey = 'Simple'
    else -- TriggerModeOptions.Advanced
        if        item.itemInfo.tier.level == 0 then stageKey = 'Unstaged'
        elseif    item.itemInfo.tier.level == 1 then stageKey = 'Stage1'
        elseif    item.itemInfo.tier.level == 2 then stageKey = 'Stage2'
        elseif    item.itemInfo.tier.level == 3 then stageKey = 'Stage3'
        elseif    item.itemInfo.tier.level == 4 then stageKey = 'Stage4'   
        end
    end
    if stageKey == nil then Debug.Error('GetItemOptionsKeys() does not recognize tier!', item.itemInfo.tier) end
    
    -- Return
    return typeKey, stageKey
end


--[[
    IsSquadLoot(targetInfo)
    Whether a loot entity is Squad loot or not.
]]--
function IsSquadLoot(targetInfo)
    -- As of now, interactToLoot is the only indication we have that this is squad loot.
    if targetInfo.interactToLoot then
        return true
    end
    return false
end

--[[
    IsTrackableItem(itemInfo)
    Whether or not an item (post pickup) was a lootable target (ish)
]]--
function IsTrackableItem(itemInfo)
    -- Verify that the looted item is of a type that we care about
    if IsSalvageModule(itemInfo) or IsEquipmentItem(itemInfo) or IsCraftingComponent(itemInfo) then
        return true
    end

    return false
end

--[[
    IsEquipmentItem([itemInfo(table)|itemType])
    Whether or not an item type classifies it as an Equipment Item
]]--
function IsEquipmentItem(info)
    -- Handle arguments
    local itemType
    if type(info) == 'table' then itemType = info.type
    else itemType = tostring(info) end

    local EquipmentItemTypes = {
        'frame_module',
        'ability_module',
        'weapon',
    }

    for i, v in ipairs(EquipmentItemTypes) do
        if itemType == v then
            return true
        end
    end

    return false
end

--[[
    IsCraftingComponent([itemInfo(table)|itemType])
    Whether or not an item type classifies it as a Crafting Component
]]--
function IsCraftingComponent(info)
    -- Handle arguments
    local itemType
    if type(info) == 'table' then itemType = info.type
    else itemType = tostring(info) end

    local CraftingComponentTypes = {
        'crafting_component',
    }

    for i, v in ipairs(CraftingComponentTypes) do
        if itemType == v then
            return true
        end
    end

    return false

end

function IsSalvageModule(itemInfo)
    if type(itemInfo) ~= 'table' then
        Debug.Warn('IsSalvageModule needs itemInfo, expects table (.type, .rarity), got '..type(itemInfo))
        return false
    end

    if(itemInfo.type == 'basic' and itemInfo.rarity == 'salvage') then
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
    IsIdentified(entityId)
    Whether or not an entity has been found and identified before
]]--
function IsIdentified(entityId)
    local stringType = (type(entityId) == 'string')
    if not _table.empty(aIdentifiedLoot) then
        for num, item in ipairs(aIdentifiedLoot) do 
            if (stringType and tostring(item.entityId) == entityId) or (item.entityId == entityId) then
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

--[[
    IsAssigned(entityId)
    Whether or not given entityId is an Identified Item that has been assigned to a player
]]--
function IsAssigned(entityId)
    local stringType = (type(entityId) == 'string')
    if not _table.empty(aIdentifiedLoot) then
        for num, item in ipairs(aIdentifiedLoot) do 
            if (stringType and tostring(item.entityId) == entityId) or (item.entityId == entityId) and item.assignedTo ~= nil then
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
    if mCurrentlyRolling == loot.entityId then RollCancel({reason='The item is no longer being tracked.'}) end

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

    Tracker.Update()
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
            Debug.Table(item)
            if not IsAssigned(item.entityId) then
                table.insert(unAssignedLoot, item)
            end
        end

        if unAssignedLoot ~= nil then
            for num, item in ipairs(unAssignedLoot) do
                SendFilteredMessage('system', num..': %i E:('..tostring(item.entityId)..') I:('..tostring(item.identityId)..')', {item=item})
            end
        else
            SendChatMessage('system', Lokii.GetString('UI_Messages_System_NoRollableForDistribute'))
        end
    else
        SendChatMessage('system', Lokii.GetString('UI_Messages_System_NoIdentifiedForDistribute'))
    end
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

    return unicode.gsub(name, '%^Q', tostring(quality))
end


function itemPrefixShortener(itemName)
    for key, prefix in pairs(data_ItemNamePrefixes) do
        --Debug.Log('Checking for '..key..' in '..itemName)
        if unicode.find(itemName, key, 0, unicode.len(key)) then
            --Debug.Log('Found '..key..' in '..itemName..', replacing with '..prefix)
            itemName = prefix..unicode.sub(itemName, unicode.len(key) + 1)
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
    SendChatMessage('system', 'Toggle')
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
    SendChatMessage('system', 'Clear')
    RollCancel({reason='Clearing tracked items.'})

    local itemsToRemove = {}
    for num, item in ipairs(aIdentifiedLoot) do 
        itemsToRemove[#itemsToRemove + 1] = item
    end

    for num, item in ipairs(itemsToRemove) do
        RemoveIdentifiedItem(item)
    end

    --aIdentifiedLoot = {}
    
    Tracker.Update()
end


function ActionRollDecision(args)
    System.PlaySound('Play_UI_Beep_06')
    SendFilteredMessage('system', 'Declaring %t on %i', args)

    -- If we are the squad leader, then we must manually call RollDecision since we ignore our own communication messages
    if bIsSquadLeader then
        RollDecision({author = Player.GetInfo(), rollType = args.rollType})
    end

    Communication.SendRollDecision(args.item, args.rollType)
end


-- Todo: Comment (what can I say, does exactly what it looks like), figure out what to do if we don't know the frame or potential universal frame icon or something
-- Todo: Move elsewhere?
function GetFrameWebIconByName(frameName)
    return data_FrameWebIcons[frameName]
end 



--[[
    Test()
    Testing function please ignore
]]--
function Test(args)

    SendChatMessage('system', 'Test')

    Debug.Log('Test')

    Debug.Log('Core_Enabled: '..tostring(Options['Core']['Enabled']))
    Debug.Log('Debug_SquadToArmy: '..tostring(Options['Debug']['SquadToArmy']))
    Debug.Log('Debug_FakeSquadRoster: '..tostring(Options['Debug']['FakeOnSquadRoster']))
    Debug.Log('Debug_AlwaysSquadLeader: '..tostring(Options['Debug']['AlwaysSquadLeader']))

    Debug.Log('bIsSquadLeader: '..tostring(bIsSquadLeader))
    Debug.Log('bInSquad: '..tostring(bInSquad))

    Debug.Log('args[1]: '..tostring(args[1]))
    Debug.Log('args[2]: '..tostring(args[1]))

    Debug.Table('numeric', Game.GetItemAttributeModifiers(85974, 1000))
    Debug.Table('stringType', Game.GetItemAttributeModifiers('85974', 1000))
    Debug.Table('stringQuality', Game.GetItemAttributeModifiers(85974, '1000'))
    Debug.Table('string', Game.GetItemAttributeModifiers('85974', '1000'))

    if true then
        -- First parameter sets filters
        local filterType = args[1] or 'any'
        Debug.Log('filterType: '..tostring(filterType))

        -- Second parameter to test controls number of panels
        local numberOfPanels = args[2] or 1
        Debug.Log('numberOfPanels: '..tostring(numberOfPanels))

        -- Target info must be faked because we have no real entity
        local targetInfoData = {
            -- Equipment Items

            {itemTypeId=85972, quality=500, filterType = {'eq', 'weapons'}}, -- needlar
            {itemTypeId=85984, quality=600, filterType = {'eq', 'weapons'}}, -- assault rifle
            {itemTypeId=86054, quality=500, filterType = {'eq', 'hkm'}}, -- chemical sprayer
            {itemTypeId=86021, quality=400, filterType = {'eq', 'passive'}}, -- regen plating
            {itemTypeId=86018, quality=500, filterType = {'eq'}}, -- platin
            {itemTypeId=85990, quality=500, filterType = {'eq', 'neutral'}}, -- servos/jumpjets
            {itemTypeId=85989, quality=801, filterType = {'eq', 'neutral'}},
            {itemTypeId=86114, quality=23, filterType = {'eq', 'ability', 'abilities'}},

            -- Crossbows ftw
            {itemTypeId=85974, quality=125, filterType = {'cb', 'crossbow', 'weapons', 'eq'}},
            {itemTypeId=85974, quality=250, filterType = {'cb', 'crossbow', 'weapons', 'eq'}},
            {itemTypeId=85974, quality=500, filterType = {'cb', 'crossbow', 'weapons', 'eq'}},
            {itemTypeId=85974, quality=801, filterType = {'cb', 'crossbow', 'weapons', 'eq'}},
            {itemTypeId=85974, quality=1000, filterType = {'cb', 'crossbow', 'weapons', 'eq'}},


            -- Crafting Components
            {itemTypeId=10009, quality=1, filterType = {'cc'}},
            {itemTypeId=10010, quality=101, filterType = {'cc'}},
            {itemTypeId=10011, quality=201, filterType = {'cc'}},
            {itemTypeId=10012, quality=301, filterType = {'cc'}},
            {itemTypeId=10014, quality=401, filterType = {'cc'}},
            {itemTypeId=10015, quality=501, filterType = {'cc'}},
            {itemTypeId=10016, quality=601, filterType = {'cc'}},
            {itemTypeId=10024, quality=701, filterType = {'cc'}},
            {itemTypeId=82500, quality=801, filterType = {'cc'}},
            {itemTypeId=85235, quality=901, filterType = {'cc'}},
            {itemTypeId=85626, quality=1000, filterType = {'cc'}},
            {itemTypeId=85627, quality=50, filterType = {'cc'}},

            -- Salvage Modules
            {itemTypeId=86398, quality=0, filterType = {'sm', 'salvage', 'tech'}}, -- half-digested
            {itemTypeId=86404, quality=0, filterType = {'sm', 'salvage', 'tech'}}, -- chosen
        }

        -- Filter
        if filterType and filterType ~= 'any' then
            for num, targetInfo in pairs(targetInfoData) do
                for k, v in ipairs(targetInfo.filterType) do
                    if v == filterType then targetInfo.match = true break end
                end
            end

            local i=1
            while i <= #targetInfoData do
                if not targetInfoData[i].match then
                    table.remove(targetInfoData, i)
                else
                    i = i + 1
                end
            end
        end

        -- Determine all
        if numberOfPanels == 'all' then numberOfPanels = #targetInfoData end
       
        -- Create
        for num = 1, tonumber(numberOfPanels) do
            -- Get random targetInfo unless exactly all were specified
            if numberOfPanels ~= #targetInfoData then
                targetInfo = targetInfoData[math.random(#targetInfoData)]
            -- Else numberOfPanels == #targetInfoData then get one of all kinds
            else
                targetInfo = targetInfoData[num]
            end

            -- Location
            entityId = num
            targetInfo.lootPos = {x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}
            local posMod = (1*(num-(1*(num%2)))) * (-1 + (2*(num%2))) 

            --Debug.Log('Position modifier for num '..tostring(num)..': '..tostring(posMod))
            targetInfo.lootPos.x = targetInfo.lootPos.x - posMod

            -- Identify Hack
            if not IsIdentified(entityId) then

                Identify(entityId, targetInfo, itemInfo)
            end

        end

    else

        -- Entity id is set to player because we have no real options here
        --    local entityId = Player.GetTargetId()

    end
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

function _table.compare(t1,t2,ignore_mt)
    local ty1 = type(t1)
    local ty2 = type(t2)
    if ty1 ~= ty2 then return false end
    -- non-table types can be directly compared
    if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
    -- as well as tables which have the metamethod __eq
    local mt = getmetatable(t1)
    if not ignore_mt and mt and mt.__eq then return t1 == t2 end
    for k1,v1 in pairs(t1) do
        local v2 = t2[k1]
        if v2 == nil or not _table.compare(v1,v2) then return false end
    end
    for k2,v2 in pairs(t2) do
        local v1 = t1[k2]
        if v1 == nil or not _table.compare(v1,v2) then return false end
    end
    return true
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- Source: http://lua-users.org/wiki/MakingLuaLikePhp
-- Credit: http://richard.warburton.it/
function explode(div,str)
    if (div=='') then return false end
    local pos,arr = 0,{}
    for st,sp in function() return unicode.find(str,div,pos,true) end do
        table.insert(arr,unicode.sub(str,pos,st-1))
        pos = sp + 1
    end
    table.insert(arr,unicode.sub(str,pos))
    return arr
end
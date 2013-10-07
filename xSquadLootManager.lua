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
require 'lib/lib_Button' -- Buttons!

-- Custom
require './lib/Lokii' -- Localization
require './lib/lib_GTimer' -- Timer for rolltimeout
require './lib/lib_LKObjects' -- 3d markers
require './obj/panel/panel' -- 3d marker template
require './util/DWFrameIdx' -- Database to determine which frame/s that any ability module belongs to
require './util/xSounds' -- Database of sounds

-- Frames
TRACKER = Component.GetFrame('Tracker')
TRACKER_TOOLTIP = LIB_ITEMS.CreateToolTip(TRACKER)

-- Constants
csVersion = '0.77'
ciSaveVersion = 0.67

local ciLootDespawn = 20 -- Seconds into the future that the callback that checks if an item entity is still around is set to. Used to remove despawned or otherwise glitched out items
local ciSquadMessageLengthLimit = 256 -- Character limit of Squad chat messages. Used to split too long messages into multiple.

-- Variables
local aSquadRoster = {} -- The latest squad roster
local aIdentifiedLoot = {} -- Currently tracked items

local bLoaded = false -- Set by the __LOADED message through options, allowing me to hold back sounds when the addon loads all the settings
local bInSquad = false -- Whether we are currently in a squad or not
local bIsSquadLeader = false -- Whether we are currently the squad leader or not

local bHUD = false -- Whether game wants HUD to be displayed or not, updated by OnHudShow
local bCursor = false -- Whether game is in cursor mode or not, updated by OnInputModeChanged

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

    -- Setup Interface Options
    SetupInterfaceOptions()

    -- Best make sure option visibility is set up quickly
    UpdateOptionVisibility()

    -- Best make sure to update the squad roster so we set the var
    OnSquadRosterUpdate()

    -- Setup Slash Commands
    LIB_SLASH.BindCallback({slash_list='slm', description='/slm : Xsear\'s Squad Loot Manager', func=OnSlash})

    -- Setup In game Objects
    LKObjects.SetMemoryWarning(20) -- should be about 5 panels

    -- Best make sure the tracker is set up
    UpdateTracker()

    -- Setup Debug
    Debug.EnableLogging(Component.GetSetting('DebugMode'))

    -- Print version message
    if Component.GetSetting('VersionMessage') then
        SendSystemMessage('Xsear\'s Squad Loot Manager v'..csVersion..' Loaded')
    end
end

--[[
    OnHudShow(args)
    Callback for MY_HUD_SHOW event.
    Used to determine if the tracker should be displayed or not.
]]--
function OnHudShow(args)
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
    if aSquadRoster ~= nil and not table.empty(aSquadRoster) then
        previousRosterMemberCount = #aSquadRoster.members
    end

    -- Update squad roster
    aSquadRoster = Squad.GetRoster()

    -- If in Squad
    if aSquadRoster ~= nil and not table.empty(aSquadRoster) then
        -- Update Squad status
        bInSquad = true

        -- Update Squad Leader status
        if Options['AlwaysSquadLeader'] then
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
        if Options['AlwaysSquadLeader'] then
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
        SendSystemMessage('/slm mode : Outputs current ruleset')
        SendSystemMessage('/slm <dice|round-robin|need-before-greed|random> : Set new ruleset')
        SendSystemMessage('/slm <distribute|roll> : Distribute first rollable item')
        SendSystemMessage('/slm list : List rollable items')
        SendSystemMessage('/slm clear : Clears list of identified items')
    elseif args.text == 'test' then
        Test()
    elseif args.text == 'clear' then
        ClearIdentified()
    elseif args.text == 'enable' or args.text == 'disable' or args.text == 'toggle' then
        ToggleEnabled(args.text)
    elseif args.text == 'mode' then  
        SendSystemMessage('Current Mode: '..Options['Manager']['LootMode'])
    elseif args.text == 'dice' or args.text == 'round-robin' or args.text == 'need-before-greed' or args.text == 'random' then
        OnOptionChange({id='LootMode', val=args.text})
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
    -- Exit if addon is disabled
    if not Options['Enabled'] then return end

    -- Filter away any entities that are not loot
    if args.type == 'loot' then
        -- Get more info about the entity
        local targetInfo = Game.GetTargetInfo(args.entityId)
        local itemInfo = Game.GetItemInfoByType(targetInfo.itemTypeId)

        -- Todo: Crystite from Daily Reward Crates is a known match for this.
        if IsLootableTarget(targetInfo) and targetInfo.quality == nil then Debug.Warn('Detected lootable entity without quality. Dumping args and targetinfo: ') vardump(args) vardump(targetInfo) end

        -- Determine if it is a lootable entity
        if IsLootableTarget(targetInfo) and IsLootableItem(itemInfo) then
            -- Determine if it is something we want to track
            if (IsPastThreshold(targetInfo.quality) or Options['IdentifyAllLoot']) and not IsIdentified(args.entityId) then
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
]]--
function OnChatMessage(args)
    if not Options['Enabled'] then return end
    -- Filter for only Squad messages
    if args.channel == 'squad' then

        -- Filter for only addon communication messages
        -- We only listen to messages from the squad leader, and only if we're not the squad leader ourselves (that has to be some fake squad leader fooshu!)
        if IsSquadLeader(args.author) and not bIsSquadLeader and FindFirstKeyInText(args.text, Options['Messages']['Communication_Prefix']) ~= nil then
            Debug.Log('Squad Communication Message')
            Debug.Log(args.text)
            -- Strip away prefix
            local message = FilterFirstKeyFromText(args.text, Options['Messages']['Communication_Prefix'])

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
                            SendSystemMessage('Squad Leader is reassigning '..FixItemNameTag(localItem.name, localItem.quality)..' from '..localItem.assignedTo..' to '..playerName)
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
                rollType = 'need'
            elseif args.text == 'g' or string.find(string.lower(args.text), '^gree+d$') ~= nil then
                rollType = 'greed'
            elseif args.text == 'p' or args.text == 'pass' then
                rollType = 'pass'
            end

            if rollType ~= nil then
                RollDecision({author=args.author, rollType=rollType})
            end
        end
    end
end

--[[
    FindFirstKeyInText(text, key)
    Chat parsing helper function
]]--
function FindFirstKeyInText(text, key)
    return string.find(text, key, 0, string.len(key))
end

--[[
    FilterFirstKeyFromText(text, key)
    Chat parsing helper function
]]--
function FilterFirstKeyFromText(text, key)
    --FindFirstKeyInText(text, key),
    return string.sub(text, string.len(key) + 1)
end


--[[
    OnLootCollected(args)
    Callback for when someone loots something.
    Used to detect ninja lootaz!
    
]]--
function OnLootCollected(args)
    -- Exit if addon is disabled
    if not Options['Enabled'] then return end

    --Debug.Log('OnLootCollected')
    --Debug.Log('args')
    --Debug.Table(args)

    if not args.itemTypeId then Debug.Warn('OnLootCollected args.itemTypeId is nil') return end

    -- Get item info
    local itemInfo = Game.GetItemInfoByType(args.itemTypeId)
    --Debug.Log('iteminfo')
    --Debug.Table(itemInfo)


    -- Is it loot that we care about?
    if IsLootableItem(itemInfo) and (IsPastThreshold(args.quality) or Options['IdentifyAllLoot']) then

        -- Todo: Check if we have assigned any items, if not just skip to Claimed ?

        -- Okay, do we have any identified loot?
        if not table.empty(aIdentifiedLoot) then

            -- Todo: Determine or at least guess which entity it was that the looter interacted with in order to collect this item.
            -- Todo: Maybe I can exclude potential duplicates by checking if identified entities are still around

            -- For now we will just grab the first identified item that this item could be
            local loot = nil
            for num, item in ipairs(aIdentifiedLoot) do 
                if item.itemTypeId == args.itemTypeId and item.quality == args.quality then
                    loot = item
                    break
                end
            end

            -- If we found the item, we will return from this function within this block after firing the appropriate event function.
            if loot ~= nil then

                -- If the item had not been assigned
                if loot.assignedTo == nil then
                    OnLootSnatched({lootedTo=args.lootedTo, item=loot})

                    -- If we were rolling for this item, we should make sure the roll is cancelled
                    if mCurrentlyRolling and mCurrentlyRolling.entityId == loot.entityId then
                        RollCancel({item=loot})
                    end


                -- Else if the item was looted by the person it was assigned to
                elseif namecompare(loot.assignedTo, args.lootedTo) then
                    OnLootReceived({lootedTo=args.lootedTo, item=loot})

                -- Else it was a ninja
                else
                    OnLootStolen({lootedTo=args.lootedTo, assignedTo=loot.assignedTo, item=loot})
                end

                -- End the function, we're done here.
                RemoveIdentifiedItem(loot)
                return

            end
        end

        -- No identified loot or this item wasn't identified
        OnLootClaimed({lootedTo=args.lootedTo, item={name=itemInfo.name, quality=args.quality}})
    end
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
    IsLootableItem(itemInfo)
    Whether or not an item (post pickup) was a lootable target (ish)
]]--
function IsLootableItem(itemInfo)
    -- Verify that the looted item is of a type that we care about
    if  itemInfo.type == 'frame_module' or
        itemInfo.type == 'ability_module' or
        itemInfo.type == 'weapon' then
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
    if     Options['Manager']['LootThreshold'] == 'any'    then return true
    elseif Options['Manager']['LootThreshold'] == 'green'  and quality > 300   then return true
    elseif Options['Manager']['LootThreshold'] == 'blue'   and quality > 700   then return true
    elseif Options['Manager']['LootThreshold'] == 'purple' and quality > 900   then return true
    elseif Options['Manager']['LootThreshold'] == 'orange' and quality == 1000 then return true end
    return false
end

--[[
    IsSquadLeader(player)
    Determine whether player is the current squad leader or not
]]--
function IsSquadLeader(localPlayer)
    if aSquadRoster == nil then OnSquadRosterUpdate() end -- If we're doomed from the start, try to resolve
    if aSquadRoster ~= nil then -- Fixme: table is never nil?
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
    itemInfo = Game.GetItemInfoByType(targetInfo.itemTypeId)
    Debug.Log('Identifying '..tostring(entityId)..','..targetInfo.name)
    Debug.Log('targetInfo: ')
    Debug.Table(targetInfo)
    Debug.Log('itemInfo: ')
    Debug.Table(itemInfo)

    -- Unify data
    local loot = {entityId=entityId, itemTypeId=targetInfo.itemTypeId, craftingTypeId=itemInfo.craftingTypeId, itemInfo=itemInfo, assignedTo=nil, quality=targetInfo.quality, name=targetInfo.name, pos={x=targetInfo.lootPos.x, y=targetInfo.lootPos.y, z=targetInfo.lootPos.z}, panel=nil, waypoint=nil, timer=nil}

    -- Create waypoint
    if Options['Waypoints']['Enabled'] then
        loot.waypoint = CreateWaypoint(loot)
    end

    -- Create panel
    if Options['Panels']['Enabled'] then
        loot.panel = CreatePanel(targetInfo, itemInfo)
    end

    -- Create timer
    loot.timer = GTimer.Create(function(time) loot.panel.panel_rt:GetChild('content'):GetChild('IconBar'):GetChild('timer'):SetText(time) end, '%02iq60p:%02iq1p', 1);
        
    -- Setup despawn timer
    loot.timer:SetAlarm('despawn', ciLootDespawn, LootDespawn, {item=loot})
    loot.timer:StartTimer()

    -- Save data
    table.insert(aIdentifiedLoot, loot)
    Debug.Log('Identified: '..tostring(loot.entityId)..', '..loot.name)
    
    -- Fire event
    OnIdentify({item=loot})
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


    -- Header
    RenderTarget:GetChild('content'):GetChild('Header'):GetChild('itemName'):SetText(FixItemNameTag(targetInfo.name, targetInfo.quality))

    local qualityColor, headerBarColor, itemNameColor
    if targetInfo.quality then
        qualityColor = LIB_ITEMS.GetResourceQualityColor(targetInfo.quality)
    else
        qualityColor = LIB_ITEMS.GetItemColor(itemInfo)
    end

    if Options['Panels']['HeaderBar_ColorMode'] == 'item-quality' then
        headerBarColor = qualityColor
    else
        headerBarColor = Options['Panels']['Color_HeaderBar_ColorMode_Custom'].tint
    end

    if Options['Panels']['ItemName_ColorMode'] == 'item-quality' then
        itemNameColor = qualityColor
    else
        itemNameColor = Options['Panels']['Color_ItemName_ColorMode_Custom'].tint
    end

    RenderTarget:GetChild('content'):GetChild('Header'):GetChild('headerBar'):SetParam("tint", headerBarColor)

    RenderTarget:GetChild('content'):GetChild('Header'):GetChild('itemName'):SetTextColor(itemNameColor)


    -- Iconbar
    RenderTarget:GetChild('content'):GetChild('IconBar'):GetChild('itemIcon'):SetUrl(itemInfo.web_icon)

   
    -- Battleframe icon
    if itemInfo.craftingTypeId then
        local itemArchetype, itemFrame = DWFrameIDX.ItemIdxString(tostring(itemInfo.craftingTypeId))
        if itemFrame == nil then
            Debug.Warn('Frame is nil for craftingTypeId: '..tostring(itemInfo.craftingTypeId))
            vardump(itemInfo)
            itemFrame = 'Assault' -- Fixme: properly solve this
        end
        RenderTarget:GetChild('content'):GetChild('IconBar'):GetChild('battleframeIcon'):SetUrl(GetFrameWebIconByName(itemFrame))
        RenderTarget:GetChild('content'):GetChild('IconBar'):GetChild('battleframeIcon'):Show(true)
    else
        RenderTarget:GetChild('content'):GetChild('IconBar'):GetChild('battleframeIcon'):Show(false)
    end
    

    -- Timer text
    RenderTarget:GetChild('content'):GetChild('IconBar'):GetChild('timer'):SetText('00:00')


    -- Marker
    --RenderTarget:GetChild('Marker'):Show(false)

    -- Stat list (attributes data first)
    local rowHeight = 38 -- Fixme: magic number
    local row = 0
    local ENTRY = nil
    if itemInfo.attributes ~= nil and not table.empty(itemInfo.attributes) then
        for num, attribute in ipairs(itemInfo.attributes) do
            row = rowHeight * num
            ENTRY = Component.CreateWidget("LootPanel_Stat", RenderTarget:GetChild('content'):GetChild('ItemStats'))
            ENTRY:SetDims("top:".. row .."; left0; width:100%; height:32;");
            ENTRY:GetChild('statName'):SetText(tostring(attribute.display_name))

            if attribute.format == nil or attribute.format == '' then
                ENTRY:GetChild('statValue'):SetText(tostring(attribute.value))
            else
                ENTRY:GetChild('statValue'):SetText(string.format(attribute.format, attribute.value))
            end
        end
    end

    -- Shitty solution to display interesting stats that are not attributes
    if itemInfo.stats ~= nil and not table.empty(itemInfo.stats) then

        if itemInfo.stats['damagePerSecond'] then
            row = row + rowHeight 
            ENTRY = Component.CreateWidget("LootPanel_Stat", RenderTarget:GetChild('content'):GetChild('ItemStats'))
            ENTRY:SetDims("top:".. row .."; left0; width:100%; height:32;");
            ENTRY:GetChild('statName'):SetText('Damage Per Second')
            ENTRY:GetChild('statValue'):SetText(tostring(round(itemInfo.stats['damagePerSecond'], 2)))
        end


        if itemInfo.stats['spread'] then
            row = row + rowHeight 
            ENTRY = Component.CreateWidget("LootPanel_Stat", RenderTarget:GetChild('content'):GetChild('ItemStats'))
            ENTRY:SetDims("top:".. row .."; left0; width:100%; height:32;");
            ENTRY:GetChild('statName'):SetText('Spread')
            ENTRY:GetChild('statValue'):SetText(tostring(round(itemInfo.stats['spread'], 2)))
        end

        if itemInfo.stats['maxAmmo'] then
            row = row + rowHeight 
            ENTRY = Component.CreateWidget("LootPanel_Stat", RenderTarget:GetChild('content'):GetChild('ItemStats'))
            ENTRY:SetDims("top:".. row .."; left0; width:100%; height:32;");
            ENTRY:GetChild('statName'):SetText('Max Ammo')
            ENTRY:GetChild('statValue'):SetText(tostring(itemInfo.stats['maxAmmo']))
        end

        if itemInfo.stats['reloadTime'] then
            row = row + rowHeight 
            ENTRY = Component.CreateWidget("LootPanel_Stat", RenderTarget:GetChild('content'):GetChild('ItemStats'))
            ENTRY:SetDims("top:".. row .."; left0; width:100%; height:32;");
            ENTRY:GetChild('statName'):SetText('Reload Time')
            ENTRY:GetChild('statValue'):SetText(tostring(round(itemInfo.stats['reloadTime'], 2)))
        end

        if itemInfo.stats['roundsPerMinute'] then
            row = row + rowHeight 
            ENTRY = Component.CreateWidget("LootPanel_Stat", RenderTarget:GetChild('content'):GetChild('ItemStats'))
            ENTRY:SetDims("top:".. row .."; left0; width:100%; height:32;");
            ENTRY:GetChild('statName'):SetText('Rounds Per Minute')
            ENTRY:GetChild('statValue'):SetText(tostring(round(itemInfo.stats['roundsPerMinute'], 2)))
        end
    
    end

    -- Shitty way to hide stats if none shown
    if (itemInfo.attributes == nil or table.empty(itemInfo.attributes)) and (itemInfo.stats == nil or table.empty(itemInfo.stats)) then
        RenderTarget:GetChild('content'):GetChild('ItemStats'):Show(false)
    else
        RenderTarget:GetChild('content'):GetChild('ItemStats'):Show(true)
    end
 

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


    -- We spent all this time building, best make sure it shows
    RenderTarget:GetChild('content'):Show(true)


    return panel
end

--[[
    UpdatePanel(loot)
    Updates the state of a loot panel
]]--
function UpdatePanel(loot)

    local RenderTarget = loot.panel.panel_rt


    -- Overall mode
    if Options['Panels']['Mode'] == 'small' then
        -- Small mode display settings
        RenderTarget:GetChild('content'):GetChild('contentBackground'):Show(false)
        RenderTarget:GetChild('content'):GetChild('IconBar'):Show(false)
        RenderTarget:GetChild('content'):GetChild('ItemStats'):Show(false)

    else
        -- Large/Normal mode display settings
        RenderTarget:GetChild('content'):GetChild('contentBackground'):Show(true)
        RenderTarget:GetChild('content'):GetChild('IconBar'):Show(true)
        RenderTarget:GetChild('content'):GetChild('ItemStats'):Show(true)

        -- Asigned To text
        if Options['Panels']['Display_AssignedTo'] then

            -- Debug.Log(RenderTarget:GetChild('content'):GetChild('Header'):GetChild('itemName'):GetTextDims()) -- To be used to detect when title wraps
            if loot.assignedTo == nil then
                RenderTarget:GetChild('content'):GetChild('Header'):GetChild('itemAssignedTo'):SetText('Not yet assigned')
                RenderTarget:GetChild('content'):GetChild('Header'):GetChild('itemAssignedTo'):SetTextColor(Options['Panels']['Color_AssignedTo_nil'].tint)

                if Options['Panels']['Display_AssignedTo_Hide_nil'] then
                    RenderTarget:GetChild('content'):GetChild('Header'):GetChild('itemAssignedTo'):Show(false)
                else
                    RenderTarget:GetChild('content'):GetChild('Header'):GetChild('itemAssignedTo'):Show(true)
                end

            elseif loot.assignedTo == true or loot.assignedTo == false then
                RenderTarget:GetChild('content'):GetChild('Header'):GetChild('itemAssignedTo'):SetText('Free for all')
                RenderTarget:GetChild('content'):GetChild('Header'):GetChild('itemAssignedTo'):SetTextColor(Options['Panels']['Color_AssignedTo_free'].tint)
            else
                RenderTarget:GetChild('content'):GetChild('Header'):GetChild('itemAssignedTo'):SetText('Assigned To: '..loot.assignedTo)

                if namecompare(loot.assignedTo, Player.GetInfo()) then
                    RenderTarget:GetChild('content'):GetChild('Header'):GetChild('itemAssignedTo'):SetTextColor(Options['Panels']['Color_AssignedTo_player'].tint)
                else
                    RenderTarget:GetChild('content'):GetChild('Header'):GetChild('itemAssignedTo'):SetTextColor(Options['Panels']['Color_AssignedTo_other'].tint)
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
    MARKER:SetSubtitle('Loot')

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
    if aIdentifiedLoot ~= nil and not table.empty(aIdentifiedLoot) then
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
    if not bIsSquadLeader or not Options['Enabled'] then return end

    -- Check that we have any loot at all
    if not table.empty(aIdentifiedLoot) then

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
            if Options['Manager']['LootMode'] == 'random' then
                local winner = weightedRoster[math.random(#weightedRoster)].name

                OnDistributeItem({item=loot})
                AssignItem(loot.entityId, winner)

            -- dice looting mode
            elseif Options['Manager']['LootMode'] == 'dice' then
                local highest = nil
                local winner = ''
                local rolls = {}
                -- Roll for each member in order to determine winner
                for num, member in ipairs(weightedRoster) do

                    -- Calc roll
                    roll = math.random(Options['Manager']['RollMin'], Options['Manager']['RollMax'])

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
            elseif Options['Manager']['LootMode'] == 'round-robin' then
                
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
            elseif Options['Manager']['LootMode'] == 'need-before-greed' then

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

                if eligibleNames == '' then eligibleNames = 'No one' end

                -- Start roll timeout timer
                mCurrentlyRolling.timer:SetAlarm('roll_timeout', mCurrentlyRolling.timer:GetTime() + Options['Manager']['RollTimeout'], RollTimeout, {item=loot})

                -- Announce that we're rolling
                OnAcceptingRolls({item=loot, eligibleNames=eligibleNames})

            end
        else
            Debug.Log('No Rollable Loot to distribute')
        end
    else
        Debug.Log('No Identified Loot to distribute')
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
                if args.rollType == 'need' and row.canNeed == false then
                    args.rollType = 'greed'
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
            if row.rollType == 'need' then
                someoneHasNeeded = true
            elseif row.rollType == false then
                row.rollType = Options['Manager']['RollTypeDefault']
            end
        end

        -- Go through rolls
        for num, row in ipairs(aCurrentlyRolling) do
            -- Inverted logic because Lua doesn't have continue
            -- Skip greed rolls if someone has needed, as well as any pass rolls
            if not(someoneHasNeeded and row.rollType == 'greed') and not (row.rollType == 'pass' or row.rollType == false) then

                -- Calc roll
                roll = math.random(Options['Manager']['RollMin'], Options['Manager']['RollMax'])

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
        if Options['Manager']['AutoDistribute'] then DistributeItem() end

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
    if Options['Manager']['LootWeighting'] ~= 'disabled' then 
        local entitledRoster = {}
        local itemArchetype, itemFrame = DWFrameIDX.ItemIdxString(tostring(loot.craftingTypeId))

        --if Options['Manager']['LootWeighting'] == 'frame' then
        --end
        --if Options['Manager']['LootWeighting'] == 'archetype' or #entitledRoster == 0 then
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
    if not table.empty(aIdentifiedLoot) then
        vardump(aIdentifiedLoot)
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
            SendSystemMessage('No Rollable Loot to distribute')
        end
    else
        SendSystemMessage('No Identified Loot to distribute')
    end
end



--[[
    UpdateTracker()
    Updates the UI tracker view.
]]--
function UpdateTracker()

    -- Only update and show tracker if enabled
    if Options['Tracker']['Enabled'] then

        -- Update List of tracked items
        RemoveAllChildren(TRACKER:GetChild('List')) -- clear previous entries
        local rowHeight = 32 -- Fixme: magic number
        local row = 0
        if not table.empty(aIdentifiedLoot) then
            for num, item in ipairs(aIdentifiedLoot) do

                -- Calc row height
                row = row + rowHeight

                -- Create widget
                ENTRY = Component.CreateWidget("Tracker_List_Entry", TRACKER:GetChild('List'))
                ENTRY:SetDims("top:".. row .."; left:0; width:100%; height:24;");

                -- Left
                    -- Setup Buttons
                        -- ENTRY:GetChild('leftbar'):GetChild('buttons')

                    -- Setup Assigned To text
                    if item.assignedTo == nil then
                        ENTRY:GetChild('leftbar'):GetChild('assignedTo'):SetText('Not yet assigned')
                    elseif item.assignedTo == false or item.assignedTo == true then
                        ENTRY:GetChild('leftbar'):GetChild('assignedTo'):SetText('Free for all')
                    else
                        ENTRY:GetChild('leftbar'):GetChild('assignedTo'):SetText(tostring(item.assignedTo))
                    end

                -- Right
                    -- Item Name text
                    ENTRY:GetChild('itemName'):SetText(FixItemNameTag(item.name, item.quality))

                -- Determine what to display
                    if item.assignedTo == nil then
                        ENTRY:GetChild('leftbar'):GetChild('buttons'):Show(true)
                        ENTRY:GetChild('leftbar'):GetChild('assignedTo'):Show(false)
                    else
                        ENTRY:GetChild('leftbar'):GetChild('buttons'):Show(false)
                        ENTRY:GetChild('leftbar'):GetChild('assignedTo'):Show(true)
                    end

                    ENTRY:GetChild('itemName'):Show(true)

        
            end
        else
            -- Clear?
        end

        -- Should we display the tracker?
        if  Options['Tracker']['Visibility'] == 'always' 
        or (Options['Tracker']['Visibility'] == 'hud' and bHUD)
        or (Options['Tracker']['Visibility'] == 'mousemode' and bCursor)
        then
            -- Yes, display tracker
            TRACKER:Show(true)
        end

    -- Tracker not enabled, so do nothing but make sure it's hidden.
    else
        -- Hide tracker
        TRACKER:Show(false)
    end
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
    SendMessage
    Sends message to the squad
]]--
function SendMessage(message, alert, communication)
    alert = alert or false
    communication = communication or false

    -- Exit if disabled
    if Options['NoSquadMessages'] then return end

    -- Exit if we're not the Squad Leader or addon is disabled
    if not bIsSquadLeader or not Options['Enabled'] then return end

    -- Setup alert prefix
    local alertPrefix = ''
    if alert then alertPrefix = '!' end

    -- Setup prefix
    local prefix = ''
    if communication then
        prefix = Options['Messages']['Communication_Prefix']
    else
        prefix = Options['Messages']['Generic_Prefix']
    end

    -- Handle splitting long messages into multiple
    if string.len(message) > ciSquadMessageLengthLimit then
        local messages = explode('\n', message)

        local currentMessage = ''

        local messageContentLengthLimit = ciSquadMessageLengthLimit - string.len(alertPrefix) - string.len(prefix)

        -- For each line in the message
        for num, message in ipairs(messages) do

            Debug.Log(num..' : Length: '..string.len(message)..' : Message: '..message)

            -- On the very first iteration, just add message
            if currentMessage == '' then

                currentMessage = message

            -- On subsequent iterations, we're gonna do some shit
            else

                -- If adding the next line exceeds the character limit
                if string.len(currentMessage..'\n'..message) > messageContentLengthLimit then

                    -- Send the current line and start a new message for the next line
                    SendMessage(currentMessage, alert, communication)
                    currentMessage = message

                -- Otherwise
                else
                    -- Add the next line to the current line
                    currentMessage = currentMessage..'\n'..message
                end


            end

        end
        -- Make sure we send the last message
        if currentMessage ~= '' then SendMessage(currentMessage, alert, communication) end

    else
        -- Send message normally
        Debug.Log('Sending Squad Message: '..alertPrefix..prefix..message)
        Debug.Log('Message Length: '..string.len(alertPrefix..prefix..message))
        Chat.SendChannelText('squad', alertPrefix..prefix..message)
    end
end

--[[
    SendSystemMessage
    Sends message to the system
]]--
function SendSystemMessage(message)
    -- Exit if disabled
    if Options['NoSystemMessages'] then return end

    -- Exit if the addon is disabled
    if not Options['Enabled'] then return end

    -- Send system message
    Component.GenerateEvent('MY_SYSTEM_MESSAGE', {text=message})
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
    output = string.gsub(output, '%%m', Options['Manager']['LootMode'])

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
    OnAcceptingRolls(args)
    args.
    args.item
]]--
function OnAcceptingRolls(args)
    -- Exit if we're not the Squad Leader or addon is disabled
    if not bIsSquadLeader or not Options['Enabled'] then return end

    if Options['Messages']['MessageSquad_OnAcceptingRolls'] then
        SendMessage(RunMessageFilters(Options['Messages']['MessageFormatSquad_OnAcceptingRolls'], args))
    end
    if Options['Messages']['MessageSystem_OnRolls'] then
        SendSystemMessage(RunMessageFilters(Options['Messages']['MessageFormatSystem_OnAcceptingRolls'], args))
    end
end

--[[
    OnLootReceived(args)
    args.lootedTo
    args.item
]]--
function OnLootReceived(args)
    -- Exit if we're not the Squad Leader or addon is disabled
    if not bIsSquadLeader or not Options['Enabled'] then return end

    if Options['Messages']['MessageSquad_OnLootReceived'] then
        SendMessage(RunMessageFilters(Options['Messages']['MessageFormatSquad_OnLootReceived'], args))
    end
    if Options['Messages']['MessageSystem_OnLootReceived'] then
        SendSystemMessage(RunMessageFilters(Options['Messages']['MessageFormatSystem_OnLootReceived'], args))
    end
end

--[[
    OnLootStolen(args)
    args.lootedTo
    args.item
]]--
function OnLootStolen(args)
    -- Exit if we're not the Squad Leader or addon is disabled
    if not bIsSquadLeader or not Options['Enabled'] then return end

    if Options['Messages']['MessageSquad_OnLootStolen'] then
        SendMessage(RunMessageFilters(Options['Messages']['MessageFormatSquad_OnLootStolen'], args))
    end
    if Options['Messages']['MessageSystem_OnLootStolen'] then
        SendSystemMessage(RunMessageFilters(Options['Messages']['MessageFormatSystem_OnLootStolen'], args))
    end
end

--[[
    OnLootSnatched(args)
    args.lootedTo
    args.item
]]--
function OnLootSnatched(args)
    -- Exit if we're not the Squad Leader or addon is disabled
    if not bIsSquadLeader or not Options['Enabled'] then return end

    if Options['Messages']['MessageSquad_OnLootSnatched'] then
        SendMessage(RunMessageFilters(Options['Messages']['MessageFormatSquad_OnLootSnatched'], args))
    end
    if Options['Messages']['MessageSystem_OnLootSnatched'] then
        SendSystemMessage(RunMessageFilters(Options['Messages']['MessageFormatSystem_OnLootSnatched'], args))
    end
end

--[[
    OnLootClaimed(args)
    args.lootedTo
    args.item (only name)
]]--
function OnLootClaimed(args)
    -- Exit if we're not the Squad Leader or addon is disabled
    if not bIsSquadLeader or not Options['Enabled'] then return end

    if Options['Messages']['MessageSquad_OnLootClaimed'] then
        SendMessage(RunMessageFilters(Options['Messages']['MessageFormatSquad_OnLootClaimed'], args))
    end
    if Options['Messages']['MessageSystem_OnLootClaimed'] then
        SendSystemMessage(RunMessageFilters(Options['Messages']['MessageFormatSystem_OnLootClaimed'], args))
    end
end

--[[
    OnDistributeItem(args)
    args.lootedTo
    args.item
]]--
function OnDistributeItem(args)

    -- Exit if we're not the Squad Leader or addon is disabled
    if not bIsSquadLeader or not Options['Enabled'] then return end

    -- Message Squad
    if Options['Messages']['MessageSquad_OnDistributeItem'] then
        local message = RunMessageFilters(Options['Messages']['MessageFormatSquad_OnDistributeItem'], args)

        if args.rolls and Options['Messages']['MessageSquad_OnRolls'] then
            message = message..'\n'..RollsFormater(Options['Messages']['MessageFormatSquad_OnRolls'], args.rolls, args.item)
        end

        SendMessage(message)
    end

    -- Message System
    if Options['Messages']['MessageSystem_OnDistributeItem'] then
        local message = RunMessageFilters(Options['Messages']['MessageFormatSystem_OnDistributeItem'], args)

        if args.rolls and Options['Messages']['MessageSystem_OnRolls'] then
            message = message..'\n'..RollsFormater(Options['Messages']['MessageFormatSystem_OnRolls'], args.rolls, args.item)
        end

        SendSystemMessage(message)
    end
end

--[[
    OnAssignItem(args)
    args.assignedTo
    args.playerName
    args.item
]]--
function OnAssignItem(args)
    -- Exit if addon is disabled
    if not Options['Enabled'] then return end

    -- Update tracker
    UpdateTracker()

    -- Update panel
    UpdatePanel(args.item)

    -- Play Sound
    if not Options['Sounds']['Mute'] then

        -- If assigned to me
        if Options['Sounds']['OnAssignItem_ToMe'] and namecompare(args.assignedTo, Player.GetInfo()) then
            System.PlaySound(Options['Sounds']['OnAssignItem_ToMe'])

        -- If not assigned to me
        elseif Options['Sounds']['OnAssignItem_ToMe'] then
            System.PlaySound(Options['Sounds']['OnAssignItem_ToOther'])
        end
    end

    -- Do stuff with the waypoint
    if Options['Waypoints']['Enabled'] and namecompare(args.assignedTo, Player.GetInfo()) then
        if Options['Waypoints']['TrailAssigned'] then
            args.item.waypoint:ShowTrail(true)
        end
        if Options['Waypoints']['PingAssigned'] then
            args.item.waypoint:Ping()
        end
    end


    -- Exit if we're not the Squad Leader
    if not bIsSquadLeader then return end

    -- Communicate Assign Item
    if Options['Messages']['Communication_Assign'] then
        SendMessage(RunMessageFilters(Options['Messages']['Communication_Assign_Format'], args), false, true)
    end

    -- Messages
    if Options['Messages']['MessageSquad_OnAssignItem'] then
        SendMessage(RunMessageFilters(Options['Messages']['MessageFormatSquad_OnAssignItem'], args), true)
    end
    if Options['Messages']['MessageSystem_OnAssignItem'] then
        SendSystemMessage(RunMessageFilters(Options['Messages']['MessageFormatSystem_OnAssignItem'], args))
    end
end

--[[
    OnRollChange(args)
]]--
function OnRollChange(args)
    -- Exit if we're not the Squad Leader or addon is disabled
    if not bIsSquadLeader or not Options['Enabled'] then return end

    -- Messages
    if Options['Messages']['MessageSquad_OnRollChange'] then
        SendMessage(RunMessageFilters(Options['Messages']['MessageFormatSquad_OnRollChange'], args))
    end
    if Options['Messages']['MessageSystem_OnRollChange'] then
        SendSystemMessage(RunMessageFilters(Options['Messages']['MessageFormatSystem_OnRollChange'], args))
    end
end

--[[
    OnRollBusy(args)
]]--
function OnRollBusy(args)
    -- Exit if we're not the Squad Leader or addon is disabled
    if not bIsSquadLeader or not Options['Enabled'] then return end

    -- Messages
    if Options['Messages']['MessageSquad_OnRollBusy'] then
        SendMessage(RunMessageFilters(Options['Messages']['MessageFormatSquad_OnRollBusy'], args))
    end
    if Options['Messages']['MessageSystem_OnRollBusy'] then
        SendSystemMessage(RunMessageFilters(Options['Messages']['MessageFormatSystem_OnRollBusy'], args))
    end
end

--[[
    OnRollNobody(args)
]]--
function OnRollNobody(args)
    -- Exit if we're not the Squad Leader or addon is disabled
    if not bIsSquadLeader or not Options['Enabled'] then return end

    -- Messages
    if Options['Messages']['MessageSquad_OnRollNobody'] then
        SendMessage(RunMessageFilters(Options['Messages']['MessageFormatSquad_OnRollNobody'], args))
    end
    if Options['Messages']['MessageSystem_OnRollNobody'] then
        SendSystemMessage(RunMessageFilters(Options['Messages']['MessageFormatSystem_OnRollNobody'], args))
    end
end

--[[
    OnRollAccept(args)
]]--
function OnRollAccept(args)
    -- Exit if we're not the Squad Leader or addon is disabled
    if not bIsSquadLeader or not Options['Enabled'] then return end

    -- Messages
    if Options['Messages']['MessageSquad_OnRollAccept'] then
        SendMessage(RunMessageFilters(Options['Messages']['MessageFormatSquad_OnRollAccept'], args))
    end
    if Options['Messages']['MessageSystem_OnRollAccept'] then
        SendSystemMessage(RunMessageFilters(Options['Messages']['MessageFormatSystem_OnRollAccept'], args))
    end
end

--[[
    OnLootDespawn(args)
]]--
function OnLootDespawn(args)
    -- Exit if we're not the Squad Leader or addon is disabled
    if not bIsSquadLeader or not Options['Enabled'] then return end

    -- Messages
    if Options['Messages']['MessageSquad_OnLootDespawn'] then
        SendMessage(RunMessageFilters(Options['Messages']['MessageFormatSquad_OnLootDespawn'], args))
    end
    if Options['Messages']['MessageSystem_OnLootDespawn'] then
        SendSystemMessage(RunMessageFilters(Options['Messages']['MessageFormatSystem_OnLootDespawn'], args))
    end
end

--[[
    OnIdentify(args)
    Callback for when a new item is identified.
    args.loot - the newly identified item
    We use this to start automatic item distribution
]]--
function OnIdentify(args)
    -- Exit if addon is disabled
    if not Options['Enabled'] then return end

    -- Update the tracker
    UpdateTracker()

    -- Update the panel
    UpdatePanel(args.item)

    -- Play Sound
    if not Options['Sounds']['Mute'] and Options['Sounds']['OnIdentify'] then
        System.PlaySound(Options['Sounds']['OnIdentify'])
    end

    -- Exit if we're not the Squad Leader
    if not bIsSquadLeader then return end

    -- Messages
    if Options['Messages']['MessageSquad_OnIdentify'] then
        SendMessage(RunMessageFilters(Options['Messages']['MessageFormatSquad_OnIdentify'], args))
    end
    if Options['Messages']['MessageSystem_OnIdentify'] then
        SendSystemMessage(RunMessageFilters(Options['Messages']['MessageFormatSystem_OnIdentify'], args))
    end

    -- If auto distribute is enabled, distribute the item
    if Options['Manager']['AutoDistribute'] then
        DistributeItem()
    end

end





-- Shitty stuff below

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
        newStatus = not Options['Enabled']
    end

    OnOptionChange({'Enabled', newStatus})
end

--[[
    ClearIdentified()
    Clears the aIdentifiedLoot list.
]]--
function ClearIdentified()

    RollCancel()

    -- YOLO
    while not table.empty(aIdentifiedLoot) do
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

    SendSystemMessage('Test')

    Debug.Log('test')
    Debug.Log('bIsSquadLeader: '..tostring(bIsSquadLeader))
    Debug.Log('Options[\'Enabled\']: '..tostring(Options['Enabled']))
    Debug.Log('Options[\'AlwaysSquadLeader\']: '..tostring(Options['AlwaysSquadLeader']))

--Game.GetItemAttributeModifiers(itemTypeId,quality)


    -- Entity id is set to player because we have no real options here
    local entityId = Player.GetTargetId()


    --targetInfo = targetInfo or Game.GetTargetInfo(entityId)

    -- Target info must be faked because we have no real entity
    local targetInfoData = {
        {name='Accord Prototype SIN Beacon I^Q', lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=85050, quality=894},
        {name='Accord Prototype Sticky Grenade Launcher II^Q', lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=85017, quality=879},
        {name='Accord Prototype Assault Plating I^Q', lootPos={x=Player.GetAimPosition().x, y=Player.GetAimPosition().y, z=Player.GetAimPosition().z}, itemTypeId=85099, quality=712},
    }

    -- Create 3 pannelz
    for num, targetInfo in ipairs(targetInfoData) do


        

        -- hax the location
        if num == 1 then
            entityId = 1
        elseif num == 2 then
            targetInfo.lootPos.x = targetInfo.lootPos.x - 2
            entityId = 2
        elseif num == 3 then
            targetInfo.lootPos.x = targetInfo.lootPos.x + 2
            entityId = 3
        end

        if not IsIdentified(entityId) then

            local itemInfo = Game.GetItemInfoByType(targetInfo.itemTypeId)


            local loot = {entityId=entityId, itemTypeId=targetInfo.itemTypeId, craftingTypeId=itemInfo.craftingTypeId, itemInfo=itemInfo, assignedTo=nil, quality=targetInfo.quality, name=targetInfo.name, pos={x=targetInfo.lootPos.x, y=targetInfo.lootPos.y, z=targetInfo.lootPos.z}, panel=CreatePanel(targetInfo, Game.GetItemInfoByType(targetInfo.itemTypeId)), waypoint=nil, timer=nil}

            -- Create timer
            loot.timer = GTimer.Create(function(time) loot.panel.panel_rt:GetChild('content'):GetChild('IconBar'):GetChild('timer'):SetText(time) end, '%02iq60p:%02iq1p', 1);
            
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
function table.empty(table)
    if next(table) == nil then
       return true
    end
    return false
end

function table.length(table)
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
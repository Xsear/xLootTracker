-- Options
uiSounds = xSounds.GetSounds()

Options = {
    ['Enabled'] = true,
    
    -- Put this shit in Manager
    ['AlwaysSquadLeader'] = false,
    ['IdentifyAllLoot'] = true,

    -- Put this shit in Messages
    ['VersionMessage'] = true,
    ['NoSquadMessages'] = false,
    ['NoSystemMessages'] = false,


    ['Manager'] = {
        ['LootMode'] = 'need-before-greed',
        ['LootWeighting'] = 'archetype',
        ['LootThreshold'] = 'green',


        ['Weighting'] = {
            ['Battleframe'] = 'archetype',
        },

        ['Threshold'] = {
            ['Standard'] = {
                ['Quality'] = 'rare',
                ['Quality_Custom_Value'] = 500,
            },
            ['Stage0'] = {
                ['Enabled'] = false,
                ['Quality'] = 'rare',
                ['Quality_Custom_Value'] = 500,
            },
            ['Stage1'] = {
                ['Enabled'] = false,
                ['Quality'] = 'rare',
                ['Quality_Custom_Value'] = 500,
            },
            ['Stage2'] = {
                ['Enabled'] = false,
                ['Quality'] = 'rare',
                ['Quality_Custom_Value'] = 500,
            },
            ['Stage3'] = {
                ['Enabled'] = false,
                ['Quality'] = 'uncommon',
                ['Quality_Custom_Value'] = 500,
            },
            ['Stage4'] = {
                ['Enabled'] = false,
                ['Quality'] = 'uncommon',
                ['Quality_Custom_Value'] = 500,
            },
        },

        ['AutoDistribute'] = true,
        ['RollMin'] = 1,
        ['RollMax'] = 100,
        ['RollTimeout'] = 15,
        ['RollTypeDefault'] = 'pass',
    },


    ['Messages'] = {
        ['Generic_Prefix'] = '',

        ['OnDistributeItem_Enabled'] = true,
        ['MessageSquad_OnDistributeItem'] = true,
        ['MessageFormatSquad_OnDistributeItem'] = 'Distributing [%iq] by %m',
        ['MessageSystem_OnDistributeItem'] = false,
        ['MessageFormatSystem_OnDistributeItem'] = 'Distributing [%iq] by %m',

        ['OnRolls_Enabled'] = true,
        ['MessageSquad_OnRolls'] = true,
        ['MessageFormatSquad_OnRolls'] = '%n rolls %r for [%iq]',
        ['MessageSystem_OnRolls'] = false,
        ['MessageFormatSystem_OnRolls'] = '%n rolls %r for [%iq]',

        ['OnAcceptingRolls_Enabled'] = true,
        ['MessageSquad_OnAcceptingRolls'] = true,
        ['MessageFormatSquad_OnAcceptingRolls'] = 'Declare need/greed/pass on [%iq]\nEligible for need: %e',
        ['MessageSystem_OnAcceptingRolls'] = false,
        ['MessageFormatSystem_OnAcceptingRolls'] = 'Declare need/greed/pass on [%iq]\nEligible for need: %e',

        ['OnLootReceived_Enabled'] = true,
        ['MessageSquad_OnLootReceived'] = true,
        ['MessageFormatSquad_OnLootReceived'] = '%l looted [%iq]',
        ['MessageSystem_OnLootReceived'] = false,
        ['MessageFormatSystem_OnLootReceived'] = '%l looted [%iq]',

        ['OnLootStolen_Enabled'] = true,
        ['MessageSquad_OnLootStolen'] = true,
        ['MessageFormatSquad_OnLootStolen'] = '%l stole %a\'s [%iq]',
        ['MessageSystem_OnLootStolen'] = false,
        ['MessageFormatSystem_OnLootStolen'] = '%l stole %a\'s [%iq]',

        ['OnLootSnatched_Enabled'] = true,
        ['MessageSquad_OnLootSnatched'] = true,
        ['MessageFormatSquad_OnLootSnatched'] = '%l snatched [%iq]',
        ['MessageSystem_OnLootSnatched'] = false,
        ['MessageFormatSystem_OnLootSnatched'] = '%l snatched [%q]',

        ['OnLootClaimed_Enabled'] = true,
        ['MessageSquad_OnLootClaimed'] = true,
        ['MessageFormatSquad_OnLootClaimed'] = '%l claimed [%iq]',
        ['MessageSystem_OnLootClaimed'] = false,
        ['MessageFormatSystem_OnLootClaimed'] = '%l claimed [%iq]',

        ['OnAssignItem_Enabled'] = true,
        ['MessageSquad_OnAssignItem'] = true,
        ['MessageFormatSquad_OnAssignItem'] = '%n won [%iq]',
        ['MessageSystem_OnAssignItem'] = false,
        ['MessageFormatSystem_OnAssignItem'] = '%n won [%iq]',

        ['OnRollChange_Enabled'] = true,
        ['MessageSquad_OnRollChange'] = false,
        ['MessageFormatSquad_OnRollChange'] = 'Correcting roll of %n, attempted need but not eligible',
        ['MessageSystem_OnRollChange'] = true,
        ['MessageFormatSystem_OnRollChange'] = 'Correcting roll of %n, attempted need but not eligible',

        ['OnRollBusy_Enabled'] = true,
        ['MessageSquad_OnRollBusy'] = false,
        ['MessageFormatSquad_OnRollBusy']  = 'Can\'t roll [%iq] yet, we\'re busy rolling something else',
        ['MessageSystem_OnRollBusy'] = true,
        ['MessageFormatSystem_OnRollBusy'] = 'Can\'t roll [%iq] yet, we\'re busy rolling something else',

        ['OnRollAccept_Enabled'] = true,
        ['MessageSquad_OnRollAccept'] = false,
        ['MessageFormatSquad_OnRollAccept'] = 'Recognizing that %n has selected %t',
        ['MessageSystem_OnRollAccept'] = true,
        ['MessageFormatSystem_OnRollAccept'] = 'Recognizing that %n has selected %t',

        ['OnRollNobody_Enabled'] = true,
        ['MessageSquad_OnRollNobody'] = false,
        ['MessageFormatSquad_OnRollNobody'] = 'Nobody rolled! D:',
        ['MessageSystem_OnRollNobody'] = true,
        ['MessageFormatSystem_OnRollNobody'] = 'Nobody rolled! D:',

        ['OnLootDespawn_Enabled'] = true,
        ['MessageSquad_OnLootDespawn'] = false,
        ['MessageFormatSquad_OnLootDespawn'] = '[%iq] has despawned.',
        ['MessageSystem_OnLootDespawn'] = true,
        ['MessageFormatSystem_OnLootDespawn'] = '[%iq] has despawned.',

        ['OnIdentify_Enabled'] = true,
        ['MessageSquad_OnIdentify'] = false,
        ['MessageFormatSquad_OnIdentify'] = 'Detected a new loot drop: [%iq]',
        ['MessageSystem_OnIdentify'] = true,
        ['MessageFormatSystem_OnIdentify'] = 'Detected a new loot drop: [%iq]',

        ['Communication_Custom'] = false,
        ['Communication_Prefix'] = 'xSLM:',
        ['Communication_Assign'] = true,
        ['Communication_Assign_Format'] = 'A:%tId:%q:%n',
    },


    ['Waypoints'] = {
            ['Enabled'] = true,
            ['ShowOnHud'] = true,
            ['ShowOnWorldMap'] = true,
            ['ShowOnRadar'] = true,
            ['RadarEdgeMode'] = MapMarker.EDGE_ICON,
            ['TrailAssigned'] = true,
            ['PingAssigned'] = true,
    },

    ['Panels'] = {
            ['Enabled'] = true,
            ['HeaderBar_ColorMode'] = 'item-quality',
            ['Color_HeaderBar_ColorMode_Custom'] = {alpha=1, tint='00000'},
            ['ItemName_ColorMode'] = 'custom',
            ['Color_ItemName_ColorMode_Custom'] = {alpha=1, tint='FFFFFF'},
            ['Display_AssignedTo'] = true,
            ['Display_AssignedTo_Hide_nil'] = true,
            ['Color_AssignedTo_nil'] = {alpha=1, tint='FFFFFF'},
            ['Color_AssignedTo_free'] = {alpha=1, tint='00FF00'},
            ['Color_AssignedTo_player'] = {alpha=1, tint='00FF00'},
            ['Color_AssignedTo_other'] = {alpha=1, tint='FF0000'},
    },

    ['Tracker'] = {
        ['Enabled'] = false,
        ['Display_Mode'] = true,
        ['Display_Mode_OnlySquadLeader'] = true,
        ['Display_Headings'] = true,
    },

    ['Sounds'] = {
        ['Mute'] = false,

        ['OnIdentify'] = 'Play_UI_Beep_13',
        ['OnIdentify_Rollable'] = uiSounds[1],
        ['OnAssignItem_ToMe'] = 'Play_SFX_UI_Ding',
        ['OnAssignItem_ToOther'] = 'Play_SFX_UI_Ticker',
    },


    ['Debug'] = {
        ['Enabled'] = false,
        ['FakeOnSquadRoster'] = false,
    },

}





--[[
    OnOptionChange(args)
        args.id  - interface option id
        args.val - interface option value
    Callback function for Interface Options, when the user has changed an option
]]--
function OnOptionChange(args)

    if args.id == "__LOADED" then
        bLoaded = true

    elseif args.id == 'Enabled' then
        Options['Enabled'] = args.val
    
    elseif args.id == 'VersionMessage' then
        Options['VersionMessage'] = args.val
        Component.SaveSetting('VersionMessage', Options['VersionMessage'])

    elseif args.id == 'AlwaysSquadLeader' then
        Options['AlwaysSquadLeader'] = args.val
        OnSquadRosterUpdate()
    
    elseif args.id == 'NoSquadMessages' then
        Options['NoSquadMessages'] = args.val

    elseif args.id == 'NoSystemMessages' then
        Options['NoSystemMessages'] = args.val

    elseif args.id == 'IdentifyAllLoot' then
        Options['IdentifyAllLoot'] = args.val




    elseif args.id == 'LootMode' then
        Options['Manager']['LootMode'] = args.val

    elseif args.id == 'LootWeighting' then
        Options['Manager']['LootWeighting'] = args.val

    elseif args.id == 'LootThreshold' then
        Options['Manager']['LootThreshold'] = args.val
    
    elseif args.id == 'AutoDistribute' then
        Options['Manager']['AutoDistribute'] = args.val

    elseif args.id == 'RollMin' then
        Options['Manager']['RollMin'] = args.val
    elseif args.id == 'RollMax' then
        Options['Manager']['RollMax'] = args.val
    elseif args.id == 'RollTimeout' then
        Options['Manager']['RollTimeout'] = args.val
    elseif args.id == 'RollTypeDefault' then
        Options['Manager']['RollTypeDefault'] = args.val




    elseif args.id == 'Generic_Prefix' then
        Options['Messages']['Generic_Prefix'] = args.val

    elseif args.id == 'Messages_OnDistributeItem_Enabled' then
        Options['Messages']['OnDistributeItem_Enabled'] = args.val
    elseif args.id == 'MessageSquad_OnDistributeItem' then
        Options['Messages']['MessageSquad_OnDistributeItem'] = args.val
    elseif args.id == 'MessageFormatSquad_OnDistributeItem' then
        Options['Messages']['MessageFormatSquad_OnDistributeItem'] = args.val
    elseif args.id == 'MessageSystem_OnDistributeItem' then
        Options['Messages']['MessageSystem_OnDistributeItem'] = args.val
    elseif args.id == 'MessageFormatSystem_OnDistributeItem' then
        Options['Messages']['MessageFormatSystem_OnDistributeItem'] = args.val

    elseif args.id == 'Messages_OnRolls_Enabled' then
        Options['Messages']['OnRolls_Enabled'] = args.val
    elseif args.id == 'MessageSquad_OnRolls' then
        Options['Messages']['MessageSquad_OnRolls'] = args.val
    elseif args.id == 'MessageFormatSquad_OnRolls' then
        Options['Messages']['MessageFormatSquad_OnRolls'] = args.val
    elseif args.id == 'MessageSystem_OnRolls' then
        Options['Messages']['MessageSystem_OnRolls'] = args.val
    elseif args.id == 'MessageFormatSystem_OnRolls' then
        Options['Messages']['MessageFormatSystem_OnRolls'] = args.val

    elseif args.id == 'Messages_OnAcceptingRolls_Enabled' then
        Options['Messages']['OnAcceptingRolls_Enabled'] = args.val
    elseif args.id == 'MessageSquad_OnAcceptingRolls' then
        Options['Messages']['MessageSquad_OnAcceptingRolls'] = args.val
    elseif args.id == 'MessageFormatSquad_OnAcceptingRolls' then
        Options['Messages']['MessageFormatSquad_OnAcceptingRolls'] = args.val
    elseif args.id == 'MessageSystem_OnAcceptingRolls' then
        Options['Messages']['MessageSystem_OnRolls'] = args.val
    elseif args.id == 'MessageFormatSystem_OnAcceptingRolls' then
        Options['Messages']['MessageFormatSystem_OnAcceptingRolls'] = args.val

    elseif args.id == 'Messages_OnLootReceived_Enabled' then
        Options['Messages']['OnLootReceived_Enabled'] = args.val
    elseif args.id == 'MessageSquad_OnLootReceived' then
        Options['Messages']['MessageSquad_OnLootReceived'] = args.val
    elseif args.id == 'MessageFormatSquad_OnLootReceived' then
        Options['Messages']['MessageFormatSquad_OnLootReceived'] = args.val
    elseif args.id == 'MessageSystem_OnLootReceived' then
        Options['Messages']['MessageSystem_OnLootReceived'] = args.val
    elseif args.id == 'MessageFormatSystem_OnLootReceived' then
        Options['Messages']['MessageFormatSystem_OnLootReceived'] = args.val

    elseif args.id == 'Messages_OnLootStolen_Enabled' then
        Options['Messages']['OnLootStolen_Enabled'] = args.val
    elseif args.id == 'MessageSquad_OnLootStolen' then
        Options['Messages']['MessageSquad_OnLootStolen'] = args.val
    elseif args.id == 'MessageFormatSquad_OnLootStolen' then
        Options['Messages']['MessageFormatSquad_OnLootStolen'] = args.val
    elseif args.id == 'MessageSystem_OnLootStolen' then
        Options['Messages']['MessageSystem_OnLootStolen'] = args.val
    elseif args.id == 'MessageFormatSystem_OnLootStolen' then
        Options['Messages']['MessageFormatSystem_OnLootStolen'] = args.val

    elseif args.id == 'Messages_OnLootSnatched_Enabled' then
        Options['Messages']['OnLootSnatched_Enabled'] = args.val
    elseif args.id == 'MessageSquad_OnLootSnatched' then
        Options['Messages']['MessageSquad_OnLootSnatched'] = args.val
    elseif args.id == 'MessageFormatSquad_OnLootSnatched' then
        Options['Messages']['MessageFormatSquad_OnLootSnatched'] = args.val
    elseif args.id == 'MessageSystem_OnLootSnatched' then
        Options['Messages']['MessageSystem_OnLootSnatched'] = args.val
    elseif args.id == 'MessageFormatSystem_OnLootSnatched' then
        Options['Messages']['MessageFormatSystem_OnLootSnatched'] = args.val

    elseif args.id == 'Messages_OnLootClaimed_Enabled' then
        Options['Messages']['OnLootClaimed_Enabled'] = args.val
    elseif args.id == 'MessageSquad_OnLootClaimed' then
        Options['Messages']['MessageSquad_OnLootClaimed'] = args.val
    elseif args.id == 'MessageFormatSquad_OnLootClaimed' then
        Options['Messages']['MessageFormatSquad_OnLootClaimed'] = args.val
    elseif args.id == 'MessageSystem_OnLootClaimed' then
        Options['Messages']['MessageSystem_OnLootClaimed'] = args.val
    elseif args.id == 'MessageFormatSystem_OnLootClaimed' then
        Options['Messages']['MessageFormatSystem_OnLootClaimed'] = args.val

    elseif args.id == 'Messages_OnAssignItem_Enabled' then
        Options['Messages']['OnAssignItem_Enabled'] = args.val
    elseif args.id == 'MessageSquad_OnAssignItem' then
        Options['Messages']['MessageSquad_OnAssignItem'] = args.val
    elseif args.id == 'MessageFormatSquad_OnAssignItem' then
        Options['Messages']['MessageFormatSquad_OnAssignItem'] = args.val
    elseif args.id == 'MessageSystem_OnAssignItem' then
        Options['Messages']['MessageSystem_OnAssignItem'] = args.val
    elseif args.id == 'MessageFormatSystem_OnAssignItem' then
        Options['Messages']['MessageFormatSystem_OnAssignItem'] = args.val

    elseif args.id == 'Messages_OnRollChange_Enabled' then
        Options['Messages']['OnRollChange_Enabled'] = args.val
    elseif args.id == 'MessageSquad_OnRollChange' then
        Options['Messages']['MessageSquad_OnRollChange'] = args.val
    elseif args.id == 'MessageFormatSquad_OnRollChange' then
        Options['Messages']['MessageFormatSquad_OnRollChange'] = args.val
    elseif args.id == 'MessageSystem_OnRollChange' then
        Options['Messages']['MessageSystem_OnRollChange'] = args.val
    elseif args.id == 'MessageFormatSystem_OnRollChange' then
        Options['Messages']['MessageFormatSystem_OnRollChange'] = args.val

    elseif args.id == 'Messages_OnRollAccept_Enabled' then
        Options['Messages']['OnRollAccept_Enabled'] = args.val
    elseif args.id == 'MessageSquad_OnRollAccept' then
        Options['Messages']['MessageSquad_OnRollAccept'] = args.val
    elseif args.id == 'MessageFormatSquad_OnRollAccept' then
        Options['Messages']['MessageFormatSquad_OnRollAccept'] = args.val
    elseif args.id == 'MessageSystem_OnRollAccept' then
        Options['Messages']['MessageSystem_OnRollAccept'] = args.val
    elseif args.id == 'MessageFormatSystem_OnRollAccept' then
        Options['Messages']['MessageFormatSystem_OnRollAccept'] = args.val

    elseif args.id == 'Messages_OnRollBusy_Enabled' then
        Options['Messages']['OnRollBusy_Enabled'] = args.val
    elseif args.id == 'MessageSquad_OnRollBusy' then
        Options['Messages']['MessageSquad_OnRollBusy'] = args.val
    elseif args.id == 'MessageFormatSquad_OnRollBusy' then
        Options['Messages']['MessageFormatSquad_OnRollBusy'] = args.val
    elseif args.id == 'MessageSystem_OnRollBusy' then
        Options['Messages']['MessageSystem_OnRollBusy'] = args.val
    elseif args.id == 'MessageFormatSystem_OnRollBusy' then
        Options['Messages']['MessageFormatSystem_OnRollBusy'] = args.val

    elseif args.id == 'Messages_OnRollNobody_Enabled' then
        Options['Messages']['OnRollNobody_Enabled'] = args.val
    elseif args.id == 'MessageSquad_OnRollNobody' then
        Options['Messages']['MessageSquad_OnRollNobody'] = args.val
    elseif args.id == 'MessageFormatSquad_OnRollNobody' then
        Options['Messages']['MessageFormatSquad_OnRollNobody'] = args.val
    elseif args.id == 'MessageSystem_OnRollNobody' then
        Options['Messages']['MessageSystem_OnRollNobody'] = args.val
    elseif args.id == 'MessageFormatSystem_OnRollNobody' then
        Options['Messages']['MessageFormatSystem_OnRollNobody'] = args.val

    elseif args.id == 'Messages_OnLootDespawn_Enabled' then
        Options['Messages']['OnLootDespawn_Enabled'] = args.val
    elseif args.id == 'MessageSquad_OnLootDespawn' then
        Options['Messages']['MessageSquad_OnLootDespawn'] = args.val
    elseif args.id == 'MessageFormatSquad_OnLootDespawn' then
        Options['Messages']['MessageFormatSquad_OnLootDespawn'] = args.val
    elseif args.id == 'MessageSystem_OnLootDespawn' then
        Options['Messages']['MessageSystem_OnLootDespawn'] = args.val
    elseif args.id == 'MessageFormatSystem_OnLootDespawn' then
        Options['Messages']['MessageFormatSystem_OnLootDespawn'] = args.val

    elseif args.id == 'Messages_OnIdentify_Enabled' then
        Options['Messages']['OnIdentify_Enabled'] = args.val
    elseif args.id == 'MessageSquad_OnIdentify' then
        Options['Messages']['MessageSquad_OnIdentify'] = args.val
    elseif args.id == 'MessageFormatSquad_OnIdentify' then
        Options['Messages']['MessageFormatSquad_OnIdentify'] = args.val
    elseif args.id == 'MessageSystem_OnIdentify' then
        Options['Messages']['MessageSystem_OnIdentify'] = args.val
    elseif args.id == 'MessageFormatSystem_OnIdentify' then
        Options['Messages']['MessageFormatSystem_OnIdentify'] = args.val



    elseif args.id == 'Communication_Custom' then
        Options['Messages']['Communication_Custom'] = args.val
        UpdateOptionVisibility()

    elseif args.id == 'Communication_Prefix' then
        Options['Messages']['Communication_Prefix'] = args.val

    elseif args.id == 'Communication_Assign' then
        Options['Messages']['Communication_Assign'] = args.val

    elseif args.id == 'Communication_Assign_Format' then
        Options['Messages']['Communication_Assign_Format'] = args.val



    elseif args.id == 'Group_Waypoints' then
        Options['Waypoints']['Enabled'] = args.val

    elseif args.id == 'Waypoints_ShowOnHud' then
        Options['Waypoints']['ShowOnHud'] = args.val

    elseif args.id == 'Waypoints_ShowOnWorldMap' then
        Options['Waypoints']['ShowOnWorldMap'] = args.val

    elseif args.id == 'Waypoints_ShowOnRadar' then
        Options['Waypoints']['ShowOnRadar'] = args.val

    elseif args.id == 'Waypoints_RadarEdgeMode' then
        Options['Waypoints']['RadarEdgeMode'] = args.val

    elseif args.id == 'Waypoints_TrailAssigned' then
        Options['Waypoints']['TrailAssigned'] = args.val

    elseif args.id == 'Waypoints_PingAssigned' then
        Options['Waypoints']['PingAssigned'] = args.val



    elseif args.id == 'Group_Panels' then
        Options['Panels']['Enabled'] = args.val

    elseif args.id == 'Panels_Mode' then
        Options['Panels']['Mode'] = args.val

    elseif args.id == 'Panels_HeaderBar_ColorMode' then
        Options['Panels']['HeaderBar_ColorMode'] = args.val

    elseif args.id == 'Panels_Color_ItemName_ColorMode' then
        Options['Panels']['Color_ItemName_ColorMode'] = args.val

    elseif args.id == 'Panels_ItemName_ColorMode' then
        Options['Panels']['ItemName_ColorMode'] = args.val

    elseif args.id == 'Panels_Color_ItemName_ColorMode_Custom' then
        Options['Panels']['Color_ItemName_ColorMode_Custom'] = args.val

    elseif args.id == 'Panels_Display_AssignedTo' then
        Options['Panels']['Display_AssignedTo'] = args.val

    elseif args.id == 'Panels_Display_AssignedTo_Hide_nil' then
        Options['Panels']['Display_AssignedTo_Hide_nil'] = args.val

    elseif args.id == 'Panels_Color_AssignedTo_nil' then
        Options['Panels']['Color_AssignedTo_nil'] = args.val

    elseif args.id == 'Panels_Color_AssignedTo_free' then
        Options['Panels']['Color_AssignedTo_free'] = args.val

    elseif args.id == 'Panels_Color_AssignedTo_player' then
        Options['Panels']['Color_AssignedTo_player'] = args.val

    elseif args.id == 'Panels_Color_AssignedTo_other' then
        Options['Panels']['Color_AssignedTo_other'] = args.val



    elseif args.id == 'Tracker_Enabled' then
        Options['Tracker']['Enabled'] = args.val
    elseif args.id == 'Tracker_Display_Mode' then
        Options['Tracker']['Display_Mode'] = args.val
    elseif args.id == 'Tracker_Display_Mode_OnlySquadLeader' then
        Options['Tracker']['Display_Mode_OnlySquadLeader'] = args.val
    elseif args.id == 'Tracker_Display_Headings' then
        Options['Tracker']['Display_Headings'] = args.val



    elseif args.id == 'Sounds_Mute' then
        Options['Sounds']['Mute'] = args.val

    elseif args.id == 'Sounds_OnIdentify' then
        Options['Sounds']['OnIdentify'] = args.val
        if bLoaded then System.PlaySound(args.val) end

    elseif args.id == 'Sounds_OnIdentify_Rollable' then
        Options['Sounds']['OnIdentify_Rollable'] = args.val
        if bLoaded then System.PlaySound(args.val) end

    elseif args.id == 'Sounds_OnAssignItem_ToMe' then
        Options['Sounds']['OnAssignItem_ToMe'] = args.val
        if bLoaded then System.PlaySound(args.val) end

    elseif args.id == 'Sounds_OnAssignItem_ToOther' then
        Options['Sounds']['OnAssignItem_ToOther'] = args.val
        if bLoaded then System.PlaySound(args.val) end


    elseif args.id == 'Debug_Enabled' then
        Options['Debug']['Enabled'] = args.val
        Component.SaveSetting('DebugMode', Options['Debug']['Enabled'])
        Debug.EnableLogging(Options['Debug']['Enabled'])

    elseif args.id == 'Debug_FakeOnSquadRoster' then
        Options['Debug']['FakeOnSquadRoster'] = args.val
        OnSquadRosterUpdate()

    end

    -- Updates
    UpdateOptionVisibility()
    UpdateTracker()
end

--[[
    UpdateOptionVisibility()
    Supposed to hide/unhide shit in the Interface Options.
]]--
function UpdateOptionVisibility()
    -- Disable all
    InterfaceOptions.DisableOption('Group_Loot_Rolls', true)
    InterfaceOptions.DisableOption('RollMin', true)
    InterfaceOptions.DisableOption('RollMax', true)
    InterfaceOptions.DisableOption('RollTimeout', true)

    InterfaceOptions.DisableOption('Communication_Prefix', true)
    InterfaceOptions.DisableOption('Communication_Assign', true)
    InterfaceOptions.DisableOption('Communication_Assign_Format', true)

    InterfaceOptions.DisableOption('Panels_Color_HeaderBar_ColorMode_Custom', true)
    InterfaceOptions.DisableOption('Panels_Color_ItemName_ColorMode_Custom', true)


    -- Enable specific
    if Options['Manager']['LootMode'] == 'dice' or Options['Manager']['LootMode'] == 'need-before-greed' then
        InterfaceOptions.DisableOption('Group_Loot_Rolls', false)
        InterfaceOptions.DisableOption('RollMin', false)
        InterfaceOptions.DisableOption('RollMax', false)
        InterfaceOptions.DisableOption('RollTimeout', false)
    end

    if Options['Panels']['HeaderBar_ColorMode'] == 'custom' then
        InterfaceOptions.DisableOption('Panels_Color_HeaderBar_ColorMode_Custom', false)
    end

    if Options['Panels']['ItemName_ColorMode'] == 'custom' then
        InterfaceOptions.DisableOption('Panels_Color_ItemName_ColorMode_Custom', false)
    end

    if Options['Messages']['Communication_Custom'] then 
        InterfaceOptions.DisableOption('Communication_Prefix', false)
        InterfaceOptions.DisableOption('Communication_Assign', false)
        InterfaceOptions.DisableOption('Communication_Assign_Format', true) -- Locked option because whislt it is used for sending, the receiving end is a hardcoded match
    end

end


--[[
    SetupInterfaceOptions()
    Sets up the Interface Options, including the callback to OnOptionChange and the Save Version.

]]--
function SetupInterfaceOptions()
    -- Callback and save version
    InterfaceOptions.NotifyOnLoaded(true) -- Notify us on loaded so that we don't play sounds when user reloads
    InterfaceOptions.SetCallbackFunc(function(id, val) OnOptionChange({id=id,val=val}) end, 'xSquadLootManager') -- Callback for when user changes settings
    InterfaceOptions.SaveVersion(ciSaveVersion) -- Settings save-version, increment if behavior changes

    -- First page Settings
    InterfaceOptions.StartGroup({
        id='Group_Front',
        label='Xsear\'s Squad Loot Manager'
    })
        
        InterfaceOptions.AddCheckBox({id='Enabled',
            label=Lokii.GetString('Enabled_Label'),
            tooltip=Lokii.GetString('Enabled_ToolTip'),
            default=true
        })

        InterfaceOptions.AddCheckBox({id='VersionMessage',
            label=Lokii.GetString('VersionMessage_Label'),
            tooltip=Lokii.GetString('VersionMessage_ToolTip'),
            default=true
        })

        InterfaceOptions.AddCheckBox({id='AlwaysSquadLeader',
            label=Lokii.GetString('AlwaysSquadLeader_Label'),
            tooltip=Lokii.GetString('AlwaysSquadLeader_ToolTip'),
            default=false
        })

        InterfaceOptions.AddCheckBox({id='NoSquadMessages',
            label=Lokii.GetString('NoSquadMessages_Label'),
            tooltip=Lokii.GetString('NoSquadMessages_ToolTip'),
            default=false
        })
        InterfaceOptions.AddCheckBox({id='NoSystemMessages',
            label=Lokii.GetString('NoSystemMessages_Label'),
            tooltip=Lokii.GetString('NoSystemMessages_ToolTip'),
            default=false
        })

    InterfaceOptions.StopGroup()


    -- Debug Settings
    InterfaceOptions.StartGroup({
        id = 'Debug_Enabled',
        checkbox = true,
        default = Options['Debug']['Enabled'],
        label = Lokii.GetString('Debug_Enabled_Label'),
        tooltip = Lokii.GetString('Debug_Enabled_ToolTip')
    })

        InterfaceOptions.AddCheckBox({
            id = 'Debug_FakeOnSquadRoster',
            default = Options['Debug']['FakeOnSquadRoster'],
            label = Lokii.GetString('Debug_FakeOnSquadRoster_Label'),
            tooltip = Lokii.GetString('Debug_FakeOnSquadRoster_ToolTip'),
        })

    InterfaceOptions.StopGroup()

    
    -- Manager General Settings
    InterfaceOptions.StartGroup({
        id='Group_Loot_General',
        label=Lokii.GetString('Group_Loot_General_Label'),
        tooltip=Lokii.GetString('Group_Loot_General_ToolTip'),
        subtab={Lokii.GetString('Subtab_LootingRules')}
    })

        InterfaceOptions.AddChoiceMenu({
            id='LootMode',
            default='dice',
            label=Lokii.GetString('LootMode_Label'),
            tooltip=Lokii.GetString('LootMode_ToolTip'),
            subtab={Lokii.GetString('Subtab_LootingRules')}
        })

            InterfaceOptions.AddChoiceEntry({
                menuId='LootMode',
                val='random',
                label=Lokii.GetString('LootMode_Random_Label'),
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })

            InterfaceOptions.AddChoiceEntry({
                menuId='LootMode',
                val='dice',
                label=Lokii.GetString('LootMode_Dice_Label'),
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })

            InterfaceOptions.AddChoiceEntry({
                menuId='LootMode',
                val='round-robin',
                label=Lokii.GetString('LootMode_RoundRobin_Label'),
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })

            InterfaceOptions.AddChoiceEntry({
                menuId='LootMode',
                val='need-before-greed',
                label=Lokii.GetString('LootMode_NeedBeforeGreed_Label'),
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })

        InterfaceOptions.AddChoiceMenu({
            id='LootWeighting',
            default='disabled',
            label=Lokii.GetString('LootWeighting_Label'),
            tooltip=Lokii.GetString('LootWeighting_ToolTip'),
            subtab={Lokii.GetString('Subtab_LootingRules')}
        })

            InterfaceOptions.AddChoiceEntry({
                menuId='LootWeighting',
                val='disabled',
                label=Lokii.GetString('LootWeighting_Disabled_Label'),
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })

            InterfaceOptions.AddChoiceEntry({
                menuId='LootWeighting',
                val='archetype',
                label=Lokii.GetString('LootWeighting_Archetype_Label'),
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })


            --[[
            InterfaceOptions.AddChoiceEntry({
                menuId='LootWeighting',
                val='frame',
                label=Lokii.GetString('LootWeighting_Frame_Label'),
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })
            --]]

            --[[
            InterfaceOptions.AddChoiceEntry({
                menuId='LootWeighting',
                val='preference',
                label='NYI-Preference',
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })
            --]]

        InterfaceOptions.AddChoiceMenu({
            id='LootThreshold',
            default='any',
            label=Lokii.GetString('LootThreshold_Label'),
            tooltip=Lokii.GetString('LootThreshold_ToolTip'),
            subtab={Lokii.GetString('Subtab_LootingRules')}
        })

            InterfaceOptions.AddChoiceEntry({
                menuId='LootThreshold',
                val='any',
                label=Lokii.GetString('LootThreshold_Any_Label'),
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })

            InterfaceOptions.AddChoiceEntry({
                menuId='LootThreshold',
                val='green',
                label=Lokii.GetString('LootThreshold_Green_Label'),
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })

            InterfaceOptions.AddChoiceEntry({
                menuId='LootThreshold',
                val='blue',
                label=Lokii.GetString('LootThreshold_Blue_Label'),
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })

            InterfaceOptions.AddChoiceEntry({
                menuId='LootThreshold',
                val='purple',
                label=Lokii.GetString('LootThreshold_Purple_Label'),
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })

            InterfaceOptions.AddChoiceEntry({
                menuId='LootThreshold',
                val='orange',
                label=Lokii.GetString('LootThreshold_Orange_Label'),
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })

        InterfaceOptions.AddCheckBox({
            id='AutoDistribute',
            default=true,
            label=Lokii.GetString('AutoDistribute_Label'),
            tooltip=Lokii.GetString('AutoDistribute_ToolTip'),
            subtab={Lokii.GetString('Subtab_LootingRules')}
        })

        InterfaceOptions.AddCheckBox({
            id = 'IdentifyAllLoot',
            default = true,
            label = Lokii.GetString('IdentifyAllLoot_Label'),
            tooltip = Lokii.GetString('IdentifyAllLoot_ToolTip'),
            subtab = {Lokii.GetString('Subtab_LootingRules')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_LootingRules')}})


    InterfaceOptions.StartGroup({
        id='Group_Loot_Rolls',
        label=Lokii.GetString('Group_Loot_Rolls_Label'),
        tooltip=Lokii.GetString('Group_Loot_Rolls_ToolTip'),
        subtab={Lokii.GetString('Subtab_LootingRules')}
    })

        InterfaceOptions.AddTextInput({
            id='RollMin',
            numeric=true,
            default=Options['Manager']['RollMin'],
            label=Lokii.GetString('RollMin_Label'),
            tooltip=Lokii.GetString('RollMin_ToolTip'),
            subtab={Lokii.GetString('Subtab_LootingRules')}
        })

        InterfaceOptions.AddTextInput({
            id='RollMax',
            numeric=true,
            default=Options['Manager']['RollMax'],
            label=Lokii.GetString('RollMax_Label'),
            tooltip=Lokii.GetString('RollMax_ToolTip'),
            subtab={Lokii.GetString('Subtab_LootingRules')}
        })

        InterfaceOptions.AddTextInput({
            id='RollTimeout',
            numeric=true,
            default=Options['Manager']['RollTimeout'],
            label=Lokii.GetString('RollTimeout_Label'),
            tooltip=Lokii.GetString('RollTimeout_ToolTip'),
            subtab={Lokii.GetString('Subtab_LootingRules')}
        })

        InterfaceOptions.AddChoiceMenu({
            id='RollTypeDefault',
            default='pass',
            label=Lokii.GetString('RollTypeDefault_Label'),
            tooltip=Lokii.GetString('RollTypeDefault_ToolTip'),
            subtab={Lokii.GetString('Subtab_LootingRules')}
        })

            InterfaceOptions.AddChoiceEntry({
                menuId='RollTypeDefault',
                val='pass',
                label=Lokii.GetString('RollTypeDefault_Pass_Label'),
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })

            InterfaceOptions.AddChoiceEntry({
                menuId='RollTypeDefault',
                val='greed',
                label=Lokii.GetString('RollTypeDefault_Greed_Label'),
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })
            -- For now we don't allow users to select need as the default roll type since it would cause issues
            --[[
            InterfaceOptions.AddChoiceEntry({
                menuId='RollTypeDefault',
                val='need',
                label=Lokii.GetString('RollTypeDefault_Need_Label'),
                subtab={Lokii.GetString('Subtab_LootingRules')}
            })
            ]]--

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_LootingRules')}})
    
    -- Messages Generic Settings    
    InterfaceOptions.StartGroup({
        id='Group_Messages_Generic',
        label=Lokii.GetString('Group_Messages_Generic_Label'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })
        
        InterfaceOptions.AddTextInput({
            id='Generic_Prefix',
            label=Lokii.GetString('Generic_Prefix_Label'),
            tooltip=Lokii.GetString('Generic_Prefix_ToolTip'),
            default=Options['Messages']['Generic_Prefix'],
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})


    InterfaceOptions.StartGroup({
        id='OnDistributeItem_Enabled',
        default=Options['Messages']['OnDistributeItem_Enabled'],
        checkbox=true,
        label=Lokii.GetString('OnDistributeItem_Enabled_Label'),
        tooltip=Lokii.GetString('OnDistributeItem_Enabled_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })

        InterfaceOptions.AddCheckBox({
            id='MessageSquad_OnDistributeItem',
            default=Options['Messages']['MessageSquad_OnDistributeItem'],
            label=Lokii.GetString('MessageSquad_OnDistributeItem_Label'),
            tooltip=Lokii.GetString('MessageSquad_OnDistributeItem_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSquad_OnDistributeItem',
            label=Lokii.GetString('MessageFormatSquad_OnDistributeItem_Label'),
            tooltip=Lokii.GetString('MessageFormatSquad_OnDistributeItem_ToolTip'),
            default=Options['Messages']['MessageFormatSquad_OnDistributeItem'],
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddCheckBox({id='MessageSystem_OnDistributeItem',
            default=Options['Messages']['MessageSystem_OnDistributeItem'],
            label=Lokii.GetString('MessageSystem_OnDistributeItem_Label'),
            tooltip=Lokii.GetString('MessageSystem_OnDistributeItem_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({id='MessageFormatSystem_OnDistributeItem',
            default=Options['Messages']['MessageFormatSystem_OnDistributeItem'],
            label=Lokii.GetString('MessageFormatSystem_OnDistributeItem_Label'),
            tooltip=Lokii.GetString('MessageFormatSystem_OnDistributeItem_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})


    InterfaceOptions.StartGroup({
        id='OnIdentify_Enabled',
        default=Options['Messages']['OnIdentify_Enabled'],
        checkbox=true,
        label=Lokii.GetString('OnIdentify_Enabled_Label'),
        tooltip=Lokii.GetString('OnIdentify_Enabled_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })

        InterfaceOptions.AddCheckBox({
            id='MessageSquad_OnIdentify',
            default=Options['Messages']['MessageSquad_OnIdentify'],
            label=Lokii.GetString('MessageSquad_OnIdentify_Label'),
            tooltip=Lokii.GetString('MessageSquad_OnIdentify_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSquad_OnIdentify',
            default=Options['Messages']['MessageFormatSquad_OnIdentify'],
            label=Lokii.GetString('MessageFormatSquad_OnIdentify_Label'),
            tooltip=Lokii.GetString('MessageFormatSquad_OnIdentify_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddCheckBox({
            id='MessageSystem_OnIdentify',
            default=Options['Messages']['MessageSystem_OnIdentify'],
            label=Lokii.GetString('MessageSystem_OnIdentify_Label'),
            tooltip=Lokii.GetString('MessageSystem_OnIdentify_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSystem_OnIdentify',
            default=Options['Messages']['MessageFormatSystem_OnIdentify'],
            label=Lokii.GetString('MessageFormatSystem_OnIdentify_Label'),
            tooltip=Lokii.GetString('MessageFormatSystem_OnIdentify_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})


    InterfaceOptions.StartGroup({
        id='OnRolls_Enabled',
        default=Options['Messages']['OnRolls_Enabled'],
        checkbox=true,
        label=Lokii.GetString('OnRolls_Enabled_Label'),
        tooltip=Lokii.GetString('OnRolls_Enabled_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })


        InterfaceOptions.AddCheckBox({
            id='MessageSquad_OnRolls',
            default=Options['Messages']['MessageSquad_OnRolls'],
            label=Lokii.GetString('MessageSquad_OnRolls_Label'),
            tooltip=Lokii.GetString('MessageSquad_OnRolls_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSquad_OnRolls',
            label=Lokii.GetString('MessageFormatSquad_OnRolls_Label'),
            tooltip=Lokii.GetString('MessageFormatSquad_OnRolls_ToolTip'),
            default=Options['Messages']['MessageFormatSquad_OnRolls'],
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddCheckBox({
            id='MessageSystem_OnRolls',
            default=Options['Messages']['MessageSystem_OnRolls'],
            label=Lokii.GetString('MessageSystem_OnRolls_Label'),
            tooltip=Lokii.GetString('MessageSystem_OnRolls_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSystem_OnRolls',
            label=Lokii.GetString('MessageFormatSystem_OnRolls_Label'),
            tooltip=Lokii.GetString('MessageFormatSystem_OnRolls_ToolTip'),
            default=Options['Messages']['MessageFormatSystem_OnRolls'],
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})


    InterfaceOptions.StartGroup({
        id='OnAcceptingRolls_Enabled',
        default=Options['Messages']['OnAcceptingRolls_Enabled'],
        checkbox=true,
        label=Lokii.GetString('OnAcceptingRolls_Enabled_Label'),
        tooltip=Lokii.GetString('OnAcceptingRolls_Enabled_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })

        InterfaceOptions.AddCheckBox({
            id='MessageSquad_OnAcceptingRolls',
            default=Options['Messages']['MessageSquad_OnAcceptingRolls'],
            label=Lokii.GetString('MessageSquad_OnAcceptingRolls_Label'),
            tooltip=Lokii.GetString('MessageSquad_OnAcceptingRolls_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSquad_OnAcceptingRolls',
            label=Lokii.GetString('MessageFormatSquad_OnAcceptingRolls_Label'),
            tooltip=Lokii.GetString('MessageFormatSquad_OnAcceptingRolls_ToolTip'),
            default=Options['Messages']['MessageFormatSquad_OnAcceptingRolls'],
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddCheckBox({
            id='MessageSystem_OnAcceptingRolls',
            default=Options['Messages']['MessageSystem_OnRolls'],
            label=Lokii.GetString('MessageSystem_OnAcceptingRolls_Label'),
            tooltip=Lokii.GetString('MessageSystem_OnAcceptingRolls_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSystem_OnAcceptingRolls',
            label=Lokii.GetString('MessageFormatSystem_OnAcceptingRolls_Label'),
            tooltip=Lokii.GetString('MessageFormatSystem_OnAcceptingRolls_ToolTip'),
            default=Options['Messages']['MessageFormatSystem_OnAcceptingRolls'],
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})


    InterfaceOptions.StartGroup({
        id='OnAssignItem_Enabled',
        default=Options['Messages']['OnAssignItem_Enabled'],
        checkbox=true,
        label=Lokii.GetString('OnAssignItem_Enabled_Label'),
        tooltip=Lokii.GetString('OnAssignItem_Enabled_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })

        InterfaceOptions.AddCheckBox({
            id='MessageSquad_OnAssignItem',
            default=Options['Messages']['MessageSquad_OnAssignItem'],
            label=Lokii.GetString('MessageSquad_OnAssignItem_Label'),
            tooltip=Lokii.GetString('MessageSquad_OnAssignItem_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSquad_OnAssignItem',
            default=Options['Messages']['MessageFormatSquad_OnAssignItem'],
            label=Lokii.GetString('MessageFormatSquad_OnAssignItem_Label'),
            tooltip=Lokii.GetString('MessageFormatSquad_OnAssignItem_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddCheckBox({
            id='MessageSystem_OnAssignItem',
            default=Options['Messages']['MessageSystem_OnAssignItem'],
            label=Lokii.GetString('MessageSystem_OnAssignItem_Label'),
            tooltip=Lokii.GetString('MessageSystem_OnAssignItem_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSystem_OnAssignItem',
            default=Options['Messages']['MessageFormatSystem_OnAssignItem'],
            label=Lokii.GetString('MessageFormatSystem_OnAssignItem_Label'),
            tooltip=Lokii.GetString('MessageFormatSystem_OnAssignItem_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})


    InterfaceOptions.StartGroup({
        id='OnLootReceived_Enabled',
        default=Options['Messages']['OnLootReceived_Enabled'],
        checkbox=true,
        label=Lokii.GetString('OnLootReceived_Enabled_Label'),
        tooltip=Lokii.GetString('OnLootReceived_Enabled_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })

        InterfaceOptions.AddCheckBox({
            id='MessageSquad_OnLootReceived',
            default=Options['Messages']['MessageSquad_OnLootReceived'],
            label=Lokii.GetString('MessageSquad_OnLootReceived_Label'),
            tooltip=Lokii.GetString('MessageSquad_OnLootReceived_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSquad_OnLootReceived',
            default=Options['Messages']['MessageFormatSquad_OnLootReceived'],
            label=Lokii.GetString('MessageFormatSquad_OnLootReceived_Label'),
            tooltip=Lokii.GetString('MessageFormatSquad_OnLootReceived_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddCheckBox({
            id='MessageSystem_OnLootReceived',
            default=Options['Messages']['MessageSystem_OnLootReceived'],
            label=Lokii.GetString('MessageSystem_OnLootReceived_Label'),
            tooltip=Lokii.GetString('MessageSystem_OnLootReceived_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSystem_OnLootReceived',
            default=Options['Messages']['MessageFormatSystem_OnLootReceived'],
            label=Lokii.GetString('MessageFormatSystem_OnLootReceived_Label'),
            tooltip=Lokii.GetString('MessageFormatSystem_OnLootReceived_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})


    InterfaceOptions.StartGroup({
        id='OnLootStolen_Enabled',
        default=Options['Messages']['OnLootStolen_Enabled'],
        checkbox=true,
        label=Lokii.GetString('OnLootStolen_Enabled_Label'),
        tooltip=Lokii.GetString('OnLootStolen_Enabled_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })

        InterfaceOptions.AddCheckBox({
            id='MessageSquad_OnLootStolen',
            default=Options['Messages']['MessageSquad_OnLootStolen'],
            label=Lokii.GetString('MessageSquad_OnLootStolen_Label'),
            tooltip=Lokii.GetString('MessageSquad_OnLootStolen_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSquad_OnLootStolen',
            default=Options['Messages']['MessageFormatSquad_OnLootStolen'],
            label=Lokii.GetString('MessageFormatSquad_OnLootStolen_Label'),
            tooltip=Lokii.GetString('MessageFormatSquad_OnLootStolen_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddCheckBox({
            id='MessageSystem_OnLootStolen',
            default=Options['Messages']['MessageSystem_OnLootStolen'],
            label=Lokii.GetString('MessageSystem_OnLootStolen_Label'),
            tooltip=Lokii.GetString('MessageSystem_OnLootStolen_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSystem_OnLootStolen',
            default=Options['Messages']['MessageFormatSystem_OnLootStolen'],
            label=Lokii.GetString('MessageFormatSystem_OnLootStolen_Label'),
            tooltip=Lokii.GetString('MessageFormatSystem_OnLootStolen_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})


    InterfaceOptions.StartGroup({
        id='OnLootSnatched_Enabled',
        default=Options['Messages']['OnLootSnatched_Enabled'],
        checkbox=true,
        label=Lokii.GetString('OnLootSnatched_Enabled_Label'),
        tooltip=Lokii.GetString('OnLootSnatched_Enabled_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })

        InterfaceOptions.AddCheckBox({
            id='MessageSquad_OnLootSnatched',
            default=Options['Messages']['MessageSquad_OnLootSnatched'],
            label=Lokii.GetString('MessageSquad_OnLootSnatched_Label'),
            tooltip=Lokii.GetString('MessageSquad_OnLootSnatched_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSquad_OnLootSnatched',
            default=Options['Messages']['MessageFormatSquad_OnLootSnatched'],
            label=Lokii.GetString('MessageFormatSquad_OnLootSnatched_Label'),
            tooltip=Lokii.GetString('MessageFormatSquad_OnLootSnatched_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddCheckBox({
            id='MessageSystem_OnLootSnatched',
            default=Options['Messages']['MessageSystem_OnLootSnatched'],
            label=Lokii.GetString('MessageSystem_OnLootSnatched_Label'),
            tooltip=Lokii.GetString('MessageSystem_OnLootSnatched_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSystem_OnLootSnatched',
            default=Options['Messages']['MessageFormatSystem_OnLootSnatched'],
            label=Lokii.GetString('MessageFormatSystem_OnLootSnatched_Label'),
            tooltip=Lokii.GetString('MessageFormatSystem_OnLootSnatched_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})

    InterfaceOptions.StartGroup({
        id='OnLootClaimed_Enabled',
        default=Options['Messages']['OnLootClaimed_Enabled'],
        checkbox=true,
        label=Lokii.GetString('OnLootClaimed_Enabled_Label'),
        tooltip=Lokii.GetString('OnLootClaimed_Enabled_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })

        InterfaceOptions.AddCheckBox({
            id='MessageSquad_OnLootClaimed',
            default=Options['Messages']['MessageSquad_OnLootClaimed'],
            label=Lokii.GetString('MessageSquad_OnLootClaimed_Label'),
            tooltip=Lokii.GetString('MessageSquad_OnLootClaimed_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSquad_OnLootClaimed',
            default=Options['Messages']['MessageFormatSquad_OnLootClaimed'],
            label=Lokii.GetString('MessageFormatSquad_OnLootClaimed_Label'),
            tooltip=Lokii.GetString('MessageFormatSquad_OnLootClaimed_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddCheckBox({
            id='MessageSystem_OnLootClaimed',
            default=Options['Messages']['MessageSystem_OnLootClaimed'],
            label=Lokii.GetString('MessageSystem_OnLootClaimed_Label'),
            tooltip=Lokii.GetString('MessageSystem_OnLootClaimed_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSystem_OnLootClaimed',
            default=Options['Messages']['MessageFormatSystem_OnLootClaimed'],
            label=Lokii.GetString('MessageFormatSystem_OnLootClaimed_Label'),
            tooltip=Lokii.GetString('MessageFormatSystem_OnLootClaimed_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})


    InterfaceOptions.StartGroup({
        id='OnLootDespawn_Enabled',
        default=Options['Messages']['OnLootDespawn_Enabled'],
        checkbox=true,
        label=Lokii.GetString('OnLootDespawn_Enabled_Label'),
        tooltip=Lokii.GetString('OnLootDespawn_Enabled_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })

        InterfaceOptions.AddCheckBox({
            id='MessageSquad_OnLootDespawn',
            default=Options['Messages']['MessageSquad_OnLootDespawn'],
            label=Lokii.GetString('MessageSquad_OnLootDespawn_Label'),
            tooltip=Lokii.GetString('MessageSquad_OnLootDespawn_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSquad_OnLootDespawn',
            default=Options['Messages']['MessageFormatSquad_OnLootDespawn'],
            label=Lokii.GetString('MessageFormatSquad_OnLootDespawn_Label'),
            tooltip=Lokii.GetString('MessageFormatSquad_OnLootDespawn_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddCheckBox({
            id='MessageSystem_OnLootDespawn',
            default=Options['Messages']['MessageSystem_OnLootDespawn'],
            label=Lokii.GetString('MessageSystem_OnLootDespawn_Label'),
            tooltip=Lokii.GetString('MessageSystem_OnLootDespawn_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSystem_OnLootDespawn',
            default=Options['Messages']['MessageFormatSystem_OnLootDespawn'],
            label=Lokii.GetString('MessageFormatSystem_OnLootDespawn_Label'),
            tooltip=Lokii.GetString('MessageFormatSystem_OnLootDespawn_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})


    InterfaceOptions.StartGroup({
        id='OnRollAccept_Enabled',
        default=Options['Messages']['OnRollAccept_Enabled'],
        checkbox=true,
        label=Lokii.GetString('OnRollAccept_Enabled_Label'),
        tooltip=Lokii.GetString('OnRollAccept_Enabled_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })

        InterfaceOptions.AddCheckBox({
            id='MessageSquad_OnRollAccept',
            default=Options['Messages']['MessageSquad_OnRollAccept'],
            label=Lokii.GetString('MessageSquad_OnRollAccept_Label'),
            tooltip=Lokii.GetString('MessageSquad_OnRollAccept_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSquad_OnRollAccept',
            default=Options['Messages']['MessageFormatSquad_OnRollAccept'],
            label=Lokii.GetString('MessageFormatSquad_OnRollAccept_Label'),
            tooltip=Lokii.GetString('MessageFormatSquad_OnRollAccept_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddCheckBox({
            id='MessageSystem_OnRollAccept',
            default=Options['Messages']['MessageSystem_OnRollAccept'],
            label=Lokii.GetString('MessageSystem_OnRollAccept_Label'),
            tooltip=Lokii.GetString('MessageSystem_OnRollAccept_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSystem_OnRollAccept',
            default=Options['Messages']['MessageFormatSystem_OnRollAccept'],
            label=Lokii.GetString('MessageFormatSystem_OnRollAccept_Label'),
            tooltip=Lokii.GetString('MessageFormatSystem_OnRollAccept_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})


    InterfaceOptions.StartGroup({
        id='OnRollBusy_Enabled',
        default=Options['Messages']['OnRollBusy_Enabled'],
        checkbox=true,
        label=Lokii.GetString('OnRollBusy_Enabled_Label'),
        tooltip=Lokii.GetString('OnRollBusy_Enabled_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })

        InterfaceOptions.AddCheckBox({
            id='MessageSquad_OnRollBusy',
            default=Options['Messages']['MessageSquad_OnRollBusy'],
            label=Lokii.GetString('MessageSquad_OnRollBusy_Label'),
            tooltip=Lokii.GetString('MessageSquad_OnRollBusy_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSquad_OnRollBusy',
            default=Options['Messages']['MessageFormatSquad_OnRollBusy'],
            label=Lokii.GetString('MessageFormatSquad_OnRollBusy_Label'),
            tooltip=Lokii.GetString('MessageFormatSquad_OnRollBusy_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddCheckBox({
            id='MessageSystem_OnRollBusy',
            default=Options['Messages']['MessageSystem_OnRollBusy'],
            label=Lokii.GetString('MessageSystem_OnRollBusy_Label'),
            tooltip=Lokii.GetString('MessageSystem_OnRollBusy_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSystem_OnRollBusy',
            default=Options['Messages']['MessageFormatSystem_OnRollBusy'],
            label=Lokii.GetString('MessageFormatSystem_OnRollBusy_Label'),
            tooltip=Lokii.GetString('MessageFormatSystem_OnRollBusy_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})


    InterfaceOptions.StartGroup({
        id='OnRollChange_Enabled',
        default=Options['Messages']['OnRollChange_Enabled'],
        checkbox=true,
        label=Lokii.GetString('OnRollChange_Enabled_Label'),
        tooltip=Lokii.GetString('OnRollChange_Enabled_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })

        InterfaceOptions.AddCheckBox({
            id='MessageSquad_OnRollChange',
            default=Options['Messages']['MessageSquad_OnRollChange'],
            label=Lokii.GetString('MessageSquad_OnRollChange_Label'),
            tooltip=Lokii.GetString('MessageSquad_OnRollChange_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSquad_OnRollChange',
            default=Options['Messages']['MessageFormatSquad_OnRollChange'],
            label=Lokii.GetString('MessageFormatSquad_OnRollChange_Label'),
            tooltip=Lokii.GetString('MessageFormatSquad_OnRollChange_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddCheckBox({
            id='MessageSystem_OnRollChange',
            default=Options['Messages']['MessageSystem_OnRollChange'],
            label=Lokii.GetString('MessageSystem_OnRollChange_Label'),
            tooltip=Lokii.GetString('MessageSystem_OnRollChange_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSystem_OnRollChange',
            default=Options['Messages']['MessageFormatSystem_OnRollChange'],
            label=Lokii.GetString('MessageFormatSystem_OnRollChange_Label'),
            tooltip=Lokii.GetString('MessageFormatSystem_OnRollChange_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})


    InterfaceOptions.StartGroup({
        id='OnRollNobody_Enabled',
        default=Options['Messages']['OnRollNobody_Enabled'],
        checkbox=true,
        label=Lokii.GetString('OnRollNobody_Enabled_Label'),
        tooltip=Lokii.GetString('OnRollNobody_Enabled_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })

        InterfaceOptions.AddCheckBox({
            id='MessageSquad_OnRollNobody',
            default=Options['Messages']['MessageSquad_OnRollNobody'],
            label=Lokii.GetString('MessageSquad_OnRollNobody_Label'),
            tooltip=Lokii.GetString('MessageSquad_OnRollNobody_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSquad_OnRollNobody',
            default=Options['Messages']['MessageFormatSquad_OnRollNobody'],
            label=Lokii.GetString('MessageFormatSquad_OnRollNobody_Label'),
            tooltip=Lokii.GetString('MessageFormatSquad_OnRollNobody_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddCheckBox({
            id='MessageSystem_OnRollNobody',
            default=Options['Messages']['MessageSystem_OnRollNobody'],
            label=Lokii.GetString('MessageSystem_OnRollNobody_Label'),
            tooltip=Lokii.GetString('MessageSystem_OnRollNobody_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='MessageFormatSystem_OnRollNobody',
            default=Options['Messages']['MessageFormatSystem_OnRollNobody'],
            label=Lokii.GetString('MessageFormatSystem_OnRollNobody_Label'),
            tooltip=Lokii.GetString('MessageFormatSystem_OnRollNobody_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})

    -- Messages Communication Settings
    InterfaceOptions.StartGroup({
        id='Group_Com',
        label=Lokii.GetString('Group_Com_Label'),
        tooltip=Lokii.GetString('Group_Com_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages')}
    })

        InterfaceOptions.AddCheckBox({
            id='Communication_Custom',
            default=Options['Messages']['Communication_Custom'],
            label=Lokii.GetString('Communication_Custom_Label'),
            tooltip=Lokii.GetString('Communication_Custom_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='Communication_Prefix',
            default=Options['Messages']['Communication_Prefix'],
            label=Lokii.GetString('Communication_Prefix_Label'),
            tooltip=Lokii.GetString('Communication_Prefix_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddCheckBox({
            id='Communication_Assign',
            default=Options['Messages']['Communication_Assign'],
            label=Lokii.GetString('Communication_Assign_Label'),
            tooltip=Lokii.GetString('Communication_Assign_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

        InterfaceOptions.AddTextInput({
            id='Communication_Assign_Format',
            default=Options['Messages']['Communication_Assign_Format'],
            label=Lokii.GetString('Communication_Assign_Format_Label'),
            tooltip=Lokii.GetString('Communication_Assign_Format_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages')}})


    InterfaceOptions.StartGroup({
        id='Group_Panels',
        default=Options['Panels']['Enabled'],
        checkbox=true,
        label=Lokii.GetString('Group_Panels_Label'),
        tooltip=Lokii.GetString('Group_Panels_ToolTip'),
        subtab={Lokii.GetString('Subtab_Markers')}
    })

        InterfaceOptions.AddChoiceMenu({
            id='Panels_Mode',
            default=Options['Panels']['Mode'],
            label=Lokii.GetString('Panels_Mode_Label'),
            tooltip=Lokii.GetString('Panels_Mode_ToolTip'),
            subtab={Lokii.GetString('Subtab_Markers')}
        })
                InterfaceOptions.AddChoiceEntry({
                    menuId='Panels_Mode',
                    val='standard',
                    label=Lokii.GetString('Panels_Mode_Standard_Label'),
                    subtab={Lokii.GetString('Subtab_Markers')}
                })

                InterfaceOptions.AddChoiceEntry({
                    menuId='Panels_Mode',
                    val='small',
                    label=Lokii.GetString('Panels_Mode_Small_Label'),
                    subtab={Lokii.GetString('Subtab_Markers')}
                })

        InterfaceOptions.AddChoiceMenu({
            id='Panels_HeaderBar_ColorMode',
            default=Options['Panels']['HeaderBar_ColorMode'],
            label=Lokii.GetString('Panels_HeaderBar_ColorMode_Label'),
            tooltip=Lokii.GetString('Panels_HeaderBar_ColorMode_ToolTip'),
            subtab={Lokii.GetString('Subtab_Markers')}
        })

                InterfaceOptions.AddChoiceEntry({
                    menuId='Panels_HeaderBar_ColorMode', 
                    val='item-quality', 
                    label=Lokii.GetString('Panels_HeaderBar_ColorMode_Quality_Label'), 
                    subtab={Lokii.GetString('Subtab_Markers')}
                })

                InterfaceOptions.AddChoiceEntry({
                    menuId='Panels_HeaderBar_ColorMode',
                    val='custom',
                    label=Lokii.GetString('Panels_HeaderBar_ColorMode_Custom_Label'),
                    subtab={Lokii.GetString('Subtab_Markers')}
                })

        InterfaceOptions.AddColorPicker({
            id='Panels_Color_HeaderBar_ColorMode_Custom',
            label=Lokii.GetString('Panels_Color_HeaderBar_ColorMode_Custom_Label'), 
            default=Options['Panels']['Color_HeaderBar_ColorMode_Custom'], 
            subtab={Lokii.GetString('Subtab_Markers')}
        })

        InterfaceOptions.AddChoiceMenu({
            id = 'Panels_ItemName_ColorMode',
            default = Options['Panels']['Color_ItemName_ColorMode'],
            label = Lokii.GetString('Panels_ItemName_ColorMode_Label'),
            tooltip = Lokii.GetString('Panels_ItemName_ColorMode_ToolTip'),
            subtab = {Lokii.GetString('Subtab_Markers')}
        })

                InterfaceOptions.AddChoiceEntry({
                    menuId='Panels_ItemName_ColorMode',
                    val='item-quality',
                    label=Lokii.GetString('Panels_ItemName_ColorMode_Quality_Label'),
                    subtab={Lokii.GetString('Subtab_Markers')}
                })

                InterfaceOptions.AddChoiceEntry({
                    menuId='Panels_ItemName_ColorMode',
                    val='custom',
                    label=Lokii.GetString('Panels_ItemName_ColorMode_Custom_Label'),
                    subtab={Lokii.GetString('Subtab_Markers')}
                })

        InterfaceOptions.AddColorPicker({
            id='Panels_Color_ItemName_ColorMode_Custom',
            label=Lokii.GetString('Panels_Color_ItemName_ColorMode_Custom_Label'),
            default=Options['Panels']['Color_ItemName_ColorMode_Custom'],
            subtab={Lokii.GetString('Subtab_Markers')}
        })

        InterfaceOptions.AddCheckBox({
            id='Panels_Display_AssignedTo',
            default=Options['Panels']['Display_AssignedTo'],
            label=Lokii.GetString('Panels_Display_AssignedTo_Label'),
            tooltip=Lokii.GetString('Panels_Display_AssignedTo_ToolTip'),
            subtab={Lokii.GetString('Subtab_Markers')}
        })

        InterfaceOptions.AddCheckBox({
            id='Panels_Display_AssignedTo_Hide_nil',
            default=Options['Panels']['Display_AssignedTo_Hide_nil'],
            label=Lokii.GetString('Panels_Display_AssignedTo_Hide_nil_Label'),
            tooltip=Lokii.GetString('Panels_Display_AssignedTo_Hide_nil_ToolTip'),
            subtab={Lokii.GetString('Subtab_Markers')}
        })

        InterfaceOptions.AddColorPicker({
            id='Panels_Color_AssignedTo_nil',
            label=Lokii.GetString('Color_AssignedTo_nil_Label'),
            default=Options['Panels']['Color_AssignedTo_nil'],
            subtab={Lokii.GetString('Subtab_Markers')}
        })

        InterfaceOptions.AddColorPicker({
            id='Panels_Color_AssignedTo_free',
            label=Lokii.GetString('Color_AssignedTo_free_Label'),
            default=Options['Panels']['Color_AssignedTo_free'],
            subtab={Lokii.GetString('Subtab_Markers')}
        })

        InterfaceOptions.AddColorPicker({
            id='Panels_Color_AssignedTo_player',
            label=Lokii.GetString('Color_AssignedTo_player_Label'),
            default=Options['Panels']['Color_AssignedTo_player'],
            subtab={Lokii.GetString('Subtab_Markers')}
        })

        InterfaceOptions.AddColorPicker({
            id='Panels_Color_AssignedTo_other',
            label=Lokii.GetString('Color_AssignedTo_other_Label'),
            default=Options['Panels']['Color_AssignedTo_other'],
            subtab={Lokii.GetString('Subtab_Markers')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Markers')}})


    InterfaceOptions.StartGroup({
        id='Group_Waypoints',
        default=Options['Waypoints']['Enabled'],
        checkbox=true,
        label=Lokii.GetString('Group_Waypoints_Label'),
        tooltip=Lokii.GetString('Group_Waypoints_ToolTip'),
        subtab={Lokii.GetString('Subtab_Markers')}
    })

        InterfaceOptions.AddCheckBox({
            id='Waypoints_ShowOnHud',
            default=Options['Waypoints']['ShowOnHud'],
            label=Lokii.GetString('Waypoints_ShowOnHud_Label'),
            tooltip=Lokii.GetString('Waypoints_ShowOnHud_ToolTip'),
            subtab={Lokii.GetString('Subtab_Markers')}
        })

        InterfaceOptions.AddCheckBox({
            id='Waypoints_ShowOnWorldMap',
            default=Options['Waypoints']['ShowOnWorldMap'],
            label=Lokii.GetString('Waypoints_ShowOnWorldMap_Label'),
            tooltip=Lokii.GetString('Waypoints_ShowOnWorldMap_ToolTip'),
            subtab={Lokii.GetString('Subtab_Markers')}
        })

        InterfaceOptions.AddCheckBox({
            id='Waypoints_ShowOnRadar',
            default=Options['Waypoints']['ShowOnRadar'],
            label=Lokii.GetString('Waypoints_ShowOnRadar_Label'),
            tooltip=Lokii.GetString('Waypoints_ShowOnRadar_ToolTip'),
            subtab={Lokii.GetString('Subtab_Markers')}
        })

        InterfaceOptions.AddChoiceMenu({
            id = 'Waypoints_RadarEdgeMode',
            default = Options['Waypoints']['RadarEdgeMode'],
            label = Lokii.GetString('Waypoints_RadarEdgeMode_Label'),
            tooltip = Lokii.GetString('Waypoints_RadarEdgeMode_ToolTip'),
            subtab = {Lokii.GetString('Subtab_Markers')}
        })

                InterfaceOptions.AddChoiceEntry({
                    menuId='Waypoints_RadarEdgeMode',
                    val=MapMarker.EDGE_NONE,
                    label=Lokii.GetString('Waypoints_RadarEdgeMode_none_Label'),
                    subtab={Lokii.GetString('Subtab_Markers')}
                })

                InterfaceOptions.AddChoiceEntry({
                    menuId='Waypoints_RadarEdgeMode',
                    val=MapMarker.EDGE_ARROW,
                    label=Lokii.GetString('Waypoints_RadarEdgeMode_arrow_Label'),
                    subtab={Lokii.GetString('Subtab_Markers')}
                })

                InterfaceOptions.AddChoiceEntry({
                    menuId='Waypoints_RadarEdgeMode',
                    val=MapMarker.EDGE_ICON,
                    label=Lokii.GetString('Waypoints_RadarEdgeMode_icon_Label'),
                    subtab={Lokii.GetString('Subtab_Markers')}
                })

        InterfaceOptions.AddCheckBox({
            id='Waypoints_TrailAssigned',
            default=Options['Waypoints']['TrailAssigned'],
            label=Lokii.GetString('Waypoints_TrailAssigned_Label'),
            tooltip=Lokii.GetString('Waypoints_TrailAssigned_ToolTip'),
            subtab={Lokii.GetString('Subtab_Markers')}
        })

        InterfaceOptions.AddCheckBox({
            id='Waypoints_PingAssigned',
            default=Options['Waypoints']['PingAssigned'],
            label=Lokii.GetString('Waypoints_PingAssigned_Label'),
            tooltip=Lokii.GetString('Waypoints_PingAssigned_ToolTip'),
            subtab={Lokii.GetString('Subtab_Markers')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Markers')}})


    InterfaceOptions.StartGroup({
        id='Group_Tracker',
        label=Lokii.GetString('Group_Tracker_Label'),
        subtab={Lokii.GetString('Subtab_Tracker')}
    })

        InterfaceOptions.AddMovableFrame({
            frame = TRACKER,
            label = "xSLM Tracker",
            scalable = true
        })

        InterfaceOptions.AddCheckBox({
            id='Tracker_Enabled',
            default=Options['Tracker']['Enabled'],
            label=Lokii.GetString('Tracker_Enabled_Label'),
            tooltip=Lokii.GetString('Tracker_Enabled_ToolTip'),
            subtab={Lokii.GetString('Subtab_Tracker')}
        })

        InterfaceOptions.AddCheckBox({
            id='Tracker_Display_Mode',
            default=Options['Tracker']['Display_Mode'],
            label=Lokii.GetString('Tracker_Display_Mode_Label'),
            tooltip=Lokii.GetString('Tracker_Display_Mode_ToolTip'),
            subtab={Lokii.GetString('Subtab_Tracker')}
        })

        InterfaceOptions.AddCheckBox({
            id='Tracker_Display_Mode_OnlySquadLeader',
            default=Options['Tracker']['Display_Mode_OnlySquadLeader'],
            label=Lokii.GetString('Tracker_Display_Mode_OnlySquadLeader_Label'),
            tooltip=Lokii.GetString('Tracker_Display_Mode_OnlySquadLeader_ToolTip'),
            subtab={Lokii.GetString('Subtab_Tracker')}
        })

        InterfaceOptions.AddCheckBox({
            id='Tracker_Display_Headings',
            default=Options['Tracker']['Display_Headings'],
            label=Lokii.GetString('Tracker_Display_Headings_Label'),
            tooltip=Lokii.GetString('Tracker_Display_Headings_ToolTip'),
            subtab={Lokii.GetString('Subtab_Tracker')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Tracker')}})


    InterfaceOptions.StartGroup({
        id='Group_Sounds',
        label=Lokii.GetString('Group_Sounds_Label'),
        subtab={Lokii.GetString('Subtab_Sounds')}
    })

        InterfaceOptions.AddCheckBox({
            id='Sounds_Mute',
            default=Options['Sounds']['Mute'],
            label=Lokii.GetString('Sounds_Mute_Label'),
            tooltip=Lokii.GetString('Sounds_Mute_ToolTip'),
            subtab={Lokii.GetString('Subtab_Sounds')}
        })

        UISoundOptionsMenu('Sounds_OnIdentify', Lokii.GetString('Sounds_OnIdentify_Label'), Options['Sounds']['OnIdentify'], Lokii.GetString('Subtab_Sounds'))

        --UISoundOptionsMenu('Sounds_OnIdentify_Rollable', Lokii.GetString('Sounds_OnIdentify_Rollable_Label'), Options['Sounds']['OnIdentify_Rollable'], Lokii.GetString('Subtab_Sounds'))

        UISoundOptionsMenu('Sounds_OnAssignItem_ToMe', Lokii.GetString('Sounds_OnAssignItem_ToMe_Label'), Options['Sounds']['OnAssignItem_ToMe'], Lokii.GetString('Subtab_Sounds'))

        UISoundOptionsMenu('Sounds_OnAssignItem_ToOther', Lokii.GetString('Sounds_OnAssignItem_ToOther_Label'), Options['Sounds']['OnAssignItem_ToOther'], Lokii.GetString('Subtab_Sounds'))

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Sounds')}})

end

--[[
    UISoundOptionsMenu(uid, label, default, subtab)
    Helper function for creating sound options
]]--
function UISoundOptionsMenu(uid, label, default, subtab)
    InterfaceOptions.AddChoiceMenu({
            id=uid,
            label=label,
            subtab={subtab},
            default=default,
        })

        for num, sound in ipairs(uiSounds) do
            InterfaceOptions.AddChoiceEntry({
                menuId=uid,
                label=Lokii.GetString(sound.label),
                val=sound.val,
            })
        end
end


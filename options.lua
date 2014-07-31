Options = {
    ['Core'] = {
        ['Enabled'] = true,
        ['VersionMessage'] = true,
        ['SlashHandles'] = 'xlt,lt',
    },

    ['Tracker'] = {
        ['Enabled'] = true,
        ['TrackDelay'] = 1,
        ['UpdateDelay'] = 0,
        ['RemoveDelay'] = 0,
        ['RefreshInterval'] = 2,
        ['LootUpdateInterval'] = 2,
        ['LootEventHistoryCleanupInterval'] = 2,
        ['LootEventHistoryLifetime'] = 3 * 1000,
    },

    ['Panels'] = {
        ['Enabled'] = true,

        ['Mode'] = LootPanelModes.Standard,

        ['Display'] = {
            ['AssignedTo'] = true,
            ['AssignedToHideNil'] = true,
        },

        ['Color'] = {
            ['AssignedTo'] = {
                ['Nil'] = {alpha=1, tint='FFFFFF'},
                ['Free'] = {alpha=1, tint='00FF00'},
                ['Player'] = {alpha=1, tint='00FF00'},
                ['Other'] = {alpha=1, tint='FF0000'},
            },
        },

        ['ColorMode'] = {
            ['HeaderBar'] = ColorModes.MatchItem,
            ['HeaderBarCustomValue'] = {alpha=1, tint='00000'},
            ['ItemName'] = ColorModes.Custom,
            ['ItemNameCustomValue'] = {alpha=1, tint='FFFFFF'},
        },

        ['Filtering'] = {
            [LootCategory.Equipment] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = false,
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

            },

            [LootCategory.Modules] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = false,
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },
            },

            [LootCategory.Salvage] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = false,
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },
            },

            [LootCategory.Components] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = false,
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                },
            },
            
            [LootCategory.Currency] = {
                ['Enabled'] = false,
            },

        },

    },  
 
    ['Waypoints'] = {
        ['Enabled'] = true,

        ['ShowOnHud'] = true,
        ['ShowOnWorldMap'] = true,
        ['ShowOnRadar'] = true,
        ['RadarEdgeMode'] = RadarEdgeModes.Icon,


        ['Filtering'] = {
            [LootCategory.Equipment] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = false,
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

            },

            [LootCategory.Modules] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = false,
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },
            },

            [LootCategory.Salvage] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = false,
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },
            },

            [LootCategory.Components] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = false,
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = false,
                    ['RequiredLevelThreshold'] = false,
                    ['WaypointTitle'] = "",
                },
            },
            
            [LootCategory.Currency] = {
                ['Enabled'] = false,
            },

        },


    },

    ['Messages'] = {
        ['Enabled'] = true,

        ['Channels'] = {
            ['Squad'] = true,
            ['Platoon'] = true,
            ['System'] = true,
            ['Notifications'] = true,
        },

        ['Prefix'] = '',

        ['Events'] = {

            ['Tracker'] = {

                ['OnLootNew'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'Detected a new loot drop: %i',
                        },

                        ['Platoon'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'Detected a new loot drop: %i',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Detected a new loot drop: %i',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Detected a new loot drop: %i',
                        },
                    },

                },

                ['OnLootLooted'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%l looted %i',
                        },

                        ['Platoon'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%l looted %i',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l looted %i',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l looted %i',
                        },
                    },

                },

                ['OnClaimed'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%l claimed %i',
                        },

                        ['Platoon'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%l claimed %i',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l claimed %i',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l claimed %i',
                        },
                    },

                },

                ['OnLootLost'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%i has despawned.',
                        },

                        ['Platoon'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%i has despawned.',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%i has despawned.',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%i has despawned.',
                        },
                    },

                },

            },
 
        },
    },

    ['HUDTracker'] = {
        ['Enabled'] = true,
        ['Visibility'] = HUDTrackerVisibilityOptions.HUD,
        ['Tooltip'] = {
            ['Enabled'] = true,
        },
        ['PlateMode'] = HUDTrackerPlateModeOptions.Decorated,
        ['IconMode'] = HUDTrackerIconModeOptions.Decorated,

        ['UpdateInterval'] = 1,
    },

    ['Sounds'] = {
        ['Enabled'] = true,

        ['Mute'] = false,

        ['OnIdentify'] = 'Play_UI_Beep_13',
        ['OnIdentifyRollable'] = 'Play_UI_Beep_13',
        ['OnAssignItemToMe'] = 'Play_SFX_UI_Ding',
        ['OnAssignItemToOther'] = 'Play_SFX_UI_Ticker',

    },

    ['Debug'] = {
        ['Enabled'] = true,
        ['AlwaysSquadLeader'] = true,
        ['FakeOnSquadRoster'] = true,
        ['SquadToArmy'] = true,
        ['UndefinedFilterArguments'] = true,
        ['LogLootableTargets'] = true, 
        ['LogLootableCollection'] = true,
        ['LogOptionChange'] = true,
        ['CommunicationExtra'] = true,
        ['RoundRobin'] = true,
    },
}
























--[[
    OnOptionChange(args)
        args.id  - interface option id
        args.val - interface option value
    Callback function for Interface Options, when the user has changed an option
]]--
function OnOptionChange(args)
    -- Explode Id
    local explodedId = splitExplode('_', args.id)

    -- InterfaceOptions Special Values
    if args.id == "__LOADED" then
        State.loaded = true

    elseif args.id == '__DEFAULT' then
        -- Todo: Fixme:

    elseif args.id == '__DISPLAY' then
        -- Todo: Fixme:

    -- Addon Options
    else
        -- Find and update the setting within the Options table
        digOptions(Options, args, explodedId)
    end

    -- Log Changes
    if Options['Debug']['Enabled'] and Options['Debug']['LogOptionChange'] then
        Debug.Log('OnOptionChange: '..args.id..' to '..tostring(args.val))
    end

    -- Store neccessary settings 
    if args.id == 'Debug_Enabled' then
        Component.SaveSetting('Debug_Enabled', args.val)
    elseif args.id == 'Core_VersionMessage' then
        Component.SaveSetting('Core_VersionMessage', args.val)
    end

    -- Perform extra actions
    if args.id == 'Debug_Enabled' then
        Debug.EnableLogging(args.val)
    elseif args.id == 'Debug_FakeOnSquadRoster' or args.id == 'Debug_AlwaysSquadLeader' then
        OnSquadRosterUpdate()
    end

    -- Perform extra actions when loaded
    if State.loaded then
        -- For Tracker options, update the tracker
        if explodedId[1] == 'HUDTracker' then
            HUDTracker.OnOptionChange(args.id, args.val)
        -- For Sound option changes, play the sound
        elseif explodedId[1] == 'Sounds' then
            -- Note: This could behave poorly if other sound options are added
            if type(args.val) == 'string' then
                System.PlaySound(args.val)
            end
        end
    end

    -- Update Options Visibility
    SetOptionsAvailability()
end

--[[
    digOptions(table, args, refs, depth, key)
    Tempoary function name
    Finds and updates a key within a table
--]]
function digOptions(table, args, refs, depth, key)
    if depth == nil then
        depth = 1 -- start at 1
    else
        depth = depth + 1
    end

    if type(table) == 'table' then
        for tableKey, tableValue in pairs(table) do
            -- If there's a key in this table that matches the option id at the current depth, we're on the right track
            if tableKey == refs[depth] then
                -- If the value of this key we found is not a table, then we're at the end of the digging. This should be the option we were looking for.
                if type(tableValue) ~= 'table' then
                    table[tableKey] = args.val

                -- If the value of the option we are updating is a table - and the option id we are working with ends at this depth, that's all right too.
                elseif type(args.val) == 'table' and #refs == depth then
                    if Options['Debug']['LogOptionChange'] then Debug.Log('Option with Id: '..args.id..' has its value updated as a table.') end
                    table[tableKey] = args.val

                -- Otherwise, we still have some more digging to do.
                else 
                    digOptions(tableValue, args, refs, depth, tableKey)
                end
                return
            end
        end
    end
end





--[[
    SetOptionsAvailability()
    Supposed to hide/unhide shit in the Interface Options.
]]--
function SetOptionsAvailability()


end



--[[
    Options.Setup()
    Sets up the Interface Options, including the callback to OnOptionChange and the Save Version.

]]--
function Options.Setup()
    -- Notifications
    InterfaceOptions.NotifyOnLoaded(true) -- Notify us when all options have been loaded (we don't play sounds before that)
    --InterfaceOptions.NotifyOnDefaults(true) -- Notify us when user resets the options
    --InterfaceOptions.NotifyOnDisplay(true) -- Notify us when the user opens the interface options

    -- Callback
    InterfaceOptions.SetCallbackFunc(function(id, val) OnOptionChange({id=id,val=val}) end, 'xLootTracker') -- Callback for when user changes settings

    -- Save version
    InterfaceOptions.SaveVersion(AddonInfo.save) -- Settings save-version, increment if behavior changes

    -- Frames
    InterfaceOptions.AddMovableFrame({
        frame = HUDTracker.GetFrame(),
        label = Lokii.GetString('Options_MoveableFrame_Tracker_Label'),
        scalable = true
    })


    -- Build the interface options
    BuildInterfaceOptions() -- Todo: Fixme:
end


--[[
    BuildInterfaceOptions()
    Separate everything
]]--
function BuildInterfaceOptions()

    BuildInterfaceOptions_Front()
    
    BuildInterfaceOptions_Tracker()

    BuildInterfaceOptions_Waypoints()

    --BuildInterfaceOptions_Panels()

    BuildInterfaceOptions_HUDTracker()
    BuildInterfaceOptions_Sounds()
    BuildInterfaceOptions_Messages()
end


function BuildInterfaceOptions_Front()

    -- Core
    InterfaceOptions.StartGroup({
        id    = 'Group_Core',
        label = 'Xsear\'s Loot Tracker',
    })
        
        InterfaceOptions.AddCheckBox({
            id      = 'Core_Enabled',
            label   = Lokii.GetString('Core_Enabled_Label'),
            tooltip = Lokii.GetString('Core_Enabled_Tooltip'),
            default = Options['Core']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Core_VersionMessage',
            label   = Lokii.GetString('Core_VersionMessage_Label'),
            tooltip = Lokii.GetString('Core_VersionMessage_Tooltip'),
            default = Options['Core']['VersionMessage'],
        })

        InterfaceOptions.AddTextInput({
            id      = 'Core_SlashHandles',
            label   = Lokii.GetString('Core_SlashHandles_Label'),
            tooltip = Lokii.GetString('Core_SlashHandles_Tooltip'),
            default = Options['Core']['SlashHandles'],
        })

    InterfaceOptions.StopGroup()

    -- Features
    InterfaceOptions.StartGroup({
        id    = 'Group_Features',
        label = 'Features',
    })

        InterfaceOptions.AddCheckBox({
            id      = 'Messages_Enabled',
            label   = Lokii.GetString('Messages_Enabled_Label'),
            tooltip = Lokii.GetString('Messages_Enabled_Tooltip'),
            default = Options['Messages']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Panels_Enabled',
            label   = Lokii.GetString('Panels_Enabled_Label'),
            tooltip = Lokii.GetString('Panels_Enabled_Tooltip'),
            default = Options['Panels']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Waypoints_Enabled',
            label   = Lokii.GetString('Waypoints_Enabled_Label'),
            tooltip = Lokii.GetString('Waypoints_Enabled_Tooltip'),
            default = Options['Waypoints']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'HUDTracker_Enabled',
            label   = Lokii.GetString('HUDTracker_Enabled_Label'),
            tooltip = Lokii.GetString('HUDTracker_Enabled_Tooltip'),
            default = Options['HUDTracker']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Sounds_Enabled',
            label   = Lokii.GetString('Sounds_Enabled_Label'),
            tooltip = Lokii.GetString('Sounds_Enabled_Tooltip'),
            default = Options['Sounds']['Enabled'],
        })


    InterfaceOptions.StopGroup()

    -- Debug
    InterfaceOptions.StartGroup({
        id       = 'Debug_Enabled',
        checkbox = true,
        default  = Options['Debug']['Enabled'],
        label    = Lokii.GetString('Debug_Enabled_Label'),
        tooltip  = Lokii.GetString('Debug_Enabled_Tooltip'),
    })

        InterfaceOptions.AddCheckBox({
            id      = 'Debug_SquadToArmy',
            default = Options['Debug']['SquadToArmy'],
            label   = Lokii.GetString('Debug_SquadToArmy_Label'),
            tooltip = Lokii.GetString('Debug_SquadToArmy_Tooltip'),
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Debug_UndefinedFilterArguments',
            default = Options['Debug']['UndefinedFilterArguments'],
            label   = Lokii.GetString('Debug_UndefinedFilterArguments_Label'),
            tooltip = Lokii.GetString('Debug_UndefinedFilterArguments_Tooltip'),
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Debug_LogLootableTargets',
            default = Options['Debug']['LogLootableTargets'],
            label   = Lokii.GetString('Debug_LogLootableTargets_Label'),
            tooltip = Lokii.GetString('Debug_LogLootableTargets_Tooltip'),
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Debug_LogLootableCollection',
            default = Options['Debug']['LogLootableCollection'],
            label   = Lokii.GetString('Debug_LogLootableCollection_Label'),
            tooltip = Lokii.GetString('Debug_LogLootableCollection_Tooltip'),
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Debug_LogOptionChange',
            default = Options['Debug']['LogOptionChange'],
            label   = Lokii.GetString('Debug_LogOptionChange_Label'),
            tooltip = Lokii.GetString('Debug_LogOptionChange_Tooltip'),
        })

    InterfaceOptions.StopGroup()
end

function BuildInterfaceOptions_Tracker()

    -- Track Delay
    InterfaceOptions.AddSlider({
        id      = 'Tracker_TrackDelay',
        min     = 0.0,
        max     = 5.0,
        inc     = 0.5,
        suffix  = 's',
        default = Options['Tracker']['TrackDelay'],
        label   = Lokii.GetString('Tracker_TrackDelay_Label'),
        tooltip = Lokii.GetString('Tracker_TrackDelay_Tooltip'),
        subtab  = {
            Lokii.GetString('Subtab_Tracker')
        },
    })

    -- Update Delay
    InterfaceOptions.AddSlider({
        id      = 'Tracker_UpdateDelay',
        min     = 0.0,
        max     = 5.0,
        inc     = 0.5,
        suffix  = 's',
        default = Options['Tracker']['UpdateDelay'],
        label   = Lokii.GetString('Tracker_UpdateDelay_Label'),
        tooltip = Lokii.GetString('Tracker_UpdateDelay_Tooltip'),
        subtab  = {
            Lokii.GetString('Subtab_Tracker')
        },
    })

    -- Remove Delay
    InterfaceOptions.AddSlider({
        id      = 'Tracker_RemoveDelay',
        min     = 0.0,
        max     = 5.0,
        inc     = 0.5,
        suffix  = 's',
        default = Options['Tracker']['RemoveDelay'],
        label   = Lokii.GetString('Tracker_RemoveDelay_Label'),
        tooltip = Lokii.GetString('Tracker_RemoveDelay_Tooltip'),
        subtab  = {
            Lokii.GetString('Subtab_Tracker')
        },
    })

    -- Refresh Interval
    InterfaceOptions.AddSlider({
        id      = 'Tracker_RefreshInterval',
        min     = 0.5,
        max     = 5.0,
        inc     = 0.5,
        suffix  = 's',
        default = Options['Tracker']['RefreshInterval'],
        label   = Lokii.GetString('Tracker_RefreshInterval_Label'),
        tooltip = Lokii.GetString('Tracker_RefreshInterval_Tooltip'),
        subtab  = {
            Lokii.GetString('Subtab_Tracker')
        },
    })

    -- Loot Update Interval
    InterfaceOptions.AddSlider({
        id      = 'Tracker_LootUpdateInterval',
        min     = 0.5,
        max     = 120,
        inc     = 0.5,
        suffix  = 's',
        default = Options['Tracker']['LootUpdateInterval'],
        label   = Lokii.GetString('Tracker_LootUpdateInterval_Label'),
        tooltip = Lokii.GetString('Tracker_LootUpdateInterval_Tooltip'),
        subtab  = {
            Lokii.GetString('Subtab_Tracker')
        },
    })

    -- LootEvent History Cleanup Interval
    InterfaceOptions.AddSlider({
        id      = 'Tracker_LootEventHistoryCleanupInterval',
        min     = 0.5,
        max     = 120,
        inc     = 0.5,
        suffix  = 's',
        default = Options['Tracker']['LootEventHistoryCleanupInterval'],
        label   = Lokii.GetString('Tracker_LootEventHistoryCleanupInterval_Label'),
        tooltip = Lokii.GetString('Tracker_LootEventHistoryCleanupInterval_Tooltip'),
        subtab  = {
            Lokii.GetString('Subtab_Tracker')
        },
    })

    -- LootEvent History Lifetime
    InterfaceOptions.AddTextInput({
        id      = 'Tracker_LootEventHistoryLifetime',
        numeric = true,
        default = Options['Tracker']['LootEventHistoryLifetime'],
        label   = Lokii.GetString('Tracker_LootEventHistoryLifetime_Label'),
        tooltip = Lokii.GetString('Tracker_LootEventHistoryLifetime_Tooltip'),
        subtab  = subtab
    })
end

function BuildInterfaceOptions_Panels()
    -- Filters
    --UIHELPER_DetectDistributeMarkX('Panels', 'EquipmentItems')
    --UIHELPER_DetectDistributeMarkX('Panels', 'CraftingComponents')
    --UIHELPER_DetectDistributeMarkX('Panels', 'SalvageModules')
    

    -- Display Assigned To
    InterfaceOptions.AddCheckBox({
        id      = 'Panels_Display_AssignedTo',
        default = Options['Panels']['Display']['AssignedTo'],
        label   = Lokii.GetString('Panels_Display_AssignedTo_Label'),
        tooltip = Lokii.GetString('Panels_Display_AssignedTo_Tooltip'),
        subtab  = {
            Lokii.GetString('Subtab_Panels')
        },
    })

    -- Display Assigned To Hide Nil
    InterfaceOptions.AddCheckBox({
        id      = 'Panels_Display_AssignedToHideNil',
        default = Options['Panels']['Display']['AssignedToHideNil'],
        label   = Lokii.GetString('Panels_Display_AssignedToHideNil_Label'),
        tooltip = Lokii.GetString('Panels_Display_AssignedToHideNil_Tooltip'),
        subtab  = {
            Lokii.GetString('Subtab_Panels')
        },
    })

    -- Color Mode Headerbar
    UIHELPER_DropdownFromTable('Panels_ColorMode_HeaderBar', 'Panels_ColorMode_HeaderBar', Options['Panels']['ColorMode']['HeaderBar'], ColorModes, 'ColorModes', Lokii.GetString('Subtab_Panels'))
    
    -- Custom Color Headerbar
    InterfaceOptions.AddColorPicker({
        id      = 'Panels_ColorMode_HeaderBarCustomValue',
        default = Options['Panels']['ColorMode']['HeaderBarCustomValue'],
        label   = Lokii.GetString('Panels_ColorMode_HeaderBarCustomValue_Label'),
        tooltip = Lokii.GetString('Panels_ColorMode_HeaderBarCustomValue_Tooltip'),
        subtab  = Lokii.GetString('Subtab_Panels'),
    })

    -- Color Mode ItemName
    UIHELPER_DropdownFromTable('Panels_ColorMode_ItemName', 'Panels_ColorMode_ItemName', Options['Panels']['ColorMode']['ItemName'], ColorModes, 'ColorModes', Lokii.GetString('Subtab_Panels'))

    -- Custom Color Item Name
    InterfaceOptions.AddColorPicker({
        id      = 'Panels_ColorMode_ItemNameCustomValue',
        default = Options['Panels']['ColorMode']['ItemNameCustomValue'],
        label   = Lokii.GetString('Panels_ColorMode_ItemNameCustomValue_Label'),
        tooltip = Lokii.GetString('Panels_ColorMode_ItemNameCustomValue_Tooltip'),
        subtab  = Lokii.GetString('Subtab_Panels'),
    })

    -- Custom Colors Assigned To 
    InterfaceOptions.AddColorPicker({
        id      = 'Panels_Color_AssignedTo_Nil',
        default = Options['Panels']['Color']['AssignedTo']['Nil'],
        label   = Lokii.GetString('Panels_Color_AssignedTo_Nil_Label'),
        tooltip = Lokii.GetString('Panels_Color_AssignedTo_Nil_Tooltip'),
        subtab  = Lokii.GetString('Subtab_Panels'),
    })

    InterfaceOptions.AddColorPicker({
        id      = 'Panels_Color_AssignedTo_Free',
        default = Options['Panels']['Color']['AssignedTo']['Free'],
        label   = Lokii.GetString('Panels_Color_AssignedTo_Free_Label'),
        tooltip = Lokii.GetString('Panels_Color_AssignedTo_Free_Tooltip'),
        subtab  = Lokii.GetString('Subtab_Panels'),
    })

    InterfaceOptions.AddColorPicker({
        id      = 'Panels_Color_AssignedTo_Player',
        default = Options['Panels']['Color']['AssignedTo']['Player'],
        label   = Lokii.GetString('Panels_Color_AssignedTo_Player_Label'),
        tooltip = Lokii.GetString('Panels_Color_AssignedTo_Player_Tooltip'),
        subtab  = Lokii.GetString('Subtab_Panels'),
    })

    InterfaceOptions.AddColorPicker({
        id      = 'Panels_Color_AssignedTo_Other',
        default = Options['Panels']['Color']['AssignedTo']['Other'],
        label   = Lokii.GetString('Panels_Color_AssignedTo_Other_Label'),
        tooltip = Lokii.GetString('Panels_Color_AssignedTo_Other_Tooltip'),
        subtab  = Lokii.GetString('Subtab_Panels'),
    })
end


function BuildInterfaceOptions_Waypoints()
    --UIHELPER_DetectDistributeMarkX('Waypoints', 'EquipmentItems')
    --UIHELPER_DetectDistributeMarkX('Waypoints', 'CraftingComponents')
    --UIHELPER_DetectDistributeMarkX('Waypoints', 'SalvageModules')

    InterfaceOptions.AddCheckBox({
        id      = 'Waypoints_ShowOnHud',
        default = Options['Waypoints']['ShowOnHud'],
        label   = Lokii.GetString('Waypoints_ShowOnHud_Label'),
        tooltip = Lokii.GetString('Waypoints_ShowOnHud_Tooltip'),
        subtab  = {Lokii.GetString('Subtab_Waypoints')}
    })

    InterfaceOptions.AddCheckBox({
        id      = 'Waypoints_ShowOnWorldMap',
        default = Options['Waypoints']['ShowOnWorldMap'],
        label   = Lokii.GetString('Waypoints_ShowOnWorldMap_Label'),
        tooltip = Lokii.GetString('Waypoints_ShowOnWorldMap_Tooltip'),
        subtab  = {Lokii.GetString('Subtab_Waypoints')}
    })

    InterfaceOptions.AddCheckBox({
        id      = 'Waypoints_ShowOnRadar',
        default = Options['Waypoints']['ShowOnRadar'],
        label   = Lokii.GetString('Waypoints_ShowOnRadar_Label'),
        tooltip = Lokii.GetString('Waypoints_ShowOnRadar_Tooltip'),
        subtab  = {Lokii.GetString('Subtab_Waypoints')}
    })

    UIHELPER_DropdownFromTable('Waypoints_RadarEdgeMode', 'Waypoints_RadarEdgeMode', Options['Waypoints']['RadarEdgeMode'], RadarEdgeModes, 'RadarEdgeModes', Lokii.GetString('Subtab_Waypoints'))

    InterfaceOptions.AddCheckBox({
        id      = 'Waypoints_TrailAssigned',
        default = Options['Waypoints']['TrailAssigned'],
        label   = Lokii.GetString('Waypoints_TrailAssigned_Label'),
        tooltip = Lokii.GetString('Waypoints_TrailAssigned_Tooltip'),
        subtab  = {Lokii.GetString('Subtab_Waypoints')}
    })

    InterfaceOptions.AddCheckBox({
        id      = 'Waypoints_PingAssigned',
        default = Options['Waypoints']['PingAssigned'],
        label   = Lokii.GetString('Waypoints_PingAssigned_Label'),
        tooltip = Lokii.GetString('Waypoints_PingAssigned_Tooltip'),
        subtab  = {Lokii.GetString('Subtab_Waypoints')}
    })

end


function BuildInterfaceOptions_Messages()
    -- Prefix
    InterfaceOptions.AddTextInput({
        id      = 'Messages_Prefix',
        default = Options['Messages']['Prefix'],
        label   = Lokii.GetString('Messages_Prefix_Label'),
        tooltip = Lokii.GetString('Messages_Prefix_Tooltip'),
        subtab  = {Lokii.GetString('Subtab_Messages')}
    })

    -- Channels
    InterfaceOptions.AddCheckBox({
        id      = 'Messages_Channels_Squad',
        default = Options['Messages']['Channels']['Squad'],
        label   = Lokii.GetString('Messages_Channels_Squad_Label'),
        tooltip = Lokii.GetString('Messages_Channels_Squad_Tooltip'),
        subtab  = {Lokii.GetString('Subtab_Messages')}
    })

    InterfaceOptions.AddCheckBox({
        id      = 'Messages_Channels_System',
        default = Options['Messages']['Channels']['System'],
        label   = Lokii.GetString('Messages_Channels_System_Label'),
        tooltip = Lokii.GetString('Messages_Channels_System_Tooltip'),
        subtab  = {Lokii.GetString('Subtab_Messages')}
    })

    InterfaceOptions.AddCheckBox({
        id      = 'Messages_Channels_Notifications',
        default = Options['Messages']['Channels']['Notifications'],
        label   = Lokii.GetString('Messages_Channels_Notifications_Label'),
        tooltip = Lokii.GetString('Messages_Channels_Notifications_Tooltip'),
        subtab  = {Lokii.GetString('Subtab_Messages')}
    })

    -- Event settings
    for tableKey, tableValue in pairs(Options['Messages']['Events']) do
        for eventKey, eventValue in pairs(Options['Messages']['Events'][tableKey]) do
            UIHELPER_MessageEventOptions('Messages', tableKey..'_'..eventKey, Options['Messages']['Events'][tableKey][eventKey], {Lokii.GetString('Subtab_Messages'), Lokii.GetString('Subtab_Messages_'..tableKey)})
        end
    end
end

function BuildInterfaceOptions_HUDTracker()
    -- Visibility
    UIHELPER_DropdownFromTable('HUDTracker_Visibility', 'HUDTracker_Visibility', Options['HUDTracker']['Visibility'], HUDTrackerVisibilityOptions, 'HUDTrackerVisibility',  Lokii.GetString('Subtab_HUDTracker'))

    -- Tooltips
    InterfaceOptions.AddCheckBox({
        id      = 'HUDTracker_Tooltip_Enabled',
        default = Options['HUDTracker']['Tooltip']['Enabled'],
        label   = Lokii.GetString('HUDTracker_Tooltip_Enabled_Label'),
        tooltip = Lokii.GetString('HUDTracker_Tooltip_Enabled_Tooltip'),
        subtab  = {Lokii.GetString('Subtab_HUDTracker')}
    })

    -- PlateMode
    UIHELPER_DropdownFromTable('HUDTracker_PlateMode', 'HUDTracker_PlateMode', Options['HUDTracker']['PlateMode'], HUDTrackerPlateModeOptions, 'HUDTrackerPlateModeOptions',  Lokii.GetString('Subtab_HUDTracker'))

    -- IconMode
    UIHELPER_DropdownFromTable('HUDTracker_IconMode', 'HUDTracker_IconMode', Options['HUDTracker']['IconMode'], HUDTrackerIconModeOptions, 'HUDTrackerIconModeOptions',  Lokii.GetString('Subtab_HUDTracker'))

    -- Filters
    --UIHELPER_DetectDistributeMarkX('HUDTracker', 'EquipmentItems')
    --UIHELPER_DetectDistributeMarkX('HUDTracker', 'CraftingComponents')
    --UIHELPER_DetectDistributeMarkX('HUDTracker', 'SalvageModules')
end

function BuildInterfaceOptions_Sounds()
    UIHELPER_SoundOptionsMenu('Sounds_OnIdentify', Lokii.GetString('Sounds_OnIdentify_Label'), Options['Sounds']['OnIdentify'], Lokii.GetString('Subtab_Sounds'))

    --UIHELPER_SoundOptionsMenu('Sounds_OnIdentifyRollable', Lokii.GetString('Sounds_OnIdentifyRollable_Label'), Options['Sounds']['OnIdentifyRollable'], Lokii.GetString('Subtab_Sounds'))

    UIHELPER_SoundOptionsMenu('Sounds_OnAssignItemToMe', Lokii.GetString('Sounds_OnAssignItemToMe_Label'), Options['Sounds']['OnAssignItemToMe'], Lokii.GetString('Subtab_Sounds'))

    UIHELPER_SoundOptionsMenu('Sounds_OnAssignItemToOther', Lokii.GetString('Sounds_OnAssignItemToOther_Label'), Options['Sounds']['OnAssignItemToOther'], Lokii.GetString('Subtab_Sounds'))
end


function UIHELPER_DetectDistributeMarkX(rootKey, x)

    -- Checkbox Group X
    --[[
    -- Maybe one day we'll have nested groups...
    InterfaceOptions.StartGroup({
        id       = rootKey..'_'..x..'_Enabled',
        checkbox = true,
        default  = Options[rootKey][x]['Enabled'],
        label    = Lokii.GetString(rootKey..'_'..x..'_Enabled_Label'),
        tooltip  = Lokii.GetString(rootKey..'_'..x..'_Enabled_Tooltip'),
        subtab   = {
            Lokii.GetString('Subtab_'..rootKey)
        },
    })
    ]]--
        -- rootKey x Enabled
        InterfaceOptions.AddCheckBox({
            id      = rootKey..'_'..x..'_Enabled',
            default = Options[rootKey][x]['Enabled'],
            label   = Lokii.GetString('Filter_Generic_'..x..'_Enabled_Label'),
            tooltip = Lokii.GetString('Filter_Generic_'..x..'_Enabled_Tooltip'),
            subtab  = {Lokii.GetString('Subtab_'..rootKey), Lokii.GetString('Subtab_Filtering')}
        })

        -- Mode dropdown
        UIHELPER_DropdownFromTable(rootKey..'_'..x..'_Mode', 'Filter_Generic_'..x..'_Mode', Options[rootKey][x]['Mode'], TriggerModeOptions, 'Mode', {Lokii.GetString('Subtab_'..rootKey), Lokii.GetString('Subtab_Filtering')})

        -- Simple mode options
        UIHELPER_StageX(rootKey, x, 'Simple', {Lokii.GetString('Subtab_'..rootKey), Lokii.GetString('Subtab_Filtering')})

        -- Advanced mode options
        UIHELPER_StageX(rootKey, x, 'Unstaged', {Lokii.GetString('Subtab_'..rootKey), Lokii.GetString('Subtab_Filtering')})
        UIHELPER_StageX(rootKey, x, 'Stage1', {Lokii.GetString('Subtab_'..rootKey), Lokii.GetString('Subtab_Filtering')})
        UIHELPER_StageX(rootKey, x, 'Stage2', {Lokii.GetString('Subtab_'..rootKey), Lokii.GetString('Subtab_Filtering')})
        UIHELPER_StageX(rootKey, x, 'Stage3', {Lokii.GetString('Subtab_'..rootKey), Lokii.GetString('Subtab_Filtering')})
        UIHELPER_StageX(rootKey, x, 'Stage4', {Lokii.GetString('Subtab_'..rootKey), Lokii.GetString('Subtab_Filtering')})

    --[[
    InterfaceOptions.StopGroup({
        subtab = {
            Lokii.GetString('Subtab_'..rootKey)
        },
    })
    ]]--
end

function UIHELPER_StageX(rootKey, x, stage, subtab)
    -- Vars
    local checkbox = (stage ~= 'Simple')
    local tierdropdown = (stage == 'Simple')

    -- rootKey x stage Enabled group
    InterfaceOptions.StartGroup({
        id       = rootKey..'_'..x..'_'..stage..'_Enabled',
        checkbox = checkbox,
        default  = Options[rootKey][x]['Enabled'],
        label    = Lokii.GetString('Filter_Generic_'..x..'_'..stage..'_Enabled_Label'),
        tooltip  = Lokii.GetString('Filter_Generic_'..x..'_'..stage..'_Enabled_Tooltip'),
        subtab   = subtab
    })

        -- Distribution extras
        if rootKey == 'Distribution' then
            UIHELPER_DropdownFromTable(rootKey..'_'..x..'_'..stage..'_LootMode', 'Filter_Generic_LootMode', Options[rootKey][x][stage]['LootMode'], DistributionMode, 'LootMode', subtab)
            UIHELPER_DropdownFromTable(rootKey..'_'..x..'_'..stage..'_Weighting', 'Filter_Generic_Weighting', Options[rootKey][x][stage]['Weighting'], WeightingOptions, 'Weighting', subtab)
        end

        -- Tier and Quality threshold dropdowns
        if tierdropdown then
        UIHELPER_DropdownFromTable(rootKey..'_'..x..'_'..stage..'_TierThreshold', 'Filter_Generic_TierThreshold', Options[rootKey][x][stage]['TierThreshold'], TierOptions, 'TierThreshold', subtab)
        end
        UIHELPER_DropdownFromTable(rootKey..'_'..x..'_'..stage..'_QualityThreshold', 'Filter_Generic_QualityThreshold', Options[rootKey][x][stage]['QualityThreshold'], QualityOptions, 'QualityThreshold', subtab)

        -- Custom Quality input
        InterfaceOptions.AddTextInput({
            id      = rootKey..'_'..x..'_'..stage..'_QualityThresholdCustomValue',
            numeric = true,
            label   = Lokii.GetString('Filter_Generic_QualityThresholdCustomValue_Label'),
            tooltip = Lokii.GetString('Filter_Generic_QualityThresholdCustomValue_Tooltip'),
            default = Options[rootKey][x][stage]['QualityThresholdCustomValue'],
            subtab  = subtab
        })

    InterfaceOptions.StopGroup({
        subtab = subtab
    })
end

--[[
    UIHELPER_DropdownFromTable(id, key, default, table, optionKey, subtab)
    id        - The Option id for the Choice Menu
    key       - Used to get label and tooltip for the Choice Menu via Lokii
    default   - The default value
    table     - The table of options
    optionKey - Used to get label and tooltip for the Choice Entries via Lokii
    subtab    - the subtab

--]]
function UIHELPER_DropdownFromTable(id, key, default, table, optionKey, subtab)
    InterfaceOptions.AddChoiceMenu({
        id      = id,
        default = default,
        label   = Lokii.GetString(key..'_Label'),
        tooltip = Lokii.GetString(key..'_Tooltip'),
        subtab  = subtab,
    })

        for tableKey, tableValue in pairs(table) do
            InterfaceOptions.AddChoiceEntry({
                menuId  = id,
                val     = tableValue,
                label   = Lokii.GetString(optionKey..'_Choice_'..tableKey..'_Label'),
                tooltip = Lokii.GetString(optionKey..'_Choice_'..tableKey..'_Tooltip'),
                subtab  = subtab,
            })
            --Debug.Log(Lokii.GetString(optionKey..'_Choice_'..tableKey..'_Label'))
            --Debug.Log(Lokii.GetString(optionKey..'_Choice_'..tableKey..'_Tooltip'))
        end
end


--[[
    UIHELPER_SoundOptionsMenu(uid, label, default, subtab)
    Helper function for creating sound options
]]--
function UIHELPER_SoundOptionsMenu(uid, label, default, subtab)
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


function UIHELPER_MessageEventOptions(rootKey, eventKey, defaults, subtab)
    -- Checkbox Group
    InterfaceOptions.StartGroup({
        id       = rootKey..'_Events_'..eventKey..'_Enabled',
        checkbox = true,
        default  = defaults['Enabled'],
        label    = Lokii.GetString(rootKey..'_Events_'..eventKey..'_Enabled_Label'),
        tooltip  = Lokii.GetString(rootKey..'_Events_'..eventKey..'_Enabled_Tooltip'),
        subtab   = subtab,
    })

        -- Squad
        InterfaceOptions.AddCheckBox({
            id      = rootKey..'_Events_'..eventKey..'_Channels_Squad_Enabled',
            default = defaults['Channels']['Squad']['Enabled'],
            label   = Lokii.GetString('Messages_Generic_Channels_Squad_Enabled_Label'),
            tooltip = Lokii.GetString('Messages_Generic_Channels_Squad_Enabled_Tooltip'),
            subtab  = subtab,
        })

        InterfaceOptions.AddTextInput({
            id      = rootKey..'_Events_'..eventKey..'_Channels_Squad_Format',
            default = defaults['Channels']['Squad']['Format'],
            label   = Lokii.GetString('Messages_Generic_Channels_Squad_Format_Label'),
            tooltip = Lokii.GetString('Messages_Generic_Channels_Squad_Format_Tooltip'),
            subtab  = subtab,
        })

        -- System
        InterfaceOptions.AddCheckBox({
            id      = rootKey..'_Events_'..eventKey..'_Channels_System_Enabled',
            default = defaults['Channels']['System']['Enabled'],
            label   = Lokii.GetString('Messages_Generic_Channels_System_Enabled_Label'),
            tooltip = Lokii.GetString('Messages_Generic_Channels_System_Enabled_Tooltip'),
            subtab  = subtab,
        })

        InterfaceOptions.AddTextInput({
            id      = rootKey..'_Events_'..eventKey..'_Channels_System_Format',
            default = defaults['Channels']['System']['Format'],
            label   = Lokii.GetString('Messages_Generic_Channels_System_Format_Label'),
            tooltip = Lokii.GetString('Messages_Generic_Channels_System_Format_Tooltip'),
            subtab  = subtab,
        })

        -- Notifications
        InterfaceOptions.AddCheckBox({
            id      = rootKey..'_Events_'..eventKey..'_Channels_Notifications_Enabled',
            default = defaults['Channels']['Notifications']['Enabled'],
            label   = Lokii.GetString('Messages_Generic_Channels_Notifications_Enabled_Label'),
            tooltip = Lokii.GetString('Messages_Generic_Channels_Notifications_Enabled_Tooltip'),
            subtab  = subtab,
        })

        InterfaceOptions.AddTextInput({
            id      = rootKey..'_Events_'..eventKey..'_Channels_Notifications_Format',
            default = defaults['Channels']['Notifications']['Format'],
            label   = Lokii.GetString('Messages_Generic_Channels_Notifications_Format_Label'),
            tooltip = Lokii.GetString('Messages_Generic_Channels_Notifications_Format_Tooltip'),
            subtab  = subtab,
        })

    InterfaceOptions.StopGroup({
            subtab = subtab,
        })


end
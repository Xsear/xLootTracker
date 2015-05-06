Options = {
    ['Core'] = {
        ['Enabled'] = true,
        ['VersionMessage'] = true,
        ['SlashHandles'] = 'xlt,lt',
    },

    ['Tracker'] = {
        ['Enabled'] = true,
        ['TrackDelay'] = 0.5,
        ['UpdateDelay'] = 0,
        ['RemoveDelay'] = 0.5,
        ['RefreshInterval'] = 10,
        ['LootUpdateInterval'] = 2,
        ['LootEventHistoryCleanupInterval'] = 2,
        ['LootEventHistoryLifetime'] = 3 * 1000,
        ['Limit'] = 100,
        ['IgnoreCrystite'] = true,
        ['IgnoreMetalsTornado'] = true,
        ['UpdateMode'] = TrackerUpdateMode.Global,
    },

    ['Blacklist'] = {
        ['Tracker'] = {},
        ['Panels'] = {},
        ['Sounds'] = {},
        ['HUDTracker'] = {},
        ['Messages'] = {},
        ['Waypoints'] = {},
    },

    ['Panels'] = {
        ['Enabled'] = false,

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

        ['TimerMode'] = PanelsTimerMode.Countdown,
        ['TimerCountdownTime'] = 120,

    },  
 
    ['Waypoints'] = {
        ['Enabled'] = true,

        ['ShowOnHud'] = true,
        ['ShowOnWorldMap'] = true,
        ['ShowOnRadar'] = true,
        ['RadarEdgeMode'] = RadarEdgeModes.Icon,

        ['IconGlow'] = true,

    },

    ['Messages'] = {
        ['Enabled'] = false,

        ['Channels'] = {
            ['Squad'] = false,
            ['Platoon'] = false,
            ['System'] = false,
            ['Notifications'] = true,
        },

        ['OnlyWhenSquadLeader'] = true,
        ['OnlyWhenPlatoonLeader'] = true,

        ['Prefix'] = '',

        ['Events'] = {

            ['Tracker'] = {

                ['OnLootNew'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'New loot drop: {itemAsLink}',
                        },

                        ['Platoon'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'New loot drop: {itemAsLink}',
                        },

                        ['System'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'New loot drop: {itemAsLink}',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'New loot drop: {itemAsLink}',
                        },
                    },

                },

                ['OnLootLooted'] = {
                    ['Enabled'] = true,

                    ['IgnoreOthers'] = false,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '{lootedTo} looted {itemAsLink}',
                        },

                        ['Platoon'] = {
                            ['Enabled'] = true,
                            ['Format'] = '{lootedTo} looted {itemAsLink}',
                        },

                        ['System'] = {
                            ['Enabled'] = true,
                            ['Format'] = '{lootedTo} looted {itemAsLink}',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = true,
                            ['Format'] = '{lootedTo} looted {itemAsLink}',
                        },
                    },

                },

                ['OnLootLost'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '{itemAsLink} has despawned',
                        },

                        ['Platoon'] = {
                            ['Enabled'] = true,
                            ['Format'] = '{itemAsLink} has despawned',
                        },

                        ['System'] = {
                            ['Enabled'] = true,
                            ['Format'] = '{itemAsLink} has despawned',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = true,
                            ['Format'] = '{itemAsLink} has despawned',
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

        ['EntrySize'] = 32,
        ['EntryFontType'] = OptionsFontTypes.UbuntuMedium,
        ['EntryFontSize'] = 10,

        ['ForceWebIcons'] = false,

        ['Frame'] = {
            ['Width'] = 450,
            ['Height'] = 150,
        },

        ['ContextMenu'] = {
            ['Enabled'] = true,
        },
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
        ['Enabled'] = false,
        ['SquadToArmy'] = false,
        ['LogLootableTargets'] = false, 
        ['LogLootableCollection'] = false,
        ['LogLootCreateData'] = false,
        ['LogOptionChange'] = false,
        ['LogLootDetermineCategory'] = false,
        ['LogTrackerLight'] = true,
    },

}







for i, eventKey in ipairs({'OnLootNew', 'OnLootLooted', 'OnLootLost'}) do

    Options['Messages']['Events']['Tracker'][eventKey]['Filtering'] = {}

    local filteringTable = Options['Messages']['Events']['Tracker'][eventKey]['Filtering']

    for categoryId, categoryKey in pairs(FilterableLootCategories) do

        filteringTable[categoryKey] = {}
        local categoryTable = filteringTable[categoryKey]

        categoryTable['Enabled'] = true
        categoryTable['Mode'] = TriggerModeOptions.Simple


        local formatDefault = ''
        if eventKey == 'OnLootNew' then
            formatDefault = 'New loot drop: {itemAsLink}'
        elseif eventKey == 'OnLootLooted' then
            formatDefault = '{lootedTo} looted {itemAsLink}'
        elseif eventKey == 'OnLootLost' then
            formatDefault = '{itemAsLink} has despawned'
        end

        local rarityTableTemplate = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,

            ['Channels'] = {
                ['Squad'] = {
                    ['Enabled'] = false,
                    ['Format'] = formatDefault,
                },

                ['Platoon'] = {
                    ['Enabled'] = true,
                    ['Format'] = formatDefault,
                },

                ['System'] = {
                    ['Enabled'] = false,
                    ['Format'] = formatDefault,
                },

                ['Notifications'] = {
                    ['Enabled'] = true,
                    ['Format'] = formatDefault,
                },
            },
        }

        if eventKey == 'OnLootLooted' then
            rarityTableTemplate['IgnoreOthers'] = false
        end


        -- Trigger Group: Simple Mode
        categoryTable['Simple'] = _table.copy(rarityTableTemplate)
        categoryTable['Simple']['RarityThreshold'] = LootRarity.Salvage

        -- Trigger Groups: Advanced Mode (Rarity Trigger Groups)   
        for rarityKey, rarityValue  in pairs(LootRarity) do

            -- Create
            categoryTable[rarityValue] = _table.copy(rarityTableTemplate)

        end


    end


end
--Debug.Table('MessagesEventPost', Options['Messages']['Events'])







--_table.copy


-- Create filtering template
-- Todo: maybe one day...
--[[
local filteringTemplate = {}
for categoryKey, categoryValue in pairs(FilterableLootCategories) do
    filteringTemplate['Enabled'] = true,
    filteringTemplate['Mode'] = TriggerModeOptions.Simple,

    filteringTemplate['Simple'] = {
        ['RarityThreshold'] = LootRarity.Salvage,
        ['ItemLevelThreshold'] = 0,
        ['RequiredLevelThreshold'] = 0,
    },

    local rarityFilterTemplate = {
        ['ItemLevelThreshold'] = 0,
        ['RequiredLevelThreshold'] = 0,
    }

    for rarityKey, rarityValue  in pairs(LootRarity) do
        filteringTemplate[rarityKey] = {

        }
    end

end
--]]




Options['Waypoints']['Filtering'] = {
            [LootCategory.Equipment] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['Enabled'] = true,
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },

                [LootRarity.Salvage] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },

                [LootRarity.Common] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },

                [LootRarity.Uncommon] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },

                [LootRarity.Rare] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },

                [LootRarity.Epic] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },

                [LootRarity.Prototype] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },

                [LootRarity.Legendary] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },

            },

            [LootCategory.Consumable] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['Enabled'] = true,
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Salvage] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Common] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Uncommon] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Rare] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Epic] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Prototype] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Legendary] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

            },

            [LootCategory.Modules] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['Enabled'] = true,
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },

                [LootRarity.Salvage] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },

                [LootRarity.Common] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },

                [LootRarity.Uncommon] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },

                [LootRarity.Rare] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },

                [LootRarity.Epic] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },

                [LootRarity.Prototype] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },

                [LootRarity.Legendary] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '[{itemReqLevel}] {itemName}',
                },
            },

            [LootCategory.Salvage] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['Enabled'] = true,
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Salvage] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Common] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Uncommon] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Rare] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Epic] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Prototype] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Legendary] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },
            },

            [LootCategory.Metals] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['Enabled'] = true,
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Salvage] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Common] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Uncommon] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Rare] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Epic] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Prototype] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Legendary] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

            },

            [LootCategory.Components] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['Enabled'] = true,
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Salvage] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Common] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Uncommon] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Rare] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Epic] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Prototype] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Legendary] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },
            },
            
            [LootCategory.Currency] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['Enabled'] = true,
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Salvage] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Common] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Uncommon] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Rare] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Epic] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Prototype] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

                [LootRarity.Legendary] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = '{itemName}',
                },

            },

        }




Options['HUDTracker']['Filtering'] = {
    [LootCategory.Equipment] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['Enabled'] = true,
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Salvage] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Common] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Uncommon] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Rare] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Epic] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Prototype] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Legendary] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

    },

    [LootCategory.Consumable] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['Enabled'] = true,
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Salvage] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Common] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Uncommon] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Rare] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Epic] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Prototype] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Legendary] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

    },

    [LootCategory.Modules] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['Enabled'] = true,
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Salvage] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Common] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Uncommon] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Rare] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Epic] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Prototype] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Legendary] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },
    },

    [LootCategory.Salvage] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['Enabled'] = true,
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Salvage] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Common] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Uncommon] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Rare] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Epic] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Prototype] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Legendary] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },
    },

    [LootCategory.Metals] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['Enabled'] = true,
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Salvage] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Common] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Uncommon] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Rare] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Epic] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Prototype] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Legendary] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

    },

    [LootCategory.Components] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['Enabled'] = true,
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Salvage] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Common] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Uncommon] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Rare] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Epic] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Prototype] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Legendary] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },
    },
    
    [LootCategory.Currency] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['Enabled'] = true,
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Salvage] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Common] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Uncommon] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Rare] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Epic] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Prototype] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

        [LootRarity.Legendary] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = '{itemName}',
        },

    },
}




Options['Sounds']['Filtering'] = {
    [LootCategory.Equipment] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['Enabled'] = true,
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Salvage] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Common] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Uncommon] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Rare] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Epic] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Prototype] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Legendary] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

    },

    [LootCategory.Consumable] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['Enabled'] = true,
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Salvage] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Common] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Uncommon] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Rare] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Epic] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Prototype] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Legendary] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

    },

    [LootCategory.Modules] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['Enabled'] = true,
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Salvage] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Common] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Uncommon] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Rare] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Epic] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Prototype] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Legendary] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },
    },

    [LootCategory.Salvage] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['Enabled'] = true,
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Salvage] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Common] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Uncommon] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Rare] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Epic] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Prototype] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Legendary] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },
    },

    [LootCategory.Metals] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['Enabled'] = true,
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Salvage] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Common] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Uncommon] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Rare] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Epic] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Prototype] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Legendary] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

    },

    [LootCategory.Components] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['Enabled'] = true,
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Salvage] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Common] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Uncommon] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Rare] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Epic] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Prototype] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Legendary] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },
    },
    
    [LootCategory.Currency] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['Enabled'] = true,
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Salvage] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Common] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Uncommon] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Rare] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Epic] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Prototype] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Legendary] = {
            ['Enabled'] = true,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

    },
}


Options['Panels']['Filtering'] = {
            [LootCategory.Equipment] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['Enabled'] = true,
                    ['RarityThreshold'] = LootRarity.Uncommon,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Salvage] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Common] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Uncommon] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Rare] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Epic] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Prototype] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Legendary] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

            },

            [LootCategory.Consumable] = {
                ['Enabled'] = false,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['Enabled'] = true,
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Salvage] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Common] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Uncommon] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Rare] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Epic] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Prototype] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Legendary] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

            },

            [LootCategory.Modules] = {
                ['Enabled'] = false,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['Enabled'] = true,
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Salvage] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Common] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Uncommon] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Rare] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Epic] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Prototype] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Legendary] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },
            },

            [LootCategory.Salvage] = {
                ['Enabled'] = false,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['Enabled'] = true,
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Salvage] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Common] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Uncommon] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Rare] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Epic] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Prototype] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Legendary] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },
            },

            [LootCategory.Metals] = {
                ['Enabled'] = false,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['Enabled'] = true,
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Salvage] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Common] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Uncommon] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Rare] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Epic] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Prototype] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Legendary] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

            },

            [LootCategory.Components] = {
                ['Enabled'] = false,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['Enabled'] = true,
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Salvage] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Common] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Uncommon] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Rare] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Epic] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Prototype] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Legendary] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },
            },
            
            [LootCategory.Currency] = {
                ['Enabled'] = false,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['Enabled'] = true,
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Salvage] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Common] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Uncommon] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Rare] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Epic] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Prototype] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Legendary] = {
                    ['Enabled'] = true,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

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
    if args.id == '__LOADED' then
        State.loaded = true
        SetOptionsAvailability()
        OnOptionsLoaded()
        return

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
    elseif args.id == 'Core_SlashHandles' then
        Component.SaveSetting('Core_SlashHandles', args.val)
    end

    -- Perform extra actions
    if args.id == 'Debug_Enabled' then
        Debug.EnableLogging(args.val)
    elseif args.id == 'Debug_FakeOnSquadRoster' or args.id == 'Debug_AlwaysSquadLeader' then
        OnSquadRosterUpdate()
    end

    -- Perform extra actions when loaded
    if State.loaded then
        -- For HUDTracker options, update the tracker
        if explodedId[1] == 'HUDTracker' then
            HUDTracker.OnOptionChange(args.id, args.val)

        -- For Tracker options
        elseif explodedId[1] == 'Tracker' then
            Tracker.OnOptionChange(args.id, args.val)

        -- For Waypoints options
        elseif explodedId[1] == 'Waypoints' then
            WaypointManager.OnOptionChange(args.id, args.val) 

        -- For Panels options
        elseif explodedId[1] == 'Panels' then
            LootPanelManager.OnOptionChange(args.id, args.val) 

        -- For Sound option changes, play the sound
        elseif explodedId[1] == 'Sounds' then
            -- Note: This could behave poorly if other sound options are added
            if type(args.val) == 'string' then
                System.PlaySound(args.val)
            end
        end

        -- Update Options Visibility
        SetOptionsAvailability({id=args.id, val=args.val, explodedId=explodedId})
    end

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
function SetOptionsAvailability(args)


    -- Tracker Update Mode
    local updateModeToggler = (Options['Tracker']['UpdateMode'] == TrackerUpdateMode.Global)
    InterfaceOptions.EnableOption('Tracker_RefreshInterval', updateModeToggler)
    InterfaceOptions.DisableOption('Tracker_LootUpdateInterval', updateModeToggler)

    -- Panels Timer Mode
    local timerModeToggler = (Options['Panels']['TimerMode'] == PanelsTimerMode.Countdown)
    InterfaceOptions.EnableOption('Panels_TimerCountdownTime', timerModeToggler)


    -- Summary: If simple disable advanced options
    for i, moduleArg in pairs({'HUDTracker', 'Panels', 'Waypoints', 'Sounds', {parent='Messages', 'OnLootNew', 'OnLootLooted', 'OnLootLost'}}) do

        -- If we didn't receive args, we have to go through all modules. But if we did recieve args, we only update the module that changed!
        local function hasPart(targetPart, parts)
            for i, part in ipairs(parts) do
                if part == targetPart then
                    return true 
                end 
            end
            return false
        end
        local function hasEventArg(moduleArg, explodedId)
            for i, part in ipairs(moduleArg) do
                if hasPart(part, explodedId) then
                    return part
                end
            end
            return false
        end
        if not args 
           or  ( 
                (
                   (type(moduleArg) ~= 'table' and args.explodedId[1] == moduleArg)
                or (type(moduleArg) == 'table' and moduleArg.parent and args.explodedId[1] == moduleArg.parent and hasEventArg(moduleArg, args.explodedId))
                )
                and
                (hasPart('Filtering', args.explodedId))
            )
        then

            local modules = {}
            local moduleParent = nil
            if type(moduleArg) == 'table' then
                if moduleArg.parent == 'Messages' then
                    moduleParent = moduleArg.parent
                    for i, eventKey in ipairs(moduleArg) do
                        if not args or eventKey == hasEventArg(moduleArg, args.explodedId) then
                            local moduleKey = moduleArg.parent..'_Events_Tracker_'..eventKey
                            local moduleRef = Options[moduleArg.parent]['Events']['Tracker'][eventKey]['Filtering']
                            modules[moduleKey] = moduleRef
                        end
                    end
                end
            else
                local moduleKey = moduleArg
                local moduleRef = Options[moduleArg]['Filtering']
                modules[moduleKey] = moduleRef
            end


            -- Generate
            for moduleKey, moduleRef in pairs(modules) do
             
                for id, categoryKey in pairs(FilterableLootCategories) do


                    -- Mode selection only available when type enabled
                    InterfaceOptions.EnableOption(moduleKey..'_Filtering_'..categoryKey..'_Mode', moduleRef[categoryKey]['Enabled'])

                    -- Don't wanna hardcode this shit
                    local rarityKeys = _table.copy(OptionsLootRarityDropdown)
                    rarityKeys[#rarityKeys + 1] = 'Simple'

                    -- For each rarity (and simple)
                    for i, rarityKey in ipairs(rarityKeys) do
                        --Debug.Log(moduleKey..'_'..categoryKey)

                        -- Disable/Enable logic
                        -- Fixme: bluuuuuurgh
                        local disable = false

                        -- If type not enabled, disable everything
                        if moduleRef[categoryKey]['Enabled'] == false then
                            disable = true 

                        -- If type is enabled, disable stuff not relevant to current mode
                        else
                            -- Tired Xsear reading this got confused, so he expanded the comments. Stick with me here.
                            -- We want to disable all the other groups if we're in simple mode, and only the simple group otherwise.

                            -- So. If we are currently in Simple Mode, disable = true.
                            disable = (moduleRef[categoryKey]['Mode'] == TriggerModeOptions.Simple)

                            -- But in order to keep Simple enabled, if the current rarityKey is Simple, disable = false (but I decided to be fancy and just invert it)
                            if rarityKey == 'Simple' then disable = not disable end
                        end

                        -- Do our job
                        for optionKey, optionValue in pairs(moduleRef[categoryKey][rarityKey]) do


                            -- major hardcode for message channels specific options
                            if optionKey == 'Channels' then 

                                for channelKey, channelOptions in pairs(optionValue) do
                                    for key, val in pairs(channelOptions) do
                                        InterfaceOptions.DisableOption(moduleKey..'_Filtering_'..categoryKey..'_'..rarityKey..'_'..optionKey..'_'..channelKey..'_'..key, disable)
                                    end
                                end

                            else
                                InterfaceOptions.DisableOption(moduleKey..'_Filtering_'..categoryKey..'_'..rarityKey..'_'..optionKey, disable)
                            end
                        end

          
                    end

                end

            end
        end


    end


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
    BuildInterfaceOptions()

    --
    Options.SetupFilteringUI()
end


--[[
    BuildInterfaceOptions()
    Separate everything
]]--
function BuildInterfaceOptions()
    BuildInterfaceOptions_Front()
    BuildInterfaceOptions_Tracker()
    BuildInterfaceOptions_Waypoints()
    BuildInterfaceOptions_Panels()
    BuildInterfaceOptions_HUDTracker()
    BuildInterfaceOptions_Sounds()
    BuildInterfaceOptions_Messages()
end


function BuildInterfaceOptions_Front()

    -- Core
    InterfaceOptions.StartGroup({
        id    = 'Group_Core',
        label = Lokii.GetString('Options_Group_Core_Label'),
    })
        
        InterfaceOptions.AddCheckBox({
            id      = 'Core_Enabled',
            label   = Lokii.GetString('Options_Core_Enabled_Label'),
            tooltip = Lokii.GetString('Options_Core_Enabled_Tooltip'),
            default = Options['Core']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Core_VersionMessage',
            label   = Lokii.GetString('Options_Core_VersionMessage_Label'),
            tooltip = Lokii.GetString('Options_Core_VersionMessage_Tooltip'),
            default = Options['Core']['VersionMessage'],
        })

        InterfaceOptions.AddTextInput({
            id      = 'Core_SlashHandles',
            label   = Lokii.GetString('Options_Core_SlashHandles_Label'),
            tooltip = Lokii.GetString('Options_Core_SlashHandles_Tooltip'),
            default = Options['Core']['SlashHandles'],
        })

    InterfaceOptions.StopGroup()

    -- Features
    InterfaceOptions.StartGroup({
        id    = 'Group_Features',
        label = Lokii.GetString('Options_Group_Features_Label'),
    })

        InterfaceOptions.AddCheckBox({
            id      = 'Messages_Enabled',
            label   = Lokii.GetString('Options_Messages_Enabled_Label'),
            tooltip = Lokii.GetString('Options_Messages_Enabled_Tooltip'),
            default = Options['Messages']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Panels_Enabled',
            label   = Lokii.GetString('Options_Panels_Enabled_Label'),
            tooltip = Lokii.GetString('Options_Panels_Enabled_Tooltip'),
            default = Options['Panels']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Waypoints_Enabled',
            label   = Lokii.GetString('Options_Waypoints_Enabled_Label'),
            tooltip = Lokii.GetString('Options_Waypoints_Enabled_Tooltip'),
            default = Options['Waypoints']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'HUDTracker_Enabled',
            label   = Lokii.GetString('Options_HUDTracker_Enabled_Label'),
            tooltip = Lokii.GetString('Options_HUDTracker_Enabled_Tooltip'),
            default = Options['HUDTracker']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Sounds_Enabled',
            label   = Lokii.GetString('Options_Sounds_Enabled_Label'),
            tooltip = Lokii.GetString('Options_Sounds_Enabled_Tooltip'),
            default = Options['Sounds']['Enabled'],
        })


    InterfaceOptions.StopGroup()

    -- Debug
    InterfaceOptions.StartGroup({
        id       = 'Debug_Enabled',
        checkbox = true,
        default  = Options['Debug']['Enabled'],
        label    = Lokii.GetString('Options_Debug_Enabled_Label'),
        tooltip  = Lokii.GetString('Options_Debug_Enabled_Tooltip'),
    })

        InterfaceOptions.AddCheckBox({
            id      = 'Debug_SquadToArmy',
            default = Options['Debug']['SquadToArmy'],
            label   = Lokii.GetString('Options_Debug_SquadToArmy_Label'),
            tooltip = Lokii.GetString('Options_Debug_SquadToArmy_Tooltip'),
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Debug_LogLootableTargets',
            default = Options['Debug']['LogLootableTargets'],
            label   = Lokii.GetString('Options_Debug_LogLootableTargets_Label'),
            tooltip = Lokii.GetString('Options_Debug_LogLootableTargets_Tooltip'),
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Debug_LogLootableCollection',
            default = Options['Debug']['LogLootableCollection'],
            label   = Lokii.GetString('Options_Debug_LogLootableCollection_Label'),
            tooltip = Lokii.GetString('Options_Debug_LogLootableCollection_Tooltip'),
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Debug_LogLootCreateData',
            default = Options['Debug']['LogLootCreateData'],
            label   = Lokii.GetString('Options_Debug_LogLootCreateData_Label'),
            tooltip = Lokii.GetString('Options_Debug_LogLootCreateData_Tooltip'),
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Debug_LogOptionChange',
            default = Options['Debug']['LogOptionChange'],
            label   = Lokii.GetString('Options_Debug_LogOptionChange_Label'),
            tooltip = Lokii.GetString('Options_Debug_LogOptionChange_Tooltip'),
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Debug_LogLootDetermineCategory',
            default = Options['Debug']['LogLootDetermineCategory'],
            label   = Lokii.GetString('Options_Debug_LogLootDetermineCategory_Label'),
            tooltip = Lokii.GetString('Options_Debug_LogLootDetermineCategory_Tooltip'),
        })

    InterfaceOptions.StopGroup()
end

function BuildInterfaceOptions_Tracker()
    -- Update Mode
    UIHELPER_DropdownFromTable('Tracker_UpdateMode', 'Options_Tracker_UpdateMode', Options['Tracker']['UpdateMode'], OptionsTrackerUpdateModeDropdown, 'TrackerUpdateMode', Lokii.GetString('Options_Subtab_Tracker'))

    -- Track Delay
    InterfaceOptions.AddSlider({
        id      = 'Tracker_TrackDelay',
        min     = 0.0,
        max     = 5.0,
        inc     = 0.5,
        suffix  = 's',
        default = Options['Tracker']['TrackDelay'],
        label   = Lokii.GetString('Options_Tracker_TrackDelay_Label'),
        tooltip = Lokii.GetString('Options_Tracker_TrackDelay_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_Tracker')
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
        label   = Lokii.GetString('Options_Tracker_UpdateDelay_Label'),
        tooltip = Lokii.GetString('Options_Tracker_UpdateDelay_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_Tracker')
        },
    })

    -- Remove Delay
    InterfaceOptions.AddSlider({
        id      = 'Tracker_RemoveDelay',
        min     = 0.5, -- Neccessary for Looted events to work atm
        max     = 5.0,
        inc     = 0.5,
        suffix  = 's',
        default = Options['Tracker']['RemoveDelay'],
        label   = Lokii.GetString('Options_Tracker_RemoveDelay_Label'),
        tooltip = Lokii.GetString('Options_Tracker_RemoveDelay_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_Tracker')
        },
    })

    -- Tracker Limit
    InterfaceOptions.AddTextInput({
        id      = 'Tracker_Limit',
        numeric = true,
        default = Options['Tracker']['Limit'],
        label   = Lokii.GetString('Options_Tracker_Limit_Label'),
        tooltip = Lokii.GetString('Options_Tracker_Limit_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_Tracker')
        },
    })

    -- Refresh Interval
    InterfaceOptions.AddSlider({
        id      = 'Tracker_RefreshInterval',
        min     = 0.5,
        max     = 120.0,
        inc     = 0.5,
        suffix  = 's',
        default = Options['Tracker']['RefreshInterval'],
        label   = Lokii.GetString('Options_Tracker_RefreshInterval_Label'),
        tooltip = Lokii.GetString('Options_Tracker_RefreshInterval_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_Tracker')
        },
    })

    -- Loot Update Interval
    InterfaceOptions.AddSlider({
        id      = 'Tracker_LootUpdateInterval',
        min     = 0.5,
        max     = 120.0,
        inc     = 0.5,
        suffix  = 's',
        default = Options['Tracker']['LootUpdateInterval'],
        label   = Lokii.GetString('Options_Tracker_LootUpdateInterval_Label'),
        tooltip = Lokii.GetString('Options_Tracker_LootUpdateInterval_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_Tracker')
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
        label   = Lokii.GetString('Options_Tracker_LootEventHistoryCleanupInterval_Label'),
        tooltip = Lokii.GetString('Options_Tracker_LootEventHistoryCleanupInterval_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_Tracker')
        },
    })

    -- LootEvent History Lifetime
    InterfaceOptions.AddTextInput({
        id      = 'Tracker_LootEventHistoryLifetime',
        numeric = true,
        default = Options['Tracker']['LootEventHistoryLifetime'],
        label   = Lokii.GetString('Options_Tracker_LootEventHistoryLifetime_Label'),
        tooltip = Lokii.GetString('Options_Tracker_LootEventHistoryLifetime_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_Tracker')
        },
    })

    -- Ignore Crystite
    InterfaceOptions.AddCheckBox({
        id      = 'Tracker_IgnoreCrystite',
        default = Options['Tracker']['IgnoreCrystite'],
        label   = Lokii.GetString('Options_Tracker_IgnoreCrystite_Label'),
        tooltip = Lokii.GetString('Options_Tracker_IgnoreCrystite_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_Tracker')
        },
    })

    -- Ignore Metals in Tornado
    InterfaceOptions.AddCheckBox({
        id      = 'Tracker_IgnoreMetalsTornado',
        default = Options['Tracker']['IgnoreMetalsTornado'],
        label   = Lokii.GetString('Options_Tracker_IgnoreMetalsTornado_Label'),
        tooltip = Lokii.GetString('Options_Tracker_IgnoreMetalsTornado_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_Tracker')
        },
    })
end

function BuildInterfaceOptions_Panels()
    --[[
    -- Display Assigned To
    InterfaceOptions.AddCheckBox({
        id      = 'Panels_Display_AssignedTo',
        default = Options['Panels']['Display']['AssignedTo'],
        label   = Lokii.GetString('Options_Panels_Display_AssignedTo_Label'),
        tooltip = Lokii.GetString('Options_Panels_Display_AssignedTo_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_Panels')
        },
    })

    -- Display Assigned To Hide Nil
    InterfaceOptions.AddCheckBox({
        id      = 'Panels_Display_AssignedToHideNil',
        default = Options['Panels']['Display']['AssignedToHideNil'],
        label   = Lokii.GetString('Options_Panels_Display_AssignedToHideNil_Label'),
        tooltip = Lokii.GetString('Options_Panels_Display_AssignedToHideNil_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_Panels')
        },
    })
    --]]
    

    -- Color Mode Headerbar
    UIHELPER_DropdownFromTable('Panels_ColorMode_HeaderBar', 'Panels_ColorMode_HeaderBar', Options['Panels']['ColorMode']['HeaderBar'], OptionsColorModesDropdown, 'ColorModes', Lokii.GetString('Options_Subtab_Panels'))
    
    -- Custom Color Headerbar
    InterfaceOptions.AddColorPicker({
        id      = 'Panels_ColorMode_HeaderBarCustomValue',
        default = Options['Panels']['ColorMode']['HeaderBarCustomValue'],
        label   = Lokii.GetString('Options_Panels_ColorMode_HeaderBarCustomValue_Label'),
        tooltip = Lokii.GetString('Options_Panels_ColorMode_HeaderBarCustomValue_Tooltip'),
        subtab  = Lokii.GetString('Options_Subtab_Panels'),
    })

    -- Color Mode ItemName
    UIHELPER_DropdownFromTable('Panels_ColorMode_ItemName', 'Panels_ColorMode_ItemName', Options['Panels']['ColorMode']['ItemName'], OptionsColorModesDropdown, 'ColorModes', Lokii.GetString('Options_Subtab_Panels'))

    -- Custom Color Item Name
    InterfaceOptions.AddColorPicker({
        id      = 'Panels_ColorMode_ItemNameCustomValue',
        default = Options['Panels']['ColorMode']['ItemNameCustomValue'],
        label   = Lokii.GetString('Options_Panels_ColorMode_ItemNameCustomValue_Label'),
        tooltip = Lokii.GetString('Options_Panels_ColorMode_ItemNameCustomValue_Tooltip'),
        subtab  = Lokii.GetString('Options_Subtab_Panels'),
    })

    --[[
    -- Custom Colors Assigned To 
    InterfaceOptions.AddColorPicker({
        id      = 'Panels_Color_AssignedTo_Nil',
        default = Options['Panels']['Color']['AssignedTo']['Nil'],
        label   = Lokii.GetString('Options_Panels_Color_AssignedTo_Nil_Label'),
        tooltip = Lokii.GetString('Options_Panels_Color_AssignedTo_Nil_Tooltip'),
        subtab  = Lokii.GetString('Options_Subtab_Panels'),
    })

    InterfaceOptions.AddColorPicker({
        id      = 'Panels_Color_AssignedTo_Free',
        default = Options['Panels']['Color']['AssignedTo']['Free'],
        label   = Lokii.GetString('Options_Panels_Color_AssignedTo_Free_Label'),
        tooltip = Lokii.GetString('Options_Panels_Color_AssignedTo_Free_Tooltip'),
        subtab  = Lokii.GetString('Options_Subtab_Panels'),
    })

    InterfaceOptions.AddColorPicker({
        id      = 'Panels_Color_AssignedTo_Player',
        default = Options['Panels']['Color']['AssignedTo']['Player'],
        label   = Lokii.GetString('Options_Panels_Color_AssignedTo_Player_Label'),
        tooltip = Lokii.GetString('Options_Panels_Color_AssignedTo_Player_Tooltip'),
        subtab  = Lokii.GetString('Options_Subtab_Panels'),
    })

    InterfaceOptions.AddColorPicker({
        id      = 'Panels_Color_AssignedTo_Other',
        default = Options['Panels']['Color']['AssignedTo']['Other'],
        label   = Lokii.GetString('Options_Panels_Color_AssignedTo_Other_Label'),
        tooltip = Lokii.GetString('Options_Panels_Color_AssignedTo_Other_Tooltip'),
        subtab  = Lokii.GetString('Options_Subtab_Panels'),
    })
    --]]


    UIHELPER_DropdownFromTable('Panels_TimerMode', 'Options_Panels_TimerMode', Options['Panels']['TimerMode'], OptionsPanelsTimerModeDropdown, 'PanelsTimerMode', Lokii.GetString('Options_Subtab_Panels'))
    
     InterfaceOptions.AddSlider({
        id      = 'Panels_TimerCountdownTime',
        min     = 1,
        max     = 600,
        inc     = 1,
        suffix  = 's',
        default = Options['Panels']['TimerCountdownTime'],
        label   = Lokii.GetString('Options_Panels_TimerCountdownTime_Label'),
        tooltip = Lokii.GetString('Options_Panels_TimerCountdownTime_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_Panels')
        },
    })    



    UIHELPER_Filtering('Panels')
end


function BuildInterfaceOptions_Waypoints()
    InterfaceOptions.AddCheckBox({
        id      = 'Waypoints_ShowOnHud',
        default = Options['Waypoints']['ShowOnHud'],
        label   = Lokii.GetString('Options_Waypoints_ShowOnHud_Label'),
        tooltip = Lokii.GetString('Options_Waypoints_ShowOnHud_Tooltip'),
        subtab  = {Lokii.GetString('Options_Subtab_Waypoints')}
    })

    InterfaceOptions.AddCheckBox({
        id      = 'Waypoints_ShowOnWorldMap',
        default = Options['Waypoints']['ShowOnWorldMap'],
        label   = Lokii.GetString('Options_Waypoints_ShowOnWorldMap_Label'),
        tooltip = Lokii.GetString('Options_Waypoints_ShowOnWorldMap_Tooltip'),
        subtab  = {Lokii.GetString('Options_Subtab_Waypoints')}
    })

    InterfaceOptions.AddCheckBox({
        id      = 'Waypoints_ShowOnRadar',
        default = Options['Waypoints']['ShowOnRadar'],
        label   = Lokii.GetString('Options_Waypoints_ShowOnRadar_Label'),
        tooltip = Lokii.GetString('Options_Waypoints_ShowOnRadar_Tooltip'),
        subtab  = {Lokii.GetString('Options_Subtab_Waypoints')}
    })

    UIHELPER_DropdownFromTable('Waypoints_RadarEdgeMode', 'Options_Waypoints_RadarEdgeMode', Options['Waypoints']['RadarEdgeMode'], OptionsRadarEdgeModesDropdown, 'RadarEdgeModes', Lokii.GetString('Options_Subtab_Waypoints'))

    InterfaceOptions.AddCheckBox({
        id      = 'Waypoints_IconGlow',
        default = Options['Waypoints']['IconGlow'],
        label   = Lokii.GetString('Options_Waypoints_IconGlow_Label'),
        tooltip = Lokii.GetString('Options_Waypoints_IconGlow_Tooltip'),
        subtab  = {Lokii.GetString('Options_Subtab_Waypoints')}
    })

    UIHELPER_Filtering('Waypoints')
end


function BuildInterfaceOptions_Messages()
    -- Prefix
    InterfaceOptions.AddTextInput({
        id      = 'Messages_Prefix',
        default = Options['Messages']['Prefix'],
        label   = Lokii.GetString('Options_Messages_Prefix_Label'),
        tooltip = Lokii.GetString('Options_Messages_Prefix_Tooltip'),
        subtab  = {Lokii.GetString('Options_Subtab_Messages')}
    })

    -- Channels
    InterfaceOptions.AddCheckBox({
        id      = 'Messages_Channels_Squad',
        default = Options['Messages']['Channels']['Squad'],
        label   = Lokii.GetString('Options_Messages_Channels_Squad_Label'),
        tooltip = Lokii.GetString('Options_Messages_Channels_Squad_Tooltip'),
        subtab  = {Lokii.GetString('Options_Subtab_Messages')}
    })

    InterfaceOptions.AddCheckBox({
        id      = 'Messages_Channels_Platoon',
        default = Options['Messages']['Channels']['Platoon'],
        label   = Lokii.GetString('Options_Messages_Channels_Platoon_Label'),
        tooltip = Lokii.GetString('Options_Messages_Channels_Platoon_Tooltip'),
        subtab  = {Lokii.GetString('Options_Subtab_Messages')}
    })

    InterfaceOptions.AddCheckBox({
        id      = 'Messages_Channels_System',
        default = Options['Messages']['Channels']['System'],
        label   = Lokii.GetString('Options_Messages_Channels_System_Label'),
        tooltip = Lokii.GetString('Options_Messages_Channels_System_Tooltip'),
        subtab  = {Lokii.GetString('Options_Subtab_Messages')}
    })

    InterfaceOptions.AddCheckBox({
        id      = 'Messages_Channels_Notifications',
        default = Options['Messages']['Channels']['Notifications'],
        label   = Lokii.GetString('Options_Messages_Channels_Notifications_Label'),
        tooltip = Lokii.GetString('Options_Messages_Channels_Notifications_Tooltip'),
        subtab  = {Lokii.GetString('Options_Subtab_Messages')}
    })

    -- Only Squad when Squad Leader
    InterfaceOptions.AddCheckBox({
        id      = 'Messages_OnlyWhenSquadLeader',
        default = Options['Messages']['OnlyWhenSquadLeader'],
        label   = Lokii.GetString('Options_Messages_OnlyWhenSquadLeader_Label'),
        tooltip = Lokii.GetString('Options_Messages_OnlyWhenSquadLeader_Tooltip'),
        subtab  = {Lokii.GetString('Options_Subtab_Messages')}
    })

    -- Only Platoon when Platoon Leader
    InterfaceOptions.AddCheckBox({
        id      = 'Messages_OnlyWhenPlatoonLeader',
        default = Options['Messages']['OnlyWhenPlatoonLeader'],
        label   = Lokii.GetString('Options_Messages_OnlyWhenPlatoonLeader_Label'),
        tooltip = Lokii.GetString('Options_Messages_OnlyWhenPlatoonLeader_Tooltip'),
        subtab  = {Lokii.GetString('Options_Subtab_Messages')}
    })

    -- Event settings
    local filteringArgs = {parent='Messages'}
    for eventKey, eventValue in pairs(Options['Messages']['Events']['Tracker']) do
        table.insert(filteringArgs, eventKey)
    end
    UIHELPER_Filtering(filteringArgs)
end

function BuildInterfaceOptions_HUDTracker()
    -- HUDTracker frame
    InterfaceOptions.AddTextInput({
        id      = 'HUDTracker_Frame_Width',
        numeric = true,
        label   = Lokii.GetString('Options_HUDTracker_Frame_Width_Label'),
        tooltip = Lokii.GetString('Options_HUDTracker_Frame_Width_Tooltip'),
        default = Options['HUDTracker']['Frame']['Width'],
        subtab  = {Lokii.GetString('Options_Subtab_HUDTracker')}
    })

    InterfaceOptions.AddTextInput({
        id      = 'HUDTracker_Frame_Height',
        numeric = true,
        label   = Lokii.GetString('Options_HUDTracker_Frame_Height_Label'),
        tooltip = Lokii.GetString('Options_HUDTracker_Frame_Height_Tooltip'),
        default = Options['HUDTracker']['Frame']['Height'],
        subtab  = {Lokii.GetString('Options_Subtab_HUDTracker')}
    })

    -- Visibility
    UIHELPER_DropdownFromTable('HUDTracker_Visibility', 'Options_HUDTracker_Visibility', Options['HUDTracker']['Visibility'], OptionsHUDTrackerVisibilityDropdown, 'HUDTrackerVisibility',  Lokii.GetString('Options_Subtab_HUDTracker'))

    -- Tooltips
    InterfaceOptions.AddCheckBox({
        id      = 'HUDTracker_Tooltip_Enabled',
        default = Options['HUDTracker']['Tooltip']['Enabled'],
        label   = Lokii.GetString('Options_HUDTracker_Tooltip_Enabled_Label'),
        tooltip = Lokii.GetString('Options_HUDTracker_Tooltip_Enabled_Tooltip'),
        subtab  = {Lokii.GetString('Options_Subtab_HUDTracker')}
    })

    -- PlateMode
    UIHELPER_DropdownFromTable('HUDTracker_PlateMode', 'Options_HUDTracker_PlateMode', Options['HUDTracker']['PlateMode'], OptionsHUDTrackerPlateModeDropdown, 'HUDTrackerPlateModeOptions',  Lokii.GetString('Options_Subtab_HUDTracker'))

    -- IconMode
    UIHELPER_DropdownFromTable('HUDTracker_IconMode', 'Options_HUDTracker_IconMode', Options['HUDTracker']['IconMode'], OptionsHUDTrackerIconModeDropdown, 'HUDTrackerIconModeOptions',  Lokii.GetString('Options_Subtab_HUDTracker'))

    -- Entry Size
    InterfaceOptions.AddSlider({
        id      = 'HUDTracker_EntrySize',
        min     = 24,
        max     = 64,
        inc     = 8,
        suffix  = 'px',
        default = Options['HUDTracker']['EntrySize'],
        label   = Lokii.GetString('Options_HUDTracker_EntrySize_Label'),
        tooltip = Lokii.GetString('Options_HUDTracker_EntrySize_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_HUDTracker')
        },
    })

    -- Font Type
    UIHELPER_DropdownFromTable('HUDTracker_EntryFontType', 'Options_HUDTracker_EntryFontType', Options['HUDTracker']['EntryFontType'], OptionsFontTypeDropdown, 'OptionsFontTypes',  Lokii.GetString('Options_Subtab_HUDTracker'))

    -- Font Size
    InterfaceOptions.AddSlider({
        id      = 'HUDTracker_EntryFontSize',
        min     = 8,
        max     = 24,
        inc     = 1,
        suffix  = 'px',
        default = Options['HUDTracker']['EntryFontSize'],
        label   = Lokii.GetString('Options_HUDTracker_EntryFontSize_Label'),
        tooltip = Lokii.GetString('Options_HUDTracker_EntryFontSize_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_HUDTracker')
        },
    })

    -- Force Web Icons
    InterfaceOptions.AddCheckBox({
        id      = 'HUDTracker_ForceWebIcons',
        default = Options['HUDTracker']['ForceWebIcons'],
        label   = Lokii.GetString('Options_HUDTracker_ForceWebIcons_Label'),
        tooltip = Lokii.GetString('Options_HUDTracker_ForceWebIcons_Tooltip'),
        subtab  = {Lokii.GetString('Options_Subtab_HUDTracker')}
    })

    UIHELPER_Filtering('HUDTracker')
end

function BuildInterfaceOptions_Sounds()
    UIHELPER_Filtering('Sounds')
end


function UIHELPER_Filtering(moduleArg)

    -- Determine modules
    local modules = {}
    local moduleParent = nil
    if type(moduleArg) == 'table' then
        if moduleArg.parent == 'Messages' then
            moduleParent = moduleArg.parent
            for i, eventKey in ipairs(moduleArg) do
                local moduleKey = moduleArg.parent..'_Events_Tracker_'..eventKey
                local moduleRef = Options[moduleArg.parent]['Events']['Tracker'][eventKey]['Filtering']
                modules[moduleKey] = moduleRef
            end
        end
    else
        local moduleKey = moduleArg
        local moduleRef = Options[moduleArg]['Filtering']
        modules[moduleKey] = moduleRef
    end

    --Debug.Table('filtering modules', modules)

    -- Generate
    for moduleKey, moduleRef in pairs(modules) do
        for id, category in pairs(FilterableLootCategories) do
            UIHELPER_FilterCategory(moduleKey, moduleRef, category, moduleParent)
        end
    end
end

function UIHELPER_FilterCategory(moduleKey, moduleRef, category, moduleParent)
    --Debug.Log('UIHELPER_FilterCategory', tostring(moduleKey), tostring(category))

    local subtab = {}
    if moduleParent then
        table.insert(subtab, Lokii.GetString('Options_Subtab_'..moduleParent))
    end

    table.insert(subtab, Lokii.GetString('Options_Subtab_'..moduleKey))

    table.insert(subtab, Lokii.GetString('Options_Subtab_Filtering'))

    -- moduleKey category Enabled
    InterfaceOptions.AddCheckBox({
        id      = moduleKey..'_Filtering_'..category..'_Enabled',
        default = moduleRef[category]['Enabled'],
        label   = Lokii.GetString('Options_Filtering_'..category..'_Enabled_Label'),
        tooltip = Lokii.GetString('Options_Filtering_'..category..'_Enabled_Tooltip'),
        subtab  = subtab
    })



    subtab = _table.copy(subtab) -- end Filtering tab
    table.insert(subtab, Lokii.GetString('Options_Subtab_'..category))

    -- Mode dropdown
    UIHELPER_DropdownFromTable(moduleKey..'_Filtering_'..category..'_Mode', 'Options_Filtering_Mode', moduleRef[category]['Mode'], OptionsTriggerModeDropdown, 'Mode', subtab)

    -- Simple mode options
    UIHELPER_FilterRarity(moduleKey, moduleRef, category, 'Simple', subtab)

    -- Advanced mode options
    subtab = _table.copy(subtab) -- end Category tab
    table.insert(subtab, Lokii.GetString('Options_Subtab_Advanced'))
    for id, rarity in pairs(LootRarity) do
        UIHELPER_FilterRarity(moduleKey, moduleRef, category, rarity, subtab)
    end
end

function UIHELPER_FilterRarity(moduleKey, moduleRef, category, rarity, subtab)
    -- Vars
    local checkbox = (rarity ~= 'Simple')
    local raritydropdown = (rarity == 'Simple')

    if false and checkbox then
        subtab = _table.copy(subtab)
        table.insert(subtab, Lokii.GetString('Options_Subtab_Advanced'))
    end


    -- moduleKey category rarity Enabled group
    InterfaceOptions.StartGroup({
        id       = moduleKey..'_Filtering_'..category..'_'..rarity..'_Enabled',
        checkbox = checkbox,
        default  = moduleRef[category]['Enabled'],
        label    = Lokii.GetString('Options_Filtering_'..rarity..'_Enabled_Label'),
        tooltip  = Lokii.GetString('Options_Filtering_'..rarity..'_Enabled_Tooltip'),
        subtab   = subtab
    })

        -- Rarity Threshold
        if raritydropdown then
        UIHELPER_DropdownFromTable(moduleKey..'_Filtering_'..category..'_'..rarity..'_RarityThreshold', 'Options_Filtering_RarityThreshold', moduleRef[category][rarity]['RarityThreshold'], OptionsLootRarityDropdown, 'RarityThreshold', subtab)
        end


        InterfaceOptions.AddSlider({
            id      = moduleKey..'_Filtering_'..category..'_'..rarity..'_ItemLevelThreshold',
            min     = 0.0,
            max     = 100.0,
            inc     = 1.0,
            label   = Lokii.GetString('Options_Filtering_ItemLevelThreshold_Label'),
            tooltip = Lokii.GetString('Options_Filtering_ItemLevelThreshold_Tooltip'),
            default = moduleRef[category][rarity]['ItemLevelThreshold'],
            subtab  = subtab
        })


        InterfaceOptions.AddSlider({
            id      = moduleKey..'_Filtering_'..category..'_'..rarity..'_RequiredLevelThreshold',
            min     = 0.0,
            max     = 100.0,
            inc     = 1.0,
            label   = Lokii.GetString('Options_Filtering_RequiredLevelThreshold_Label'),
            tooltip = Lokii.GetString('Options_Filtering_RequiredLevelThreshold_Tooltip'),
            default = moduleRef[category][rarity]['RequiredLevelThreshold'],
            subtab  = subtab
        })



        -- Waypoints
        if moduleKey == 'Waypoints' then
            InterfaceOptions.AddTextInput({
                id      = moduleKey..'_Filtering_'..category..'_'..rarity..'_WaypointTitle',
                label   = Lokii.GetString('Options_Filtering_WaypointTitle_Label'),
                tooltip = Lokii.GetString('Options_Filtering_WaypointTitle_Tooltip'),
                default = moduleRef[category][rarity]['WaypointTitle'],
                subtab  = subtab
            })

        -- HUDTracker
        elseif moduleKey == 'HUDTracker' then
            InterfaceOptions.AddTextInput({
                id      = moduleKey..'_Filtering_'..category..'_'..rarity..'_HUDTrackerTitle',
                label   = Lokii.GetString('Options_Filtering_HUDTrackerTitle_Label'),
                tooltip = Lokii.GetString('Options_Filtering_HUDTrackerTitle_Tooltip'),
                default = moduleRef[category][rarity]['HUDTrackerTitle'],
                subtab  = subtab
            })

        -- Sounds
        elseif moduleKey == 'Sounds' then

            UIHELPER_SoundOptionsMenu(moduleKey..'_Filtering_'..category..'_'..rarity..'_SoundsNewLoot', Lokii.GetString('Options_Filtering_SoundsNewLoot_Label'), moduleRef[category][rarity]['SoundsNewLoot'], subtab)

        -- Messages
        elseif moduleKey == 'Messages_Events_Tracker_OnLootNew' or moduleKey == 'Messages_Events_Tracker_OnLootLooted' or moduleKey == 'Messages_Events_Tracker_OnLootLost' then 

            -- OnLootLooted - IgnoreOthers
            if moduleKey == 'Messages_Events_Tracker_OnLootLooted' then
                InterfaceOptions.AddCheckBox({
                    id      = moduleKey..'_Filtering_'..category..'_'..rarity..'_IgnoreOthers',
                    default = moduleRef[category][rarity]['IgnoreOthers'],
                    label   = Lokii.GetString('Options_Messages_Generic_IgnoreOthers_Label'),
                    tooltip = Lokii.GetString('Options_Messages_Generic_IgnoreOthers_Tooltip'),
                    subtab  = subtab,
                })
            end

            -- Squad
            InterfaceOptions.AddCheckBox({
                id      = moduleKey..'_Filtering_'..category..'_'..rarity..'_Channels_Squad_Enabled',
                default = moduleRef[category][rarity]['Channels']['Squad']['Enabled'],
                label   = Lokii.GetString('Options_Messages_Generic_Channels_Squad_Enabled_Label'),
                tooltip = Lokii.GetString('Options_Messages_Generic_Channels_Squad_Enabled_Tooltip'),
                subtab  = subtab,
            })

            InterfaceOptions.AddTextInput({
                id      = moduleKey..'_Filtering_'..category..'_'..rarity..'_Channels_Squad_Format',
                default = moduleRef[category][rarity]['Channels']['Squad']['Format'],
                label   = Lokii.GetString('Options_Messages_Generic_Channels_Squad_Format_Label'),
                tooltip = Lokii.GetString('Options_Messages_Generic_Channels_Squad_Format_Tooltip'),
                subtab  = subtab,
            })

            -- Platoon
            InterfaceOptions.AddCheckBox({
                id      = moduleKey..'_Filtering_'..category..'_'..rarity..'_Channels_Platoon_Enabled',
                default = moduleRef[category][rarity]['Channels']['Platoon']['Enabled'],
                label   = Lokii.GetString('Options_Messages_Generic_Channels_Platoon_Enabled_Label'),
                tooltip = Lokii.GetString('Options_Messages_Generic_Channels_Platoon_Enabled_Tooltip'),
                subtab  = subtab,
            })

            InterfaceOptions.AddTextInput({
                id      = moduleKey..'_Filtering_'..category..'_'..rarity..'_Channels_Platoon_Format',
                default = moduleRef[category][rarity]['Channels']['Platoon']['Format'],
                label   = Lokii.GetString('Options_Messages_Generic_Channels_Platoon_Format_Label'),
                tooltip = Lokii.GetString('Options_Messages_Generic_Channels_Platoon_Format_Tooltip'),
                subtab  = subtab,
            })

            -- System
            InterfaceOptions.AddCheckBox({
                id      = moduleKey..'_Filtering_'..category..'_'..rarity..'_Channels_System_Enabled',
                default = moduleRef[category][rarity]['Channels']['System']['Enabled'],
                label   = Lokii.GetString('Options_Messages_Generic_Channels_System_Enabled_Label'),
                tooltip = Lokii.GetString('Options_Messages_Generic_Channels_System_Enabled_Tooltip'),
                subtab  = subtab,
            })

            InterfaceOptions.AddTextInput({
                id      = moduleKey..'_Filtering_'..category..'_'..rarity..'_Channels_System_Format',
                default = moduleRef[category][rarity]['Channels']['System']['Format'],
                label   = Lokii.GetString('Options_Messages_Generic_Channels_System_Format_Label'),
                tooltip = Lokii.GetString('Options_Messages_Generic_Channels_System_Format_Tooltip'),
                subtab  = subtab,
            })

            -- Notifications
            InterfaceOptions.AddCheckBox({
                id      = moduleKey..'_Filtering_'..category..'_'..rarity..'_Channels_Notifications_Enabled',
                default = moduleRef[category][rarity]['Channels']['Notifications']['Enabled'],
                label   = Lokii.GetString('Options_Messages_Generic_Channels_Notifications_Enabled_Label'),
                tooltip = Lokii.GetString('Options_Messages_Generic_Channels_Notifications_Enabled_Tooltip'),
                subtab  = subtab,
            })

            InterfaceOptions.AddTextInput({
                id      = moduleKey..'_Filtering_'..category..'_'..rarity..'_Channels_Notifications_Format',
                default = moduleRef[category][rarity]['Channels']['Notifications']['Format'],
                label   = Lokii.GetString('Options_Messages_Generic_Channels_Notifications_Format_Label'),
                tooltip = Lokii.GetString('Options_Messages_Generic_Channels_Notifications_Format_Tooltip'),
                subtab  = subtab,
            })


        end

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

        for tableKey, tableValue in ipairs(table) do
            InterfaceOptions.AddChoiceEntry({
                menuId  = id,
                val     = tableValue,
                label   = Lokii.GetString('Options_Dropdown_'..optionKey..'_Choice_'..tableValue..'_Label'),
                tooltip = Lokii.GetString('Options_Dropdown_'..optionKey..'_Choice_'..tableValue..'_Tooltip'),
                subtab  = subtab,
            })
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
            subtab=subtab,
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
        label    = Lokii.GetString('Options_'..rootKey..'_Events_'..eventKey..'_Enabled_Label'),
        tooltip  = Lokii.GetString('Options_'..rootKey..'_Events_'..eventKey..'_Enabled_Tooltip'),
        subtab   = subtab,
    })

        -- OnLootLooted - IgnoreOthers
        if eventKey == 'Tracker_OnLootLooted' then
            InterfaceOptions.AddCheckBox({
                id      = rootKey..'_Events_'..eventKey..'_IgnoreOthers',
                default = defaults['IgnoreOthers'],
                label   = Lokii.GetString('Options_Messages_Generic_IgnoreOthers_Label'),
                tooltip = Lokii.GetString('Options_Messages_Generic_IgnoreOthers_Tooltip'),
                subtab  = subtab,
            })
        end

        -- Squad
        InterfaceOptions.AddCheckBox({
            id      = rootKey..'_Events_'..eventKey..'_Channels_Squad_Enabled',
            default = defaults['Channels']['Squad']['Enabled'],
            label   = Lokii.GetString('Options_Messages_Generic_Channels_Squad_Enabled_Label'),
            tooltip = Lokii.GetString('Options_Messages_Generic_Channels_Squad_Enabled_Tooltip'),
            subtab  = subtab,
        })

        InterfaceOptions.AddTextInput({
            id      = rootKey..'_Events_'..eventKey..'_Channels_Squad_Format',
            default = defaults['Channels']['Squad']['Format'],
            label   = Lokii.GetString('Options_Messages_Generic_Channels_Squad_Format_Label'),
            tooltip = Lokii.GetString('Options_Messages_Generic_Channels_Squad_Format_Tooltip'),
            subtab  = subtab,
        })

        -- Platoon
        InterfaceOptions.AddCheckBox({
            id      = rootKey..'_Events_'..eventKey..'_Channels_Platoon_Enabled',
            default = defaults['Channels']['Platoon']['Enabled'],
            label   = Lokii.GetString('Options_Messages_Generic_Channels_Platoon_Enabled_Label'),
            tooltip = Lokii.GetString('Options_Messages_Generic_Channels_Platoon_Enabled_Tooltip'),
            subtab  = subtab,
        })

        InterfaceOptions.AddTextInput({
            id      = rootKey..'_Events_'..eventKey..'_Channels_Platoon_Format',
            default = defaults['Channels']['Platoon']['Format'],
            label   = Lokii.GetString('Options_Messages_Generic_Channels_Platoon_Format_Label'),
            tooltip = Lokii.GetString('Options_Messages_Generic_Channels_Platoon_Format_Tooltip'),
            subtab  = subtab,
        })

        -- System
        InterfaceOptions.AddCheckBox({
            id      = rootKey..'_Events_'..eventKey..'_Channels_System_Enabled',
            default = defaults['Channels']['System']['Enabled'],
            label   = Lokii.GetString('Options_Messages_Generic_Channels_System_Enabled_Label'),
            tooltip = Lokii.GetString('Options_Messages_Generic_Channels_System_Enabled_Tooltip'),
            subtab  = subtab,
        })

        InterfaceOptions.AddTextInput({
            id      = rootKey..'_Events_'..eventKey..'_Channels_System_Format',
            default = defaults['Channels']['System']['Format'],
            label   = Lokii.GetString('Options_Messages_Generic_Channels_System_Format_Label'),
            tooltip = Lokii.GetString('Options_Messages_Generic_Channels_System_Format_Tooltip'),
            subtab  = subtab,
        })

        -- Notifications
        InterfaceOptions.AddCheckBox({
            id      = rootKey..'_Events_'..eventKey..'_Channels_Notifications_Enabled',
            default = defaults['Channels']['Notifications']['Enabled'],
            label   = Lokii.GetString('Options_Messages_Generic_Channels_Notifications_Enabled_Label'),
            tooltip = Lokii.GetString('Options_Messages_Generic_Channels_Notifications_Enabled_Tooltip'),
            subtab  = subtab,
        })

        InterfaceOptions.AddTextInput({
            id      = rootKey..'_Events_'..eventKey..'_Channels_Notifications_Format',
            default = defaults['Channels']['Notifications']['Format'],
            label   = Lokii.GetString('Options_Messages_Generic_Channels_Notifications_Format_Label'),
            tooltip = Lokii.GetString('Options_Messages_Generic_Channels_Notifications_Format_Tooltip'),
            subtab  = subtab,
        })

    InterfaceOptions.StopGroup({
            subtab = subtab,
        })


end





require "lib/lib_Tabs"

FiltUI = {}

FiltUIref = {
    MAIN = Component.GetFrame("Options"),
    WINDOW = Component.GetWidget("Window"),
    MOVABLE_PARENT = Component.GetWidget("MovableParent"),
    CLOSE_BUTTON = Component.GetWidget("close"),
    TITLE_TEXT = Component.GetWidget("title"),

    LEFT_COLUMN = Component.GetWidget("LeftColumn"),
    MAIN_AREA = Component.GetWidget("MainArea"),
    FILTER_LIST = Component.GetWidget("FilterList"),

    BUTTON_ADD = Component.GetWidget("ButtonAdd"),
    BUTTON_DEL = Component.GetWidget("ButtonDel"),



    PANES = Component.GetWidget("Tabs"),
    
    BODY = Component.GetWidget("Body"),

}
FiltUIref.TABS = Tabs.Create(3, FiltUIref.PANES)

FiltUI.State = {
    page = "Blacklist",
    section = "all"
}

FiltUI.Instance = {
    filterList,
}

function Options.SetupFilteringUI(args)
    
    
    MovablePanel.ConfigFrame({
        frame = FiltUIref.MAIN,
        MOVABLE_PARENT = FiltUIref.MOVABLE_PARENT
    })

    PanelManager.RegisterFrame(FiltUIref.MAIN, ToggleWindow, {show=false})

    -- Setup close button
    FiltUIref.CLOSE_BUTTON:BindEvent("OnMouseDown", function() FiltUI.Show(false) end)
    local X = FiltUIref.CLOSE_BUTTON:GetChild("X");
    FiltUIref.CLOSE_BUTTON:BindEvent("OnMouseEnter", function()
        X:ParamTo("tint", Component.LookupColor("red"), 0.15);
        X:ParamTo("glow", "#30991111", 0.15);
    end)
    FiltUIref.CLOSE_BUTTON:BindEvent("OnMouseLeave", function()
        X:ParamTo("tint", Component.LookupColor("white"), 0.15);
        X:ParamTo("glow", "#00000000", 0.15);
    end)

    FiltUIref.TITLE_TEXT:SetText("Loot Tracker") -- fixme: hardcoded


    -- Setup Tabs
    FiltUIref.TABS:SetTab(1, {label="Blacklist"})
    FiltUIref.TABS:SetTab(2, {label="Filtering"})
    FiltUIref.TABS:SetTab(3, {label="Keybinds"})

    FiltUIref.TABS:Select(1)







    
    --Component.GetWidget("pathText"):SetText("Filtering >> " .. FiltUI.State.page .. " >> " .. FiltUI.State.section)


    local addButton = Button.Create(FiltUIref.BUTTON_ADD);
    addButton:SetText("Change Scope");
    addButton:TintPlate(Button.DEFAULT_GREEN_COLOR);
    addButton:Bind(function()
        
        FiltUI.ChangeView("Blacklist", (FiltUI.State.section == "Tracker" and "Waypoints") or "Tracker") -- Debug input, toggles between "all" and "tracker"

        

    end);

    
    local delButton = Button.Create(FiltUIref.BUTTON_DEL);
    delButton:SetText("Debug Blacklist");
    delButton:TintPlate(Button.DEFAULT_RED_COLOR);
    delButton:Bind(function()
        Debug.Table(Options['Blacklist'])
        --[[

        Private.ShowDialog(
        {
            body = Component.LookupText("DELETE_FILTER_SET"):format(activeFilterSet or ""),
            onYes = DeleteFilterSet,
            onNo = function()
            
            end
        });
        --]]
    end);

    
    -- init
    FiltUI.Instance.filterList = RowScroller.Create(FiltUIref.FILTER_LIST);
    FiltUI.Instance.filterList:SetSpacing(2);
    FiltUI.Instance.filterList:ShowSlider(true);

    FiltUI.ChangeView("Blacklist", "all")

end

function Options.ToggleFilteringUI(args)
    ToggleWindow(true)
end


function ToggleWindow(show)
    FiltUI.Show(show);
end


function FiltUI.ChangeView(page, section)

    -- Save previous values for reference
    local oldPage = FiltUI.State.page
    local oldSection = FiltUI.State.section

    -- Update to new values
    FiltUI.State.page = page
    FiltUI.State.section = section


    -- Update path
    --Component.GetWidget("pathText"):SetText("Filtering >> " .. FiltUI.State.page .. " >> " .. FiltUI.State.section)



    


    -- Do stuffz
    if page == "Blacklist" then


        FiltUI.Instance.filterList:LockUpdates()

        -- clear
        FiltUI.Instance.filterList:Reset()

        -- list active stuff
        if not _table.empty(Options['Blacklist'][section]) then



            for itemTypeId, value in pairs(Options['Blacklist'][section]) do
                local itemInfo = Game.GetItemInfoByType(itemTypeId)
                if not itemInfo then
                    Debug.Warn('Invalid itemTypeId in blacklist') 
                else
                    --results[#results + 1] = tostring(itemInfo.name) .. ' (' .. tostring(itemInfo.itemTypeId) ..')'


                    widget = Component.CreateWidget("BlacklistRow", FiltUIref.FILTER_LIST)
                    widget:SetDims("width:100%; height:64;")
                    local content = widget:GetChild("content");
                    local focus = widget:GetChild("focusBox");
                    local bg = widget:GetChild("bg");
                    local defaultBgAlpha = 0.4;
                    focus:BindEvent("OnMouseEnter", function()
                        bg:ParamTo("tint", Component.LookupColor("RowHover"), 0.15);
                        bg:ParamTo("alpha", 0.3, 0.15);
                    end);
                    focus:BindEvent("OnMouseLeave", function()
                        bg:ParamTo("tint", Component.LookupColor("RowDefault"), 0.15);
                        bg:ParamTo("alpha", defaultBgAlpha, 0.15);
                    end);


                    local ICON = MultiArt.Create(content:GetChild("icon"))
                    ICON:SetUrl(itemInfo.web_icon)

                    Component.CreateWidget("RowField", content:GetChild("name")):GetChild("text"):SetText(tostring(itemInfo.name));
                    Component.CreateWidget("RowField", content:GetChild("typeid")):GetChild("text"):SetText(tostring(itemInfo.itemTypeId));




                    FiltUI.Instance.filterList:AddRow(widget)

                end

            end
            
             

        end


        FiltUI.Instance.filterList:UnlockUpdates()



    end

end

function FiltUI.Show(show) 

    FiltUIref.MAIN:Show(show)

    Component.SetInputMode(show and "cursor" or "none");
    if (show) then
        PanelManager.OnShow(FiltUIref.MAIN)
    else
        PanelManager.OnHide(FiltUIref.MAIN)
    end

end
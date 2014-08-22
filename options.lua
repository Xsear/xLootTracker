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
        ['RemoveDelay'] = 0.5,
        ['RefreshInterval'] = 10,
        ['LootUpdateInterval'] = 2,
        ['LootEventHistoryCleanupInterval'] = 2,
        ['LootEventHistoryLifetime'] = 3 * 1000,
        ['Limit'] = 50,
        ['IgnoreCrystite'] = true,
        ['IgnoreMetalsTornado'] = true,
        ['UpdateMode'] = 'global',
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
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

            },

            [LootCategory.Consumable] = {
                ['Enabled'] = false,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

            },

            [LootCategory.Modules] = {
                ['Enabled'] = false,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },
            },

            [LootCategory.Salvage] = {
                ['Enabled'] = false,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },
            },

            [LootCategory.Metals] = {
                ['Enabled'] = false,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

            },

            [LootCategory.Components] = {
                ['Enabled'] = false,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },
            },
            
            [LootCategory.Currency] = {
                ['Enabled'] = false,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                },

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
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },

            },

            [LootCategory.Consumable] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

            },

            [LootCategory.Modules] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "[{itemReqLevel}] {itemName}",
                },
            },

            [LootCategory.Salvage] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },
            },

            [LootCategory.Metals] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

            },

            [LootCategory.Components] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },
            },
            
            [LootCategory.Currency] = {
                ['Enabled'] = true,

                ['Mode'] = TriggerModeOptions.Simple,

                ['Simple'] = {
                    ['RarityThreshold'] = LootRarity.Salvage,
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Salvage] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Common] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Uncommon] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Rare] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Epic] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Prototype] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

                [LootRarity.Legendary] = {
                    ['ItemLevelThreshold'] = 0,
                    ['RequiredLevelThreshold'] = 0,
                    ['WaypointTitle'] = "{itemName}",
                },

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
                            ['Format'] = 'New loot drop: {itemAsLink}',
                        },

                        ['Platoon'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'New loot drop: {itemAsLink}',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'New loot drop: {itemAsLink}',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
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
                            ['Enabled'] = false,
                            ['Format'] = '{lootedTo} looted {itemAsLink}',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '{lootedTo} looted {itemAsLink}',
                        },
                    },

                },

                ['OnLootLost'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = false,
                            ['Format'] = '{itemAsLink} has despawned',
                        },

                        ['Platoon'] = {
                            ['Enabled'] = true,
                            ['Format'] = '{itemAsLink} has despawned',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
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
        ['Enabled'] = false,
        ['Visibility'] = HUDTrackerVisibilityOptions.HUD,
        ['Tooltip'] = {
            ['Enabled'] = true,
        },
        ['PlateMode'] = HUDTrackerPlateModeOptions.Decorated,
        ['IconMode'] = HUDTrackerIconModeOptions.Decorated,

        ['UpdateInterval'] = 5,
        ['MinimumUpdateDelay'] = 1,

        ['EntrySize'] = 32,
        ['EntryFontType'] = OptionsFontTypes.UbuntuMedium,
        ['EntryFontSize'] = 10,

        ['ForceWebIcons'] = false,
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
    },

}







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


Options['HUDTracker']['Filtering'] = {
    [LootCategory.Equipment] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Salvage] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Common] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Uncommon] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Rare] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Epic] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Prototype] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Legendary] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

    },

    [LootCategory.Consumable] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Salvage] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Common] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Uncommon] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Rare] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Epic] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Prototype] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Legendary] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

    },

    [LootCategory.Modules] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Salvage] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Common] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Uncommon] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Rare] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Epic] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Prototype] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Legendary] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },
    },

    [LootCategory.Salvage] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Salvage] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Common] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Uncommon] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Rare] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Epic] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Prototype] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Legendary] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },
    },

    [LootCategory.Metals] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Salvage] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Common] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Uncommon] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Rare] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Epic] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Prototype] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Legendary] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

    },

    [LootCategory.Components] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Salvage] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Common] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Uncommon] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Rare] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Epic] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Prototype] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Legendary] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },
    },
    
    [LootCategory.Currency] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Salvage] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Common] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Uncommon] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Rare] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Epic] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Prototype] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

        [LootRarity.Legendary] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['HUDTrackerTitle'] = "{itemName}",
        },

    },
}




Options['Sounds']['Filtering'] = {
    [LootCategory.Equipment] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Salvage] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Common] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Uncommon] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Rare] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Epic] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Prototype] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Legendary] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

    },

    [LootCategory.Consumable] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Salvage] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Common] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Uncommon] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Rare] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Epic] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Prototype] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Legendary] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

    },

    [LootCategory.Modules] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Salvage] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Common] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Uncommon] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Rare] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Epic] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Prototype] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Legendary] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },
    },

    [LootCategory.Salvage] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Salvage] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Common] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Uncommon] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Rare] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Epic] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Prototype] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Legendary] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },
    },

    [LootCategory.Metals] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Salvage] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Common] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Uncommon] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Rare] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Epic] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Prototype] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Legendary] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

    },

    [LootCategory.Components] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Salvage] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Common] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Uncommon] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Rare] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Epic] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Prototype] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Legendary] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },
    },
    
    [LootCategory.Currency] = {
        ['Enabled'] = true,

        ['Mode'] = TriggerModeOptions.Simple,

        ['Simple'] = {
            ['RarityThreshold'] = LootRarity.Salvage,
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Salvage] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Common] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Uncommon] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Rare] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Epic] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Prototype] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
        },

        [LootRarity.Legendary] = {
            ['ItemLevelThreshold'] = 0,
            ['RequiredLevelThreshold'] = 0,
            ['SoundsNewLoot'] = 'Play_UI_Beep_13',
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
    if args.id == "__LOADED" then
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

        -- For Sound option changes, play the sound
        elseif explodedId[1] == 'Sounds' then
            -- Note: This could behave poorly if other sound options are added
            if type(args.val) == 'string' then
                System.PlaySound(args.val)
            end
        end

        -- Update Options Visibility
        SetOptionsAvailability()
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
function SetOptionsAvailability()


    -- If simple disable advanced options
    for i, moduleKey in pairs({'HUDTracker', 'Panels', 'Waypoints', 'Sounds'}) do

        for id, categoryKey in pairs(FilterableLootCategories) do


            -- Mode selection only available when type enabled
            InterfaceOptions.EnableOption(moduleKey..'_Filtering_'..categoryKey..'_Mode', Options[moduleKey]['Filtering'][categoryKey]['Enabled'])

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
                if Options[moduleKey]['Filtering'][categoryKey]['Enabled'] == false then
                    disable = true 

                -- If type is enabled, disable stuff not relevant to current mode
                else
                    -- Tired Xsear reading this got confused, so he expanded the comments. Stick with me here.
                    -- We want to disable all the other groups if we're in simple mode, and only the simple group otherwise.

                    -- So. If we are currently in Simple Mode, disable = true.
                    disable = (Options[moduleKey]['Filtering'][categoryKey]['Mode'] == TriggerModeOptions.Simple)

                    -- But in order to keep Simple enabled, if the current rarityKey is Simple, disable = false (but I decided to be fancy and just invert it)
                    if rarityKey == 'Simple' then disable = not disable end
                end

                -- Do our job
                for optionKey, optionValue in pairs(Options[moduleKey]['Filtering'][categoryKey][rarityKey]) do
                    InterfaceOptions.DisableOption(moduleKey..'_Filtering_'..categoryKey..'_'..rarityKey..'_'..optionKey, disable)
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
    --[[
    InterfaceOptions.AddSlider({
        id      = 'Tracker_RefreshInterval',
        min     = 0.5,
        max     = 5.0,
        inc     = 0.5,
        suffix  = 's',
        default = Options['Tracker']['RefreshInterval'],
        label   = Lokii.GetString('Options_Tracker_RefreshInterval_Label'),
        tooltip = Lokii.GetString('Options_Tracker_RefreshInterval_Tooltip'),
        subtab  = {
            Lokii.GetString('Options_Subtab_Tracker')
        },
    })
    --]]

    -- Loot Update Interval
    InterfaceOptions.AddSlider({
        id      = 'Tracker_LootUpdateInterval',
        min     = 0.5,
        max     = 120,
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

    -- Event settings
    for tableKey, tableValue in pairs(Options['Messages']['Events']) do
        for eventKey, eventValue in pairs(Options['Messages']['Events'][tableKey]) do
            UIHELPER_MessageEventOptions('Messages', tableKey..'_'..eventKey, Options['Messages']['Events'][tableKey][eventKey], {Lokii.GetString('Options_Subtab_Messages'), Lokii.GetString('Options_Subtab_Messages_'..tableKey)})
        end
    end
end

function BuildInterfaceOptions_HUDTracker()
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


function UIHELPER_Filtering(moduleKey)
    for id, category in pairs(FilterableLootCategories) do
        UIHELPER_FilterCategory(moduleKey, category)
    end
end

function UIHELPER_FilterCategory(moduleKey, x)
    Debug.Log("UIHELPER_FilterCategory", tostring(moduleKey), tostring(x))
    -- Checkbox Group X
    --[[
    -- Maybe one day we'll have nested groups...
    InterfaceOptions.StartGroup({
        id       = moduleKey..'_'..x..'_Enabled',
        checkbox = true,
        default  = Options[moduleKey][x]['Enabled'],
        label    = Lokii.GetString(moduleKey..'_'..x..'_Enabled_Label'),
        tooltip  = Lokii.GetString(moduleKey..'_'..x..'_Enabled_Tooltip'),
        subtab   = {
            Lokii.GetString('Options_Subtab_'..moduleKey)
        },
    })
    ]]--
        -- moduleKey x Enabled
        InterfaceOptions.AddCheckBox({
            id      = moduleKey..'_Filtering_'..x..'_Enabled',
            default = Options[moduleKey]['Filtering'][x]['Enabled'],
            label   = Lokii.GetString('Options_Filtering_'..x..'_Enabled_Label'),
            tooltip = Lokii.GetString('Options_Filtering_'..x..'_Enabled_Tooltip'),
            subtab  = {Lokii.GetString('Options_Subtab_'..moduleKey), Lokii.GetString('Options_Subtab_Filtering')}
        })

        -- Mode dropdown
        UIHELPER_DropdownFromTable(moduleKey..'_Filtering_'..x..'_Mode', 'Options_Filtering_Mode', Options[moduleKey]['Filtering'][x]['Mode'], OptionsTriggerModeDropdown, 'Mode', {Lokii.GetString('Options_Subtab_'..moduleKey), Lokii.GetString('Options_Subtab_Filtering'), Lokii.GetString('Options_Subtab_'..x)})

        -- Simple mode options
        UIHELPER_FilterRarity(moduleKey, x, 'Simple', {Lokii.GetString('Options_Subtab_'..moduleKey), Lokii.GetString('Options_Subtab_Filtering'), Lokii.GetString('Options_Subtab_'..x)})

        -- Advanced mode options
        for id, rarity in pairs(LootRarity) do
            UIHELPER_FilterRarity(moduleKey, x, rarity, {Lokii.GetString('Options_Subtab_'..moduleKey), Lokii.GetString('Options_Subtab_Filtering'), Lokii.GetString('Options_Subtab_'..x)})
        end

    --[[
    InterfaceOptions.StopGroup({
        subtab = {
            Lokii.GetString('Options_Subtab_'..moduleKey)
        },
    })
    ]]--
end

function UIHELPER_FilterRarity(moduleKey, x, rarity, subtab)
    -- Vars
    local checkbox = (rarity ~= 'Simple')
    local raritydropdown = (rarity == 'Simple')

    -- moduleKey x rarity Enabled group
    InterfaceOptions.StartGroup({
        id       = moduleKey..'_Filtering_'..x..'_'..rarity..'_Enabled',
        checkbox = checkbox,
        default  = Options[moduleKey]['Filtering'][x]['Enabled'],
        label    = Lokii.GetString('Options_Filtering_'..rarity..'_Enabled_Label'),
        tooltip  = Lokii.GetString('Options_Filtering_'..rarity..'_Enabled_Tooltip'),
        subtab   = subtab
    })

        -- Rarity Threshold
        if raritydropdown then
        UIHELPER_DropdownFromTable(moduleKey..'_Filtering_'..x..'_'..rarity..'_RarityThreshold', 'Options_Filtering_RarityThreshold', Options[moduleKey]['Filtering'][x][rarity]['RarityThreshold'], OptionsLootRarityDropdown, 'RarityThreshold', subtab)
        end

        -- Item Level Threshold
        InterfaceOptions.AddTextInput({
            id      = moduleKey..'_Filtering_'..x..'_'..rarity..'_ItemLevelThreshold',
            numeric = true,
            label   = Lokii.GetString('Options_Filtering_ItemLevelThreshold_Label'),
            tooltip = Lokii.GetString('Options_Filtering_ItemLevelThreshold_Tooltip'),
            default = Options[moduleKey]['Filtering'][x][rarity]['ItemLevelThreshold'],
            subtab  = subtab
        })

        -- Required Level Threshold
        InterfaceOptions.AddTextInput({
            id      = moduleKey..'_Filtering_'..x..'_'..rarity..'_RequiredLevelThreshold',
            numeric = true,
            label   = Lokii.GetString('Options_Filtering_RequiredLevelThreshold_Label'),
            tooltip = Lokii.GetString('Options_Filtering_RequiredLevelThreshold_Tooltip'),
            default = Options[moduleKey]['Filtering'][x][rarity]['RequiredLevelThreshold'],
            subtab  = subtab
        })

        -- Waypoints
        if moduleKey == "Waypoints" then
            InterfaceOptions.AddTextInput({
                id      = moduleKey..'_Filtering_'..x..'_'..rarity..'_WaypointTitle',
                label   = Lokii.GetString('Options_Filtering_WaypointTitle_Label'),
                tooltip = Lokii.GetString('Options_Filtering_WaypointTitle_Tooltip'),
                default = Options[moduleKey]['Filtering'][x][rarity]['WaypointTitle'],
                subtab  = subtab
            })

        -- HUDTracker
        elseif moduleKey == "HUDTracker" then
            InterfaceOptions.AddTextInput({
                id      = moduleKey..'_Filtering_'..x..'_'..rarity..'_HUDTrackerTitle',
                label   = Lokii.GetString('Options_Filtering_HUDTrackerTitle_Label'),
                tooltip = Lokii.GetString('Options_Filtering_HUDTrackerTitle_Tooltip'),
                default = Options[moduleKey]['Filtering'][x][rarity]['HUDTrackerTitle'],
                subtab  = subtab
            })

        elseif moduleKey == "Sounds" then

            UIHELPER_SoundOptionsMenu(moduleKey..'_Filtering_'..x..'_'..rarity..'_SoundsNewLoot', Lokii.GetString('Options_Filtering_SoundsNewLoot_Label'), Options['Sounds']['Filtering'][x][rarity]['SoundsNewLoot'], subtab)

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
            if optionKey == "OptionsFontTypes" then
                Debug.Log('Options_Dropdown_'..optionKey..'_Choice_'..tableValue..'_Label', 'Options_Dropdown_'..optionKey..'_Choice_'..tableValue..'_Tooltip')
            end
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
        if eventKey == 'OnLootLooted' then
            InterfaceOptions.AddCheckBox({
                id      = rootKey..'_Events_'..eventKey..'_IgnoreOthers',
                default = defaults['IgnoreOthers'],
                label   = Lokii.GetString('Options_Messages_Generic_IgnoreOthers_Label'),
                tooltip = Lokii.GetString('Options_Messages_Generic_IgnoreOthers_Tooltip'),
                subtab  = {Lokii.GetString('Options_Subtab_Messages')}
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
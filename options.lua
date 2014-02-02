Options = {
    ['Core'] = {
        ['Enabled'] = true,
        ['VersionMessage'] = true,
    },

    ['Detection'] = {
        ['Enabled'] = true,
    },

    ['Distribution'] = {
        ['Enabled'] = true,

        ['AutoDistribute'] = true,

        ['RollMin'] = 1,
        ['RollMax'] = 100,
        ['RollTimeout'] = 15,
        ['RollTypeDefault'] = RollType.Pass,

        ['EquipmentItems'] = {

            ['Enabled'] = true,

            ['Mode'] = TriggerModeOptions.Simple,

            ['Simple'] = {
                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.Archetype,
                ['TierThreshold'] = TierOptions.Any,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Unstaged'] = {
                ['Enabled'] = false,
                ['LootMode'] = DistributionMode.RoundRobin,
                ['Weighting'] = WeightingOptions.None,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage1'] = {
                ['Enabled'] = false,
                ['LootMode'] = DistributionMode.RoundRobin,
                ['Weighting'] = WeightingOptions.None,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage2'] = {
                ['Enabled'] = false,
                ['LootMode'] = DistributionMode.RoundRobin,
                ['Weighting'] = WeightingOptions.Archetype,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage3'] = {
                ['Enabled'] = true,
                ['LootMode'] = DistributionMode.Dice,
                ['Weighting'] = WeightingOptions.Archetype,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage4'] = {
                ['Enabled'] = true,
                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.Archetype,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },
        },

        ['CraftingComponents'] = {
        
            ['Enabled'] = true,

            ['Mode'] = TriggerModeOptions.Simple,

            ['Simple'] = {
                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.None,
                ['TierThreshold'] = TierOptions.Any,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Unstaged'] = {
                ['Enabled'] = false,
                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.None,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage1'] = {
                ['Enabled'] = false,
                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.None,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage2'] = {
                ['Enabled'] = false,
                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.None,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage3'] = {
                ['Enabled'] = false,
                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.None,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage4'] = {
                ['Enabled'] = false,
                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.None,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },
        },

        ['SalvageModules'] = {
            ['Enabled'] = true,

            ['Mode'] = TriggerModeOptions.Simple,

            ['Simple'] = {
                ['LootMode'] = DistributionMode.RoundRobin,
                ['Weighting'] = WeightingOptions.None,
                ['TierThreshold'] = TierOptions.Any,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Unstaged'] = {
                ['Enabled'] = false,
                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.None,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage1'] = {
                ['Enabled'] = false,
                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.None,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage2'] = {
                ['Enabled'] = false,
                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.None,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage3'] = {
                ['Enabled'] = false,
                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.None,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage4'] = {
                ['Enabled'] = false,
                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.None,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },
        },

    },

    ['Waypoints'] = {
        ['Enabled'] = true,

        ['ShowOnHud'] = true,
        ['ShowOnWorldMap'] = true,
        ['ShowOnRadar'] = true,
        ['RadarEdgeMode'] = RadarEdgeModes.Icon,
        ['TrailAssigned'] = true,
        ['PingAssigned'] = true,

        ['EquipmentItems'] = {

            ['Enabled'] = true,

            ['Mode'] = TriggerModeOptions.Simple,

            ['Simple'] = {
                ['TierThreshold'] = TierOptions.Any,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Unstaged'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage1'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage2'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage3'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage4'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },
        },

        ['CraftingComponents'] = {
        
            ['Enabled'] = true,

            ['Mode'] = TriggerModeOptions.Simple,

            ['Simple'] = {
                ['TierThreshold'] = TierOptions.Any,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Unstaged'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage1'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage2'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage3'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage4'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },
        },

        ['SalvageModules'] = {
        
            ['Enabled'] = true,

            ['Mode'] = TriggerModeOptions.Simple,

            ['Simple'] = {
                ['TierThreshold'] = TierOptions.Any,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Unstaged'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage1'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage2'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage3'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage4'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },
        },
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

        ['EquipmentItems'] = {

            ['Enabled'] = true,

            ['Mode'] = TriggerModeOptions.Simple,

            ['Simple'] = {
                ['TierThreshold'] = TierOptions.Any,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Unstaged'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage1'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage2'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage3'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage4'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },
        },

        ['CraftingComponents'] = {
        
            ['Enabled'] = true,

            ['Mode'] = TriggerModeOptions.Simple,

            ['Simple'] = {
                ['TierThreshold'] = TierOptions.Any,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Unstaged'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage1'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage2'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage3'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage4'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },
        },

        ['SalvageModules'] = {
        
            ['Enabled'] = true,

            ['Mode'] = TriggerModeOptions.Simple,

            ['Simple'] = {
                ['TierThreshold'] = TierOptions.Any,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Unstaged'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage1'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage2'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage3'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage4'] = {
                ['Enabled'] = false,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },
        },
    },

    ['Messages'] = {
        ['Enabled'] = true,

        ['Channels'] = {
            ['Squad'] = true,
            ['System'] = true,
            ['Notifications'] = true,
        },

        ['Prefix'] = '',

        ['Events'] = {
            
            ['Detection'] = {

                ['OnIdentify'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
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

                ['OnLootReceived'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
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


                ['OnLootStolen'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%l stole %a\'s %i',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l stole %a\'s %i',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l stole %a\'s %i',
                        },
                    },

                },


                ['OnLootSnatched'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%l snatched %i',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l snatched %i',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l snatched %i',
                        },
                    },

                },


                ['OnLootClaimed'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
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

                ['OnLootDespawn'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = false,
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

            ['Distribution'] = {
                ['OnDistributeItem'] = {
                    ['Enabled'] = false,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Distributing %i by %m',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Distributing %i by %m',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'Distributing %i by %m',
                        },
                    },

                },

                ['OnAssignItem'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%n won %i',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%n won %i',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%n won %i',
                        },
                    },

                },

                ['OnAssignItemByRoll'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%n rolls %r and wins %i',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%n rolls %r and wins %i',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%n rolls %r and wins %i',
                        },
                    },

                },

                ['OnAssignItemFreeForAll'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%i is up for grabs',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%i is up for grabs',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%i is up for grabs',
                        },
                    },

                },

                ['OnRolls'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%n rolls %r for %i',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = ' %n rolls %r for %i',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%n rolls %r for %i',
                        },
                    },

                },

                ['OnAcceptingRolls'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'Declare need/greed/pass on %i (%id)\nEligible for need: %e',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Declare need/greed/pass on %i (%id)\nEligible for need: %e',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Declare need/greed/pass on %i (%id)\nEligible for need: %e',
                        },
                    },

                },

                ['OnRollChange'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Correcting roll of %n, attempted need but not eligible',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Correcting roll of %n, attempted need but not eligible',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'Correcting roll of %n, attempted need but not eligible',
                        },
                    },

                },

                ['OnRollBusy'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Can\'t roll %i yet, we\'re busy rolling something else',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Can\'t roll %i yet, we\'re busy rolling something else',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'Can\'t roll %i yet, we\'re busy rolling something else',
                        },
                    },

                },

                ['OnRollAccept'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'Recognizing that %n has selected %t',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Recognizing that %n has selected %t',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Recognizing that %n has selected %t',
                        },
                    },

                },

                ['OnRollNobody'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'Nobody rolled!',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Nobody rolled!',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Nobody rolled!',
                        },
                    },

                },

            },
 
        },
    },

    ['Tracker'] = {
        ['Enabled'] = true,

        ['Visibility'] = TrackerVisibilityOptions.MouseMode,
        ['Tooltip'] = {
            ['Enabled'] = true,
            ['Mode'] = TrackerTooltipModes.ProgressionStyle,
        },

        ['PlateMode'] = TrackerPlateModeOptions.Decorated,
        ['IconMode'] = TrackerIconModeOptions.Decorated,

        ['EquipmentItems'] = {

            ['Enabled'] = true,

            ['Mode'] = TriggerModeOptions.Simple,

            ['Simple'] = {
                ['TierThreshold'] = TierOptions.Any,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Unstaged'] = {
                ['Enabled'] = false,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage1'] = {
                ['Enabled'] = false,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage2'] = {
                ['Enabled'] = false,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage3'] = {
                ['Enabled'] = false,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage4'] = {
                ['Enabled'] = false,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },
        },

        ['CraftingComponents'] = {
        
            ['Enabled'] = true,

            ['Mode'] = TriggerModeOptions.Simple,

            ['Simple'] = {
                ['TierThreshold'] = TierOptions.Any,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Unstaged'] = {
                ['Enabled'] = false,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage1'] = {
                ['Enabled'] = false,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage2'] = {
                ['Enabled'] = false,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage3'] = {
                ['Enabled'] = false,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage4'] = {
                ['Enabled'] = false,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },
        },

        ['SalvageModules'] = {
        
            ['Enabled'] = true,

            ['Mode'] = TriggerModeOptions.Simple,

            ['Simple'] = {
                ['TierThreshold'] = TierOptions.Any,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Unstaged'] = {
                ['Enabled'] = false,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage1'] = {
                ['Enabled'] = false,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage2'] = {
                ['Enabled'] = false,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage3'] = {
                ['Enabled'] = false,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage4'] = {
                ['Enabled'] = false,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },
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

    ['Communication'] = {
        ['Enabled'] = true,

        ['Custom'] = false,

        ['Send'] = false,
        ['Receive'] = false,

        ['Assign'] = {
            ['Enabled'] = true,
            ['Send'] = true,
            ['Receive'] = true,
        },

        ['ItemIdentity'] = {
            ['Enabled'] = true,
            ['Send'] = true,
            ['Receive'] = true,
        },

        ['RollStart'] = {
            ['Enabled'] = true,
            ['Send'] = true,
            ['Receive'] = true,
        },

        ['RollDecision'] = {
            ['Enabled'] = true,
            ['Send'] = true,
            ['Receive'] = true,
        },

        ['RollUpdate'] = {
            ['Enabled'] = true,
            ['Send'] = true,
            ['Receive'] = true,
        },


    },

--[[
 ['Communication'] = {
        ['Custom'] = false,
        ['Prefix'] = 'xSLM:',
        ['Assign'] = {
            ['Enabled'] = true,
            ['Format'] = 'A:%tId:%q:%n',
        },
    },
--]]

    ['Debug'] = {
        ['Enabled'] = false,
        ['AlwaysSquadLeader'] = false,
        ['FakeOnSquadRoster'] = false,
        ['SquadToArmy'] = false,
        ['UndefinedFilterArguments'] = false,
        ['LogLootableTargets'] = false, 
        ['LogLootableCollection'] = false,
        ['LogOptionChange'] = false,
        ['CommunicationExtra'] = false,
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
        bLoaded = true

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
    if bLoaded then
        -- For Tracker options, update the tracker
        if explodedId[1] == 'Tracker' then
            Tracker.Update()
        -- For Panels options, update the panels
        elseif explodedId[1] == 'Panels' then
            for i, item in ipairs(aIdentifiedLoot) do
                UpdatePanel(item)
            end
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


-- from: http://lua-users.org/wiki/SplitJoin
function splitExplode(d,p)
  local t, ll
  t={}
  ll=0
  if(#p == 1) then return {p} end
    while true do
      l=string.find(p,d,ll,true) -- find the next d in the string
      if l~=nil then -- if "not not" found then..
        table.insert(t, string.sub(p,ll,l-1)) -- Save it in our array.
        ll=l+1 -- save just after where we found it for searching next time.
      else
        table.insert(t, string.sub(p,ll)) -- Save what's left in our array.
        break -- Break at end, as it should be, according to the lua manual.
      end
    end
  return t
end



--[[
    SetOptionsAvailability()
    Supposed to hide/unhide shit in the Interface Options.
]]--
function SetOptionsAvailability()

    -- If simple disable advanced options
    for i, rootKey in pairs({'Tracker', 'Distribution', 'Panels', 'Waypoints'}) do

        for i, typeKey in pairs({'EquipmentItems', 'CraftingComponents', 'SalvageModules'}) do


            -- Mode selection only available when type enabled
            InterfaceOptions.EnableOption(rootKey..'_'..typeKey..'_Mode', Options[rootKey][typeKey]['Enabled'])

            for i, stageKey in pairs({'Simple', 'Unstaged', 'Stage1', 'Stage2', 'Stage3', 'Stage4'}) do
                --Debug.Log(rootKey..'_'..typeKey)

                -- Disable/Enable logic
                -- Fixme: bluuuuuurgh
                local disable = false

                -- If type not enabled, disable everything
                if Options[rootKey][typeKey]['Enabled'] == false then
                    disable = true 

                -- If type is enabled, disable stuff not relevant to current mode
                else
                    -- If in Simple mode, disable everything except for the Simple group.
                    -- The opposite is done if not in Simple mode.
                    disable = (Options[rootKey][typeKey]['Mode'] == TriggerModeOptions.Simple)
                    if stageKey == 'Simple' then disable = not disable end
                end

                -- Do our job
                for optionKey, optionValue in pairs(Options[rootKey][typeKey][stageKey]) do
                    InterfaceOptions.DisableOption(rootKey..'_'..typeKey..'_'..stageKey..'_'..optionKey, disable)
                end

  
            end

        end

    end

    -- Communication Messages are disabled if the Custom Communication Messages option is not enabled
    InterfaceOptions.DisableOption('Communication_Send', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_Receive', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_Assign_Enabled', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_Assign_Send', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_Assign_Receive', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_ItemIdentity_Enabled', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_ItemIdentity_Send', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_ItemIdentity_Receive', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_RollStart_Enabled', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_RollStart_Send', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_RollStart_Receive', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_RollDecision_Enabled', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_RollDecision_Send', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_RollDecision_Receive', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_RollUpdate_Enabled', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_RollUpdate_Send', not Options['Communication']['Custom'])
    InterfaceOptions.DisableOption('Communication_RollUpdate_Receive', not Options['Communication']['Custom'])

    -- Panels custom colormode is hidden when colormode is not set to cutom
    InterfaceOptions.DisableOption('Panels_ColorMode_HeaderBarCustomValue', Options['Panels']['ColorMode']['HeaderBar'] ~= ColorModes.Custom)
    InterfaceOptions.DisableOption('Panels_ColorMode_ItemNameCustomValue', Options['Panels']['ColorMode']['ItemName'] ~= ColorModes.Custom)
end



--[[
    SetupInterfaceOptions()
    Sets up the Interface Options, including the callback to OnOptionChange and the Save Version.

]]--
function SetupInterfaceOptions()
    -- Notifications
    InterfaceOptions.NotifyOnLoaded(true) -- Notify us when all options have been loaded (we don't play sounds before that)
    --InterfaceOptions.NotifyOnDefaults(true) -- Notify us when user resets the options
    --InterfaceOptions.NotifyOnDisplay(true) -- Notify us when the user opens the interface options

    -- Callback
    InterfaceOptions.SetCallbackFunc(function(id, val) OnOptionChange({id=id,val=val}) end, 'xSquadLootManager') -- Callback for when user changes settings

    -- Save version
    InterfaceOptions.SaveVersion(ciSaveVersion) -- Settings save-version, increment if behavior changes

    -- Frames
    InterfaceOptions.AddMovableFrame({
        frame = Tracker.GetFrame(),
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

    BuildInterfaceOptions_Distribution()
    
    BuildInterfaceOptions_Panels()
    BuildInterfaceOptions_Waypoints()

    BuildInterfaceOptions_Messages()
    BuildInterfaceOptions_Tracker()
    BuildInterfaceOptions_Sounds()

    BuildInterfaceOptions_Communication()
end


function BuildInterfaceOptions_Front()

    -- Core
    InterfaceOptions.StartGroup({
        id    = 'Group_Core',
        label = 'Xsear\'s Squad Loot Manager',
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

    InterfaceOptions.StopGroup()

    -- Features
    InterfaceOptions.StartGroup({
        id    = 'Group_Features',
        label = 'Features',
    })
        --[[
        InterfaceOptions.AddCheckBox({
            id      = 'Detection_Enabled',
            label   = Lokii.GetString('Detection_Enabled_Label'),
            tooltip = Lokii.GetString('Detection_Enabled_Tooltip'),
            default = Options['Detection']['Enabled'],
        })
        --]]

        InterfaceOptions.AddCheckBox({
            id      = 'Distribution_Enabled',
            label   = Lokii.GetString('Distribution_Enabled_Label'),
            tooltip = Lokii.GetString('Distribution_Enabled_Tooltip'),
            default = Options['Distribution']['Enabled'],
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
            id      = 'Tracker_Enabled',
            label   = Lokii.GetString('Tracker_Enabled_Label'),
            tooltip = Lokii.GetString('Tracker_Enabled_Tooltip'),
            default = Options['Tracker']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Sounds_Enabled',
            label   = Lokii.GetString('Sounds_Enabled_Label'),
            tooltip = Lokii.GetString('Sounds_Enabled_Tooltip'),
            default = Options['Sounds']['Enabled'],
        })

        --[[
        InterfaceOptions.AddCheckBox({
            id      = 'Communication_Enabled',
            label   = Lokii.GetString('Communication_Enabled_Label'),
            tooltip = Lokii.GetString('Communication_Enabled_Tooltip'),
            default = Options['Communication']['Enabled'],
        })
        --]]


    InterfaceOptions.StopGroup()

    -- Debug
    InterfaceOptions.StartGroup({
        id       = 'Debug_Enabled',
        checkbox = true,
        default  = Options['Debug']['Enabled'],
        label    = Lokii.GetString('Debug_Enabled_Label'),
        tooltip  = Lokii.GetString('Debug_Enabled_Tooltip'),
    })

        -- Always Squad Leader
        InterfaceOptions.AddCheckBox({
            id      = 'Debug_AlwaysSquadLeader',
            default = Options['Debug']['AlwaysSquadleader'],
            label   = Lokii.GetString('Debug_AlwaysSquadLeader_Label'),
            tooltip = Lokii.GetString('Debug_AlwaysSquadLeader_Tooltip'),
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Debug_FakeOnSquadRoster',
            default = Options['Debug']['FakeOnSquadRoster'],
            label   = Lokii.GetString('Debug_FakeOnSquadRoster_Label'),
            tooltip = Lokii.GetString('Debug_FakeOnSquadRoster_Tooltip'),
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

        -- CommunicationExtra
        InterfaceOptions.AddCheckBox({
            id      = 'Debug_CommunicationExtra',
            default = Options['Debug']['CommunicationExtra'],
            label   = Lokii.GetString('Debug_CommunicationExtra_Label'),
            tooltip = Lokii.GetString('Debug_CommunicationExtra_Tooltip'),
        })


    InterfaceOptions.StopGroup()
end

function BuildInterfaceOptions_Distribution()
    -- Filters
    UIHELPER_DetectDistributeMarkX('Distribution', 'EquipmentItems')
    UIHELPER_DetectDistributeMarkX('Distribution', 'CraftingComponents')
    UIHELPER_DetectDistributeMarkX('Distribution', 'SalvageModules')


    -- Auto Distribute
    InterfaceOptions.AddCheckBox({
        id      = 'Distribution_AutoDistribute',
        default = Options['Distribution']['AutoDistribute'],
        label   = Lokii.GetString('Distribution_AutoDistribute_Label'),
        tooltip = Lokii.GetString('Distribution_AutoDistribute_Tooltip'),
        subtab  = {
            Lokii.GetString('Subtab_Distribution')
        },
    })

    -- Rolls
    InterfaceOptions.AddTextInput({
        id      = 'Distribution_RollMin',
        numeric =  true,
        default = Options['Distribution']['RollMin'],
        label   = Lokii.GetString('Distribution_RollMin_Label'),
        tooltip = Lokii.GetString('Distribution_RollMin_Tooltip'),
        subtab  = {Lokii.GetString('Subtab_Distribution')}
    })

    InterfaceOptions.AddTextInput({
        id      = 'Distribution_RollMax',
        numeric =  true,
        default = Options['Distribution']['RollMax'],
        label   = Lokii.GetString('Distribution_RollMax_Label'),
        tooltip = Lokii.GetString('Distribution_RollMax_Tooltip'),
        subtab  = {Lokii.GetString('Subtab_Distribution')}
    })

    InterfaceOptions.AddTextInput({
        id      = 'Distribution_RollTimeout',
        numeric =  true,
        default = Options['Distribution']['RollTimeout'],
        label   = Lokii.GetString('Distribution_RollTimeout_Label'),
        tooltip = Lokii.GetString('Distribution_RollTimeout_Tooltip'),
        subtab  = {Lokii.GetString('Subtab_Distribution')}
    })

    UIHELPER_DropdownFromTable('Distribution_RollTypeDefault', 'Distribution_RollTypeDefault', Options['Distribution']['RollTypeDefault'], RollType, 'RollType', Lokii.GetString('Subtab_Distribution'))
end

function BuildInterfaceOptions_Panels()
    -- Filters
    UIHELPER_DetectDistributeMarkX('Panels', 'EquipmentItems')
    UIHELPER_DetectDistributeMarkX('Panels', 'CraftingComponents')
    UIHELPER_DetectDistributeMarkX('Panels', 'SalvageModules')
    

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
    UIHELPER_DetectDistributeMarkX('Waypoints', 'EquipmentItems')
    UIHELPER_DetectDistributeMarkX('Waypoints', 'CraftingComponents')
    UIHELPER_DetectDistributeMarkX('Waypoints', 'SalvageModules')

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

function BuildInterfaceOptions_Tracker()
    -- Visibility
    UIHELPER_DropdownFromTable('Tracker_Visibility', 'Tracker_Visibility', Options['Tracker']['Visibility'], TrackerVisibilityOptions, 'TrackerVisibility',  Lokii.GetString('Subtab_Tracker'))

    -- Tooltips
    InterfaceOptions.AddCheckBox({
        id      = 'Tracker_Tooltip_Enabled',
        default = Options['Tracker']['Tooltip']['Enabled'],
        label   = Lokii.GetString('Tracker_Tooltip_Enabled_Label'),
        tooltip = Lokii.GetString('Tracker_Tooltip_Enabled_Tooltip'),
        subtab  = {Lokii.GetString('Subtab_Tracker')}
    })
    UIHELPER_DropdownFromTable('Tracker_Tooltip_Mode', 'Tracker_Tooltip_Mode', Options['Tracker']['Tooltip']['Mode'], TrackerTooltipModes, 'TrackerTooltipModes',  Lokii.GetString('Subtab_Tracker'))

    -- PlateMode
    UIHELPER_DropdownFromTable('Tracker_PlateMode', 'Tracker_PlateMode', Options['Tracker']['PlateMode'], TrackerPlateModeOptions, 'TrackerPlateModeOptions',  Lokii.GetString('Subtab_Tracker'))

    -- IconMode
    UIHELPER_DropdownFromTable('Tracker_IconMode', 'Tracker_IconMode', Options['Tracker']['IconMode'], TrackerIconModeOptions, 'TrackerIconModeOptions',  Lokii.GetString('Subtab_Tracker'))

    -- Filters
    UIHELPER_DetectDistributeMarkX('Tracker', 'EquipmentItems')
    UIHELPER_DetectDistributeMarkX('Tracker', 'CraftingComponents')
    UIHELPER_DetectDistributeMarkX('Tracker', 'SalvageModules')
end

function BuildInterfaceOptions_Sounds()
    UIHELPER_SoundOptionsMenu('Sounds_OnIdentify', Lokii.GetString('Sounds_OnIdentify_Label'), Options['Sounds']['OnIdentify'], Lokii.GetString('Subtab_Sounds'))

    --UIHELPER_SoundOptionsMenu('Sounds_OnIdentifyRollable', Lokii.GetString('Sounds_OnIdentifyRollable_Label'), Options['Sounds']['OnIdentifyRollable'], Lokii.GetString('Subtab_Sounds'))

    UIHELPER_SoundOptionsMenu('Sounds_OnAssignItemToMe', Lokii.GetString('Sounds_OnAssignItemToMe_Label'), Options['Sounds']['OnAssignItemToMe'], Lokii.GetString('Subtab_Sounds'))

    UIHELPER_SoundOptionsMenu('Sounds_OnAssignItemToOther', Lokii.GetString('Sounds_OnAssignItemToOther_Label'), Options['Sounds']['OnAssignItemToOther'], Lokii.GetString('Subtab_Sounds'))
end

function BuildInterfaceOptions_Communication()

    -- Communication Settings
    InterfaceOptions.StartGroup({
        id          = 'Group_Communication',
        label       = Lokii.GetString('Group_Communication_Label'),
        tooltip     = Lokii.GetString('Group_Communication_Tooltip'),
        subtab      = {Lokii.GetString('Subtab_Communication')}
    })

        InterfaceOptions.AddCheckBox({
            id      = 'Communication_Custom',
            default = Options['Communication']['Custom'],
            label   = Lokii.GetString('Communication_Custom_Label'),
            tooltip = Lokii.GetString('Communication_Custom_Tooltip'),
            subtab  = {Lokii.GetString('Subtab_Communication')}
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Communication_Send',
            default = Options['Communication']['Send'],
            label   = Lokii.GetString('Communication_Send_Label'),
            tooltip = Lokii.GetString('Communication_Send_Tooltip'),
            subtab  = {Lokii.GetString('Subtab_Communication')}
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Communication_Receive',
            default = Options['Communication']['Receive'],
            label   = Lokii.GetString('Communication_Receive_Label'),
            tooltip = Lokii.GetString('Communication_Receive_Tooltip'),
            subtab  = {Lokii.GetString('Subtab_Communication')}
        })

    InterfaceOptions.StopGroup({
        subtab = {Lokii.GetString('Subtab_Communication')}
    })

    -- Assign
    InterfaceOptions.StartGroup({
        id       = 'Communication_Assign_Enabled',
        checkbox = true,
        default  = Options['Communication']['Assign']['Enabled'],
        label    = Lokii.GetString('Communication_Assign_Enabled_Label'),
        tooltip  = Lokii.GetString('Communication_Assign_Enabled_Tooltip'),
        subtab   = {Lokii.GetString('Subtab_Communication')}
    })

        InterfaceOptions.AddCheckBox({
            id      = 'Communication_Assign_Send',
            default = Options['Communication']['Assign']['Send'],
            label   = Lokii.GetString('Communication_Send_Label'),
            tooltip = Lokii.GetString('Communication_Send_Tooltip'),
            subtab  = {Lokii.GetString('Subtab_Communication')}
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Communication_Assign_Receive',
            default = Options['Communication']['Assign']['Receive'],
            label   = Lokii.GetString('Communication_Receive_Label'),
            tooltip = Lokii.GetString('Communication_Receive_Tooltip'),
            subtab  = {Lokii.GetString('Subtab_Communication')}
        })

    InterfaceOptions.StopGroup({
        subtab = {Lokii.GetString('Subtab_Communication')}
    })


    -- ItemIdentity
    InterfaceOptions.StartGroup({
        id       = 'Communication_ItemIdentity_Enabled',
        checkbox = true,
        default  = Options['Communication']['ItemIdentity']['Enabled'],
        label    = Lokii.GetString('Communication_ItemIdentity_Enabled_Label'),
        tooltip  = Lokii.GetString('Communication_ItemIdentity_Enabled_Tooltip'),
        subtab   = {Lokii.GetString('Subtab_Communication')}
    })

        InterfaceOptions.AddCheckBox({
            id      = 'Communication_ItemIdentity_Send',
            default = Options['Communication']['ItemIdentity']['Send'],
            label   = Lokii.GetString('Communication_Send_Label'),
            tooltip = Lokii.GetString('Communication_Send_Tooltip'),
            subtab  = {Lokii.GetString('Subtab_Communication')}
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Communication_ItemIdentity_Receive',
            default = Options['Communication']['ItemIdentity']['Receive'],
            label   = Lokii.GetString('Communication_Receive_Label'),
            tooltip = Lokii.GetString('Communication_Receive_Tooltip'),
            subtab  = {Lokii.GetString('Subtab_Communication')}
        })

    InterfaceOptions.StopGroup({
        subtab = {Lokii.GetString('Subtab_Communication')}
    })


    -- RollStart
    InterfaceOptions.StartGroup({
        id       = 'Communication_RollStart_Enabled',
        checkbox = true,
        default  = Options['Communication']['RollStart']['Enabled'],
        label    = Lokii.GetString('Communication_RollStart_Enabled_Label'),
        tooltip  = Lokii.GetString('Communication_RollStart_Enabled_Tooltip'),
        subtab   = {Lokii.GetString('Subtab_Communication')}
    })

        InterfaceOptions.AddCheckBox({
            id      = 'Communication_RollStart_Send',
            default = Options['Communication']['RollStart']['Send'],
            label   = Lokii.GetString('Communication_Send_Label'),
            tooltip = Lokii.GetString('Communication_Send_Tooltip'),
            subtab  = {Lokii.GetString('Subtab_Communication')}
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Communication_RollStart_Receive',
            default = Options['Communication']['RollStart']['Receive'],
            label   = Lokii.GetString('Communication_Receive_Label'),
            tooltip = Lokii.GetString('Communication_Receive_Tooltip'),
            subtab  = {Lokii.GetString('Subtab_Communication')}
        })

    InterfaceOptions.StopGroup({
        subtab = {Lokii.GetString('Subtab_Communication')}
    })

    -- RollDecision
    InterfaceOptions.StartGroup({
        id       = 'Communication_RollDecision_Enabled',
        checkbox = true,
        default  = Options['Communication']['RollDecision']['Enabled'],
        label    = Lokii.GetString('Communication_RollDecision_Enabled_Label'),
        tooltip  = Lokii.GetString('Communication_RollDecision_Enabled_Tooltip'),
        subtab   = {Lokii.GetString('Subtab_Communication')}
    })

        InterfaceOptions.AddCheckBox({
            id      = 'Communication_RollDecision_Send',
            default = Options['Communication']['RollDecision']['Send'],
            label   = Lokii.GetString('Communication_Send_Label'),
            tooltip = Lokii.GetString('Communication_Send_Tooltip'),
            subtab  = {Lokii.GetString('Subtab_Communication')}
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Communication_RollDecision_Receive',
            default = Options['Communication']['RollDecision']['Receive'],
            label   = Lokii.GetString('Communication_Receive_Label'),
            tooltip = Lokii.GetString('Communication_Receive_Tooltip'),
            subtab  = {Lokii.GetString('Subtab_Communication')}
        })

    InterfaceOptions.StopGroup({
        subtab = {Lokii.GetString('Subtab_Communication')}
    })

    -- RollUpdate
    InterfaceOptions.StartGroup({
        id       = 'Communication_RollUpdate_Enabled',
        checkbox = true,
        default  = Options['Communication']['RollUpdate']['Enabled'],
        label    = Lokii.GetString('Communication_RollUpdate_Enabled_Label'),
        tooltip  = Lokii.GetString('Communication_RollUpdate_Enabled_Tooltip'),
        subtab   = {Lokii.GetString('Subtab_Communication')}
    })

        InterfaceOptions.AddCheckBox({
            id      = 'Communication_RollUpdate_Send',
            default = Options['Communication']['RollUpdate']['Send'],
            label   = Lokii.GetString('Communication_Send_Label'),
            tooltip = Lokii.GetString('Communication_Send_Tooltip'),
            subtab  = {Lokii.GetString('Subtab_Communication')}
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Communication_RollUpdate_Receive',
            default = Options['Communication']['RollUpdate']['Receive'],
            label   = Lokii.GetString('Communication_Receive_Label'),
            tooltip = Lokii.GetString('Communication_Receive_Tooltip'),
            subtab  = {Lokii.GetString('Subtab_Communication')}
        })

    InterfaceOptions.StopGroup({
        subtab = {Lokii.GetString('Subtab_Communication')}
    })

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
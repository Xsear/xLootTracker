
uiSounds = xSounds.GetSounds()

TriggerModeOptions = {
    Simple = 'simple',
    Advanced = 'advanced',
}

TierOptions = {
    Any = 'any',
    Tier1 = '1',
    Tier2 = '2',
    Tier3 = '3',
    Tier4 = '4',
}

QualityOptions = {
    Any = 'any',
    Common = 'common',
    Uncommon = 'uncommon',
    Rare = 'rare',
    Epic = 'epic',
    Legendary = 'legendary',
    Custom = 'custom',
}

WeightingOptions = {
    None = 'none',
    Archetype = 'archetype',
    Battleframe = 'battleframe',
}

DistributionMode = {
    Random = 'random',
    Dice = 'dice',
    RoundRobin = 'round-robin',
    YayNay = 'yaynay',
    NeedBeforeGreed = 'need-before-greed',
    LootMaster = 'lootmaster',
}

RollType = {
    --None = false,
    Pass = 'pass',
    Greed = 'greed',
    Need = 'need',
}

TrackerVisibilityOptions = {
    Always = 'always',
    HUD = 'hud',
    MouseMode = 'mousemode',
}

LootPanelModes = {
    Standard = 'standard',
    Small = 'small',
}

ColorModes = {
    MatchItem = 'match-quality',
    Custom = 'custom',
}

RadarEdgeModes = {
    None = MapMarker.EDGE_NONE,
    Arrow = MapMarker.EDGE_ARROW,
    Icon = MapMarker.EDGE_ICON,
}

Options = {
    ['Core'] = {
        ['Enabled'] = true,
        ['VersionMessage'] = true,
    },

    ['Detection'] = {
        ['Enabled'] = true,

        ['EquipmentItems'] = {

            ['Enabled'] = true,

            ['Mode'] = TriggerModeOptions.Simple,

            ['Simple'] = {
                ['TierThreshold'] = TierOptions.Any,
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

    ['Distribution'] = {
        ['Enabled'] = true,

        ['AlwaysSquadLeader'] = false,

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

            ['Stage1'] = {
                ['Enabled'] = false,

                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.Archetype,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage2'] = {
                ['Enabled'] = false,

                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.Archetype,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage3'] = {
                ['Enabled'] = false,

                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.Archetype,


                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage4'] = {
                ['Enabled'] = false,

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
                ['Weighting'] = WeightingOptions.Archetype,

                ['TierThreshold'] = TierOptions.Any,
                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage1'] = {
                ['Enabled'] = false,

                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.Archetype,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage2'] = {
                ['Enabled'] = false,

                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.Archetype,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage3'] = {
                ['Enabled'] = false,

                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.Archetype,

                ['QualityThreshold'] = QualityOptions.Any,
                ['QualityThresholdCustomValue'] = 500,
            },

            ['Stage4'] = {
                ['Enabled'] = false,

                ['LootMode'] = DistributionMode.NeedBeforeGreed,
                ['Weighting'] = WeightingOptions.Archetype,

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
            ['HeaderBar'] = ColorModes.MatchQuality,
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
                            ['Enabled'] = false,
                            ['Format'] = 'Detected a new loot drop: [%iq]',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Detected a new loot drop: [%iq]',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'Detected a new loot drop: [%iq]',
                        },
                    },

                },

                ['OnLootReceived'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%l looted [%iq]',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l looted [%iq]',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l looted [%iq]',
                        },
                    },

                },


                ['OnLootStolen'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%l stole %a\'s [%iq]',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l stole %a\'s [%iq]',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l stole %a\'s [%iq]',
                        },
                    },

                },


                ['OnLootSnatched'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%l snatched [%iq]',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l snatched [%iq]',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l snatched [%iq]',
                        },
                    },

                },


                ['OnLootClaimed'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%l claimed [%iq]',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l claimed [%iq]',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%l claimed [%iq]',
                        },
                    },

                },

                ['OnLootDespawn'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '[%iq] has despawned.',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = '[%iq] has despawned.',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '[%iq] has despawned.',
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
                            ['Format'] = 'Distributing [%iq] by %m',
                        },

                        ['System'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'Distributing [%iq] by %m',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Distributing [%iq] by %m',
                        },
                    },

                },

                ['OnAssignItem'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%n won [%iq]',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%n won [%iq]',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%n won [%iq]',
                        },
                    },

                },

                ['OnRolls'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = '%n rolls %r for [%iq]',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = ' %n rolls %r for [%iq]',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = '%n rolls %r for [%iq]',
                        },
                    },

                },

                ['OnAcceptingRolls'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'Declare need/greed/pass on [%iq]\nEligible for need: %e',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Declare need/greed/pass on [%iq]\nEligible for need: %e',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Declare need/greed/pass on [%iq]\nEligible for need: %e',
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
                            ['Enabled'] = true,
                            ['Format'] = 'Correcting roll of %n, attempted need but not eligible',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Correcting roll of %n, attempted need but not eligible',
                        },
                    },

                },

                ['OnRollBusy'] = {
                    ['Enabled'] = true,

                    ['Channels'] = {
                        ['Squad'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Can\'t roll [%iq] yet, we\'re busy rolling something else',
                        },

                        ['System'] = {
                            ['Enabled'] = true,
                            ['Format'] = 'Can\'t roll [%iq] yet, we\'re busy rolling something else',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Can\'t roll [%iq] yet, we\'re busy rolling something else',
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
                            ['Format'] = 'Nobody rolled! D:',
                        },

                        ['System'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Nobody rolled! D:',
                        },

                        ['Notifications'] = {
                            ['Enabled'] = false,
                            ['Format'] = 'Nobody rolled! D:',
                        },
                    },

                },

            },
 
        },

        ['Communication'] = {
            ['Custom'] = false,
            ['Prefix'] = 'xSLM:',
            ['Assign'] = {
                ['Enabled'] = true,
                ['Format'] = 'A:%tId:%q:%n',
            },
        },
    },

    ['Tracker'] = {
        ['Enabled'] = true,

        ['Visibility'] = TrackerVisibilityOptions.MouseMode,

        ['EquipmentItems'] = {

            ['Enabled'] = true,

            ['Mode'] = TriggerModeOptions.Simple,

            ['Simple'] = {
                ['TierThreshold'] = TierOptions.Any,
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
        ['OnIdentifyRollable'] = uiSounds[1],
        ['OnAssignItemToMe'] = 'Play_SFX_UI_Ding',
        ['OnAssignItemToOther'] = 'Play_SFX_UI_Ticker',

    },

    ['Debug'] = {
        ['Enabled'] = false,
        ['FakeOnSquadRoster'] = false,
        ['LogLootableTargets'] = false, 
        ['LogLootableCollection'] = false,
    },
}


--[[
    OnOptionChange(args)
        args.id  - interface option id
        args.val - interface option value
    Callback function for Interface Options, when the user has changed an option
]]--
function OnOptionChange(args)

    -- InterfaceOptions Specials
    if args.id == "__LOADED" then
        bLoaded = true

    elseif args.id == '__DEFAULT' then
        -- Todo: Fixme:

    elseif args.id == '__DISPLAY' then
        -- Todo: Fixme:

    else

        if args.id == 'Debug_Enabled' then
            Component.SaveSetting('Debug_Enabled', args.val)
        elseif args.id == 'Core_VersionMessage' then
            Component.SaveSetting('Core_VersionMessage', args.val)
        end

        digOptions(Options, args, splitExplode('_', args.id))
    end

    SetOptionsAvailability()
end


function digOptions(table, args, refs, depth, key)
    if depth == nil then
        depth = 1 -- start at 1
    else
        depth = depth + 1
    end

    if type(table) == 'table' then
        for tableKey, tableValue in pairs(table) do
            if tableKey == refs[depth] then
                if type(tableValue) ~= 'table' then
                    table[tableKey] = args.val
                    Debug.Log('OnOptionChange: '..args.id..' to '..tostring(args.val))
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
    for i, rootKey in pairs({'Detection', 'Distribution', 'Panels', 'Waypoints'}) do

        for i, typeKey in pairs({'EquipmentItems', 'CraftingComponents'}) do


            -- Disable mode selection if type not enabled
            if Options[rootKey][typeKey]['Enabled'] == false then
                InterfaceOptions.DisableOption(rootKey..'_'..typeKey..'_Mode', true)
            end

            for i, stageKey in pairs({'Simple', 'Stage1', 'Stage2', 'Stage3', 'Stage4'}) do
                --Debug.Log(rootKey..'_'..typeKey)

                -- Disable/Enable logic
                -- Fixme: bluuuuuurgh
                local disable = false

                -- If we are in simple mode, disable is true.
                disable = (Options[rootKey][typeKey]['Mode'] == TriggerModeOptions.Simple)

                -- But if the current stageKey is simple, then we invert the value. (So in Simple Mode, simple options are enabled and the rest disabled)
                if stageKey == 'Simple' then disable = not disable end

                -- Buuut, if this kind of type isn't enabled, then everything should be disabled!
                if Options[rootKey][typeKey]['Enabled'] == false then disable = true end


                for optionKey, optionValue in pairs(Options[rootKey][typeKey][stageKey]) do
                    InterfaceOptions.DisableOption(rootKey..'_'..typeKey..'_'..stageKey..'_'..optionKey, disable)
                end

  
            end

        end

    end



--[[
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
]]--


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
    BuildInterfaceOptions_Markers()
    BuildInterfaceOptions_Messages()
    BuildInterfaceOptions_Tracker()
    BuildInterfaceOptions_Sounds()

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
            tooltip = Lokii.GetString('Core_Enabled_ToolTip'),
            default = Options['Core']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Core_VersionMessage',
            label   = Lokii.GetString('Core_VersionMessage_Label'),
            tooltip = Lokii.GetString('Core_VersionMessage_ToolTip'),
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
            tooltip = Lokii.GetString('Detection_Enabled_ToolTip'),
            default = Options['Detection']['Enabled'],
        })
        --]]

        InterfaceOptions.AddCheckBox({
            id      = 'Distribution_Enabled',
            label   = Lokii.GetString('Distribution_Enabled_Label'),
            tooltip = Lokii.GetString('Distribution_Enabled_ToolTip'),
            default = Options['Distribution']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Messages_Enabled',
            label   = Lokii.GetString('Messages_Enabled_Label'),
            tooltip = Lokii.GetString('Messages_Enabled_ToolTip'),
            default = Options['Messages']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Panels_Enabled',
            label   = Lokii.GetString('Panels_Enabled_Label'),
            tooltip = Lokii.GetString('Panels_Enabled_ToolTip'),
            default = Options['Panels']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Waypoints_Enabled',
            label   = Lokii.GetString('Waypoints_Enabled_Label'),
            tooltip = Lokii.GetString('Waypoints_Enabled_ToolTip'),
            default = Options['Waypoints']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Tracker_Enabled',
            label   = Lokii.GetString('Tracker_Enabled_Label'),
            tooltip = Lokii.GetString('Tracker_Enabled_ToolTip'),
            default = Options['Tracker']['Enabled'],
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Sounds_Enabled',
            label   = Lokii.GetString('Sounds_Enabled_Label'),
            tooltip = Lokii.GetString('Sounds_Enabled_ToolTip'),
            default = Options['Sounds']['Enabled'],
        })

    InterfaceOptions.StopGroup()

    -- Debug
    InterfaceOptions.StartGroup({
        id       = 'Debug_Enabled',
        checkbox = true,
        default  = Options['Debug']['Enabled'],
        label    = Lokii.GetString('Debug_Enabled_Label'),
        tooltip  = Lokii.GetString('Debug_Enabled_ToolTip'),
    })

        InterfaceOptions.AddCheckBox({
            id      = 'Debug_FakeOnSquadRoster',
            default = Options['Debug']['FakeOnSquadRoster'],
            label   = Lokii.GetString('Debug_FakeOnSquadRoster_Label'),
            tooltip = Lokii.GetString('Debug_FakeOnSquadRoster_ToolTip'),
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Debug_LogLootableTargets',
            default = Options['Debug']['LogLootableTargets'],
            label   = Lokii.GetString('Debug_LogLootableTargets_Label'),
            tooltip = Lokii.GetString('Debug_LogLootableTargets_ToolTip'),
        })

        InterfaceOptions.AddCheckBox({
            id      = 'Debug_LogLootableCollection',
            default = Options['Debug']['LogLootableCollection'],
            label   = Lokii.GetString('Debug_LogLootableCollection_Label'),
            tooltip = Lokii.GetString('Debug_LogLootableCollection_ToolTip'),
        })

    InterfaceOptions.StopGroup()
end

function BuildInterfaceOptions_Distribution()
    UIHELPER_DetectDistributeMarkX('Distribution', 'EquipmentItems')
    UIHELPER_DetectDistributeMarkX('Distribution', 'CraftingComponents')

    InterfaceOptions.AddCheckBox({
        id      = 'Distribution_AlwaysSquadLeader',
        default = Options['Distribution']['AlwaysSquadleader'],
        label   = Lokii.GetString('Distribution_AlwaysSquadLeader_Label'),
        tooltip = Lokii.GetString('Distribution_AlwaysSquadLeader_ToolTip'),
        subtab  = {
            Lokii.GetString('Subtab_Distribution')
        },
    })

    InterfaceOptions.AddCheckBox({
        id      = 'Distribution_AutoDistribute',
        default = Options['Distribution']['AutoDistribute'],
        label   = Lokii.GetString('Distribution_AutoDistribute_Label'),
        tooltip = Lokii.GetString('Distribution_AutoDistribute_ToolTip'),
        subtab  = {
            Lokii.GetString('Subtab_Distribution')
        },
    })

    -- Rolls
    UIHELPER_TextInput('Distribution_RollMin', true, Options['Distribution']['RollMin'], Lokii.GetString('Subtab_Distribution'))
    UIHELPER_TextInput('Distribution_RollMax', true, Options['Distribution']['RollMax'], Lokii.GetString('Subtab_Distribution'))
    UIHELPER_TextInput('Distribution_RollTimeout', true, Options['Distribution']['RollTimeout'], Lokii.GetString('Subtab_Distribution'))

    UIHELPER_DropdownFromTable('Distribution_RollTypeDefault', Lokii.GetString('Subtab_Distribution'), RollType, Options['Distribution']['RollTypeDefault'], 'RollType')


end

function BuildInterfaceOptions_Markers()
    UIHELPER_DetectDistributeMarkX('Panels', 'EquipmentItems')
    UIHELPER_DetectDistributeMarkX('Panels', 'CraftingComponents')

    UIHELPER_CheckBox('Panels_Display_AssignedTo', Options['Panels']['Display']['AssignedTo'], Lokii.GetString('Subtab_Panels'))
    UIHELPER_CheckBox('Panels_Display_AssignedToHideNil', Options['Panels']['Display']['AssignedToHideNil'], Lokii.GetString(Lokii.GetString('Subtab_Panels')))

    UIHELPER_DropdownFromTable('Panels_ColorMode_HeaderBar', Lokii.GetString('Subtab_Panels'), ColorModes, Options['Panels']['ColorMode']['HeaderBar'], 'ColorModes')
    UIHELPER_ColorPicker('Panels_ColorMode_HeaderBarCustomValue', Options['Panels']['ColorMode']['HeaderBarCustomValue'], Lokii.GetString('Subtab_Panels'))

    UIHELPER_DropdownFromTable('Panels_ColorMode_ItemName', Lokii.GetString('Subtab_Panels'), ColorModes, Options['Panels']['ColorMode']['ItemName'], 'ColorModes')
    UIHELPER_ColorPicker('Panels_ColorMode_ItemNameCustomValue', Options['Panels']['ColorMode']['ItemNameCustomValue'], Lokii.GetString('Subtab_Panels'))

    UIHELPER_ColorPicker('Panels_Color_AssignedTo_Nil', Options['Panels']['Color']['AssignedTo']['Nil'], Lokii.GetString('Subtab_Panels'))
    UIHELPER_ColorPicker('Panels_Color_AssignedTo_Free', Options['Panels']['Color']['AssignedTo']['Free'], Lokii.GetString('Subtab_Panels'))
    UIHELPER_ColorPicker('Panels_Color_AssignedTo_Player', Options['Panels']['Color']['AssignedTo']['Player'], Lokii.GetString('Subtab_Panels'))
    UIHELPER_ColorPicker('Panels_Color_AssignedTo_Other', Options['Panels']['Color']['AssignedTo']['Other'], Lokii.GetString('Subtab_Panels'))


    UIHELPER_DetectDistributeMarkX('Waypoints', 'EquipmentItems')
    UIHELPER_DetectDistributeMarkX('Waypoints', 'CraftingComponents')

    UIHELPER_CheckBox('Waypoints_ShowOnHud', Options['Waypoints']['ShowOnHud'], Lokii.GetString('Subtab_Waypoints'))
    UIHELPER_CheckBox('Waypoints_ShowOnWorldMap', Options['Waypoints']['ShowOnWorldMap'], Lokii.GetString('Subtab_Waypoints'))
    UIHELPER_CheckBox('Waypoints_ShowOnRadar', Options['Waypoints']['ShowOnRadar'], Lokii.GetString('Subtab_Waypoints'))
    UIHELPER_DropdownFromTable('Waypoints_RadarEdgeMode', Lokii.GetString('Subtab_Waypoints'), RadarEdgeModes, Options['Waypoints']['RadarEdgeMode'], 'RadarEdgeModes')
    UIHELPER_CheckBox('Waypoints_TrailAssigned', Options['Waypoints']['TrailAssigned'], Lokii.GetString('Subtab_Waypoints'))
    UIHELPER_CheckBox('Waypoints_PingAssigned', Options['Waypoints']['PingAssigned'], Lokii.GetString('Subtab_Waypoints'))
end


function BuildInterfaceOptions_Messages()

    UIHELPER_CheckBox('Messages_Channels_Squad', Options['Messages']['Channels']['Squad'], Lokii.GetString('Subtab_Messages'))
    UIHELPER_CheckBox('Messages_Channels_System', Options['Messages']['Channels']['System'], Lokii.GetString('Subtab_Messages'))
    UIHELPER_CheckBox('Messages_Channels_Notifications', Options['Messages']['Channels']['Notifications'], Lokii.GetString('Subtab_Messages'))

    UIHELPER_TextInput('Messages_Prefix', false, Options['Messages']['Prefix'], Lokii.GetString('Subtab_Messages'))

    for tableKey, tableValue in pairs(Options['Messages']['Events']) do
        for eventKey, eventValue in pairs(Options['Messages']['Events'][tableKey]) do
            UIHELPER_MessageEventOptions('Messages', tableKey..'_'..eventKey, Options['Messages']['Events'][tableKey][eventKey], {Lokii.GetString('Subtab_Messages'), Lokii.GetString('Subtab_Messages_'..tableKey)})
        end
    end

    -- Messages Communication Settings
    -- yolo pasteday
    InterfaceOptions.StartGroup({
        id='Group_Com',
        label=Lokii.GetString('Group_Com_Label'),
        tooltip=Lokii.GetString('Group_Com_ToolTip'),
        subtab={Lokii.GetString('Subtab_Messages'), Lokii.GetString('Subtab_Messages_Communication')}
    })

        InterfaceOptions.AddCheckBox({
            id='Messages_Communication_Custom',
            default=Options['Messages']['Communication']['Custom'],
            label=Lokii.GetString('Messages_Communication_Custom_Label'),
            tooltip=Lokii.GetString('Messages_Communication_Custom_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages'), Lokii.GetString('Subtab_Messages_Communication')}
        })

        InterfaceOptions.AddTextInput({
            id='Messages_Communication_Prefix',
            default=Options['Messages']['Communication']['Prefix'],
            label=Lokii.GetString('Messages_Communication_Prefix_Label'),
            tooltip=Lokii.GetString('Messages_Communication_Prefix_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages'), Lokii.GetString('Subtab_Messages_Communication')}
        })

        InterfaceOptions.AddCheckBox({
            id='Messages_Communication_Assign_Enabled',
            default=Options['Messages']['Communication']['Assign']['Enabled'],
            label=Lokii.GetString('Messages_Communication_Assign_Enabled_Label'),
            tooltip=Lokii.GetString('Messages_Communication_Assign_Enabled_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages'), Lokii.GetString('Subtab_Messages_Communication')}
        })

        InterfaceOptions.AddTextInput({
            id='Messages_Communication_Assign_Format',
            default=Options['Messages']['Communication']['Assign']['Format'],
            label=Lokii.GetString('Messages_Communication_Assign_Format_Label'),
            tooltip=Lokii.GetString('Messages_Communication_Assign_Format_ToolTip'),
            subtab={Lokii.GetString('Subtab_Messages'), Lokii.GetString('Subtab_Messages_Communication')}
        })

    InterfaceOptions.StopGroup({subtab={Lokii.GetString('Subtab_Messages'), Lokii.GetString('Subtab_Messages_Communication')}})

end

function BuildInterfaceOptions_Tracker()
    UIHELPER_DropdownFromTable('Tracker_Visibility', Lokii.GetString('Subtab_Tracker'), TrackerVisibilityOptions, Options['Tracker']['Visibility'], 'TrackerVisibility')
end

function BuildInterfaceOptions_Sounds()

    UIHELPER_CheckBox('Sounds_Mute', Options['Sounds']['Mute'], Lokii.GetString('Subtab_Sounds'))

    UIHELPER_SoundOptionsMenu('Sounds_OnIdentify', Lokii.GetString('Sounds_OnIdentify_Label'), Options['Sounds']['OnIdentify'], Lokii.GetString('Subtab_Sounds'))

    UIHELPER_SoundOptionsMenu('Sounds_OnIdentifyRollable', Lokii.GetString('Sounds_OnIdentifyRollable_Label'), Options['Sounds']['OnIdentifyRollable'], Lokii.GetString('Subtab_Sounds'))

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
        tooltip  = Lokii.GetString(rootKey..'_'..x..'_Enabled_ToolTip'),
        subtab   = {
            Lokii.GetString('Subtab_'..rootKey)
        },
    })
    ]]--
        UIHELPER_CheckBox(rootKey..'_'..x..'_Enabled', Options[rootKey][x]['Enabled'], Lokii.GetString('Subtab_'..rootKey))

        -- Mode dropdown
        UIHELPER_DropdownFromTable(rootKey..'_'..x..'_Mode', Lokii.GetString('Subtab_'..rootKey), TriggerModeOptions, Options[rootKey][x]['Mode'], 'Mode')

        -- Simple mode options
            UIHELPER_StageX(rootKey, x, 'Simple', 'Subtab_'..rootKey)

        -- Advanced mode options
            UIHELPER_StageX(rootKey, x, 'Stage1', 'Subtab_'..rootKey)
            UIHELPER_StageX(rootKey, x, 'Stage2', 'Subtab_'..rootKey)
            UIHELPER_StageX(rootKey, x, 'Stage3', 'Subtab_'..rootKey)
            UIHELPER_StageX(rootKey, x, 'Stage4', 'Subtab_'..rootKey)

    --[[
    InterfaceOptions.StopGroup({
        subtab = {
            Lokii.GetString('Subtab_'..rootKey)
        },
    })
    ]]--
end

function UIHELPER_StageX(rootKey, x, stage, subtab)
    --[[
    -- Enable checkbox, not used by Simple
    if stage ~= 'Simple' then
        InterfaceOptions.AddCheckBox({
            id      = rootKey..'_'..x..'_'..stage..'_Enabled',
            default = Options[rootKey][x][stage]['Enabled'],
            label    = Lokii.GetString(rootKey..'_'..x..'_'..stage..'_Enabled_Label'),
            tooltip  = Lokii.GetString(rootKey..'_'..x..'_'..stage..'_Enabled_ToolTip'),
            subtab  = {
                Lokii.GetString(subtab)
            },
        })
    end
    --]]
    local checkbox = (stage ~= 'Simple')
    local tierdropdown = (stage == 'Simple')

    InterfaceOptions.StartGroup({
        id       = rootKey..'_'..x..'_'..stage..'_Enabled',
        checkbox = checkbox,
        default  = Options[rootKey][x]['Enabled'],
        label    = Lokii.GetString(rootKey..'_'..x..'_'..stage..'_Enabled_Label'),
        tooltip  = Lokii.GetString(rootKey..'_'..x..'_'..stage..'_Enabled_ToolTip'),
        subtab   = {
            Lokii.GetString(subtab)
        },
    })

        -- Distribution extras
        if rootKey == 'Distribution' then
            UIHELPER_DropdownFromTable(rootKey..'_'..x..'_'..stage..'_LootMode', Lokii.GetString('Subtab_'..rootKey), DistributionMode, Options[rootKey][x][stage]['LootMode'], 'LootMode')
            UIHELPER_DropdownFromTable(rootKey..'_'..x..'_'..stage..'_Weighting', Lokii.GetString('Subtab_'..rootKey), WeightingOptions, Options[rootKey][x][stage]['Weighting'], 'Weighting')
        end

        -- Tier and Quality threshold dropdowns
        if tierdropdown then
        UIHELPER_DropdownFromTable(rootKey..'_'..x..'_'..stage..'_TierThreshold', Lokii.GetString('Subtab_'..rootKey), TierOptions, Options[rootKey][x][stage]['TierThreshold'], 'TierThreshold')
        end
        UIHELPER_DropdownFromTable(rootKey..'_'..x..'_'..stage..'_QualityThreshold', Lokii.GetString('Subtab_'..rootKey), QualityOptions, Options[rootKey][x][stage]['QualityThreshold'], 'QualityThreshold')

        -- Custom Quality input
        InterfaceOptions.AddTextInput({
            id      = rootKey..'_'..x..'_'..stage..'_QualityThresholdCustomValue',
            numeric = true,
            label   = Lokii.GetString(rootKey..'_'..x..'_'..stage..'_QualityThresholdCustomValue_Label'),
            tooltip = Lokii.GetString(rootKey..'_'..x..'_'..stage..'_QualityThresholdCustomValue_ToolTip'),
            default = Options[rootKey][x][stage]['QualityThresholdCustomValue'],
            subtab  = {
                    Lokii.GetString(subtab)
            },
        })

    InterfaceOptions.StopGroup({
        subtab = {
            Lokii.GetString(subtab)
        },
    })
end

function UIHELPER_DropdownFromTable(key, subtab, table, tableDefault, optionKey)
    InterfaceOptions.AddChoiceMenu({
        id      = key,
        default = tableDefault,
        label   = Lokii.GetString(key..'_Label'),
        tooltip = Lokii.GetString(key..'_ToolTip'),
        subtab  = subtab,
    })

        for tableKey, tableValue in pairs(table) do
            InterfaceOptions.AddChoiceEntry({
                menuId  = key,
                val     = tableValue,
                label   = Lokii.GetString(optionKey..'_Choice_'..tableKey..'_Label'),
                tooltip = Lokii.GetString(optionKey..'_Choice_'..tableKey..'_ToolTip'),
                subtab  = subtab,
            })
            --Debug.Log(Lokii.GetString(optionKey..'_Choice_'..tableKey..'_Label'))
            --Debug.Log(Lokii.GetString(optionKey..'_Choice_'..tableKey..'_ToolTip'))
        end
end

function UIHELPER_TextInput(id, numeric, default, subtab)
    InterfaceOptions.AddTextInput({
        id      = id,
        numeric = numeric,
        label   = Lokii.GetString(id..'_Label'),
        tooltip = Lokii.GetString(id..'_ToolTip'),
        default = default,
        subtab  = subtab,
    })
end

function UIHELPER_CheckBox(id, default, subtab)
    InterfaceOptions.AddCheckBox({
        id      = id,
        default = default,
        label   = Lokii.GetString(id..'_Label'),
        tooltip = Lokii.GetString(id..'_ToolTip'),
        subtab  = subtab,
    })
end


function UIHELPER_ColorPicker(id, default, subtab)
    InterfaceOptions.AddColorPicker({
        id      = id,
        default = default,
        label   = Lokii.GetString(id..'_Label'),
        tooltip = Lokii.GetString(id..'_ToolTip'),
        subtab  = subtab,
    })

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
    Debug.Log('Subtab:')
    Debug.Table(subtab)
    -- Checkbox Group
    InterfaceOptions.StartGroup({
        id       = rootKey..'_Events_'..eventKey..'_Enabled',
        checkbox = true,
        default  = defaults['Enabled'],
        label    = Lokii.GetString(rootKey..'_Events_'..eventKey..'_Enabled_Label'),
        tooltip  = Lokii.GetString(rootKey..'_Events_'..eventKey..'_Enabled_ToolTip'),
        subtab   = subtab,
    })

        -- Squad
        UIHELPER_CheckBox(rootKey..'_Events_'..eventKey..'_Channels_Squad_Enabled', defaults['Channels']['Squad']['Enabled'], subtab)
        UIHELPER_TextInput(rootKey..'_Events_'..eventKey..'_Channels_Squad_Format', false, defaults['Channels']['Squad']['Format'], subtab)
 

        -- System
        UIHELPER_CheckBox(rootKey..'_Events_'..eventKey..'_Channels_System_Enabled', defaults['Channels']['System']['Enabled'], subtab)
        UIHELPER_TextInput(rootKey..'_Events_'..eventKey..'_Channels_System_Format', false, defaults['Channels']['System']['Format'], subtab)

        -- Notifications
        UIHELPER_CheckBox(rootKey..'_Events_'..eventKey..'_Channels_Notifications_Enabled', defaults['Channels']['Notifications']['Enabled'], subtab)
        UIHELPER_TextInput(rootKey..'_Events_'..eventKey..'_Channels_Notifications_Format', false, defaults['Channels']['Notifications']['Format'], subtab)

    InterfaceOptions.StopGroup({
            subtab = subtab,
        })


end
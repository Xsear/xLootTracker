--[[
    Does this look messy to you?
    That's because it is!
--]]



-- Parameters used for the functions below
Detect             =    "Detect"
Distribute         =    "Distribute"
Mark               =    "Mark"
Simple             =    "Simple"
Unstaged           =    "Unstaged"
Stage1             =    "Stage 1"
Stage2             =    "Stage 2"
Stage3             =    "Stage 3"
Stage4             =    "Stage 4"
EquipmentItems     =    "Equipment Items"
CraftingComponents =    "Crafting Components"
SalvageModules     =    "Salvage Modules"

function DetectDistributeMarkX_Label(type, stage, x)
    return type.." "..stage.." "..x
end

function DetectDistributeMarkX_Tooltip(type, stage, x)
    return "Toggle whether "..stage.." "..x.." should be "..type.."ed."
end


function FilterGenericX_Label(stage, x)
    return 'Enable '..stage.." "..x
end

function FilterGenericX_Tooltip(stage, x)
    return "Toggle whether this action should be active for "..stage.." "..x.."s."
end


Generic_MessageFormat = "Specify the format of the message. The following replacement variables exist, please note that they're not always available.\n%i : Subject item\n%eId : Item entityId\n%cId : Item craftingTypeId\n%c : The coordinates to the item, as a link\n%n : Subject player\n%l : Player that looted the item\n%a : Player that the item was assigned to\n%m : Distribution Mode that item was distributed in.\n%fA : Archetype suitable for item\n%fF : Frame suitable for item\n%r : The roll value\n%t : The roll type\n%p : Players that can roll\n%e : Players that can Need roll"

Filter_Generic_SimpleEnabled_Label                                              =    "Simple"
Filter_Generic_SimpleEnabled_Tooltip                                            =    "If in Simple configuration mode, only these settings are used."

LANG = {

    UI_AssignedTo_nil                                                               =    "Not yet assigned",
    UI_AssignedTo_false                                                             =    "Free for all",
    UI_AssignedTo_true                                                              =    "Free for all",
    UI_AssignedTo_Prefix                                                            =    "Assigned To: ",
    UI_Messages_System_NoRollableForDistribute                                      =    "No Rollable Loot to distribute",
    UI_Messages_System_NoIdentifiedForDistribute                                    =    "No Identified Loot to distribute",
    UI_Messages_Distribution_NobodyEligible                                         =    "No one",
    UI_Waypoints_Subtitle                                                           =    "Loot",




    -- Everything below is used by the Interface Options.

    Options_MoveableFrame_Tracker_Label                                             =     "xSLM Loot Tracker",

    Filter_Generic_Mode_Tooltip                                                     =    "Simple or Advanced configuration mode.",

    Filter_Generic_LootMode_Label                                                   =    "Ruleset",
    Filter_Generic_LootMode_Tooltip                                                 =    "Set the active ruleset/mode for how loot is distributed. This is affected by the weighting and threshold settings as well.\nRandom: Assigns the item to a random eligible group member\nDice: Rolls for each eligible member and assigns the item to the highest roller\nRound-robin: Awards items to each group member in order. Loot weighting doesn't work in this mode.\nNeed before Greed: Accepts need, greed or pass call from each eligible group member",
    Filter_Generic_Weighting_Label                                                  =    "Weighting",
    Filter_Generic_Weighting_Tooltip                                                =    "Sets the active loot weighting criteria, which can be used to disallow users from rolling on loot drops that their currently active frame cannot use.\nDisabled: No loot weighting.\nArchetype: Only players in the same Battleframe Archetype as the item are eligible.",
    Filter_Generic_TierThreshold_Label                                              =    "Tier Threshold",
    Filter_Generic_TierThreshold_Tooltip                                            =    "Loot below this tier will not be distributed.",
    Filter_Generic_QualityThreshold_Label                                           =    "Quality Threshold",
    Filter_Generic_QualityThreshold_Tooltip                                         =    "Loot below this quality threshold will not be distributed.",
    Filter_Generic_QualityThresholdCustomValue_Label                                =    "Custom Quality Threshold",
    Filter_Generic_QualityThresholdCustomValue_Tooltip                              =    "If Quality Threshold is set to Custom, loot below this quality threshold will not be distributed.",



    Filter_Generic_EquipmentItems_Enabled_Label                                     =    "Equipment Items Enabled",
    Filter_Generic_EquipmentItems_Enabled_Tooltip                                   =    "Toggle",
    Filter_Generic_EquipmentItems_Mode_Label                                        =    "Equipment Items Mode",
    Filter_Generic_EquipmentItems_Mode_Tooltip                                      =    "Simple or Advanced configuration mode.",

    Filter_Generic_CraftingComponents_Enabled_Label                                 =    "Crafting Components Enabled",
    Filter_Generic_CraftingComponents_Enabled_Tooltip                               =    "Toggle",
    Filter_Generic_CraftingComponents_Mode_Label                                    =    "Crafting Components Mode",
    Filter_Generic_CraftingComponents_Mode_Tooltip                                  =    "Simple or Advanced configuration mode.",

    Filter_Generic_SalvageModules_Enabled_Label                                 =    "Salvage Modules Enabled",
    Filter_Generic_SalvageModules_Enabled_Tooltip                               =    "Toggle",
    Filter_Generic_SalvageModules_Mode_Label                                    =    "Salvage Modules Mode",
    Filter_Generic_SalvageModules_Mode_Tooltip                                  =    "Simple or Advanced configuration mode.",


    Filter_Generic_CraftingComponents_Simple_Enabled_Label                          =    Filter_Generic_SimpleEnabled_Label,
    Filter_Generic_CraftingComponents_Simple_Enabled_Tooltip                        =    Filter_Generic_SimpleEnabled_Tooltip,  
    Filter_Generic_CraftingComponents_Unstaged_Enabled_Label                        =    FilterGenericX_Label(Unstaged, CraftingComponents),
    Filter_Generic_CraftingComponents_Unstaged_Enabled_Tooltip                      =    FilterGenericX_Tooltip(Unstaged, CraftingComponents), 
    Filter_Generic_CraftingComponents_Stage1_Enabled_Label                          =    FilterGenericX_Label(Stage1, CraftingComponents),
    Filter_Generic_CraftingComponents_Stage1_Enabled_Tooltip                        =    FilterGenericX_Tooltip(Stage1, CraftingComponents), 
    Filter_Generic_CraftingComponents_Stage2_Enabled_Label                          =    FilterGenericX_Label(Stage2, CraftingComponents),
    Filter_Generic_CraftingComponents_Stage2_Enabled_Tooltip                        =    FilterGenericX_Tooltip(Stage2, CraftingComponents), 
    Filter_Generic_CraftingComponents_Stage3_Enabled_Label                          =    FilterGenericX_Label(Stage3, CraftingComponents),
    Filter_Generic_CraftingComponents_Stage3_Enabled_Tooltip                        =    FilterGenericX_Tooltip(Stage3, CraftingComponents), 
    Filter_Generic_CraftingComponents_Stage4_Enabled_Label                          =    FilterGenericX_Label(Stage4, CraftingComponents),
    Filter_Generic_CraftingComponents_Stage4_Enabled_Tooltip                        =    FilterGenericX_Tooltip(Stage4, CraftingComponents),

    Filter_Generic_EquipmentItems_Simple_Enabled_Label                              =    Filter_Generic_SimpleEnabled_Label,
    Filter_Generic_EquipmentItems_Simple_Enabled_Tooltip                            =    Filter_Generic_SimpleEnabled_Tooltip,  
    Filter_Generic_EquipmentItems_Unstaged_Enabled_Label                            =    FilterGenericX_Label(Unstaged, EquipmentItems),
    Filter_Generic_EquipmentItems_Unstaged_Enabled_Tooltip                          =    FilterGenericX_Tooltip(Unstaged, EquipmentItems), 
    Filter_Generic_EquipmentItems_Stage1_Enabled_Label                              =    FilterGenericX_Label(Stage1, EquipmentItems),
    Filter_Generic_EquipmentItems_Stage1_Enabled_Tooltip                            =    FilterGenericX_Tooltip(Stage1, EquipmentItems), 
    Filter_Generic_EquipmentItems_Stage2_Enabled_Label                              =    FilterGenericX_Label(Stage2, EquipmentItems),
    Filter_Generic_EquipmentItems_Stage2_Enabled_Tooltip                            =    FilterGenericX_Tooltip(Stage2, EquipmentItems), 
    Filter_Generic_EquipmentItems_Stage3_Enabled_Label                              =    FilterGenericX_Label(Stage3, EquipmentItems),
    Filter_Generic_EquipmentItems_Stage3_Enabled_Tooltip                            =    FilterGenericX_Tooltip(Stage3, EquipmentItems), 
    Filter_Generic_EquipmentItems_Stage4_Enabled_Label                              =    FilterGenericX_Label(Stage4, EquipmentItems),
    Filter_Generic_EquipmentItems_Stage4_Enabled_Tooltip                            =    FilterGenericX_Tooltip(Stage4, EquipmentItems),

    Filter_Generic_SalvageModules_Simple_Enabled_Label                              =    Filter_Generic_SimpleEnabled_Label,
    Filter_Generic_SalvageModules_Simple_Enabled_Tooltip                            =    Filter_Generic_SimpleEnabled_Tooltip,  
    Filter_Generic_SalvageModules_Unstaged_Enabled_Label                            =    FilterGenericX_Label(Unstaged, SalvageModules),
    Filter_Generic_SalvageModules_Unstaged_Enabled_Tooltip                          =    FilterGenericX_Tooltip(Unstaged, SalvageModules), 
    Filter_Generic_SalvageModules_Stage1_Enabled_Label                              =    FilterGenericX_Label(Stage1, SalvageModules),
    Filter_Generic_SalvageModules_Stage1_Enabled_Tooltip                            =    FilterGenericX_Tooltip(Stage1, SalvageModules), 
    Filter_Generic_SalvageModules_Stage2_Enabled_Label                              =    FilterGenericX_Label(Stage2, SalvageModules),
    Filter_Generic_SalvageModules_Stage2_Enabled_Tooltip                            =    FilterGenericX_Tooltip(Stage2, SalvageModules), 
    Filter_Generic_SalvageModules_Stage3_Enabled_Label                              =    FilterGenericX_Label(Stage3, SalvageModules),
    Filter_Generic_SalvageModules_Stage3_Enabled_Tooltip                            =    FilterGenericX_Tooltip(Stage3, SalvageModules), 
    Filter_Generic_SalvageModules_Stage4_Enabled_Label                              =    FilterGenericX_Label(Stage4, SalvageModules),
    Filter_Generic_SalvageModules_Stage4_Enabled_Tooltip                            =    FilterGenericX_Tooltip(Stage4, SalvageModules),



    Messages_Generic_Channels_Squad_Enabled_Label                                   =    "Send Squad Message",
    Messages_Generic_Channels_Squad_Enabled_Tooltip                                 =    "Send message to Squad on this event",
    Messages_Generic_Channels_Squad_Format_Label                                    =    "Squad Message Format",
    Messages_Generic_Channels_Squad_Format_Tooltip                                  =    Generic_MessageFormat,

    Messages_Generic_Channels_System_Enabled_Label                                  =    "Send System Message",
    Messages_Generic_Channels_System_Enabled_Tooltip                                =    "Send message to System on this event",
    Messages_Generic_Channels_System_Format_Label                                   =    "System Message Format",

    Messages_Generic_Channels_System_Format_Tooltip                                 =    Generic_MessageFormat,

    Messages_Generic_Channels_Notifications_Enabled_Label                           =    "Send Notifications Message",
    Messages_Generic_Channels_Notifications_Enabled_Tooltip                         =    "Send message to Notifications on this event",
    Messages_Generic_Channels_Notifications_Format_Label                            =    "Notifications Message Format",

    Messages_Generic_Channels_Notifications_Format_Tooltip                          =    Generic_MessageFormat,

    
    Messages_Enabled_Label                                                          =    "Enable Messages",
    Messages_Enabled_Tooltip                                                        =    "The addon will send customizable Messages to the Chat when certain events occur, keeping you and your Squad members in the loop of what is going on with the item drops.",
    Messages_Prefix_Label                                                           =    "Generic Prefix",
    Messages_Prefix_Tooltip                                                         =    "Set the prefix for all public facing messages.",
    Messages_Channels_Squad_Label                                                   =    "Send on Squad Channel",
    Messages_Channels_Squad_Tooltip                                                 =    "Master switch for Squad messages. The addon will not send ANY squad messages if this is checked, regardless of other settings.",
    Messages_Channels_Notifications_Label                                           =    "Send on Notifications Channel",
    Messages_Channels_Notifications_Tooltip                                         =    "Master switch for Notification messages. The addon will not send ANY notification messages if this is checked, regardless of other settings.",
    Messages_Channels_System_Label                                                  =    "Send on System Channel",
    Messages_Channels_System_Tooltip                                                =    "Master switch for System messages. The addon will not send ANY system messages if this is checked, regardless of other settings.",

    Messages_Events_Distribution_OnRollNobody_Enabled_Label                             =    "On Roll Nobody",
    Messages_Events_Distribution_OnRollNobody_Enabled_Tooltip                           =    "When a roll ends without anyone rolling",

    Messages_Events_Distribution_OnAssignItem_Enabled_Label                             =    "On Assign Item",
    Messages_Events_Distribution_OnAssignItem_Enabled_Tooltip                           =    "When somebody is assigned an item",

    Messages_Events_Distribution_OnAssignItemByRoll_Enabled_Label                             =    "On Assign Item By Roll",
    Messages_Events_Distribution_OnAssignItemByRoll_Enabled_Tooltip                           =    "When somebody is assigned an item, having won it through a roll",

    Messages_Events_Distribution_OnAssignItemFreeForAll_Enabled_Label                             =    "On Assign Item Free For All",
    Messages_Events_Distribution_OnAssignItemFreeForAll_Enabled_Tooltip                           =    "When an item is assigned to the public domain",

    Messages_Events_Distribution_OnDistributeItem_Enabled_Label                         =    "On Distribute Item",
    Messages_Events_Distribution_OnDistributeItem_Enabled_Tooltip                       =    "When an item is about to distribute an item",
    
    Messages_Events_Distribution_OnRolls_Enabled_Label                                  =    "On Rolls",
    Messages_Events_Distribution_OnRolls_Enabled_Tooltip                                =    "When a roll is calculated",

    Messages_Events_Distribution_OnRollAccept_Enabled_Label                             =    "On Roll Accept",
    Messages_Events_Distribution_OnRollAccept_Enabled_Tooltip                           =    "When a roll gets accepted",

    Messages_Events_Distribution_OnRollBusy_Enabled_Label                               =    "On Roll Busy",
    Messages_Events_Distribution_OnRollBusy_Enabled_Tooltip                             =    "When there is an attempt to start a new roll, but we're already busy rolling for something else",

    Messages_Events_Distribution_OnRollChange_Enabled_Label                             =    "On Roll Change",
    Messages_Events_Distribution_OnRollChange_Enabled_Tooltip                           =    "When a roll gets changed",

    Messages_Events_Distribution_OnAcceptingRolls_Enabled_Label                         =    "On Accepting Rolls",
    Messages_Events_Distribution_OnAcceptingRolls_Enabled_Tooltip                       =    "When the addon is listening for roll declarations",

    Messages_Events_Detection_OnLootStolen_Enabled_Label                                =    "On Loot Stolen",
    Messages_Events_Detection_OnLootStolen_Enabled_Tooltip                              =    "When somebody loots an item that was assigned to someone else",

    Messages_Events_Detection_OnLootClaimed_Enabled_Label                               =    "On Loot Claimed",
    Messages_Events_Detection_OnLootClaimed_Enabled_Tooltip                             =    "When somebody loots an item that the addon had not found",

    Messages_Events_Detection_OnLootDespawn_Enabled_Label                               =    "On Loot Despawn",
    Messages_Events_Detection_OnLootDespawn_Enabled_Tooltip                             =    "When a tracked item despawns",

    Messages_Events_Detection_OnLootReceived_Enabled_Label                              =    "On Loot Received",
    Messages_Events_Detection_OnLootReceived_Enabled_Tooltip                            =    "When someone who won an item loots that item",

    Messages_Events_Detection_OnLootSnatched_Enabled_Label                              =    "On Loot Snatched",
    Messages_Events_Detection_OnLootSnatched_Enabled_Tooltip                            =    "When somebody loots an item that the addon had not yet assigned",

    Messages_Events_Detection_OnIdentify_Enabled_Label                                  =    "On Identify",
    Messages_Events_Detection_OnIdentify_Enabled_Tooltip                                =    "When the addon has discovered a new item",




    Panels_Enabled_Label                                                                =    "Enable Panels",
    Panels_Enabled_Tooltip                                                              =    "The addon will attach Panels onto item drops, allowing you to inspect the item in detail when up close.",


    Panels_Display_AssignedTo_Label                                                     =    "Display AssignedTo",
    Panels_Display_AssignedTo_Tooltip                                                   =    "Display who the item has been assigned to on the panel header.",
    Panels_Display_AssignedToHideNil_Label                                              =    "Hide AssignedTo Not assigned",
    Panels_Display_AssignedToHideNil_Tooltip                                            =    "Only show AssignedTo text when item has been assigned - don\'t display \"Not assigned\".",

    Panels_Mode_Label                               =    "Mode",
    Panels_Mode_Tooltip                             =    "Overall Panel display mode\nStandard: Full view\nSmall: Only header is shown", Panels_ColorMode_ItemName_Label                                                      =    "Item Name Color",
    Panels_ColorMode_ItemName_Tooltip                                                    =    "Set the color of the item name text on the panel header.",
    Panels_ColorMode_ItemNameCustomValue_Label                                           =    "Custom Item Name Color",    Panels_ColorMode_ItemNameCustomValue_Tooltip                                         =    "Set the color of the item name text on the panel header for the Custom option.",    Panels_ColorMode_HeaderBar_Label                                                     =    "Header Color",
    Panels_ColorMode_HeaderBar_Tooltip                                                   =    "Set the color of the background of the panel header.",
    Panels_ColorMode_HeaderBarCustomValue_Label                                          =    "Custom Header Color",
    Panels_ColorMode_HeaderBarCustomValue_Tooltip                                        =    "Set the color of the background of the panel header for the Custom option.",


    Panels_Color_AssignedTo_Nil_Label                                             =    "AssignedTo Color Not assigned",
    Panels_Color_AssignedTo_Nil_Tooltip                                           =    "Set the color of the Assigned To text when the item has not been assigned.",
    Panels_Color_AssignedTo_Free_Label                                            =    "AssignedTo Color Free for all",
    Panels_Color_AssignedTo_Free_Tooltip                                          =    "Set the color of the Assigned To text when the item has been declared free for all.",
    Panels_Color_AssignedTo_Player_Label                                          =    "AssignedTo Color For you",
    Panels_Color_AssignedTo_Player_Tooltip                                        =    "Set the color of the Assigned To text when the item has been assigned to you.",
    Panels_Color_AssignedTo_Other_Label                                           =    "AssignedTo Color For other",
    Panels_Color_AssignedTo_Other_Tooltip                                         =    "Set the color of the Assigned To text when the item has been assigned to someone else.",

    Core_Enabled_Label                                                                  =    "Enabled",
    Core_Enabled_Tooltip                                                                =    "The addon will be enabled. This option is mainly suitable if you wish to tempoarily disable the addon, without modifying any other options. Please note that this doesn't truly stop the addon from functioning - it merely suppresses actions that would otherwise signify that the addon is active. If you are suspecting compatability issues with other addons, it would be better to tempoarily remove the addon in order to verify whether or not it is part of the issue.",
    Core_VersionMessage_Label                                                           =    "Version Message",
    Core_VersionMessage_Tooltip                                                         =    "Upon being loaded, the addon will send a System message announcing it is active, including its version number.",  


    Detection_IdentifyDelay_Label                                                       =    "Tracking Delay",
    Detection_IdentifyDelay_Tooltip                                                     =    "The number of seconds the addon should wait after detecting a new lootable item before it begins to track it. Lower values feel better, but make the addon more prone to glitches caused by unexpected behavior from the game client.",

    Detection_DespawnCheckInterval_Label                                                =    "Despawn Check Interval",
    Detection_DespawnCheckInterval_Tooltip                                              =    "How often the addon should check that a tracked item is still in the game world. This is only used to discover that an item has dissappeared through some other means than being looted. Lower values  will lead to speedier removal of incorrectly detected items, but are for correctly detected items fairly wasteful.",

    Subtab_Detection                                                                    =    "Detection",

    Waypoints_Enabled_Label                                                             =    "Enable Waypoints",
    Waypoints_Enabled_Tooltip                                                           =    "The addon will attach Waypoints to tracked items, helping you quickly locate drops over larger distances.",

    Waypoints_ShowOnHud_Label                       =    "Show On Hud",
    Waypoints_ShowOnHud_Tooltip                     =    "Show Waypoints on the HUD",
    Waypoints_ShowOnWorldMap_Label                  =    "Show On WorldMap",
    Waypoints_ShowOnWorldMap_Tooltip                =    "Show Waypoints on the World Map",
    Waypoints_ShowOnRadar_Label                     =    "Show On Radar",
    Waypoints_ShowOnRadar_Tooltip                   =    "Show Waypoints on the Radar",
    Waypoints_TrailAssigned_Label                   =    "Trail when loot is assigned to me",
    Waypoints_TrailAssigned_Tooltip                 =    "When an item is assigned to you, the navigation trail is set to its waypoint. Requires 'Display Navigation' setting in 'Gameplay' options checked.",
    Waypoints_PingAssigned_Label                    =    "Ping when loot is assigned to me",
    Waypoints_PingAssigned_Tooltip                  =    "When an item is assigned to you, its waypoint will be pinged - drawing attention to it.",                          


    Waypoints_RadarEdgeMode_Label                   =    "Radar Edge Mode",
    Waypoints_RadarEdgeMode_Tooltip                 =    "Behavior for Waypoint icons on the radar when outside range and the icon attaches to the radar edge\nNone : Hidden \nArrow: Nonspecific arrow icon \nIcon : Keep showing the same icon",



    Debug_Enabled_Label                                                                 =    "Debug",
    Debug_Enabled_Tooltip                                                               =    "The addon will enter Debug mode, logging messages in the console that are helpful for the addon creator in order to track down problems. Additional Debug options in this group will also become available.",

    Debug_FakeOnSquadRoster_Label                                                       =    "Fake Squad Roster",
    Debug_FakeOnSquadRoster_Tooltip                                                     =    "If not in a squad but override squad leader, put fake squad members in the roster",
    Debug_SquadToArmy_Label                                                             =    "Squad To Army",
    Debug_SquadToArmy_Tooltip                                                           =    "Redirect messages on Squad channel to Army",
    Debug_UndefinedFilterArguments_Label                                                =    "Undefined Filter Arguments",
    Debug_UndefinedFilterArguments_Tooltip                                              =    "Output NOT_SET when filter arguments are undefined, rather than an empty string.",
    Debug_LogLootableTargets_Label                                                      =    "Log Loot Detected",
    Debug_LogLootableTargets_Tooltip                                                    =    "Extra debug messages, spammy.\nLogs info on detected items, helpful when errors are occuring during item detection.",
    Debug_LogLootableCollection_Label                                                   =    "Log Loot Collected",
    Debug_LogLootableCollection_Tooltip                                                 =    "Extra debug messages, spammy.\nLogs info on looted items, helpful when errors are occuring during item removal.",
    Debug_LogOptionChange_Label                                                         =    "Log Option Changes",
    Debug_LogOptionChange_Tooltip                                                       =    "Extra debug messages, spammy.\nLogs option changes, helpful when errors are occuring with the interface options.",

    Debug_CommunicationExtra_Label                                                      =    "Log Communication Extra",
    Debug_CommunicationExtra_Tooltip                                                    =    "Extra Communication messages, spammy.\nLogs encoding and decoding of communication links more closely, helpful when errors are occuring in this department.",

    Debug_RoundRobin_Label                                                      =    "Log Round Robin",
    Debug_RoundRobin_Tooltip                                                    =    "Extra logging for Round Robin, spammy.\nDetailed logging of Round Robin logic, helpful if its giving out unexpected results.",


    Sounds_Enabled_Label                                                                =    "Enable Sounds",
    Sounds_Enabled_Tooltip                                                              =    "The addon will play sounds in order to notify you when certain events occur.",
    
    Sounds_Mute_Label                               =    "Mute",
    Sounds_Mute_Tooltip                             =    "If checked, no sounds will play",
    Sounds_OnIdentify_Label                         =    "Item Detected",
    Sounds_OnIdentifyRollable_Label                 =    "NYI?",
    Sounds_OnAssignItemToMe_Label                   =    "Item Assigned To You",
    Sounds_OnAssignItemToOther_Label                =    "Item Assigned To Other",

    Tracker_Enabled_Label                           =    "Enable Tracker",
    Tracker_Enabled_Tooltip                         =    "The addon will display information about currently tracked item drops, allowing you to keep track of things at a glance, as well as to perform actions with ease, or inspect the items in more detail, when in mousemode.",

    Tracker_Visibility_Label                        =    "Visibility",
    Tracker_Visibility_Tooltip                      =    "When to display the tracker.\nAlways - I wanna be with you~\nHUD - Follow suit with rest of HUD\nMousemode - Only when in Mousemode",


    Tracker_Tooltip_Enabled_Label           =  "Enable Tooltips",
    Tracker_Tooltip_Enabled_Tooltip         =  "When hovering over an entry in the Tracker list, a tooltip representation of the item will be displayed on the cursor.",
    Tracker_Tooltip_Mode_Label              =  "Tooltip Style",
    Tracker_Tooltip_Mode_Tooltip            =  "Tooltips in Firefall look different everywhere. This option will hopefully let you choose between the most common ones.",
    Tracker_PlateMode_Label                 =  "Plate Style",
    Tracker_PlateMode_Tooltip               =  "Changes the look of the plate of entries in the Tracker.",
    Tracker_IconMode_Label                  =  "Icon Style ",
    Tracker_IconMode_Tooltip                =  "Changes the look of the item icon of entries in the Tracker. ",


    Distribution_Enabled_Label                                                          =    "Enable Distribution",
    Distribution_Enabled_Tooltip                                                        =    "When you are in a Squad as the Squad Leader, the addon will assist you with distributing the items you find between the members of your Squad. This feature heavily relies on the Messages feature, as otherwise the addon can not comunicate with your Squad.",
                                                                                                             
    Distribution_AutoDistribute_Label                                                   =    "Auto distribute",
    Distribution_AutoDistribute_Tooltip                                                 =    "If checked the addon will automatically distribute/roll items according to the current ruleset as soon as they are identified",

    Distribution_RollMin_Label                                                          =    "Roll range minimum",
    Distribution_RollMin_Tooltip                                                        =    "Minimum roll value",           
    Distribution_RollMax_Label                                                          =    "Roll range maximum",
    Distribution_RollMax_Tooltip                                                        =    "Maximum roll value",   
    Debug_AlwaysSquadLeader_Label                                                =    "Always Squad Leader",
    Debug_AlwaysSquadLeader_Tooltip                                              =    "The addon will ignore what the game says about your status, as you are in fact the undeniable Squad Leader. This allows the addon to perform Distribution even if you are not the Squad Leader. Unfortunately, the addon cannot always convince other players of your greatness on its own.",    
    Distribution_RollTypeDefault_Label                                                  =    "Default Roll Type",
    Distribution_RollTypeDefault_Tooltip                                                =    "This roll type is selected for any users who do not declare a roll type before the timeout.",
    Distribution_RollTimeout_Label                                                      =    "Roll timeout",
    Distribution_RollTimeout_Tooltip                                                    =    "Time limit in seconds for people to declare their roll type in Need before Greed.",




    Mode_Choice_Simple_Label                                =    "Simple",
    Mode_Choice_Simple_Tooltip                              =    "",
    Mode_Choice_Advanced_Label                              =    "Advanced",
    Mode_Choice_Advanced_Tooltip                            =    "",
    TierThreshold_Choice_Tier2_Label                        =    "Tier 2",
    TierThreshold_Choice_Tier2_Tooltip                      =    "",
    TierThreshold_Choice_Tier1_Label                        =    "Tier 1",
    TierThreshold_Choice_Tier1_Tooltip                      =    "",
    TierThreshold_Choice_Tier4_Label                        =    "Tier 4",
    TierThreshold_Choice_Tier4_Tooltip                      =    "",
    TierThreshold_Choice_Any_Label                          =    "Any",
    TierThreshold_Choice_Any_Tooltip                        =    "",
    TierThreshold_Choice_Tier3_Label                        =    "Tier 3",
    TierThreshold_Choice_Tier3_Tooltip                      =    "",
    QualityThreshold_Choice_Legendary_Label                 =    "Legendary",
    QualityThreshold_Choice_Legendary_Tooltip               =    "",
    QualityThreshold_Choice_Custom_Label                    =    "Custom",
    QualityThreshold_Choice_Custom_Tooltip                  =    "",
    QualityThreshold_Choice_Common_Label                    =    "Common",
    QualityThreshold_Choice_Common_Tooltip                  =    "",
    QualityThreshold_Choice_Epic_Label                      =    "Epic",
    QualityThreshold_Choice_Epic_Tooltip                    =    "",
    QualityThreshold_Choice_Uncommon_Label                  =    "Uncommon",
    QualityThreshold_Choice_Uncommon_Tooltip                =    "",
    QualityThreshold_Choice_Any_Label                       =    "Any",
    QualityThreshold_Choice_Any_Tooltip                     =    "",
    QualityThreshold_Choice_Rare_Label                      =    "Rare",
    QualityThreshold_Choice_Rare_Tooltip                    =    "",
    LootMode_Choice_Dice_Label                              =    "Dice",
    LootMode_Choice_Dice_Tooltip                            =    "",
    LootMode_Choice_NeedBeforeGreed_Label                   =    "Need before Greed",
    LootMode_Choice_NeedBeforeGreed_Tooltip                 =    "",
    LootMode_Choice_LootMaster_Label                        =    "Loot Master",
    LootMode_Choice_LootMaster_Tooltip                      =    "",
    LootMode_Choice_YayNay_Label                            =    "Yay/Nay",
    LootMode_Choice_YayNay_Tooltip                          =    "",
    LootMode_Choice_Random_Label                            =    "Random",
    LootMode_Choice_Random_Tooltip                          =    "",
    LootMode_Choice_RoundRobin_Label                        =    "Round-robin",
    LootMode_Choice_RoundRobin_Tooltip                      =    "",
    Weighting_Choice_Battleframe_Label                      =    "Battleframe",
    Weighting_Choice_Battleframe_Tooltip                    =    "",
    Weighting_Choice_Archetype_Label                        =    "Archetype",
    Weighting_Choice_Archetype_Tooltip                      =    "",
    Weighting_Choice_None_Label                             =    "None",
    Weighting_Choice_None_Tooltip                           =    "",
    RollType_Choice_Greed_Label                             =    "Greed",
    RollType_Choice_Greed_Tooltip                           =    "",
    RollType_Choice_Pass_Label                              =    "Pass",
    RollType_Choice_Pass_Tooltip                            =    "",
    RollType_Choice_Need_Label                              =    "Need",
    RollType_Choice_Need_Tooltip                            =    "",
    ColorModes_Choice_Custom_Label                          =    "Custom",
    ColorModes_Choice_Custom_Tooltip                        =    "",
    ColorModes_Choice_MatchItem_Label                       =    "Match Item",
    ColorModes_Choice_MatchItem_Tooltip                     =    "",
    TrackerVisibility_Choice_Always_Label                   =    "Always",
    TrackerVisibility_Choice_Always_Tooltip                 =    "",
    TrackerVisibility_Choice_MouseMode_Label                =    "Mousemode",
    TrackerVisibility_Choice_MouseMode_Tooltip              =    "",
    TrackerVisibility_Choice_HUD_Label                      =    "HUD",
    TrackerVisibility_Choice_HUD_Tooltip                    =    "",

    RadarEdgeModes_Choice_None_Label                        =    "None",
    RadarEdgeModes_Choice_None_Tooltip                      =    "None",
    RadarEdgeModes_Choice_Arrow_Label                       =    "Arrow",
    RadarEdgeModes_Choice_Arrow_Tooltip                     =    "Arrow",
    RadarEdgeModes_Choice_Icon_Label                        =    "Icon",
    RadarEdgeModes_Choice_Icon_Tooltip                      =    "Icon",


    TrackerTooltipModes_Choice_ProgressionStyle_Label       =    "Progression Style",
    TrackerTooltipModes_Choice_ProgressionStyle_Tooltip     =    "Progression Style",
    TrackerTooltipModes_Choice_ItemStyle_Label              =    "Items Style",
    TrackerTooltipModes_Choice_ItemStyle_Tooltip            =    "Items Style",

    TrackerPlateModeOptions_Choice_None_Label               =    "None",
    TrackerPlateModeOptions_Choice_None_Tooltip             =    "None",
    TrackerPlateModeOptions_Choice_Decorated_Label          =    "Decorated",
    TrackerPlateModeOptions_Choice_Decorated_Tooltip        =    "Decorated",
    TrackerPlateModeOptions_Choice_Simple_Label             =    "Simple",
    TrackerPlateModeOptions_Choice_Simple_Tooltip           =    "Simple",

    TrackerIconModeOptions_Choice_None_Label                =    "None",
    TrackerIconModeOptions_Choice_None_Tooltip              =    "None",
    TrackerIconModeOptions_Choice_Decorated_Label           =    "Decorated",
    TrackerIconModeOptions_Choice_Decorated_Tooltip         =    "Decorated",
    TrackerIconModeOptions_Choice_Simple_Label              =    "Simple",
    TrackerIconModeOptions_Choice_Simple_Tooltip            =    "Simple",
    TrackerIconModeOptions_Choice_IconOnly_Label            =    "IconOnly",
    TrackerIconModeOptions_Choice_IconOnly_Tooltip          =    "IconOnly",


    -- Subtabs
    Subtab_Distribution                                     =    "Distribution",
    Subtab_LootingRules                                     =    "Distribution",
    Subtab_Detection                                        =    "Detection",
    Subtab_Messages                                         =    "Messages",
    Subtab_Messages_Distribution                            =    "Distribution",
    Subtab_Messages_Detection                               =    "Detection",
    Subtab_Messages_Communication                           =    "Communication",
    Subtab_Markers                                          =    "Markers",
    Subtab_Panels                                           =    "Panels",
    Subtab_Waypoints                                        =    "Waypoints",
    Subtab_Tracker                                          =    "Tracker",
    Subtab_Sounds                                           =    "Sounds",
    Subtab_Communication                                    =    "Communication",
    Subtab_Filtering                                        =    "Filtering",


    -- Communication Options

    Group_Communication_Label                           = "Communication",
    Group_Communication_Tooltip                         = "Data communication between other players that use this addon",

    Communication_Custom_Label                          = "Enable Custom Communication Settings",
    Communication_Custom_Tooltip                        = "Warning: Changing these settings will prevent the addon from communicating with other players properly. Under normal circumstances, you shouldn't be touching them. You've been warned.",
    Communication_Send_Label                            = "Send",
    Communication_Send_Tooltip                          = "Master switch for Sending communication messages.",
    Communication_Receive_Label                         = "Receive",
    Communication_Receive_Tooltip                       = "Master switch for Receiveing communication messages.",

    Communication_Assign_Enabled_Label                  = "Assign",
    Communication_Assign_Enabled_Tooltip                = "Enable/Disable Assign",

    Communication_ItemIdentity_Enabled_Label            = "ItemIdentity",
    Communication_ItemIdentity_Enabled_Tooltip          = "Enable/Disable ItemIdentity",

    Communication_RollStart_Enabled_Label               = "RollStart",
    Communication_RollStart_Enabled_Tooltip             = "Enable/Disable RollStart",

    Communication_RollDecision_Enabled_Label            = "RollDecision",
    Communication_RollDecision_Enabled_Tooltip          = "Enable/Disable RollDecision",

    Communication_RollUpdate_Enabled_Label              = "RollUpdate",
    Communication_RollUpdate_Enabled_Tooltip            = "Enable/Disable RollUpdate",



    -- Sound choices
    Sounds_Option_none                                  =    "None",
    Sounds_Option_UI_Beep_06                            =    "Beep 06",
    Sounds_Option_UI_Beep_08                            =    "Beep 08",
    Sounds_Option_UI_Beep_09                            =    "Beep 09",
    Sounds_Option_UI_Beep_10                            =    "Beep 10",
    Sounds_Option_UI_Beep_12                            =    "Beep 12",
    Sounds_Option_UI_Beep_13                            =    "Beep 13",
    Sounds_Option_UI_Beep_20                            =    "Beep 20",
    Sounds_Option_UI_Beep_23                            =    "Beep 23",
    Sounds_Option_UI_Beep_26                            =    "Beep 26",
    Sounds_Option_UI_Beep_27                            =    "Beep 27",
    Sounds_Option_UI_Beep_35                            =    "Beep 35",
    Sounds_Option_UI_CharacterCreate_Confirm            =    "Character Create Confirm",
    Sounds_Option_UI_DailyRewardsScreen_Close           =    "Daily Rewards Close",
    Sounds_Option_UI_DailyRewardsScreen_Open            =    "Daily Rewards Open",
    Sounds_Option_UI_DailyRewardsScreen_ProgressShift   =    "Daily Rewards Progress",
    Sounds_Option_UI_DailyRewardsScreen_RewardGranted   =    "Daily Rewards Granted",
    Sounds_Option_UI_Friendly_Distress                  =    "Friendly Distress",
    Sounds_Option_UI_Garage_CPUUgrade                   =    "Garage CPU Upgrade",
    Sounds_Option_UI_Garage_MassUpgrade                 =    "Garage Mass Upgrade",
    Sounds_Option_UI_Garage_PowerUpgrade                =    "Garage Power Upgrade",
    Sounds_Option_UI_Garage_UnlockSlot                  =    "Garage Unlock Slot",
    Sounds_Option_UI_Interact_Available                 =    "Interact Available",
    Sounds_Option_UI_Intermission                       =    "Intermission",
    Sounds_Option_UI_Login                              =    "Login",
    Sounds_Option_UI_Login_Back                         =    "Login Back",
    Sounds_Option_UI_Login_Click                        =    "Login Click",
    Sounds_Option_UI_Login_Confirm                      =    "Login Confirm",
    Sounds_Option_UI_Login_Keystroke                    =    "Login Keystroke",
    Sounds_Option_UI_MapClose                           =    "Map Close",
    Sounds_Option_UI_MapMarker_GetFocus                 =    "Map Marker Get Focus",
    Sounds_Option_UI_MapMarker_LostFocus                =    "Map Marker Lost Focus",
    Sounds_Option_UI_MapOpen                            =    "Map Open",
    Sounds_Option_UI_Map_DetailClose                    =    "Map Detail Close",
    Sounds_Option_UI_Map_DetailOpen                     =    "Map Detail Open",
    Sounds_Option_UI_Map_ZoomIn                         =    "Map Zoom In",
    Sounds_Option_UI_Map_ZoomOut                        =    "Map Zoom Out",
    Sounds_Option_UI_NavWheel_Close                     =    "NavWheel Close",
    Sounds_Option_UI_NavWheel_MouseLeftButton           =    "NavWheel MouseLeftButton",
    Sounds_Option_UI_NavWheel_MouseLeftButton_Initiate  =    "NavWheel MouseLeftButton Initiate",
    Sounds_Option_UI_NavWheel_MouseRightButton          =    "NavWheel MouseRightButton",
    Sounds_Option_UI_NavWheel_MouseScroll               =    "NavWheel MouseScroll",
    Sounds_Option_UI_NavWheel_Open                      =    "NavWheel Open",
    Sounds_Option_UI_RewardNotification                 =    "Reward Notification",
    Sounds_Option_UI_RewardScreenOpen                   =    "Reward Screen Open",
    Sounds_Option_UI_RewardsAward                       =    "Rewards Award",
    Sounds_Option_UI_SINView_Mode                       =    "SINView Mode",
    Sounds_Option_UI_SIN_Acquired                       =    "SIN Acquired",
    Sounds_Option_UI_SIN_ExtraInfo_Off                  =    "SIN ExtraInfo Off",
    Sounds_Option_UI_SIN_ExtraInfo_On                   =    "SIN ExtraInfo On",
    Sounds_Option_UI_SlideNotification                  =    "Slide Notification",
    Sounds_Option_UI_Squad_Join                         =    "Squad Join",
    Sounds_Option_UI_Squad_Leave                        =    "Squad Leave",
    Sounds_Option_UI_StatsAward                         =    "StatsAward",
    Sounds_Option_UI_Ticker_1stStageIntro               =    "Ticker 1st Stage",
    Sounds_Option_UI_Ticker_2ndStageIntro               =    "Ticker 2nd Stage",
    Sounds_Option_UI_Ticker_LoudSecondTick              =    "Ticker Loud Second",
    Sounds_Option_UI_Ticker_LowPulse                    =    "Ticker Low Pulse",
    Sounds_Option_UI_Ticker_QuietSecondTick             =    "Ticker Quiet Second",
    Sounds_Option_UI_Ticker_ZeroTick                    =    "Ticker Zero",
    Sounds_Option_SFX_UI_AbilitySelect01_v4             =    "Ability Select 1",
    Sounds_Option_SFX_UI_AbilitySelect03_v4             =    "Ability Select 3",
    Sounds_Option_SFX_UI_AchievementEarned              =    "Achievement Earned",
    Sounds_Option_SFX_UI_Ding                           =    "Ding",
    Sounds_Option_SFX_UI_E_Initiate_Loop                =    "E Loop",
    Sounds_Option_SFX_UI_End                            =    "End",
    Sounds_Option_SFX_UI_FriendOffline                  =    "Friend Offline",
    Sounds_Option_SFX_UI_FriendOnline                   =    "Friend Online",
    Sounds_Option_SFX_UI_GeneralAnnouncement            =    "General Announcement",
    Sounds_Option_SFX_UI_GeneralConfirm14_v2            =    "General Confirm14",
    Sounds_Option_SFX_UI_Loot_Abilities                 =    "Loot Ability",
    Sounds_Option_SFX_UI_Loot_Backpack_Pickup           =    "Loot Backpack Pickup",
    Sounds_Option_SFX_UI_Loot_Basic                     =    "Loot Basic",
    Sounds_Option_SFX_UI_Loot_Battleframe_Pickup        =    "Loot Battleframe Pickup",
    Sounds_Option_SFX_UI_Loot_Crystite                  =    "Loot Crystite",
    Sounds_Option_SFX_UI_Loot_Flyover                   =    "Loot Flyover",
    Sounds_Option_SFX_UI_Loot_PowerUp                   =    "Loot PowerUp",
    Sounds_Option_SFX_UI_Loot_Weapon_Pickup             =    "Loot Weapon Pickup",
    Sounds_Option_SFX_UI_OCT_1MinWarning                =    "OCT 1 Min Warning",
    Sounds_Option_SFX_UI_SIN_CooldownFail               =    "SIN Cooldown Fail",
    Sounds_Option_SFX_UI_Ticker                         =    "Ticker",
    Sounds_Option_SFX_UI_TipPopUp                       =    "Tip PopUp",
    Sounds_Option_SFX_WebUI_Close                       =    "Web Close",
    Sounds_Option_SFX_WebUI_Equip_BackpackModule        =    "Web Equip Backpack Module",
    Sounds_Option_SFX_WebUI_Equip_Battleframe           =    "Web Equip Battleframe",
    Sounds_Option_SFX_WebUI_Equip_BattleframeModule     =    "Web Equip Battleframe Module",
    Sounds_Option_SFX_WebUI_Equip_Weapon                =    "Web Equip Weapon",
    Sounds_Option_SFX_WebUI_ModalWindow                 =    "Web Modal",
    Sounds_Option_SFX_WebUI_Open                        =    "Web Open",
    Sounds_Option_SFX_UI_WhisperTickle                  =    "Whisper Tickle",
    Sounds_Option_UI_ARESMIssions_Pickup_Generic01      =    "ARES Pickup Generic01",
    Sounds_Option_UI_Ability_Selection                  =    "Ability Selection",
    Sounds_Option_UI_Ability_Trigger                    =    "Ability Trigger",
    Sounds_Option_UI_VOIP_CloseChannel                  =    "VOIP Close Channel",
    Sounds_Option_UI_VOIP_OpenChannel                   =    "VOIP Open Channel",
    Sounds_Option_UI_ZoneSelect_Confirm                 =    "Zone Select Confirm",
    Sounds_Option_UI_sfx_warning_Ammo                   =    "Warning Ammo",
    Sounds_Option_ui_abilities_cooldown_complete        =    "Abilities Cooldown Complete",
    Sounds_Option_SFX_UI_E_Initiate_Loop_Fail           =    "E Fail",
    Sounds_Option_SFX_UI_E_Initiate_Loop_Success        =    "E Success",
    Sounds_Option_SlotMachine_PullLever                 =    "Slot Machine Pull Lever",
    Sounds_Option_SlotMachine_InsertCoin                =    "Slot Machine Insert Coin",
    Sounds_Option_SlotMachine_EpicDecryption            =    "Slot Machine Epic Decrypt",
    Sounds_Option_SlotMachine_Decryption                =    "Slot Machine Decrypt",
}
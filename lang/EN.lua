--[[
    Does this look messy to you?
    That's because it is!
--]]



-- Parameters used for the functions below



Simple             =    "Simple"




--[[
LootCategory
    Equipment
    Modules
    Salvage
    Components
    Consumable
    Currency
    Unknown



LootRarity
    Salvage
    Common
    Uncommon
    Rare
    Epic
    Prototype
    Legendary

--]]




Generic_MessageFormat = [[
Specify the format of the message. The following replacement variables exist, please note that they're not always available.
\nGeneral:
\n{itemName}
\n{itemRarity}
\n{itemLevel}
\n{itemReqLevel}
\nChat Only:
\n{itemAsLink}
\n{itemCoordLink}
\nLooted Items Only:
\n{lootedBy}
\n{lootedTo}
]]

LANG = {

    UI_AssignedTo_nil                                                               =    "Not yet assigned",
    UI_AssignedTo_false                                                             =    "Free for all",
    UI_AssignedTo_true                                                              =    "Free for all",
    UI_AssignedTo_Prefix                                                            =    "Assigned To: ",
    UI_Messages_System_NoRollableForDistribute                                      =    "No Rollable Loot to distribute",
    UI_Messages_System_NoIdentifiedForDistribute                                    =    "No Identified Loot to distribute",
    UI_Messages_Distribution_NobodyEligible                                         =    "No one",
    UI_Waypoints_Subtitle                                                           =    "Loot",


    -- Options
    Options_MoveableFrame_Tracker_Label                                                         =     "Xsear\'s Loot Tracker",

    Options_Group_Core_Label                                                                    =    "Xsear\'s Loot Tracker",
    Options_Core_Enabled_Label                                                                  =    "Enabled",
    Options_Core_Enabled_Tooltip                                                                =    "The addon will be enabled. This option is mainly suitable if you wish to tempoarily disable the addon, without modifying any other options. Please note that this doesn't truly stop the addon from functioning - it merely suppresses actions that would otherwise signify that the addon is active. If you are suspecting compatability issues with other addons, it would be better to tempoarily remove the addon in order to verify whether or not it is part of the issue.",
    Options_Core_VersionMessage_Label                                                           =    "Version Message",
    Options_Core_VersionMessage_Tooltip                                                         =    "Upon being loaded, the addon will send a System message announcing it is active, including its version number.",  
    Options_Core_SlashHandles_Label                                                             = "Slash Handles",
    Options_Core_SlashHandles_Tooltip                                                           = "<<WRITE ME>>",


    
    Options_Group_Features_Label                                                        =    "Features",


    Options_Tracker_TrackDelay_Label  = "Track Delay",
    Options_Tracker_TrackDelay_Toolip = "<<WRITE ME>>",
    Options_Tracker_UpdateDelay_Label  = "Update Delay",
    Options_Tracker_UpdateDelay_Toolip = "<<WRITE ME>>",
    Options_Tracker_RemoveDelay_Label  = "Remove Delay",
    Options_Tracker_RemoveDelay_Toolip = "<<WRITE ME>>",
    Options_Tracker_RefreshInterval_Label  = "Refresh Interval",
    Options_Tracker_RefreshInterval_Toolip = "<<WRITE ME>>",
    Options_Tracker_LootUpdateInterval_Label  = "Loot Update Interval",
    Options_Tracker_LootUpdateInterval_Toolip = "<<WRITE ME>>",
    Options_Tracker_LootEventHistoryCleanupInterval_Label  = "LootEvent History Cleanup Interval",
    Options_Tracker_LootEventHistoryCleanupInterval_Toolip = "<<WRITE ME>>",
    Options_Tracker_LootEventHistoryLifetime_Label  = "LootEvent History Lifetime",
    Options_Tracker_LootEventHistoryLifetime_Toolip = "<<WRITE ME>>",


    Options_Filtering_Simple_Enabled_Label                                              =    "Simple",
    Options_Filtering_Simple_Enabled_Tooltip                                            =    "If in Simple configuration mode, only these settings are used.",

    Options_Filtering_Mode_Label                                                       =    "Configuration Mode",
    Options_Filtering_Mode_Tooltip                                                     =    "Simple or Advanced configuration mode.",


    Options_Dropdown_Mode_Choice_simple_Label       = "Simple",
    Options_Dropdown_Mode_Choice_simple_Tooltip     = "<<WRITE ME>>",
    Options_Dropdown_Mode_Choice_advanced_Label     = "Advanced",
    Options_Dropdown_Mode_Choice_advanced_Tooltip   = "<<WRITE ME>>",

    Options_Filtering_equipment_Enabled_Label               = "Equipment Enabled",
    Options_Filtering_equipment_Enabled_Tooltip             = "Equipment Enabled",
    Options_Filtering_modules_Enabled_Label                 = "Modules Enabled",
    Options_Filtering_modules_Enabled_Tooltip               = "Modules Enabled",
    Options_Filtering_salvage_Enabled_Label                 = "Salvage Enabled",
    Options_Filtering_salvage_Enabled_Tooltip               = "Salvage Enabled",
    Options_Filtering_components_Enabled_Label              = "Components Enabled",
    Options_Filtering_components_Enabled_Tooltip            = "Components Enabled",
    Options_Filtering_consumable_Enabled_Label              = "Consumable Enabled",
    Options_Filtering_consumable_Enabled_Tooltip            = "Consumable Enabled",
    Options_Filtering_currency_Enabled_Label                = "Currency Enabled",
    Options_Filtering_currency_Enabled_Tooltip              = "Currency Enabled",
    Options_Filtering_unknown_Enabled_Label                 = "Unknown Enabled",
    Options_Filtering_unknown_Enabled_Tooltip               = "Unknown Enabled",
    Options_Filtering_salvage_Enabled_Label                 = "Salvage Enabled",
    Options_Filtering_salvage_Enabled_Tooltip               = "Salvage Enabled",
    Options_Filtering_common_Enabled_Label                  = "Common Enabled",
    Options_Filtering_common_Enabled_Tooltip                = "Common Enabled",
    Options_Filtering_uncommon_Enabled_Label                = "Uncommon Enabled",
    Options_Filtering_uncommon_Enabled_Tooltip              = "Uncommon Enabled",
    Options_Filtering_rare_Enabled_Label                    = "Rare Enabled",
    Options_Filtering_rare_Enabled_Tooltip                  = "Rare Enabled",
    Options_Filtering_epic_Enabled_Label                    = "Epic Enabled",
    Options_Filtering_epic_Enabled_Tooltip                  = "Epic Enabled",
    Options_Filtering_prototype_Enabled_Label               = "Prototype Enabled",
    Options_Filtering_prototype_Enabled_Tooltip             = "Prototype Enabled",
    Options_Filtering_legendary_Enabled_Label               = "Legendary Enabled",
    Options_Filtering_legendary_Enabled_Tooltip             = "Legendary Enabled",


    Options_Filtering_RarityThreshold_Label             = "Rarity Threshold",
    Options_Filtering_RarityThreshold_Tooltip         = "<<WRITE ME>>",
    Options_Filtering_ItemLevelThreshold_Label          = "Item Level Threshold",
    Options_Filtering_ItemLevelThreshold_Tooltip      = "<<WRITE ME>>",
    Options_Filtering_RequiredLevelThreshold_Label      = "Required Level Threshold",
    Options_Filtering_RequiredLevelThreshold_Tooltip  = "<<WRITE ME>>",


    




    Options_Messages_Generic_Channels_Squad_Enabled_Label                                   =    "Send Squad Message",
    Options_Messages_Generic_Channels_Squad_Enabled_Tooltip                                 =    "Send message to Squad on this event",
    Options_Messages_Generic_Channels_Squad_Format_Label                                    =    "Squad Message Format",
    Options_Messages_Generic_Channels_Squad_Format_Tooltip                                  =    Generic_MessageFormat,

    Options_Messages_Generic_Channels_Platoon_Enabled_Label                                   =    "Send Platoon Message",
    Options_Messages_Generic_Channels_Platoon_Enabled_Tooltip                                 =    "Send message to Platoon on this event",
    Options_Messages_Generic_Channels_Platoon_Format_Label                                    =    "Platoon Message Format",
    Options_Messages_Generic_Channels_Platoon_Format_Tooltip                                  =    Generic_MessageFormat,

    Options_Messages_Generic_Channels_System_Enabled_Label                                  =    "Send System Message",
    Options_Messages_Generic_Channels_System_Enabled_Tooltip                                =    "Send message to System on this event",
    Options_Messages_Generic_Channels_System_Format_Label                                   =    "System Message Format",

    Options_Messages_Generic_Channels_System_Format_Tooltip                                 =    Generic_MessageFormat,

    Options_Messages_Generic_Channels_Notifications_Enabled_Label                           =    "Send Notifications Message",
    Options_Messages_Generic_Channels_Notifications_Enabled_Tooltip                         =    "Send message to Notifications on this event",
    Options_Messages_Generic_Channels_Notifications_Format_Label                            =    "Notifications Message Format",

    Options_Messages_Generic_Channels_Notifications_Format_Tooltip                          =    Generic_MessageFormat,

    
    Options_Messages_Enabled_Label                                                          =    "Enable Messages",
    Options_Messages_Enabled_Tooltip                                                        =    "The addon will send customizable Messages to the Chat when certain events occur, keeping you and your Squad members in the loop of what is going on with the item drops.",
    Options_Messages_Prefix_Label                                                           =    "Generic Prefix",
    Options_Messages_Prefix_Tooltip                                                         =    "Set the prefix for all public facing messages.",
    Options_Messages_Channels_Squad_Label                                                   =    "Send on Squad Channel",
    Options_Messages_Channels_Squad_Tooltip                                                 =    "Master switch for Squad messages. The addon will not send ANY squad messages if this is checked, regardless of other settings.",

    Options_Messages_Channels_Platoon_Label                                                 =  "Send on Platoon Channel",
    Options_Messages_Channels_Platoon_Tooltip                                               =  "Master switch for Squad messages. The addon will not send ANY platoon messages if this is checked, regardless of other settings.",

    Options_Messages_Channels_Notifications_Label                                           =    "Send on Notifications Channel",
    Options_Messages_Channels_Notifications_Tooltip                                         =    "Master switch for Notification messages. The addon will not send ANY notification messages if this is checked, regardless of other settings.",
    Options_Messages_Channels_System_Label                                                  =    "Send on System Channel",
    Options_Messages_Channels_System_Tooltip                                                =    "Master switch for System messages. The addon will not send ANY system messages if this is checked, regardless of other settings.",



    Options_Messages_Events_Tracker_OnLootClaimed_Enabled_Label                               =    "Loot Claimed",
    Options_Messages_Events_Tracker_OnLootClaimed_Enabled_Tooltip                             =    "When somebody loots an item that the addon had not found",

    Options_Messages_Events_Tracker_OnLootLost_Enabled_Label                               =    "Loot Lost",
    Options_Messages_Events_Tracker_OnLootLost_Enabled_Tooltip                             =    "When a tracked item disappears without being looted / despawns",

    Options_Messages_Events_Tracker_OnLootLooted_Enabled_Label                              =    "Loot Looted",
    Options_Messages_Events_Tracker_OnLootLooted_Enabled_Tooltip                            =    "When someone who won an item loots that item",

    Options_Messages_Events_Tracker_OnLootNew_Enabled_Label                                  =    "Loot Detected",
    Options_Messages_Events_Tracker_OnLootNew_Enabled_Tooltip                                =    "When the addon has discovered a new item",




    Options_Panels_Enabled_Label                                                                =    "Enable Panels",
    Options_Panels_Enabled_Tooltip                                                              =    "The addon will attach Panels onto item drops, allowing you to inspect the item in detail when up close.",


    Options_Panels_Display_AssignedTo_Label                                                     =    "Display AssignedTo",
    Options_Panels_Display_AssignedTo_Tooltip                                                   =    "Display who the item has been assigned to on the panel header.",
    Options_Panels_Display_AssignedToHideNil_Label                                              =    "Hide AssignedTo Not assigned",
    Options_Panels_Display_AssignedToHideNil_Tooltip                                            =    "Only show AssignedTo text when item has been assigned - don\'t display \"Not assigned\".",

    Options_Panels_Mode_Label                               =    "Mode",
    Options_Panels_Mode_Tooltip                             =    "Overall Panel display mode\nStandard: Full view\nSmall: Only header is shown", Panels_ColorMode_ItemName_Label                                                      =    "Item Name Color",
    Options_Panels_ColorMode_ItemName_Tooltip                                                    =    "Set the color of the item name text on the panel header.",
    Options_Panels_ColorMode_ItemNameCustomValue_Label                                           =    "Custom Item Name Color",    Panels_ColorMode_ItemNameCustomValue_Tooltip                                         =    "Set the color of the item name text on the panel header for the Custom option.",    Panels_ColorMode_HeaderBar_Label                                                     =    "Header Color",
    Options_Panels_ColorMode_HeaderBar_Tooltip                                                   =    "Set the color of the background of the panel header.",
    Options_Panels_ColorMode_HeaderBarCustomValue_Label                                          =    "Custom Header Color",
    Options_Panels_ColorMode_HeaderBarCustomValue_Tooltip                                        =    "Set the color of the background of the panel header for the Custom option.",


    Options_Panels_Color_AssignedTo_Nil_Label                                             =    "AssignedTo Color Not assigned",
    Options_Panels_Color_AssignedTo_Nil_Tooltip                                           =    "Set the color of the Assigned To text when the item has not been assigned.",
    Options_Panels_Color_AssignedTo_Free_Label                                            =    "AssignedTo Color Free for all",
    Options_Panels_Color_AssignedTo_Free_Tooltip                                          =    "Set the color of the Assigned To text when the item has been declared free for all.",
    Options_Panels_Color_AssignedTo_Player_Label                                          =    "AssignedTo Color For you",
    Options_Panels_Color_AssignedTo_Player_Tooltip                                        =    "Set the color of the Assigned To text when the item has been assigned to you.",
    Options_Panels_Color_AssignedTo_Other_Label                                           =    "AssignedTo Color For other",
    Options_Panels_Color_AssignedTo_Other_Tooltip                                         =    "Set the color of the Assigned To text when the item has been assigned to someone else.",


    Options_Detection_IdentifyDelay_Label                                                       =    "Tracking Delay",
    Options_Detection_IdentifyDelay_Tooltip                                                     =    "The number of seconds the addon should wait after detecting a new lootable item before it begins to track it. Lower values feel better, but make the addon more prone to glitches caused by unexpected behavior from the game client.",

    Options_Detection_DespawnCheckInterval_Label                                                =    "Despawn Check Interval",
    Options_Detection_DespawnCheckInterval_Tooltip                                              =    "How often the addon should check that a tracked item is still in the game world. This is only used to discover that an item has dissappeared through some other means than being looted. Lower values  will lead to speedier removal of incorrectly detected items, but are for correctly detected items fairly wasteful.",


    Options_Waypoints_Enabled_Label                                                             =    "Enable Waypoints",
    Options_Waypoints_Enabled_Tooltip                                                           =    "The addon will attach Waypoints to tracked items, helping you quickly locate drops over larger distances.",

    Options_Waypoints_ShowOnHud_Label                       =    "Show On Hud",
    Options_Waypoints_ShowOnHud_Tooltip                     =    "Show Waypoints on the HUD",
    Options_Waypoints_ShowOnWorldMap_Label                  =    "Show On WorldMap",
    Options_Waypoints_ShowOnWorldMap_Tooltip                =    "Show Waypoints on the World Map",
    Options_Waypoints_ShowOnRadar_Label                     =    "Show On Radar",
    Options_Waypoints_ShowOnRadar_Tooltip                   =    "Show Waypoints on the Radar",
    Options_Waypoints_TrailAssigned_Label                   =    "Trail when loot is assigned to me",
    Options_Waypoints_TrailAssigned_Tooltip                 =    "When an item is assigned to you, the navigation trail is set to its waypoint. Requires 'Display Navigation' setting in 'Gameplay' options checked.",
    Options_Waypoints_PingAssigned_Label                    =    "Ping when loot is assigned to me",
    Options_Waypoints_PingAssigned_Tooltip                  =    "When an item is assigned to you, its waypoint will be pinged - drawing attention to it.",                          


    Options_Waypoints_RadarEdgeMode_Label                   =    "Radar Edge Mode",
    Options_Waypoints_RadarEdgeMode_Tooltip                 =    "Behavior for Waypoint icons on the radar when outside range and the icon attaches to the radar edge\nNone : Hidden \nArrow: Nonspecific arrow icon \nIcon : Keep showing the same icon",



    Options_Debug_Enabled_Label                                                                 =    "Debug",
    Options_Debug_Enabled_Tooltip                                                               =    "The addon will enter Debug mode, logging messages in the console that are helpful for the addon creator in order to track down problems. Additional Debug options in this group will also become available.",

    Options_Debug_FakeOnSquadRoster_Label                                                       =    "Fake Squad Roster",
    Options_Debug_FakeOnSquadRoster_Tooltip                                                     =    "If not in a squad but override squad leader, put fake squad members in the roster",
    Options_Debug_SquadToArmy_Label                                                             =    "Squad To Army",
    Options_Debug_SquadToArmy_Tooltip                                                           =    "Redirect messages on Squad channel to Army",
    Options_Debug_UndefinedFilterArguments_Label                                                =    "Undefined Filter Arguments",
    Options_Debug_UndefinedFilterArguments_Tooltip                                              =    "Output NOT_SET when filter arguments are undefined, rather than an empty string.",
    Options_Debug_LogLootableTargets_Label                                                      =    "Log Loot Detected",
    Options_Debug_LogLootableTargets_Tooltip                                                    =    "Extra debug messages, spammy.\nLogs info on detected items, helpful when errors are occuring during item detection.",
    Options_Debug_LogLootableCollection_Label                                                   =    "Log Loot Collected",
    Options_Debug_LogLootableCollection_Tooltip                                                 =    "Extra debug messages, spammy.\nLogs info on looted items, helpful when errors are occuring during item removal.",
    Options_Debug_LogOptionChange_Label                                                         =    "Log Option Changes",
    Options_Debug_LogOptionChange_Tooltip                                                       =    "Extra debug messages, spammy.\nLogs option changes, helpful when errors are occuring with the interface options.",

    Options_Debug_CommunicationExtra_Label                                                      =    "Log Communication Extra",
    Options_Debug_CommunicationExtra_Tooltip                                                    =    "Extra Communication messages, spammy.\nLogs encoding and decoding of communication links more closely, helpful when errors are occuring in this department.",

    Options_Debug_RoundRobin_Label                                                      =    "Log Round Robin",
    Options_Debug_RoundRobin_Tooltip                                                    =    "Extra logging for Round Robin, spammy.\nDetailed logging of Round Robin logic, helpful if its giving out unexpected results.",


    Options_Sounds_Enabled_Label                                                                =    "Enable Sounds",
    Options_Sounds_Enabled_Tooltip                                                              =    "The addon will play sounds in order to notify you when certain events occur.",
    
    Options_Sounds_Mute_Label                               =    "Mute",
    Options_Sounds_Mute_Tooltip                             =    "If checked, no sounds will play",
    Options_Sounds_OnIdentify_Label                         =    "Item Detected",
    Options_Sounds_OnIdentifyRollable_Label                 =    "NYI?",
    Options_Sounds_OnAssignItemToMe_Label                   =    "Item Assigned To You",
    Options_Sounds_OnAssignItemToOther_Label                =    "Item Assigned To Other",

    Options_HUDTracker_Enabled_Label                           =    "Enable Tracker",
    Options_HUDTracker_Enabled_Tooltip                         =    "The addon will display information about currently tracked item drops, allowing you to keep track of things at a glance, as well as to perform actions with ease, or inspect the items in more detail, when in mousemode.",

    Options_HUDTracker_Visibility_Label                        =    "Visibility",
    Options_HUDTracker_Visibility_Tooltip                      =    "When to display the tracker.\nAlways - I wanna be with you~\nHUD - Follow suit with rest of HUD\nMousemode - Only when in Mousemode",


    Options_HUDTracker_Tooltip_Enabled_Label           =  "Enable Tooltips",
    Options_HUDTracker_Tooltip_Enabled_Tooltip         =  "When hovering over an entry in the Tracker list, a tooltip representation of the item will be displayed on the cursor.",
    Options_HUDTracker_PlateMode_Label                 =  "Plate Style",
    Options_HUDTracker_PlateMode_Tooltip               =  "Changes the look of the plate of entries in the Tracker.",
    Options_HUDTracker_IconMode_Label                  =  "Icon Style ",
    Options_HUDTracker_IconMode_Tooltip                =  "Changes the look of the item icon of entries in the Tracker. ",



    -- Subtabs
    Options_Subtab_Messages                                         =    "Messages",
    Options_Subtab_Messages_Tracker                                 =    "Tracker",
    Options_Subtab_Markers                                          =    "Markers",
    Options_Subtab_Panels                                           =    "Panels",
    Options_Subtab_Waypoints                                        =    "Waypoints",
    Options_Subtab_Tracker                                          =    "Tracker",
    Options_Subtab_HUDTracker                                       =    "HUDTracker",
    Options_Subtab_Sounds                                           =    "Sounds",
    Options_Subtab_Filtering                                        =    "Filtering",

    Options_Subtab_equipment    = "Equipment",
    Options_Subtab_modules      = "Modules",
    Options_Subtab_salvage      = "Salvage",
    Options_Subtab_components   = "Components",
    Options_Subtab_consumable   = "Consumable",
    Options_Subtab_currency     = "Currency",
    Options_Subtab_unknown      = "Unknown",














    -- Dropdown Choices
    -- Due to some issues these have really bad names that I hope to correct at some point.



    Options_Dropdown_RarityThreshold_Choice_salvage_Label             = "Salvage",
    Options_Dropdown_RarityThreshold_Choice_salvage_Tooltip           = "<<WRITE ME>>",
    Options_Dropdown_RarityThreshold_Choice_common_Label              = "Common",
    Options_Dropdown_RarityThreshold_Choice_common_Tooltip            = "<<WRITE ME>>",
    Options_Dropdown_RarityThreshold_Choice_uncommon_Label            = "Uncommon",
    Options_Dropdown_RarityThreshold_Choice_uncommon_Tooltip          = "<<WRITE ME>>",
    Options_Dropdown_RarityThreshold_Choice_rare_Label                = "Rare",
    Options_Dropdown_RarityThreshold_Choice_rare_Tooltip              = "<<WRITE ME>>",
    Options_Dropdown_RarityThreshold_Choice_epic_Label                = "Epic",
    Options_Dropdown_RarityThreshold_Choice_epic_Tooltip              = "<<WRITE ME>>",
    Options_Dropdown_RarityThreshold_Choice_prototype_Label           = "Prototype",
    Options_Dropdown_RarityThreshold_Choice_prototype_Tooltip         = "<<WRITE ME>>",
    Options_Dropdown_RarityThreshold_Choice_legendary_Label           = "Legendary",
    Options_Dropdown_RarityThreshold_Choice_legendary_Tooltip         = "<<WRITE ME>>",



    Mode_Choice_Simple_Label                                =    "Simple",
    Mode_Choice_Simple_Tooltip                              =    "",
    Mode_Choice_Advanced_Label                              =    "Advanced",
    Mode_Choice_Advanced_Tooltip                            =    "",

    Options_Dropdown_ColorModes_Choice_custom_Label                          =    "Custom",
    Options_Dropdown_ColorModes_Choice_custom_Tooltip                        =    "",
    Options_Dropdown_ColorModes_Choice_matchitem_Label                       =    "Match Item",
    Options_Dropdown_ColorModes_Choice_matchitem_Tooltip                     =    "",

    Options_Dropdown_RadarEdgeModes_Choice_0_Label                        =    "None", -- none
    Options_Dropdown_RadarEdgeModes_Choice_0_Tooltip                      =    "None", -- none
    Options_Dropdown_RadarEdgeModes_Choice_1_Label                       =    "Arrow", -- arrow
    Options_Dropdown_RadarEdgeModes_Choice_1_Tooltip                     =    "Arrow", -- arrow
    Options_Dropdown_RadarEdgeModes_Choice_2_Label                        =    "Icon", -- icon
    Options_Dropdown_RadarEdgeModes_Choice_2_Tooltip                      =    "Icon", -- icon

    Options_Dropdown_HUDTrackerVisibility_Choice_always_Label                   =    "Always",
    Options_Dropdown_HUDTrackerVisibility_Choice_always_Tooltip                 =    "",
    Options_Dropdown_HUDTrackerVisibility_Choice_mousemode_Label                =    "Mousemode",
    Options_Dropdown_HUDTrackerVisibility_Choice_mousemode_Tooltip              =    "",
    Options_Dropdown_HUDTrackerVisibility_Choice_hud_Label                      =    "HUD",
    Options_Dropdown_HUDTrackerVisibility_Choice_hud_Tooltip                    =    "",

    Options_Dropdown_HUDTrackerPlateModeOptions_Choice_none_Label               =    "None",
    Options_Dropdown_HUDTrackerPlateModeOptions_Choice_none_Tooltip             =    "None",
    Options_Dropdown_HUDTrackerPlateModeOptions_Choice_decorated_Label          =    "Decorated",
    Options_Dropdown_HUDTrackerPlateModeOptions_Choice_decorated_Tooltip        =    "Decorated",
    Options_Dropdown_HUDTrackerPlateModeOptions_Choice_simple_Label             =    "Simple",
    Options_Dropdown_HUDTrackerPlateModeOptions_Choice_simple_Tooltip           =    "Simple",

    Options_Dropdown_HUDTrackerIconModeOptions_Choice_none_Label                =    "None",
    Options_Dropdown_HUDTrackerIconModeOptions_Choice_none_Tooltip              =    "None",
    Options_Dropdown_HUDTrackerIconModeOptions_Choice_decorated_Label           =    "Decorated",
    Options_Dropdown_HUDTrackerIconModeOptions_Choice_decorated_Tooltip         =    "Decorated",
    Options_Dropdown_HUDTrackerIconModeOptions_Choice_simple_Label              =    "Simple",
    Options_Dropdown_HUDTrackerIconModeOptions_Choice_simple_Tooltip            =    "Simple",
    Options_Dropdown_HUDTrackerIconModeOptions_Choice_iconOnly_Label            =    "IconOnly",
    Options_Dropdown_HUDTrackerIconModeOptions_Choice_iconOnly_Tooltip          =    "IconOnly",

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
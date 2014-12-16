--[[
    Does this look messy to you?
    That's because it is!
--]]



-- Parameters used for the functions below



Simple             =    "Simple"




--[[


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
The following replacement variables exist, please note that some may only apply under certain conditions.
General:
  {itemName}
  {itemRarity}
  {itemLevel}
  {itemReqLevel}
Chat Only:
  {itemAsLink}
  {itemCoordLink}
Looted Items Only:
  {lootedBy}
  {lootedTo}
]]



SystemMessagePrefix = "[xLT]: "

LANG = {

    -- System Messages
    SystemMessage_Prefix = "[xLT]: ",
    SystemMessage_Tracker_HitLimit = "Hit the limit on number of tracked items!",


    -- UI
    UI_Waypoints_Subtitle                                                           =    "Loot",


    -- Options
    Options_MoveableFrame_Tracker_Label                                                         =     "Xsear\'s Loot Tracker",

    Options_Group_Core_Label                                                                    =    "Xsear\'s Loot Tracker",
    Options_Core_Enabled_Label                                                                  =    "Enabled",
    Options_Core_Enabled_Tooltip                                                                =    "The addon will be enabled. This option is mainly suitable if you wish to tempoarily disable the addon, without modifying any other options. Please note that this doesn't truly stop the addon from functioning - it merely suppresses actions that would otherwise signify that the addon is active. If you are suspecting compatability issues with other addons, it would be better to tempoarily remove the addon in order to verify whether or not it is part of the issue.",
    Options_Core_VersionMessage_Label                                                           =    "Version Message",
    Options_Core_VersionMessage_Tooltip                                                         =    "Upon being loaded, the addon will send a System message announcing it is active, including its version number.",  
    Options_Core_SlashHandles_Label                                                             = "Slash Handles",
    Options_Core_SlashHandles_Tooltip                                                           = "The slash handles that the addon will register for. Requires that you reload the UI to update.",


    
    Options_Group_Features_Label                                                        =    "Features",


    Options_Tracker_TrackDelay_Label  = "Track Delay",
    Options_Tracker_TrackDelay_Tooltip = "Upon detecting a new item, how long to wait before starting the procedure to begin tracking it. A delay is recommended because the game sometimes gives out incorrect information, and by waiting a little before taking action those can be weeded out. However, the delay is quite noticeable when playing, so a lower value feels better.",
    Options_Tracker_UpdateDelay_Label  = "Update Delay",
    Options_Tracker_UpdateDelay_Tooltip = "Serves little purpose. Keep it low.",
    Options_Tracker_RemoveDelay_Label  = "Remove Delay",
    Options_Tracker_RemoveDelay_Tooltip = "How long to wait before removing an item after it has been looted or has despawned. A short delay is neccessary for other parts of the addon to work properly. A long delay serves no real purpose at this point.",
    Options_Tracker_Limit_Label = "Limit",
    Options_Tracker_Limit_Tooltip = "The maximum number of loot drops to be tracking at once. As long as the number of loot drops on the ground exceeds this Limit, the Tracker will ignore new loot drops. The purpose of this setting is to serve as a safeguard in the event that something ridiculous happens. The ideal limit is therefore a value for which during normal gameplay is either just high enough not to bother you, or low enough to stop you from lagging.", 

    Options_Tracker_RefreshInterval_Label  = "Unified Update Interval",
    Options_Tracker_RefreshInterval_Tooltip = "How often to verify the continued availability of all tracked loot drops. If everything is working properly, a short delay serves little purpose and a longer delay should be used. However, with a shorter delay, potential missdetections will be cleared more swiftly.",

    Options_Tracker_LootUpdateInterval_Label  = "Individual Update Interval",
    Options_Tracker_LootUpdateInterval_Tooltip = "How often to verify the continued availability of each tracked loot drop. If everything is working properly, a short delay serves little purpose and a longer delay could be used. However, with a shorter delay, potential missdetections will be cleared more swiftly.",

    Options_Tracker_LootEventHistoryCleanupInterval_Label  = "Loot Event History Cleanup Interval",
    Options_Tracker_LootEventHistoryCleanupInterval_Tooltip = "How often to check the history of lootevents and cleanup those that have expired. A longer interval might be more performance efficient, but it could cause issues with the tracking of items.",
    Options_Tracker_LootEventHistoryLifetime_Label  = "Loot Event History Lifetime",
    Options_Tracker_LootEventHistoryLifetime_Tooltip = "How long a lootevent should be valid for. A shorter lifetime should result in better accuracy when multiple items of the same kind are picked up in a short timespan, but too short may cause the addon to think items have despawned when they were looted. Longer timespans prevent the aforementioned issue, but may result in reduced accuracy in the aforementioned scenario.",


    Options_Tracker_IgnoreCrystite_Label  = "Ignore Currency Crystite",
    Options_Tracker_IgnoreCrystite_Tooltip = "When enabled, the Tracker ignores Crytite. Otherwise, it is tracked under the currency category. That category was added to track stuff like Crystite Resonators.",

    Options_Tracker_IgnoreMetalsTornado_Label  = "Ignore Metals in Tornado",
    Options_Tracker_IgnoreMetalsTornado_Tooltip = "When enabled, the Tracker ignores any Metals when you are inside a (known) Melding Tornado Pocket.",

    Options_Filtering_Simple_Enabled_Label                                              =    "Simple",
    Options_Filtering_Simple_Enabled_Tooltip                                            =    "If in Simple configuration mode, only these settings are used.",

    Options_Filtering_Mode_Label                                                       =    "Configuration Mode",
    Options_Filtering_Mode_Tooltip                                                     =    "Simple or Advanced configuration mode. In Simple mode, only the options in the Simple group apply. In Advanced mode, you can disable different rarities individually or set different level thresholds or text formats for them.",


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
    Options_Filtering_metals_Enabled_Label                  = "Metals Enabled",
    Options_Filtering_metals_Enabled_Tooltip                = "Metals Enabled",
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
    Options_Filtering_RarityThreshold_Tooltip         = "The minimum Rarity that an item must have in order for this to apply.",
    Options_Filtering_ItemLevelThreshold_Label          = "Item Level Threshold",
    Options_Filtering_ItemLevelThreshold_Tooltip      = "The minimum Item Level that an item must have in order for this to apply.",
    Options_Filtering_RequiredLevelThreshold_Label      = "Required Level Threshold",
    Options_Filtering_RequiredLevelThreshold_Tooltip  = "The minimum Required level that an item have in order for this to apply.",


    
    Options_Filtering_WaypointTitle_Label = "Waypoint Title Format",
    Options_Filtering_WaypointTitle_Tooltip = "Customize the title of the waypoints.\n"..Generic_MessageFormat,
    Options_Filtering_HUDTrackerTitle_Label = "HUDTracker Title Format",
    Options_Filtering_HUDTrackerTitle_Tooltip = "Customize the title of each entry in the hudtracker.\n"..Generic_MessageFormat,

    Options_Filtering_SoundsNewLoot_Label = "Sound Notification",
    Options_Filtering_SoundsNewLoot_Tooltip = "",



    Options_Messages_Generic_Channels_Squad_Enabled_Label                                   =    "Send Squad Message",
    Options_Messages_Generic_Channels_Squad_Enabled_Tooltip                                 =    "Send message to Squad on this event",
    Options_Messages_Generic_Channels_Squad_Format_Label                                    =    "Squad Message Format",
    Options_Messages_Generic_Channels_Squad_Format_Tooltip                                  =    "Specify the format of the Squad message.\n"..Generic_MessageFormat,

    Options_Messages_Generic_Channels_Platoon_Enabled_Label                                   =    "Send Platoon Message",
    Options_Messages_Generic_Channels_Platoon_Enabled_Tooltip                                 =    "Send message to Platoon on this event",
    Options_Messages_Generic_Channels_Platoon_Format_Label                                    =    "Platoon Message Format",
    Options_Messages_Generic_Channels_Platoon_Format_Tooltip                                  =    "Specify the format of the Platoon message.\n"..Generic_MessageFormat,

    Options_Messages_Generic_Channels_System_Enabled_Label                                  =    "Send System Message",
    Options_Messages_Generic_Channels_System_Enabled_Tooltip                                =    "Send message to System on this event",
    Options_Messages_Generic_Channels_System_Format_Label                                   =    "System Message Format",

    Options_Messages_Generic_Channels_System_Format_Tooltip                                 =    "Specify the format of the System message.\n"..Generic_MessageFormat,

    Options_Messages_Generic_Channels_Notifications_Enabled_Label                           =    "Send Notifications Message",
    Options_Messages_Generic_Channels_Notifications_Enabled_Tooltip                         =    "Send message to Notifications on this event",
    Options_Messages_Generic_Channels_Notifications_Format_Label                            =    "Notifications Message Format",

    Options_Messages_Generic_Channels_Notifications_Format_Tooltip                          =    "Specify the format of the Notifications message.\n"..Generic_MessageFormat,

    Options_Messages_Generic_IgnoreOthers_Label = "Ignore Others",
    Options_Messages_Generic_IgnoreOthers_Tooltip = "If checked, the message will not be sent unless the event is triggered by the local player.",

    Options_Messages_Enabled_Label                                                          =    "Enable Messages",
    Options_Messages_Enabled_Tooltip                                                        =    "The addon will send customizable Messages to the Chat when certain events occur, keeping you and your Squad members in the loop of what is going on with the item drops.",
    Options_Messages_Prefix_Label                                                           =    "Generic Prefix",
    Options_Messages_Prefix_Tooltip                                                         =    "Set the prefix for all public facing messages.",
    Options_Messages_Channels_Squad_Label                                                   =    "Send on Squad Channel",
    Options_Messages_Channels_Squad_Tooltip                                                 =    "Master switch for Squad messages. The addon will not send event squad messages if this is unchecked, regardless of other settings.",

    Options_Messages_Channels_Platoon_Label                                                 =  "Send on Platoon Channel",
    Options_Messages_Channels_Platoon_Tooltip                                               =  "Master switch for Squad messages. The addon will not send event platoon messages if this is unchecked, regardless of other settings.",

    Options_Messages_Channels_Notifications_Label                                           =    "Send on Notifications Channel",
    Options_Messages_Channels_Notifications_Tooltip                                         =    "Master switch for Notification messages. The addon will not send event notification messages if this is unchecked, regardless of other settings.",
    Options_Messages_Channels_System_Label                                                  =    "Send on System Channel",
    Options_Messages_Channels_System_Tooltip                                                =    "Master switch for System messages. The addon will not send event system messages if this is unchecked, regardless of other settings.",


    Options_Messages_OnlyWhenSquadLeader_Label                      =  "Send on Squad only when Leader",
    Options_Messages_OnlyWhenSquadLeader_Tooltip                    =  "When checked, messages will not be sent on the Squad channel unless you are the Squad leader.",
    Options_Messages_OnlyWhenPlatoonLeader_Label                    =  "Send on Platoon only when Leader",
    Options_Messages_OnlyWhenPlatoonLeader_Tooltip                  =  "When checked, messages will not be sent on the Platoon channel, unless you are the Platoon leader.",


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

    Options_Panels_TimerMode_Label    = "Timer Mode",
    Options_Panels_TimerMode_Tooltip  = "Set the timer mode.\nNormal - The timer starts at 0 and counts to infinity.\nCountdown - The time starts at the specified timestamp and counts down to 0. (Useful as an indication of the risk of despawn.)",

    Options_Panels_TimerCountdownTime_Label = "Countdown Time",
    Options_Panels_TimerCountdownTime_Tooltip = "The time to begin counting down from when Timer Mode is set to Countdown.",


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

    Options_Waypoints_IconGlow_Label                = "Enable Icon Glow",
    Options_Waypoints_IconGlow_Tooltip              = "If you have UI Glow Effects enabled in the game's Video settings, this will cause the icon displayed on your hud, worldmap and radar to glow in its rarities color.",


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


    Options_Debug_LogLootCreateData_Label  = "Log Loot Created",
    Options_Debug_LogLootCreateData_Tooltip = "Extra debug messages, spammy.\nLogs stored info about loot upon creation, helpful when errors are occuring in the various features of the addon (post detection).",



    Options_Debug_CommunicationExtra_Label                                                      =    "Log Communication Extra",
    Options_Debug_CommunicationExtra_Tooltip                                                    =    "Extra Communication messages, spammy.\nLogs encoding and decoding of communication links more closely, helpful when errors are occuring in this department.",

    Options_Debug_RoundRobin_Label                                                      =    "Log Round Robin",
    Options_Debug_RoundRobin_Tooltip                                                    =    "Extra logging for Round Robin, spammy.\nDetailed logging of Round Robin logic, helpful if its giving out unexpected results.",

    Options_Debug_LogLootDetermineCategory_Label                                        =        "Log Loot Determine Category",
    Options_Debug_LogLootDetermineCategory_Tooltip                                      =        "Extra debug messages, spammy.\nLogs info on the process of determining what category an item is, helpful when items are not of the category you expect.",

    Options_Sounds_Enabled_Label                                                                =    "Enable Sounds",
    Options_Sounds_Enabled_Tooltip                                                              =    "The addon will play sounds in order to notify you when certain events occur.",
    
    Options_Sounds_Mute_Label                               =    "Mute",
    Options_Sounds_Mute_Tooltip                             =    "If checked, no sounds will play",
    Options_Sounds_OnIdentify_Label                         =    "Item Detected",
    Options_Sounds_OnIdentifyRollable_Label                 =    "NYI?",
    Options_Sounds_OnAssignItemToMe_Label                   =    "Item Assigned To You",
    Options_Sounds_OnAssignItemToOther_Label                =    "Item Assigned To Other",

    Options_HUDTracker_Enabled_Label                           =    "Enable HUDTracker",
    Options_HUDTracker_Enabled_Tooltip                         =    "The addon will display information about currently tracked item drops, allowing you to keep track of things at a glance, as well as to perform actions with ease, or inspect the items in more detail, when in mousemode.",

    Options_HUDTracker_Visibility_Label                        =    "Visibility",
    Options_HUDTracker_Visibility_Tooltip                      =    "When to display the HUDTracker.\nHUD - Standard HUD behavior (hidden in cinematics, loadscreens etc.)\nMouse Mode - Like HUD, but also requires Mouse Mode\nSin View - Like HUD, but also requires Sin View\nAlways - Remains visible as long as there is loot to display.",

    Options_HUDTracker_Tooltip_Enabled_Label           =  "Enable Tooltips",
    Options_HUDTracker_Tooltip_Enabled_Tooltip         =  "When hovering over an entry in the Tracker list, a tooltip representation of the item will be displayed on the cursor.",
    Options_HUDTracker_PlateMode_Label                 =  "Plate Style",
    Options_HUDTracker_PlateMode_Tooltip               =  "Changes the look of the plate of entries in the Tracker.",
    Options_HUDTracker_IconMode_Label                  =  "Icon Style ",
    Options_HUDTracker_IconMode_Tooltip                =  "Changes the look of the item icon of entries in the Tracker. ",


    Options_HUDTracker_EntrySize_Label                 = "Entry Size",
    Options_HUDTracker_EntrySize_Tooltip               = "Sets the height of the entries in the HUDTracker.",

    Options_HUDTracker_EntryFontType_Label             = "Entry Font Type",
    Options_HUDTracker_EntryFontType_Tooltip           = "Sets the font of the text in the HUDTracker.",

    Options_HUDTracker_EntryFontSize_Label             = "Entry Font Size",
    Options_HUDTracker_EntryFontSize_Tooltip           = "Sets the font size of the text in the HUDTracker.",

    Options_HUDTracker_ForceWebIcons_Label             = "Force Web Icons",
    Options_HUDTracker_ForceWebIcons_Tooltip           = "When getting the icon for the entry, the addon gets the ability icon if the item is an ability. Checking this will ignore that procedure and force the usage of web icon.",

    Options_HUDTracker_Frame_Width_Label       = "Frame Width",
    Options_HUDTracker_Frame_Width_Tooltip     = "Sets the frame width",
    Options_HUDTracker_Frame_Height_Label      = "Frame Height",
    Options_HUDTracker_Frame_Height_Tooltip    = "Sets the frame height",

    Options_HUDTracker_UpdateInterval_Label       = "Update Interval",
    Options_HUDTracker_UpdateInterval_Tooltip     = "The interval at which the HUDTracker will regularily update. Note that this is in addition to updates triggered by events.",
    Options_HUDTracker_MinimumUpdateDelay_Label   = "Minimum Update Delay",
    Options_HUDTracker_MinimumUpdateDelay_Tooltip = "The absolute minimum number of seconds to wait between each HUDTracker update. Increasing this reduces the number of updates that occur and improves performance, but that also means the HUDTracker will be out of date for longer.",


    Options_Tracker_UpdateMode_Label            = "Update Mode",
    Options_Tracker_UpdateMode_Tooltip          = "Select which mode to use for the periodic updating of loot (a saftey system that for most purposes is probably redundant).\nUnified mode (Refresh) updates all loot at once on a single cycle.\nIndividual mode (Loot Update Interval) places a cycle on each loot, checking each piece of loot on a consistent interval.",

    -- Subtabs
    Options_Subtab_Messages                                         =    "Messages",
    Options_Subtab_Messages_Tracker                                 =    "Tracking",
    Options_Subtab_Markers                                          =    "Markers",
    Options_Subtab_Panels                                           =    "Panels",
    Options_Subtab_Waypoints                                        =    "Waypoints",
    Options_Subtab_Tracker                                          =    "Tracking",
    Options_Subtab_HUDTracker                                       =    "HUDTracker",
    Options_Subtab_Sounds                                           =    "Sounds",
    Options_Subtab_Filtering                                        =    "Filtering",

    Options_Subtab_equipment    = "Equipment",
    Options_Subtab_modules      = "Modules",
    Options_Subtab_salvage      = "Salvage",
    Options_Subtab_components   = "Components",
    Options_Subtab_consumable   = "Consumable",
    Options_Subtab_metals       = "Metals",
    Options_Subtab_currency     = "Currency",
    Options_Subtab_unknown      = "Unknown",

    Options_Subtab_Advanced                                       =    "Advanced",
    Options_Subtab_Messages_Events_Tracker_OnLootNew              =    "New",
    Options_Subtab_Messages_Events_Tracker_OnLootLooted           =    "Looted",
    Options_Subtab_Messages_Events_Tracker_OnLootLost             =    "Lost",












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
    Mode_Choice_Simple_Tooltip                              =    "<<WRITE ME>>",
    Mode_Choice_Advanced_Label                              =    "Advanced",
    Mode_Choice_Advanced_Tooltip                            =    "<<WRITE ME>>",

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
    Options_Dropdown_HUDTrackerVisibility_Choice_mousemode_Label                =    "Mouse Mode",
    Options_Dropdown_HUDTrackerVisibility_Choice_mousemode_Tooltip              =    "",
    Options_Dropdown_HUDTrackerVisibility_Choice_hud_Label                      =    "HUD",
    Options_Dropdown_HUDTrackerVisibility_Choice_hud_Tooltip                    =    "",
    Options_Dropdown_HUDTrackerVisibility_Choice_sinmode_Label                =    "Full Sin View",
    Options_Dropdown_HUDTrackerVisibility_Choice_sinmode_Tooltip              =    "",

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

    -- Chill!~
    Options_Dropdown_OptionsFontTypes_Choice_UbuntuRegular_Label  = Component.LookupText('CHAT_FONT_TYPE_UBUNTU_REGULAR'),
    Options_Dropdown_OptionsFontTypes_Choice_UbuntuMedium_Label   = Component.LookupText('CHAT_FONT_TYPE_UBUNTU_MEDIUM'),
    Options_Dropdown_OptionsFontTypes_Choice_UbuntuBold_Label     = Component.LookupText('CHAT_FONT_TYPE_UBUNTU_BOLD'),
    Options_Dropdown_OptionsFontTypes_Choice_Demi_Label           = Component.LookupText('CHAT_FONT_TYPE_EUROSTILE_DEMI'),
    Options_Dropdown_OptionsFontTypes_Choice_Bold_Label           = Component.LookupText('CHAT_FONT_TYPE_EUROSTILE_BOLD'),
    Options_Dropdown_OptionsFontTypes_Choice_Wide_Label           = Component.LookupText('CHAT_FONT_TYPE_EUROSTILE_WIDEBOLD'),

    Options_Dropdown_TrackerUpdateMode_Choice_global_Label      = "Unified",
    Options_Dropdown_TrackerUpdateMode_Choice_individual_Label  = "Individual",


    Options_Dropdown_PanelsTimerMode_Choice_countdown_Label = "Countdown",
    Options_Dropdown_PanelsTimerMode_Choice_normal_Label    = "Normal",
    Options_Dropdown_PanelsTimerMode_Choice_disabled_Label  = "Disabled",

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






-- to remove
UI_AssignedTo_nil                                                               =    "Not yet assigned",
UI_AssignedTo_false                                                             =    "Free for all",
UI_AssignedTo_true                                                              =    "Free for all",
UI_AssignedTo_Prefix                                                            =    "Assigned To: ",
UI_Messages_System_NoRollableForDistribute                                      =    "No Rollable Loot to distribute",
UI_Messages_System_NoIdentifiedForDistribute                                    =    "No Identified Loot to distribute"



}
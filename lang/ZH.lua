
-- A little messy, I will clean up someday.

-- Message format options, appended to tooltips.
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

-- Language Table for Lokii
LANG = {

    -- Locales
    Options_Locale_Choice_DEFAULT = "Default",
    Options_Locale_Choice_en = "English",
    Options_Locale_Choice_zh = "中文",
    Options_Locale_Choice_de = "German",
    Options_Locale_Choice_fr = "French",
    Options_Locale_Choice_es = "Spanish",

    -- System Messages
    SystemMessage_Prefix = "[xLT] ",
    SystemMessage_Tracker_HitLimit = "对于跟踪项目数量的限制！",
    SystemMessage_Core_LocaleChanged = "为了使改动生效，请输入/rui重新加载UI。", -- {locale} - New language 
    SystemMessage_Core_Version = '战利品追踪 v{version} p{patch} r{release}', -- AddonInfo is accessible with {}.

    SystemMessage_Slash_Help_TitleStandard = "Slash Commands",
    SystemMessage_Slash_Help_Command_Help = "Version message and command list.",
    SystemMessage_Slash_Help_Command_Clear = "Force the tracker to remove all loot.",
    SystemMessage_Slash_Help_Command_Refresh = "Force the tracker to update all loot.",
    SystemMessage_Slash_Help_Command_Blacklist = "Configure specific items to ignore.",
    SystemMessage_Slash_Help_Command_WaypointVisibility = "Toggle Waypoint HUD Visbility.",
    SystemMessage_Slash_Help_TitleDebug = "Debug Commands",

    SystemMessage_Slash_Clear = "Removing all tracked loot and resetting Tracker data.",

    SystemMessage_Slash_Blacklist = "Blacklist",
    SystemMessage_Slash_Blacklist_Syntax = "Syntax: <action> <scope> [itemName|itemTypeId].", -- (help message, no variables)
    SystemMessage_Slash_Blacklist_Error_NoArgs = "Incorrect syntax. First, provide an action (add, remove, view, clear). Then, specify a scope (all, panels, sounds, hudtracker, messages, waypoints). Finally, for add and remove, provide either the exact item name, or the itemTypeId.",
    SystemMessage_Slash_Blacklist_View = "Viewing blacklist entries in scope {scope}", -- {scope}
    SystemMessage_Slash_Blacklist_View_Error_Empty = "Nothing to list.",
    SystemMessage_Slash_Blacklist_Clear = "Success! Cleared {count} entries from the {scope} scope.", -- {scope}
    SystemMessage_Slash_Blacklist_Clear_Error_Empty = "The scope was already empty.",
    SystemMessage_Slash_Blacklist_AddOrRem_Error_NoItemInfo = "Could not get itemInfo, unable to find an item with the name {query}", -- {query} - User input
    SystemMessage_Slash_Blacklist_AddOrRem_Error_BadItemInfo = "This does not seem like a valid item, no information was found for {query}", -- {query} - User input
    SystemMessage_Slash_Blacklist_AddOrRem_Error_NoArg = "Missing itemName or itemTypeId argument.", 
    SystemMessage_Slash_Blacklist_Add_Error_AlreadyExists = "Already blacklisted in this scope",
    SystemMessage_Slash_Blacklist_Rem_Error_NotListed = "The item was not blacklisted in this scope",
    SystemMessage_Slash_Blacklist_AddOrRem_Error_UnknownError = "Unexpected error",
    SystemMessage_Slash_Blacklist_Add = "Success! Added {name} ({typeId}) to the {scope} blacklist.", -- {name}, {typeId}, {scope}
    SystemMessage_Slash_Blacklist_Rem = "Success! Removed {name} ({typeId}) from the {scope} blacklist.", -- {name}, {typeId}, {scope}
    SystemMessage_Slash_Blacklist_Error_NoScope = "Invalid scope argument",
    SystemMessage_Slash_Blacklist_Error_NoAction = "Invalid actionKey. Use add or remove.",
    SystemMessage_Slash_Blacklist_Error_Reason = "Failure - Reason: {reason}", -- {reason} contains error message text

    SystemMessage_Slash_Refresh = "Refreshing the status of all tracked loot.",



    -- UI
    UI_Waypoints_Subtitle = "战利品", -- When mouseovering a Waypoint on the WorldMap, this Subtitle is displayed.
    UI_HUDTracker_AddCoordinatesLink = "Add Coordinates Link", -- Right-click context menu for HUDTracker Entries, the others use standard translations.
    UI_HUDTracker_DebugRemove = "Debug - Remove", -- Right-click context menu for HUDTracker Entries
    UI_Slash_Description = "战利品追踪", -- Displayed when using /help


    -- Options
    Options_Label = "战利品追踪", -- This is the label of the top-level Loot Tracker tab in the interface options, under Addons.
    Options_MoveableFrame_Tracker_Label = "战利品追踪", -- Label for the moveable frame in the interface options that controls the position of the HUDTracker. 

    Options_Group_Core_Label = "战利品追踪",
    Options_Core_Enabled_Label = "启用",
    Options_Core_Enabled_Tooltip = "该插件将被启用。",
    Options_Core_VersionMessage_Label = "版本信息",
    Options_Core_VersionMessage_Tooltip = "当插件加载时，显示此插件的运行状态，并显示版本号。",  
    Options_Core_SlashHandles_Label = "Slash Handles (意义不明)",
    Options_Core_SlashHandles_Tooltip = "The slash handles that the addon will register for. Requires that you reload the UI to update.",
    Options_Core_Locale_Label  = "语言",
    Options_Core_Locale_Tooltip  = "Set the Language to be used by the addon. The UI must be reloaded after changing this value in order for all changes to take effect.",


    Options_Group_Features_Label =    "特性",

    Options_Tracker_TrackDelay_Label = "追踪延迟",
    Options_Tracker_TrackDelay_Tooltip = "在检测一个新的项目时，启动该程序开始跟踪，需要等待多长时间。较低的值比较好。",
    Options_Tracker_UpdateDelay_Label = "更新延迟",
    Options_Tracker_UpdateDelay_Tooltip = "更新延迟，没什么用处，值越低越好。",
    Options_Tracker_RemoveDelay_Label = "消失延迟",
    Options_Tracker_RemoveDelay_Tooltip = "在捡起战利品或战利品消失之后，在界面上继续显示多久该战利品。一般来说，捡起后该追踪信息就会消失，所以没什么必要，保持数值最低就好。",
    Options_Tracker_Limit_Label = "最大追踪信息",
    Options_Tracker_Limit_Tooltip = "最多显示多少个追踪信息，超过此数值，将不会继续显示追踪信息。如没必要，请保持默认100", 
    Options_Tracker_RefreshInterval_Label = "统一更新追踪信息",
    Options_Tracker_RefreshInterval_Tooltip = "持续多久检测战利品掉落的追踪信息，一般来说较短的延迟没有多大的意义，应该使用更长的延迟，但更短的延迟能及时清除已经消失战利品追踪信息。保持默认就好。",
    Options_Tracker_LootUpdateInterval_Label = "个别更新间隔",
    Options_Tracker_LootUpdateInterval_Tooltip = "持续多久检测战利品掉落的追踪信息，一般来说较短的延迟没有多大的意义，应该使用更长的延迟，但更短的延迟能及时清除已经消失战利品追踪信息。保持默认就好。",

    Options_Tracker_LootEventHistoryCleanupInterval_Label  = "Loot Event History Cleanup Interval",
    Options_Tracker_LootEventHistoryCleanupInterval_Tooltip = "How often to check the history of lootevents and cleanup those that have expired. A longer interval might be more performance efficient, but it could cause issues with the tracking of items.",
    Options_Tracker_LootEventHistoryLifetime_Label  = "Loot Event History Lifetime",
    Options_Tracker_LootEventHistoryLifetime_Tooltip = "How long a lootevent should be valid for. A shorter lifetime should result in better accuracy when multiple items of the same kind are picked up in a short timespan, but too short may cause the addon to think items have despawned when they were looted. Longer timespans prevent the aforementioned issue, but may result in reduced accuracy in the aforementioned scenario.",


    Options_Tracker_IgnoreCrystite_Label = "忽略水晶追踪",
    Options_Tracker_IgnoreCrystite_Tooltip = "当启用时，将追踪水晶信息，一般不用开启，如果你是强迫症，那就开吧，看着满满一屏幕水晶追踪信息。",

    Options_Tracker_IgnoreMetalsTornado_Label = "忽略混乱风暴里的矿物",
    Options_Tracker_IgnoreMetalsTornado_Tooltip = "忽略进入混乱风暴未知区域里的矿物，建议不开启，此项可能会造成游戏卡顿。",

    Options_Filtering_Simple_Enabled_Label = "简单",
    Options_Filtering_Simple_Enabled_Tooltip = "如果在简单的配置模式下，只使用这些设置。",

    Options_Filtering_Mode_Label = "配置模式",
    Options_Filtering_Mode_Tooltip = "配置简单或高级模式。在简单模式下，仅使用简单的配置中的选项。在高级模式下，你可以单独禁用不同的稀有度或设定不同的级别的选项。",


    Options_Dropdown_Mode_Choice_simple_Label = "简单",
    Options_Dropdown_Mode_Choice_simple_Tooltip = "<<WRITE ME>>",
    Options_Dropdown_Mode_Choice_advanced_Label = "高级",
    Options_Dropdown_Mode_Choice_advanced_Tooltip = "<<WRITE ME>>",

    Options_Filtering_equipment_Enabled_Label = "装备",
    Options_Filtering_equipment_Enabled_Tooltip = "装备",
    Options_Filtering_modules_Enabled_Label = "模组",
    Options_Filtering_modules_Enabled_Tooltip = "模组",
    Options_Filtering_salvage_Enabled_Label = "回收物品",
    Options_Filtering_salvage_Enabled_Tooltip = "回收物品",
    Options_Filtering_components_Enabled_Label = "制造组件",
    Options_Filtering_components_Enabled_Tooltip = "制造组件",
    Options_Filtering_metals_Enabled_Label = "矿物",
    Options_Filtering_metals_Enabled_Tooltip = "矿物",
    Options_Filtering_consumable_Enabled_Label = "消耗品",
    Options_Filtering_consumable_Enabled_Tooltip = "消耗品",
    Options_Filtering_currency_Enabled_Label = "货币",
    Options_Filtering_currency_Enabled_Tooltip = "货币",
    Options_Filtering_unknown_Enabled_Label = "不明物品",
    Options_Filtering_unknown_Enabled_Tooltip = "不明物品",
    Options_Filtering_salvage_Enabled_Label = "回收物品",
    Options_Filtering_salvage_Enabled_Tooltip = "回收物品",
    Options_Filtering_common_Enabled_Label = "白装物品",
    Options_Filtering_common_Enabled_Tooltip = "白装物品",
    Options_Filtering_uncommon_Enabled_Label = "绿装物品",
    Options_Filtering_uncommon_Enabled_Tooltip = "绿装物品",
    Options_Filtering_rare_Enabled_Label = "蓝装物品",
    Options_Filtering_rare_Enabled_Tooltip = "蓝装物品",
    Options_Filtering_epic_Enabled_Label = "紫装物品",
    Options_Filtering_epic_Enabled_Tooltip = "紫装物品",
    Options_Filtering_legendary_Enabled_Label = "橙装物品",
    Options_Filtering_legendary_Enabled_Tooltip = "橙装物品",

    Options_Filtering_RarityThreshold_Label = "稀有度调节",
    Options_Filtering_RarityThreshold_Tooltip = "一个物品必须设置最小稀有度",
    Options_Filtering_ItemLevelThreshold_Label = "物品等级调节",
    Options_Filtering_ItemLevelThreshold_Tooltip = "一个物品必须设置最小等级",
    Options_Filtering_RequiredLevelThreshold_Label = "所需求的物品等级",
    Options_Filtering_RequiredLevelThreshold_Tooltip = "一个物品所需求的最低等级水平。",


    
    Options_Filtering_WaypointTitle_Label = "路径点标题格式",
    Options_Filtering_WaypointTitle_Tooltip = "自定义路径点的称号.\n"..Generic_MessageFormat,
    Options_Filtering_HUDTrackerTitle_Label = "HUDTracker 标题格式",
    Options_Filtering_HUDTrackerTitle_Tooltip = "自定义在hudtracker每个条目的标题.\n"..Generic_MessageFormat,

    Options_Filtering_SoundsNewLoot_Label = "声音通知",
    Options_Filtering_SoundsNewLoot_Tooltip = "",

    Options_Messages_Generic_Channels_Squad_Enabled_Label = "发送消息到小队频道",
    Options_Messages_Generic_Channels_Squad_Enabled_Tooltip = "发送消息至小队",
    Options_Messages_Generic_Channels_Squad_Format_Label = "小队信息格式",
    Options_Messages_Generic_Channels_Squad_Format_Tooltip = "指定小队信息格式\n"..Generic_MessageFormat,
    Options_Messages_Generic_Channels_Platoon_Enabled_Label = "发送消息至排频道",
    Options_Messages_Generic_Channels_Platoon_Enabled_Tooltip = "发送消息至排频道",
    Options_Messages_Generic_Channels_Platoon_Format_Label = "排信息格式",
    Options_Messages_Generic_Channels_Platoon_Format_Tooltip = "指定排信息格式。\n"..Generic_MessageFormat,
    Options_Messages_Generic_Channels_System_Enabled_Label = "发送系统消息频道",
    Options_Messages_Generic_Channels_System_Enabled_Tooltip = "发送消息至系统频道",
    Options_Messages_Generic_Channels_System_Format_Label = "系统消息格式",
    Options_Messages_Generic_Channels_System_Format_Tooltip = "指定系统消息格式。\n"..Generic_MessageFormat,
    Options_Messages_Generic_Channels_Notifications_Enabled_Label = "发送通知消息",
    Options_Messages_Generic_Channels_Notifications_Enabled_Tooltip = "发送通知消息",
    Options_Messages_Generic_Channels_Notifications_Format_Label = "通知消息格式",
    Options_Messages_Generic_Channels_Notifications_Format_Tooltip = "指定通知消息的格式。\n"..Generic_MessageFormat,
    Options_Messages_Generic_IgnoreOthers_Label = "忽略其他",
    Options_Messages_Generic_IgnoreOthers_Tooltip = "如果选中，除非该事件是由当地玩家触发不会被发送的消息",
    Options_Messages_Enabled_Label = "启用消息",
    Options_Messages_Enabled_Tooltip = "该插件会发送物品掉落定制消息到聊天窗口",
    Options_Messages_Prefix_Label = "通用前缀",
    Options_Messages_Prefix_Tooltip = "设置所有公开消息的前缀",
    Options_Messages_Channels_Squad_Label = "发送在队伍频道",
    Options_Messages_Channels_Squad_Tooltip = "对于队的消息总开关。如果未被选中，插件将无法发送事件阵容的消息。",
    Options_Messages_Channels_Platoon_Label = "发送排频道",
    Options_Messages_Channels_Platoon_Tooltip = "对于队的消息总开关。如果未被选中，插件将无法发送事件排消息。",
    Options_Messages_Channels_Notifications_Label = "发送通知",
    Options_Messages_Channels_Notifications_Tooltip = "通知消息总开关。如果未被选中，插件不会发送事件通知消息。",
    Options_Messages_Channels_System_Label = "发送系统消息",
    Options_Messages_Channels_System_Tooltip = "系统消息主开关。如果未被选中，插件将无法发送事件系统消息。",
    Options_Messages_OnlyWhenSquadLeader_Label = "在小队队长时发送消息",
    Options_Messages_OnlyWhenSquadLeader_Tooltip = "当被选中的时候，如果你不是队长，就不会发送小队消息。",
    Options_Messages_OnlyWhenPlatoonLeader_Label = "在排队队长时发送消息",
    Options_Messages_OnlyWhenPlatoonLeader_Tooltip = "当被选中的时候，如果你不是排长，就不会发送排队消息.",
    Options_Messages_Events_Tracker_OnLootLost_Enabled_Label = "丢失的战利品",
    Options_Messages_Events_Tracker_OnLootLost_Enabled_Tooltip = "意义是未知的。保持默认",
    Options_Messages_Events_Tracker_OnLootLooted_Enabled_Label = "战利品抢劫",
    Options_Messages_Events_Tracker_OnLootLooted_Enabled_Tooltip = "意义是未知的。保持默认",
    Options_Messages_Events_Tracker_OnLootNew_Enabled_Label = "探测到的战利品",
    Options_Messages_Events_Tracker_OnLootNew_Enabled_Tooltip = "当插件已经发现了一个新的项目",

    Options_Panels_Enabled_Label = "启用面板特性",
    Options_Panels_Enabled_Tooltip = "掉落的战利品上方显示该物品的详细信息。",
    Options_Panels_Mode_Label = "模式",
    Options_Panels_Mode_Tooltip = "Overall Panel display mode\nStandard: Full view\nSmall: Only header is shown",
    Options_Panels_ColorMode_ItemName_Label = "项目名称颜色",
    Options_Panels_ColorMode_ItemName_Tooltip = "设置面板标题中的项目名称文本的颜色。",
    Options_Panels_ColorMode_ItemNameCustomValue_Label = "自定义项名称颜色",
    Options_Panels_ColorMode_ItemNameCustomValue_Tooltip = "设置为自定义选项的面板标题上的项目名称文本的颜色。",
    Options_Panels_ColorMode_HeaderBar_Label = "标题的颜色",
    Options_Panels_ColorMode_HeaderBar_Tooltip = "设置面板标题背景的颜色。",
    Options_Panels_ColorMode_HeaderBarCustomValue_Label = "自定义标题颜色",
    Options_Panels_ColorMode_HeaderBarCustomValue_Tooltip = "设置为自定义选项的面板标题背景的颜色。",
    Options_Panels_TimerMode_Label = "计时器模式",
    Options_Panels_TimerMode_Tooltip  = "Set the timer mode.\nNormal - The timer starts at 0 and counts to infinity.\nCountdown - The time starts at the specified timestamp and counts down to 0. (Useful as an indication of the risk of despawn.)",
    Options_Panels_TimerCountdownTime_Label = "倒计时时间",
    Options_Panels_TimerCountdownTime_Tooltip = "当计时器模式设置为倒计时,开始计数的时间。",

    Options_Detection_IdentifyDelay_Label = "追踪延迟",
    Options_Detection_IdentifyDelay_Tooltip = "意义不明保持默认。",
    Options_Detection_DespawnCheckInterval_Label = "消失检查间隔",
    Options_Detection_DespawnCheckInterval_Tooltip = "意义不明保持默认",


    Options_Waypoints_Enabled_Label = "启用的航点",
    Options_Waypoints_Enabled_Tooltip = "该插件将航点跟踪项目，帮助你快速定位战利品位置。",

    Options_Waypoints_ShowOnHud_Label = "显示在屏幕",
    Options_Waypoints_ShowOnHud_Tooltip = "显示标记在屏幕上",
    Options_Waypoints_ShowOnWorldMap_Label = "显示在世界地图",
    Options_Waypoints_ShowOnWorldMap_Tooltip = "显示世界地图上的标记",
    Options_Waypoints_ShowOnRadar_Label = "显示在雷达/小地图",
    Options_Waypoints_ShowOnRadar_Tooltip = "显示雷达上的标记",
    

    Options_Waypoints_RadarEdgeMode_Label = "雷达边缘模式",
    Options_Waypoints_RadarEdgeMode_Tooltip = "(小地图上的方向小箭头，就是这个意思。)Behavior for Waypoint icons on the radar when outside range and the icon attaches to the radar edge\nNone : Hidden \nArrow: Nonspecific arrow icon \nIcon : Keep showing the same icon",


    Options_Sounds_Enabled_Label = "使用声音提醒",
    Options_Sounds_Enabled_Tooltip = "此功能能在战利品掉落时发出声音提醒",

    Options_Sounds_Mute_Label = "静音",
    Options_Sounds_Mute_Tooltip = "静音....",
    Options_Sounds_OnIdentify_Label = "检测物品",
    Options_Sounds_OnIdentifyRollable_Label = "NYI?(我不知道这是什么鬼。）",
    Options_Sounds_OnAssignItemToMe_Label = "物品分配给你",
    Options_Sounds_OnAssignItemToOther_Label = "物品分配给其他",

    Options_HUDTracker_Enabled_Label = "启用 HUDTracker",
    Options_HUDTracker_Enabled_Tooltip = "大概意思就是 启用此功能后，能详细显示掉落的战利品信息。一目了然的意思。",

    Options_HUDTracker_Visibility_Label = "可见性",
    Options_HUDTracker_Visibility_Tooltip = "(我不知道这是什么鬼，保持默认。)When to display the HUDTracker.\nHUD - Standard HUD behavior (hidden in cinematics, loadscreens etc.)\nMouse Mode - Like HUD, but also requires Mouse Mode\nSin View - Like HUD, but also requires Sin View\nAlways - Remains visible as long as there is loot to display.",

    Options_HUDTracker_Tooltip_Enabled_Label = "启用工具提示",
    Options_HUDTracker_Tooltip_Enabled_Tooltip = "当鼠标悬停在hudtracker列表项，该项将显示在工具提示表示光标",
    Options_HUDTracker_PlateMode_Label = "风格",
    Options_HUDTracker_PlateMode_Tooltip = "更改跟踪中的项的外观。",
    Options_HUDTracker_IconMode_Label = "图标样式 ",
    Options_HUDTracker_IconMode_Tooltip = "更改跟踪中项目图标的外观。",


    Options_HUDTracker_EntrySize_Label = "项的尺寸",
    Options_HUDTracker_EntrySize_Tooltip = "设置在HUDTracker项的高度。",

    Options_HUDTracker_EntryFontType_Label = "输入字体类型",
    Options_HUDTracker_EntryFontType_Tooltip = "设置在HUDTracker文本字体。",

    Options_HUDTracker_EntryFontSize_Label = "输入字体大小。",
    Options_HUDTracker_EntryFontSize_Tooltip = "设置在HUDTracker文本的字体大小。",

    Options_HUDTracker_ForceWebIcons_Label             = "不使用项目能力的图标", -- "Don't Use Ability Icons for Items",
    Options_HUDTracker_ForceWebIcons_Tooltip           = "(就如字面意思，我特么看不懂。)When getting the icon for the entry, the addon gets the ability icon if the item is an ability. Checking this will ignore that procedure and force the usage of an item icon instead.",

    Options_HUDTracker_Frame_Width_Label = "框架宽度",
    Options_HUDTracker_Frame_Width_Tooltip = "设置框架的宽度",
    Options_HUDTracker_Frame_Height_Label = "框架高度",
    Options_HUDTracker_Frame_Height_Tooltip = "设置框架高度",

    Options_HUDTracker_UpdateInterval_Label = "更新间隔",
    Options_HUDTracker_UpdateInterval_Tooltip = "(保持默认）The interval at which the HUDTracker will regularily update. Note that this is in addition to updates triggered by events.",
    Options_HUDTracker_MinimumUpdateDelay_Label = "最小更新延迟",
    Options_HUDTracker_MinimumUpdateDelay_Tooltip = "（保持默认)The absolute minimum number of seconds to wait between each HUDTracker update. Increasing this reduces the number of updates that occur and improves performance, but that also means the HUDTracker will be out of date for longer.",

    Options_Tracker_UpdateMode_Label = "更新模式",
    Options_Tracker_UpdateMode_Tooltip = "(保持默认)Select which mode to use for the periodic updating of loot (a saftey system that for most purposes is probably redundant).\nUnified mode (Refresh) updates all loot at once on a single cycle.\nIndividual mode (Loot Update Interval) places a cycle on each loot, checking each piece of loot on a consistent interval.",





    -- Debug stuff
    Options_Debug_Enabled_Label = "调试",
    Options_Debug_Enabled_Tooltip = "开启之后能记录插件信息，以便于发送给插件作者了解详情。",

    Options_Debug_FakeOnSquadRoster_Label = "Fake Squad Roster",
    Options_Debug_FakeOnSquadRoster_Tooltip = "If not in a squad but override squad leader, put fake squad members in the roster",
    Options_Debug_SquadToArmy_Label = "Squad To Army",
    Options_Debug_SquadToArmy_Tooltip = "Redirect messages on Squad channel to Army",
    Options_Debug_UndefinedFilterArguments_Label = "Undefined Filter Arguments",
    Options_Debug_UndefinedFilterArguments_Tooltip = "Output NOT_SET when filter arguments are undefined, rather than an empty string.",
    Options_Debug_LogLootableTargets_Label = "Log Loot Detected",
    Options_Debug_LogLootableTargets_Tooltip = "Extra debug messages, spammy.\nLogs info on detected items, helpful when errors are occuring during item detection.",
    Options_Debug_LogLootableCollection_Label = "Log Loot Collected",
    Options_Debug_LogLootableCollection_Tooltip = "Extra debug messages, spammy.\nLogs info on looted items, helpful when errors are occuring during item removal.",
    Options_Debug_LogOptionChange_Label = "Log Option Changes",
    Options_Debug_LogOptionChange_Tooltip = "Extra debug messages, spammy.\nLogs option changes, helpful when errors are occuring with the interface options.",

    Options_Debug_LogLootCreateData_Label = "Log Loot Created",
    Options_Debug_LogLootCreateData_Tooltip = "Extra debug messages, spammy.\nLogs stored info about loot upon creation, helpful when errors are occuring in the various features of the addon (post detection).",

    Options_Debug_LogLootDetermineCategory_Label = "Log Loot Determine Category",
    Options_Debug_LogLootDetermineCategory_Tooltip = "Extra debug messages, spammy.\nLogs info on the process of determining what category an item is, helpful when items are not of the category you expect.",




    -- Subtabs
    Options_Subtab_Messages = "消息",
    Options_Subtab_Messages_Tracker = "追踪",
    Options_Subtab_Markers = "标记",
    Options_Subtab_Panels = "面板",
    Options_Subtab_Waypoints = "航点",
    Options_Subtab_Tracker = "追踪",
    Options_Subtab_HUDTracker = "HUDTracker",
    Options_Subtab_Sounds = "声音",
    Options_Subtab_Keybinds                   =    "Keybinds",
    Options_Subtab_Filtering = "过滤",

    Options_Subtab_equipment = "装备",
    Options_Subtab_modules = "模组",
    Options_Subtab_salvage = "回收物品",
    Options_Subtab_components = "制造组件",
    Options_Subtab_consumable = "消耗品",
    Options_Subtab_metals = "矿物",
    Options_Subtab_currency = "货币",
    Options_Subtab_unknown = "未知",
    
    Options_Subtab_Advanced = "高级",
    Options_Subtab_Messages_Events_Tracker_OnLootNew = "新的",
    Options_Subtab_Messages_Events_Tracker_OnLootLooted = "消失的战利品",
    Options_Subtab_Messages_Events_Tracker_OnLootLost = "失去的",












    -- Dropdown Choices
    -- Due to some issues these have really bad names (basedon values?) that I hope to correct at some point.



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
    Options_Dropdown_OptionsFontTypes_Choice_Narrow_Label           = "Eurostile Narrow",

    Options_Dropdown_TrackerUpdateMode_Choice_global_Label      = "Unified",
    Options_Dropdown_TrackerUpdateMode_Choice_individual_Label  = "Individual",


    Options_Dropdown_PanelsTimerMode_Choice_countdown_Label = "Countdown",
    Options_Dropdown_PanelsTimerMode_Choice_normal_Label    = "Normal",
    Options_Dropdown_PanelsTimerMode_Choice_disabled_Label  = "Disabled",








    Options_HUDTracker_FadeFrame_Enabled_Label                = "Fade Frame",
    Options_HUDTracker_FadeFrame_Enabled_Tooltip              = "Toggle whether or not to use fade-in and fade-out effects for the frame of the HUDTracker (the whole container).",
    Options_HUDTracker_FadeFrame_FadeIn_Duration_Label        = "Fade In Duration",
    Options_HUDTracker_FadeFrame_FadeIn_Duration_Tooltip      = " ",
    Options_HUDTracker_FadeFrame_FadeIn_Animation_Label       = "Fade In Animation",
    Options_HUDTracker_FadeFrame_FadeIn_Animation_Tooltip     = " ",
    Options_HUDTracker_FadeFrame_FadeOut_Duration_Label       = "Fade Out Duration",
    Options_HUDTracker_FadeFrame_FadeOut_Duration_Tooltip     = " ",
    Options_HUDTracker_FadeFrame_FadeOut_Animation_Label      = "Fade Out Animation",
    Options_HUDTracker_FadeFrame_FadeOut_Animation_Tooltip    = " ",

    Options_HUDTracker_FadeEntry_Enabled_Label                = "Fade Entries",
    Options_HUDTracker_FadeEntry_Enabled_Tooltip              = "Toggle whether or not to use fade-in and fade-out effects for the entries of the HUDTracker.",
    Options_HUDTracker_FadeEntry_FadeIn_Duration_Label        = "Fade In Duration",
    Options_HUDTracker_FadeEntry_FadeIn_Duration_Tooltip      = " ",
    Options_HUDTracker_FadeEntry_FadeIn_Animation_Label       = "Fade In Animation",
    Options_HUDTracker_FadeEntry_FadeIn_Animation_Tooltip     = " ",
    Options_HUDTracker_FadeEntry_FadeOut_Duration_Label       = "Fade Out Duration",
    Options_HUDTracker_FadeEntry_FadeOut_Duration_Tooltip     = " ",
    Options_HUDTracker_FadeEntry_FadeOut_Animation_Label      = "Fade Out Animation",
    Options_HUDTracker_FadeEntry_FadeOut_Animation_Tooltip    = " ",

    Options_AnimationType_FadeIn_Label = "Fade In Animation",
    Options_AnimationType_FadeIn_Tooltip = "Fade In Animation",
    Options_AnimationType_FadeOut_Label = "Fade Out Animation",
    Options_AnimationType_FadeOut_Tooltip = "Fade Out Animation",



    ["Options_Dropdown_AnimationTypeOptions_Choice_ease-in_Label"] = "Ease-in",
    ["Options_Dropdown_AnimationTypeOptions_Choice_ease-out_Label"] = "Ease-out",
    Options_Dropdown_AnimationTypeOptions_Choice_smooth_Label = "Smooth",
    Options_Dropdown_AnimationTypeOptions_Choice_linear_Label = "Linear",


    Options_HUDTracker_DisplaySlider_Label = "Display Slider",
    Options_HUDTracker_DisplaySlider_Tooltip = "Whether or not to display a scrollbar in the Tracker. If enabled, will only be displayed when appropriate (enough items in the list to scroll. Even if this is disabled, you can still scroll the tracker with the mouse wheel.",



    Keybinds_WaypointVisibilityToggle_Button                    = "Toggle Waypoint Visibility",
    Keybinds_HUDTrackerVisibilityToggle_Button                  = "Toggle HUDTracker Visibility",
    Keybinds_WaypointVisibilityCycle_Button                     = "Cycle Waypoint Visibility",

    Options_Keybinds_WaypointVisibilityToggle_Button_Label      = "Bind Toggle Waypoint Visibility",
    Options_Keybinds_WaypointVisibilityToggle_Button_Tooltip    = "Allows you to toggle the HUD visibility of all current Waypoints on/off with a keypress, good for clearing up the screen while in combat.",
    Options_Keybinds_HUDTrackerVisibilityToggle_Button_Label    = "Bind Toggle HUDTracker Visibility",
    Options_Keybinds_HUDTrackerVisibilityToggle_Button_Tooltip  = " ",
    Options_Keybinds_WaypointVisibilityCycle_Button_Label       = "Bind Cycle Waypoint Visibility",
    Options_Keybinds_WaypointVisibilityCycle_Button_Tooltip     = " ",

    KeyBinder_Title = "Keybind Configuration",
    KeyBinder_AcceptButton = "Save",
    KeyBinder_DeclineButton = "Cancel",



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
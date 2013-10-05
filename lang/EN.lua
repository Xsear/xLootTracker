
Generic_MessageSquad_Label = "Message Squad"
Generic_MessageSquad_ToolTip = "Send message to Squad on this event"
Generic_MessageSystem_Label = "Message System"
Generic_MessageSystem_ToolTip = "Send message to System on this event"

Generic_MessageFormat = "Specify the format of the message. The following replacement variables exist, please note that they're not always available.\n%m : Current ruleset/mode\n%i : The item name. If ^Q is encountered, it is removed.\n%q : The item quality\n%iq : The item name. If ^Q is encountered, it is replaced with the item quality.\n%n : The player name\n%r : The roll value\n%l : Playername, person who looted the item\n%a : Playername, person who the item is assigned to\n%e : Comma separated line of players able to need roll"

Generic_MessageFormatSquad_Label = "Message Format Squad"
Generic_MessageFormatSquad_ToolTip = Generic_MessageFormat
Generic_MessageFormatSystem_Label = "Message Format System"
Generic_MessageFormatSystem_ToolTip = Generic_MessageFormat




LANG = {
	Enabled_Label									=	"Enabled",
	Enabled_ToolTip									=	"Whether or not to work!",
	VersionMessage_Label							=	"Loaded Message",
	VersionMessage_ToolTip							=	"Toggle the version message on component load",
	AlwaysSquadLeader_Label							=	"Squad Leader Override",
	AlwaysSquadLeader_ToolTip						=	"By default, xSML will not manage loot if you are not the Squad Leader. Checking this option will cause xSML to always believe it is the Squad Leader. Please save us all from chatspam and only use this when necessary.",
	
	NoSquadMessages_Label							=	"No Squad Messages",
	NoSquadMessages_ToolTip   						=	"Master switch for squad messages. The addon will not send ANY squad messages if this is checked, regardless of other settings.",
	NoSystemMessages_Label    						=	"No System Messages",
	NoSystemMessages_ToolTip  						=	"Master switch for system messages. The addon will not send ANY system messages if this is checked, regardless of other settings.",

	Debug_Enabled_Label								=	"Debug",
	Debug_Enabled_ToolTip							=	"Toggle debug mode",
	Debug_FakeOnSquadRoster_Label					=	"Fake Squad Roster",
	Debug_FakeOnSquadRoster_ToolTip					=	"If not in a squad but override squad leader, put fake squad members in the roster",


	Subtab_LootingRules								=	"Manager",

	Group_Loot_General_Label						=   "General",
	LootMode_Label									=	"Ruleset",
	LootMode_ToolTip								=	"Set the active ruleset/mode for how loot is distributed. This is affected by the weighting and threshold settings as well.\nRandom: Assigns the item to a random eligible group member\nDice: Rolls for each eligible member and assigns the item to the highest roller\nRound-robin: Awards items to each group member in order. Loot weighting doesn't work in this mode.\nNeed before Greed: Accepts need, greed or pass call from each eligible group member",
	LootMode_Random_Label							=	"Random",
	LootMode_Dice_Label								=	"Dice",
	LootMode_RoundRobin_Label						=	"Round-robin",
	LootMode_NeedBeforeGreed_Label					=	"Need before Greed",

	LootWeighting_Label								=	"Weighting",
	LootWeighting_ToolTip							=	"Sets the active loot weighting criteria, which can be used to disallow users from rolling on loot drops that their currently active frame cannot use.\nDisabled: No loot weighting.\nArchetype: Only players in the same Battleframe Archetype as the item are eligible.",
	LootWeighting_Disabled_Label    				=	"Disabled",
	LootWeighting_Archetype_Label   				=	"Archetype",
	LootWeighting_Frame_Label       				=	"Frame",

	LootThreshold_Label								=	"Threshold",
	LootThreshold_ToolTip							=	"Loot below this quality threshold will not be distributed",
	LootThreshold_Any_Label							=	"Any",
	LootThreshold_Green_Label						=	"Green (Uncommon)",
	LootThreshold_Blue_Label						=	"Blue (Rare)",
	LootThreshold_Purple_Label						=	"Purple (Epic)",
	LootThreshold_Orange_Label						=	"Orange (Legendary)",

	AutoDistribute_Label							=   "Auto distribute",
	AutoDistribute_ToolTip							=   "If checked the addon will automatically distribute/roll items according to the current ruleset as soon as they are identified",

	IdentifyAllLoot_Label							=	"Track all Loot",
	IdentifyAllLoot_ToolTip							=	"Check this if you want to see loot panels and waypoints for all loot. When unchecked, the addon will only track loot over the quality threshold.",

	Group_Loot_Rolls_Label							=	"Rolls",
	RollMin_Label									=	"Roll range minimum",
	RollMin_ToolTip									=	"Minimum roll value",
	RollMax_Label									=	"Roll range maximum",
	RollMax_ToolTip									=	"Maximum roll value",
	RollTimeout_Label								=   "Roll timeout",
	RollTimeout_ToolTip 							=   "Time limit in seconds for people to declare their roll type in Need before Greed",
	RollTypeDefault_Label							=	"Default roll type",
	RollTypeDefault_ToolTip							=	"This roll type is selected for any users who do not declare a roll type before the timeout.",
	RollTypeDefault_Pass_Label						=	"Pass",
	RollTypeDefault_Greed_Label						=	"Greed",
	RollTypeDefault_Need_Label						=	"Need",


	Group_Loot_RoundRobin_Label						=	"Round-robin",

	Group_Loot_NeedBeforeGreed_Label				=	"Need before Greed",


	Subtab_Messages									=	"Messages",

	Group_Messages 									=	"Messages",

	Group_Messages_Generic_Label					=	"Generic",	
	Generic_Prefix_Label							=	"Prefix",
	Generic_Prefix_ToolTip							=	"Set this if you want a prefix for all messages.",

	OnDistributeItem_Enabled_Label    		=   "On Distribute Item",
	OnDistributeItem_Enabled_ToolTip    		=   "When an item is being assigned",

	MessageSquad_OnDistributeItem_Label 			=	Generic_MessageSquad_Label,
	MessageSquad_OnDistributeItem_ToolTip 			=	Generic_MessageSquad_ToolTip,
	MessageFormatSquad_OnDistributeItem_Label 		=	Generic_MessageFormatSquad_Label,
	MessageFormatSquad_OnDistributeItem_ToolTip  	=	Generic_MessageFormatSquad_ToolTip,
	
	MessageSystem_OnDistributeItem_Label 			=	Generic_MessageSystem_Label,
	MessageSystem_OnDistributeItem_ToolTip 			=	Generic_MessageSystem_ToolTip,
	MessageFormatSystem_OnDistributeItem_Label 		=	Generic_MessageFormatSystem_Label,
	MessageFormatSystem_OnDistributeItem_ToolTip   	=	Generic_MessageFormatSystem_ToolTip,


	OnRolls_Enabled_Label					=	"On Rolls",
	OnRolls_Enabled_ToolTip					=	"When a roll is calculated",

	MessageSquad_OnRolls_Label 						=	Generic_MessageSquad_Label,
	MessageSquad_OnRolls_ToolTip 					=	Generic_MessageSquad_ToolTip,
	MessageFormatSquad_OnRolls_Label				=	Generic_MessageFormatSquad_Label,
	MessageFormatSquad_OnRolls_ToolTip				=	Generic_MessageFormatSquad_ToolTip,

	MessageSystem_OnRolls_Label 					=	Generic_MessageSystem_Label,
	MessageSystem_OnRolls_ToolTip 					=	Generic_MessageSystem_ToolTip,
	MessageFormatSystem_OnRolls_Label 				=	Generic_MessageFormatSystem_Label,
	MessageFormatSystem_OnRolls_ToolTip 			=	Generic_MessageFormatSystem_ToolTip,

	OnAcceptingRolls_Enabled_Label			=	"On Accepting Rolls",
	OnAcceptingRolls_Enabled_ToolTip			=	"When the addon is listening for roll declarations",

	MessageSquad_OnAcceptingRolls_Label 			=	Generic_MessageSquad_Label,
	MessageSquad_OnAcceptingRolls_ToolTip 			=	Generic_MessageSquad_ToolTip,
	MessageFormatSquad_OnAcceptingRolls_Label		=	Generic_MessageFormatSquad_Label,
	MessageFormatSquad_OnAcceptingRolls_ToolTip		=	Generic_MessageFormatSquad_ToolTip,

	MessageSystem_OnAcceptingRolls_Label 			=	Generic_MessageSystem_Label,
	MessageSystem_OnAcceptingRolls_ToolTip 			=	Generic_MessageSystem_ToolTip,
	MessageFormatSystem_OnAcceptingRolls_Label 		=	Generic_MessageFormatSystem_Label,
	MessageFormatSystem_OnAcceptingRolls_ToolTip 	=	Generic_MessageFormatSystem_ToolTip,

	OnLootReceived_Enabled_Label				=	"On Loot Received",
	OnLootReceived_Enabled_ToolTip			=	"When someone who won an item loots that item",

	MessageSquad_OnLootReceived_Label               =	Generic_MessageSquad_Label,
	MessageSquad_OnLootReceived_ToolTip             =	Generic_MessageSquad_ToolTip,
	MessageFormatSquad_OnLootReceived_Label         =	Generic_MessageFormatSquad_Label,
	MessageFormatSquad_OnLootReceived_ToolTip       =	Generic_MessageFormatSquad_ToolTip,

	MessageSystem_OnLootReceived_Label              =	Generic_MessageSystem_Label,
	MessageSystem_OnLootReceived_ToolTip            =	Generic_MessageSystem_ToolTip,
	MessageFormatSystem_OnLootReceived_Label        =	Generic_MessageFormatSystem_Label,
	MessageFormatSystem_OnLootReceived_ToolTip      =	Generic_MessageFormatSystem_ToolTip,


	OnLootStolen_Enabled_Label				=	"On Loot Stolen",
	OnLootStolen_Enabled_ToolTip				=	"When somebody loots an item that was assigned to someone else",

	MessageSquad_OnLootStolen_Label                 =	Generic_MessageSquad_Label,
	MessageSquad_OnLootStolen_ToolTip               =	Generic_MessageSquad_ToolTip,
	MessageFormatSquad_OnLootStolen_Label           =	Generic_MessageFormatSquad_Label,
	MessageFormatSquad_OnLootStolen_ToolTip         =	Generic_MessageFormatSquad_ToolTip,

	MessageSystem_OnLootStolen_Label 			    =	Generic_MessageSystem_Label,
	MessageSystem_OnLootStolen_ToolTip 				=	Generic_MessageSystem_ToolTip,
	MessageFormatSystem_OnLootStolen_Label 			=	Generic_MessageFormatSystem_Label,
	MessageFormatSystem_OnLootStolen_ToolTip 		=	Generic_MessageFormatSystem_ToolTip,


	OnLootSnatched_Enabled_Label				=	"On Loot Snatched",
	OnLootSnatched_Enabled_ToolTip			=	"When somebody loots an item that the addon had not yet assigned",

	MessageSquad_OnLootSnatched_Label 				=	Generic_MessageSquad_Label,
	MessageSquad_OnLootSnatched_ToolTip 			=	Generic_MessageSquad_ToolTip,
	MessageFormatSquad_OnLootSnatched_Label 		=	Generic_MessageFormatSquad_Label,
	MessageFormatSquad_OnLootSnatched_ToolTip 		=	Generic_MessageFormatSquad_ToolTip,

	MessageSystem_OnLootSnatched_Label 				=	Generic_MessageSystem_Label,
	MessageSystem_OnLootSnatched_ToolTip 			=	Generic_MessageSystem_ToolTip,
	MessageFormatSystem_OnLootSnatched_Label 		=	Generic_MessageFormatSystem_Label,
	MessageFormatSystem_OnLootSnatched_ToolTip 		=	Generic_MessageFormatSystem_ToolTip,


	OnLootClaimed_Enabled_Label				=	"On Loot Claimed",
	OnLootClaimed_Enabled_ToolTip			=	"When somebody loots an item that the addon had not found",

	MessageSquad_OnLootClaimed_Label 				=	Generic_MessageSquad_Label,
	MessageSquad_OnLootClaimed_ToolTip 				=	Generic_MessageSquad_ToolTip,
	MessageFormatSquad_OnLootClaimed_Label 			=	Generic_MessageFormatSquad_Label,
	MessageFormatSquad_OnLootClaimed_ToolTip 		=	Generic_MessageFormatSquad_ToolTip,

	MessageSystem_OnLootClaimed_Label          		=	Generic_MessageSystem_Label,
	MessageSystem_OnLootClaimed_ToolTip        		=	Generic_MessageSystem_ToolTip,
	MessageFormatSystem_OnLootClaimed_Label    		=	Generic_MessageFormatSystem_Label,
	MessageFormatSystem_OnLootClaimed_ToolTip  		=	Generic_MessageFormatSystem_ToolTip,


	OnAssignItem_Enabled_Label				=	"On Assign Item",
	OnAssignItem_Enabled_ToolTip				=	"When somebody is assigned an item",

	MessageSquad_OnAssignItem_Label           		=	Generic_MessageSquad_Label,
	MessageSquad_OnAssignItem_ToolTip         		=	Generic_MessageSquad_ToolTip,
	MessageFormatSquad_OnAssignItem_Label     		=	Generic_MessageFormatSquad_Label,
	MessageFormatSquad_OnAssignItem_ToolTip   		=	Generic_MessageFormatSquad_ToolTip,

	MessageSystem_OnAssignItem_Label 				=	Generic_MessageSystem_Label,
	MessageSystem_OnAssignItem_ToolTip 				=	Generic_MessageSystem_ToolTip,
	MessageFormatSystem_OnAssignItem_Label 			=	Generic_MessageFormatSystem_Label,
	MessageFormatSystem_OnAssignItem_ToolTip 		=	Generic_MessageFormatSystem_ToolTip,


	OnRollChange_Enabled_Label				=	"On Roll Change",
	OnRollChange_Enabled_ToolTip				=	"When a roll gets changed",

	MessageSquad_OnRollChange_Label           		=	Generic_MessageSquad_Label,
	MessageSquad_OnRollChange_ToolTip         		=	Generic_MessageSquad_ToolTip,
	MessageFormatSquad_OnRollChange_Label     		=	Generic_MessageFormatSquad_Label,
	MessageFormatSquad_OnRollChange_ToolTip   		=	Generic_MessageFormatSquad_ToolTip,

	MessageSystem_OnRollChange_Label 				=	Generic_MessageSystem_Label,
	MessageSystem_OnRollChange_ToolTip 				=	Generic_MessageSystem_ToolTip,
	MessageFormatSystem_OnRollChange_Label 			=	Generic_MessageFormatSystem_Label,
	MessageFormatSystem_OnRollChange_ToolTip 		=	Generic_MessageFormatSystem_ToolTip,


	OnRollAccept_Enabled_Label				=	"On Roll Accept",
	OnRollAccept_Enabled_ToolTip				=	"When a roll gets accepted",

	MessageSquad_OnRollAccept_Label           		=	Generic_MessageSquad_Label,
	MessageSquad_OnRollAccept_ToolTip         		=	Generic_MessageSquad_ToolTip,
	MessageFormatSquad_OnRollAccept_Label     		=	Generic_MessageFormatSquad_Label,
	MessageFormatSquad_OnRollAccept_ToolTip   		=	Generic_MessageFormatSquad_ToolTip,

	MessageSystem_OnRollAccept_Label 				=	Generic_MessageSystem_Label,
	MessageSystem_OnRollAccept_ToolTip 				=	Generic_MessageSystem_ToolTip,
	MessageFormatSystem_OnRollAccept_Label 			=	Generic_MessageFormatSystem_Label,
	MessageFormatSystem_OnRollAccept_ToolTip 		=	Generic_MessageFormatSystem_ToolTip,


	OnIdentify_Enabled_Label					=   "On Identify",
	OnIdentify_Enabled_ToolTip				=   "When the addon has discovered a new item",

	MessageSquad_OnIdentify_Label					=	Generic_MessageSquad_Label,
	MessageSquad_OnIdentify_ToolTip					=	Generic_MessageSquad_ToolTip,
	MessageFormatSquad_OnIdentify_Label				=	Generic_MessageFormatSquad_Label,
	MessageFormatSquad_OnIdentify_ToolTip			=	Generic_MessageFormatSquad_ToolTip,

	MessageSystem_OnIdentify_Label					=	Generic_MessageSystem_Label,
	MessageSystem_OnIdentify_ToolTip				=	Generic_MessageSystem_ToolTip,
	MessageFormatSystem_OnIdentify_Label			=	Generic_MessageFormatSystem_Label,
	MessageFormatSystem_OnIdentify_ToolTip			=	Generic_MessageFormatSystem_ToolTip,


	OnLootDespawn_Enabled_Label						=	"On Loot Despawn",
	OnLootDespawn_Enabled_ToolTip					=	"When a tracked item despawns",

	MessageSquad_OnLootDespawn_Label				=	Generic_MessageSquad_Label,
	MessageSquad_OnLootDespawn_ToolTip				=	Generic_MessageSquad_ToolTip,
	MessageFormatSquad_OnLootDespawn_Label			=	Generic_MessageFormatSquad_Label,
	MessageFormatSquad_OnLootDespawn_ToolTip		=	Generic_MessageFormatSquad_ToolTip,

	MessageSystem_OnLootDespawn_Label				=	Generic_MessageSystem_Label,
	MessageSystem_OnLootDespawn_ToolTip				=	Generic_MessageSystem_ToolTip,
	MessageFormatSystem_OnLootDespawn_Label			=	Generic_MessageFormatSystem_Label,
	MessageFormatSystem_OnLootDespawn_ToolTip		=	Generic_MessageFormatSystem_ToolTip,

	OnRollBusy_Enabled_Label						=	"On Roll Busy",
	OnRollBusy_Enabled_ToolTip						=	"When there is an attempt to start a new roll, but we're already busy rolling for something else",

	MessageSquad_OnRollBusy_Label					=	Generic_MessageSquad_Label,
	MessageSquad_OnRollBusy_ToolTip					=	Generic_MessageSquad_ToolTip,
	MessageFormatSquad_OnRollBusy_Label				=	Generic_MessageFormatSquad_Label,
	MessageFormatSquad_OnRollBusy_ToolTip			=	Generic_MessageFormatSquad_ToolTip,
	
	MessageSystem_OnRollBusy_Label					=	Generic_MessageSystem_Label,
	MessageSystem_OnRollBusy_ToolTip				=	Generic_MessageSystem_ToolTip,
	MessageFormatSystem_OnRollBusy_Label			=	Generic_MessageFormatSystem_Label,
	MessageFormatSystem_OnRollBusy_ToolTip			=	Generic_MessageFormatSystem_ToolTip,

	OnRollNobody_Enabled_Label						=	"On Roll Nobody",
	OnRollNobody_Enabled_ToolTip					=	"When a roll ends without anyone rolling",

	MessageSquad_OnRollNobody_Label					=	Generic_MessageSquad_Label,
	MessageSquad_OnRollNobody_ToolTip				=	Generic_MessageSquad_ToolTip,
	MessageFormatSquad_OnRollNobody_Label			=	Generic_MessageFormatSquad_Label,
	MessageFormatSquad_OnRollNobody_ToolTip			=	Generic_MessageFormatSquad_ToolTip,

	MessageSystem_OnRollNobody_Label				=	Generic_MessageSystem_Label,
	MessageSystem_OnRollNobody_ToolTip				=	Generic_MessageSystem_ToolTip,
	MessageFormatSystem_OnRollNobody_Label			=	Generic_MessageFormatSystem_Label,
	MessageFormatSystem_OnRollNobody_ToolTip		=	Generic_MessageFormatSystem_ToolTip,





	Group_Com_Label									=	"Communication",
	Group_Com_ToolTip								=	"Inter-addon communication options",

	ComPrefix_Label									=	"Prefix",
	ComPrefix_ToolTip								=	"Set the prefix for all public facing messages.",

	Communication_Custom_Label						=	"Enable Custom Communication Settings",
	Communication_Custom_ToolTip					=	"Warning: So much as touching any of these settings will break addon-to-addon communication. These settings should be identical between addon users. Disabling the mode will not reset settings. You've been warned.",
	Communication_Prefix_Label						=	"Communication Prefix",
	Communication_Prefix_ToolTip					=	"Prefix for all Communication messages. If changed, squad members must mirror.",
	Communication_Assign_Label 						=	"Communicate Assign",
	Communication_Assign_ToolTip 					=	"Turning this off will render other users unable to see who you've assigned items to when you are squad leader.",
	Communication_Assign_Format_Label				=	"Assign Format",
	Communication_Assign_Format_ToolTip				=	"Can't be customized because receiving end is hardcoded.",


	Subtab_Markers									=	"Markers",
	Group_Markers_Label								=	"Markers",

	Group_Waypoints_Label					=	"Waypoints",
	Group_Waypoints_ToolTip					=	"Toggle Waypoints",
		
	Waypoints_ShowOnHud_Label						=	"Show On Hud",
	Waypoints_ShowOnHud_ToolTip						=	"Show Waypoints on the HUD",
	Waypoints_ShowOnWorldMap_Label					=	"Show On WorldMap",
	Waypoints_ShowOnWorldMap_ToolTip				=	"Show Waypoints on the World Map",
	Waypoints_ShowOnRadar_Label						=	"Show On Radar",
	Waypoints_ShowOnRadar_ToolTip					=	"Show Waypoints on the Radar",
	Waypoints_RadarEdgeMode_Label 					=	"Radar Edge Mode",
	Waypoints_RadarEdgeMode_ToolTip 				=	"Behavior for Waypoint icons on the radar when outside range and the icon attaches to the radar edge\nNone : Hidden \nArrow: Nonspecific arrow icon \nIcon : Keep showing the same icon",
	Waypoints_RadarEdgeMode_none_Label 				=	"None",
	Waypoints_RadarEdgeMode_arrow_Label 			=	"Arrow",
	Waypoints_RadarEdgeMode_icon_Label 				=	"Icon",
 
 	Waypoints_TrailAssigned_Label					=	"Trail when loot is assigned to me",
	Waypoints_TrailAssigned_ToolTip					=	"When an item is assigned to you, the navigation trail is set to its waypoint. Requires 'Display Navigation' setting in 'Gameplay' options checked.",
	Waypoints_PingAssigned_Label					=	"Ping when loot is assigned to me",
	Waypoints_PingAssigned_ToolTip					=	"When an item is assigned to you, its waypoint will be pinged - drawing attention to it.",

	Group_Panels_Label						=	"Panels",
	Group_Panels_ToolTip					=	"Toggle Panels",

	Panels_Mode_Label								=	"Mode",	
	Panels_Mode_ToolTip								=	"Overall Panel display mode\nStandard: Full view\nSmall: Only header is shown",	
	Panels_Mode_Standard_Label						=	"Standard",			
	Panels_Mode_Small_Label							=	"Small",		
	Panels_HeaderBar_ColorMode_Label				=	"Header Color",					
	Panels_HeaderBar_ColorMode_ToolTip				=	"Set the color of the background of the panel header.",					
	Panels_HeaderBar_ColorMode_Quality_Label		=	"Match Quality",							
	Panels_HeaderBar_ColorMode_Custom_Label			=	"Custom",						
	Panels_Color_HeaderBar_ColorMode_Custom_Label	=	"Custom Color",						
	Panels_ItemName_ColorMode_Label					=	"Item Name Color",				
	Panels_ItemName_ColorMode_ToolTip				=	"Set the color of the item name text on the panel header.",					
	Panels_ItemName_ColorMode_Quality_Label			=	"Match Quality",						
	Panels_ItemName_ColorMode_Custom_Label			=	"Custom",
	Panels_Color_ItemName_ColorMode_Custom_Label	=	"Custom Color",	
	Panels_Display_AssignedTo_Label					=	"Display AssignedTo",				
	Panels_Display_AssignedTo_ToolTip				=	"Display who the item has been assigned to on the panel header.",					
	Color_AssignedTo_nil_Label						=	"AssignedTo Color Not assigned",
	Color_AssignedTo_free_Label						=	"AssignedTo Color Free for all",
	Color_AssignedTo_player_Label					=	"AssignedTo Color For you",
	Color_AssignedTo_other_Label					=	"AssignedTo Color For other",


	Subtab_Tracker									=   "Tracker",
	Group_Tracker_Label								=	"Tracker",


	Tracker_Enabled_Label							=   "Enabled",
	Tracker_Enabled_ToolTip							=   "Enables a HUDFrame that displays the currently tracked items.",
	Tracker_Display_Mode_Label 						= 	"Display Ruleset",
	Tracker_Display_Mode_ToolTip 					=	"Display the active ruleset (local)",
	Tracker_Display_Mode_OnlySquadLeader_Label  	=	"Only Display Ruleset when Squad Leader",
	Tracker_Display_Mode_OnlySquadLeader_ToolTip  	=	"It's pretty useless to display local ruleset if we are not the Squad Leader, so checking this option will keep it hidden if we are not the Squad Leader, even if Display Ruleset is checked.",
	Tracker_Display_Headings_Label 					=	"Display Headings",
	Tracker_Display_Headings_ToolTip				=	"Display headings for the Entry columns",


	Group_Sounds_Label								=	"Sounds",
	Subtab_Sounds									=	"Sounds",
	Sounds_Mute_Label								=	"Mute",
	Sounds_Mute_ToolTip								=	"If checked, no sounds will play",
	Sounds_OnIdentify_Label							=	"Item Detected",
	Sounds_OnIdentify_Rollable_Label				=	"...",
	Sounds_OnAssignItem_ToMe_Label					=	"Item Assigned To You",
	Sounds_OnAssignItem_ToOther_Label				=	"Item Assigned To Other",									

	Sounds_Option_none								=	"None",
	Sounds_Option_UI_Beep_06						=	"Beep 06",
	Sounds_Option_UI_Beep_08						=	"Beep 08",
	Sounds_Option_UI_Beep_09						=	"Beep 09",
	Sounds_Option_UI_Beep_10						=	"Beep 10",
	Sounds_Option_UI_Beep_12						=	"Beep 12",
	Sounds_Option_UI_Beep_13						=	"Beep 13",
	Sounds_Option_UI_Beep_20						=	"Beep 20",
	Sounds_Option_UI_Beep_23						=	"Beep 23",
	Sounds_Option_UI_Beep_26						=	"Beep 26",
	Sounds_Option_UI_Beep_27						=	"Beep 27",
	Sounds_Option_UI_Beep_35						=	"Beep 35",
	Sounds_Option_UI_CharacterCreate_Confirm		=	 "Character Create Confirm",
	Sounds_Option_UI_DailyRewardsScreen_Close		=	 "Daily Rewards Close",
	Sounds_Option_UI_DailyRewardsScreen_Open		=	 "Daily Rewards Open",
	Sounds_Option_UI_DailyRewardsScreen_ProgressShift	=	 "Daily Rewards Progress",
	Sounds_Option_UI_DailyRewardsScreen_RewardGranted	=	 "Daily Rewards Granted",
	Sounds_Option_UI_Friendly_Distress				=	 "Friendly Distress",
	Sounds_Option_UI_Garage_CPUUgrade				=	 "Garage CPU Upgrade",
	Sounds_Option_UI_Garage_MassUpgrade				=	 "Garage Mass Upgrade",
	Sounds_Option_UI_Garage_PowerUpgrade			=	 "Garage Power Upgrade",
	Sounds_Option_UI_Garage_UnlockSlot				=	 "Garage Unlock Slot",
	Sounds_Option_UI_Interact_Available				=	 "Interact Available",
	Sounds_Option_UI_Intermission					=	 "Intermission",
	Sounds_Option_UI_Login							=	 "Login",
	Sounds_Option_UI_Login_Back						=	 "Login Back",
	Sounds_Option_UI_Login_Click					=	 "Login Click",
	Sounds_Option_UI_Login_Confirm					=	 "Login Confirm",
	Sounds_Option_UI_Login_Keystroke				=	 "Login Keystroke",
	Sounds_Option_UI_MapClose						=	 "Map Close",
	Sounds_Option_UI_MapMarker_GetFocus				=	 "Map Marker Get Focus",
	Sounds_Option_UI_MapMarker_LostFocus			=	 "Map Marker Lost Focus",
	Sounds_Option_UI_MapOpen						=	 "Map Open",
	Sounds_Option_UI_Map_DetailClose				=	 "Map Detail Close",
	Sounds_Option_UI_Map_DetailOpen					=	 "Map Detail Open",
	Sounds_Option_UI_Map_ZoomIn						=	 "Map Zoom In",
	Sounds_Option_UI_Map_ZoomOut					=	 "Map Zoom Out",
	Sounds_Option_UI_NavWheel_Close					=	 "NavWheel Close",
	Sounds_Option_UI_NavWheel_MouseLeftButton		=	 "NavWheel MouseLeftButton",
	Sounds_Option_UI_NavWheel_MouseLeftButton_Initiate	=	 "NavWheel MouseLeftButton Initiate",
	Sounds_Option_UI_NavWheel_MouseRightButton		=	"NavWheel MouseRightButton",
	Sounds_Option_UI_NavWheel_MouseScroll			=	"NavWheel MouseScroll",
	Sounds_Option_UI_NavWheel_Open					=	"NavWheel Open",
	Sounds_Option_UI_RewardNotification				=	"Reward Notification",
	Sounds_Option_UI_RewardScreenOpen				=	"Reward Screen Open",
	Sounds_Option_UI_RewardsAward					=	"Rewards Award",
	Sounds_Option_UI_SINView_Mode					=	"SINView Mode",
	Sounds_Option_UI_SIN_Acquired					=	"SIN Acquired",
	Sounds_Option_UI_SIN_ExtraInfo_Off				=	"SIN ExtraInfo Off",
	Sounds_Option_UI_SIN_ExtraInfo_On				=	"SIN ExtraInfo On",
	Sounds_Option_UI_SlideNotification				=	"Slide Notification",
	Sounds_Option_UI_Squad_Join						=	"Squad Join",
	Sounds_Option_UI_Squad_Leave					=	"Squad Leave",
	Sounds_Option_UI_StatsAward						=	"StatsAward",
	Sounds_Option_UI_Ticker_1stStageIntro   		= 	"Ticker 1st Stage",
	Sounds_Option_UI_Ticker_2ndStageIntro   		= 	"Ticker 2nd Stage",
	Sounds_Option_UI_Ticker_LoudSecondTick   		= 	"Ticker Loud Second",
	Sounds_Option_UI_Ticker_LowPulse   				= 	"Ticker Low Pulse",
	Sounds_Option_UI_Ticker_QuietSecondTick   		= 	"Ticker Quiet Second",
	Sounds_Option_UI_Ticker_ZeroTick   				= 	"Ticker Zero",
	Sounds_Option_SFX_UI_AbilitySelect01_v4			=	"Ability Select 1",
	Sounds_Option_SFX_UI_AbilitySelect03_v4			=	"Ability Select 3",
	Sounds_Option_SFX_UI_AchievementEarned   		= 	"Achievement Earned",
	Sounds_Option_SFX_UI_Ding   					= 	"Ding",
	Sounds_Option_SFX_UI_E_Initiate_Loop   			= 	"E Loop",
	Sounds_Option_SFX_UI_End   						= 	"End",
	Sounds_Option_SFX_UI_FriendOffline   			= 	"Friend Offline",
	Sounds_Option_SFX_UI_FriendOnline   			= 	"Friend Online",
	Sounds_Option_SFX_UI_GeneralAnnouncement		=	"General Announcement",
	Sounds_Option_SFX_UI_GeneralConfirm14_v2   		= 	"General Confirm14",
	Sounds_Option_SFX_UI_Loot_Abilities				=	"Loot Ability",
	Sounds_Option_SFX_UI_Loot_Backpack_Pickup		=	"Loot Backpack Pickup",
	Sounds_Option_SFX_UI_Loot_Basic					=	"Loot Basic",
	Sounds_Option_SFX_UI_Loot_Battleframe_Pickup	=	"Loot Battleframe Pickup",
	Sounds_Option_SFX_UI_Loot_Crystite				=	"Loot Crystite",
	Sounds_Option_SFX_UI_Loot_Flyover				=	"Loot Flyover",
	Sounds_Option_SFX_UI_Loot_PowerUp				=	"Loot PowerUp",
	Sounds_Option_SFX_UI_Loot_Weapon_Pickup			=	"Loot Weapon Pickup",
	Sounds_Option_SFX_UI_OCT_1MinWarning			=	"OCT 1 Min Warning",
	Sounds_Option_SFX_UI_SIN_CooldownFail			=	"SIN Cooldown Fail",
	Sounds_Option_SFX_UI_Ticker						=	"Ticker",
	Sounds_Option_SFX_UI_TipPopUp					=	"Tip PopUp",
	Sounds_Option_SFX_WebUI_Close					=	"Web Close",
	Sounds_Option_SFX_WebUI_Equip_BackpackModule	=	"Web Equip Backpack Module",
	Sounds_Option_SFX_WebUI_Equip_Battleframe		=	"Web Equip Battleframe",
	Sounds_Option_SFX_WebUI_Equip_BattleframeModule	=	"Web Equip Battleframe Module",
	Sounds_Option_SFX_WebUI_Equip_Weapon			=	"Web Equip Weapon",
	Sounds_Option_SFX_WebUI_ModalWindow				=	"Web Modal",
	Sounds_Option_SFX_WebUI_Open					=	"Web Open",
	Sounds_Option_SFX_UI_WhisperTickle				=	"Whisper Tickle",
	Sounds_Option_UI_ARESMIssions_Pickup_Generic01	=	"ARES Pickup Generic01",
	Sounds_Option_UI_Ability_Selection				=	"Ability Selection",
	Sounds_Option_UI_Ability_Trigger				=	"Ability Trigger",
	Sounds_Option_UI_VOIP_CloseChannel				=	"VOIP Close Channel",
	Sounds_Option_UI_VOIP_OpenChannel				=	"VOIP Open Channel",
	Sounds_Option_UI_ZoneSelect_Confirm				=	"Zone Select Confirm",
	Sounds_Option_UI_sfx_warning_Ammo				=	"Warning Ammo",
	Sounds_Option_ui_abilities_cooldown_complete	=	"Abilities Cooldown Complete",
	Sounds_Option_SFX_UI_E_Initiate_Loop_Fail		=	"E Fail",
	Sounds_Option_SFX_UI_E_Initiate_Loop_Success	=	"E Success",
	Sounds_Option_SlotMachine_PullLever				=	"Slot Machine Pull Lever",
	Sounds_Option_SlotMachine_InsertCoin			=	"Slot Machine Insert Coin",
	Sounds_Option_SlotMachine_EpicDecryption		=	"Slot Machine Epic Decrypt",
	Sounds_Option_SlotMachine_Decryption 			=	"Slot Machine Decrypt",
}




-- Reused
Detect =    "Detect"
Distribute =    "Distribute"
Mark =    "Mark"
Simple =    "Simple"
Stage1 =    "Stage 1"
Stage2 =    "Stage 2"
Stage3 =    "Stage 3"
Stage4 =    "Stage 4"
EquipmentItems =    "Equipment Items"
CraftingComponents =    "Crafting Components"

function DetectDistributeMarkX_Label(type, stage, x)
    return type.." "..stage.." "..x
end

function DetectDistributeMarkX_ToolTip(type, stage, x)
    return "Toggle whether "..stage.." "..x.." should be "..type.."ed."
end


function FilterGenericX_Label(stage, x)
    return 'Enable '..stage.." "..x
end

function FilterGenericX_ToolTip(stage, x)
    return "Toggle whether this action should be active for "..stage.." "..x.."s."
end


ModeX_Label                                     =    "Mode" 
ModeX_ToolTip                                   =    "Simple or Advanced configuration mode."

SimpleEnabled_Label                             =    "Simple"
SimpleEnabled_ToolTip                           =    "If in Simple configuraiton mode, only these settings are used."

LootMode_Label                                  =    "Ruleset"
LootMode_ToolTip                                =    "Set the active ruleset/mode for how loot is distributed. This is affected by the weighting and threshold settings as well.\nRandom: Assigns the item to a random eligible group member\nDice: Rolls for each eligible member and assigns the item to the highest roller\nRound-robin: Awards items to each group member in order. Loot weighting doesn't work in this mode.\nNeed before Greed: Accepts need, greed or pass call from each eligible group member"
LootWeighting_Label                             =    "Weighting"
LootWeighting_ToolTip                           =    "Sets the active loot weighting criteria, which can be used to disallow users from rolling on loot drops that their currently active frame cannot use.\nDisabled: No loot weighting.\nArchetype: Only players in the same Battleframe Archetype as the item are eligible."
QualityThreshold_Label                          =    "Quality Threshold"
QualityThreshold_ToolTip                        =    "Loot below this quality threshold will not be distributed."
QualityThresholdCustomValue_Label               =    "Custom Quality Threshold"
QualityThresholdCustomValue_ToolTip             =    "If Quality Threshold is set to Custom, loot below this quality threshold will not be distributed."
TierThreshold_Label                             =    "Tier Threshold"
TierThreshold_ToolTip                           =    "Loot below this tier will not be distributed."
LootMode_Label                                  =    "Ruleset"
LootMode_ToolTip                                =    "Loot will be distributed according to this ruleset."
-- ----------


Generic_MessageFormat = "Specify the format of the message. The following replacement variables exist, please note that they're not always available.\n%m : Current ruleset/mode\n%i : The item name. If ^Q is encountered, it is removed.\n%q : The item quality\n%iq : The item name. If ^Q is encountered, it is replaced with the item quality.\n%n : The player name\n%r : The roll value\n%l : Playername, person who looted the item\n%a : Playername, person who the item is assigned to\n%e : Comma separated line of players able to need roll"

Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label              =    "Send Squad Message"
Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip            =    "Send message to Squad on this event"
Generic_Messages_Events_X_Event_Channels_Squad_Format_Label               =    "Squad Message Format"
Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip             =     Generic_MessageFormat
Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label      =    "Send Notifications Message"
Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip    =    "Send message to Notifications on this event"
Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label       =    "Notifications Message Format"
Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip     =     Generic_MessageFormat
Generic_Messages_Events_X_Event_Channels_System_Enabled_Label             =    "Send System Message"
Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip           =    "Send message to System on this event"
Generic_Messages_Events_X_Event_Channels_System_Format_Label              =    "System Message Format"
Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip            =     Generic_MessageFormat


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

    Filter_Generic_LootMode_Label                                                   =    LootMode_Label,
    Filter_Generic_LootMode_ToolTip                                                 =    LootMode_ToolTip,
    Filter_Generic_Weighting_Label                                                  =    LootWeighting_Label,
    Filter_Generic_Weighting_ToolTip                                                =    LootWeighting_ToolTip,
    Filter_Generic_TierThreshold_Label                                              =    TierThreshold_Label,
    Filter_Generic_TierThreshold_ToolTip                                            =    TierThreshold_ToolTip,
    Filter_Generic_QualityThreshold_Label                                           =    QualityThreshold_Label,
    Filter_Generic_QualityThreshold_ToolTip                                         =    QualityThreshold_ToolTip,
    Filter_Generic_QualityThresholdCustomValue_Label                                =    QualityThresholdCustomValue_Label,
    Filter_Generic_QualityThresholdCustomValue_ToolTip                              =    QualityThresholdCustomValue_ToolTip,



    Filter_Generic_EquipmentItems_Enabled_Label                                     =    "Equipment Items Enabled",
    Filter_Generic_EquipmentItems_Enabled_ToolTip                                   =    "Toggle",
    Filter_Generic_EquipmentItems_Mode_Label                                        =    "Equipment Items Mode",
    Filter_Generic_EquipmentItems_Mode_ToolTip                                      =    "Simple or Advanced configuration mode.",

    Filter_Generic_CraftingComponents_Enabled_Label                                 =    "Crafting Components Enabled",
    Filter_Generic_CraftingComponents_Enabled_ToolTip                               =    "Toggle",
    Filter_Generic_CraftingComponents_Mode_Label                                    =    "Crafting Components Mode",
    Filter_Generic_CraftingComponents_Mode_ToolTip                                  =    "Simple or Advanced configuration mode.",

    Filter_Generic_CraftingComponents_Simple_Enabled_Label                          =    SimpleEnabled_Label,
    Filter_Generic_CraftingComponents_Simple_Enabled_ToolTip                        =    SimpleEnabled_ToolTip,  
    Filter_Generic_CraftingComponents_Stage1_Enabled_Label                          =    FilterGenericX_Label(Stage1, CraftingComponents),
    Filter_Generic_CraftingComponents_Stage1_Enabled_ToolTip                        =    FilterGenericX_ToolTip(Stage1, CraftingComponents), 
    Filter_Generic_CraftingComponents_Stage2_Enabled_Label                          =    FilterGenericX_Label(Stage2, CraftingComponents),
    Filter_Generic_CraftingComponents_Stage2_Enabled_ToolTip                        =    FilterGenericX_ToolTip(Stage2, CraftingComponents), 
    Filter_Generic_CraftingComponents_Stage3_Enabled_Label                          =    FilterGenericX_Label(Stage3, CraftingComponents),
    Filter_Generic_CraftingComponents_Stage3_Enabled_ToolTip                        =    FilterGenericX_ToolTip(Stage3, CraftingComponents), 
    Filter_Generic_CraftingComponents_Stage4_Enabled_Label                          =    FilterGenericX_Label(Stage4, CraftingComponents),
    Filter_Generic_CraftingComponents_Stage4_Enabled_ToolTip                        =    FilterGenericX_ToolTip(Stage4, CraftingComponents),

    Filter_Generic_EquipmentItems_Simple_Enabled_Label                              =    SimpleEnabled_Label,
    Filter_Generic_EquipmentItems_Simple_Enabled_ToolTip                            =    SimpleEnabled_ToolTip,  
    Filter_Generic_EquipmentItems_Stage1_Enabled_Label                              =    FilterGenericX_Label(Stage1, EquipmentItems),
    Filter_Generic_EquipmentItems_Stage1_Enabled_ToolTip                            =    FilterGenericX_ToolTip(Stage1, EquipmentItems), 
    Filter_Generic_EquipmentItems_Stage2_Enabled_Label                              =    FilterGenericX_Label(Stage2, EquipmentItems),
    Filter_Generic_EquipmentItems_Stage2_Enabled_ToolTip                            =    FilterGenericX_ToolTip(Stage2, EquipmentItems), 
    Filter_Generic_EquipmentItems_Stage3_Enabled_Label                              =    FilterGenericX_Label(Stage3, EquipmentItems),
    Filter_Generic_EquipmentItems_Stage3_Enabled_ToolTip                            =    FilterGenericX_ToolTip(Stage3, EquipmentItems), 
    Filter_Generic_EquipmentItems_Stage4_Enabled_Label                              =    FilterGenericX_Label(Stage4, EquipmentItems),
    Filter_Generic_EquipmentItems_Stage4_Enabled_ToolTip                            =    FilterGenericX_ToolTip(Stage4, EquipmentItems),


    Messages_Generic_Channels_Squad_Enabled_Label                                   =    Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label,
    Messages_Generic_Channels_Squad_Enabled_ToolTip                                 =    Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip,
    Messages_Generic_Channels_Squad_Format_Label                                    =    Generic_Messages_Events_X_Event_Channels_Squad_Format_Label,
    Messages_Generic_Channels_Squad_Format_ToolTip                                  =    Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip,
    Messages_Generic_Channels_System_Enabled_Label                                  =    Generic_Messages_Events_X_Event_Channels_System_Enabled_Label,
    Messages_Generic_Channels_System_Enabled_ToolTip                                =    Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip,
    Messages_Generic_Channels_System_Format_Label                                   =    Generic_Messages_Events_X_Event_Channels_System_Format_Label,
    Messages_Generic_Channels_System_Format_ToolTip                                 =    Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip,
    Messages_Generic_Channels_Notifications_Enabled_Label                           =    Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label,
    Messages_Generic_Channels_Notifications_Enabled_ToolTip                         =    Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip,
    Messages_Generic_Channels_Notifications_Format_Label                            =    Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label,
    Messages_Generic_Channels_Notifications_Format_ToolTip                          =    Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip,




    Group_Com_Label                                                                 =    "Communication",
    Group_Com_ToolTip                                                               =    "Inter-addon communication options",


    
    Messages_Enabled_Label                                                          =    "Enable Messages",
    Messages_Enabled_ToolTip                                                        =    "The addon will send customizable Messages to the Chat when certain events occur, keeping you and your Squad members in the loop of what is going on with the item drops.",
    Messages_Prefix_Label                                                           =    "Generic Prefix",
    Messages_Prefix_ToolTip                                                         =    "Set the prefix for all public facing messages.",
    Messages_Channels_Squad_Label                                                   =    "Send on Squad Channel",
    Messages_Channels_Squad_ToolTip                                                 =    "Master switch for Squad messages. The addon will not send ANY squad messages if this is checked, regardless of other settings.",
    Messages_Channels_Notifications_Label                                           =    "Send on Notifications Channel",
    Messages_Channels_Notifications_ToolTip                                         =    "Master switch for Notification messages. The addon will not send ANY notification messages if this is checked, regardless of other settings.",
    Messages_Channels_System_Label                                                  =    "Send on System Channel",
    Messages_Channels_System_ToolTip                                                =    "Master switch for System messages. The addon will not send ANY system messages if this is checked, regardless of other settings.",
    Messages_Communication_Prefix_Label                                             =    "Communication Prefix",
    Messages_Communication_Prefix_ToolTip                                           =    "Prefix for all Communication messages. If changed, squad members must mirror.",
    Messages_Communication_Custom_Label                                             =    "Enable Custom Communication Settings",
    Messages_Communication_Custom_ToolTip                                           =    "Warning: So much as touching any of these settings will break addon-to-addon communication. These settings should be identical between addon users. Disabling the mode will not reset settings. You've been warned.",
    Messages_Communication_Assign_Enabled_Label                                     =    "Communicate Assign",
    Messages_Communication_Assign_Enabled_ToolTip                                   =    "Turning this off will render other users unable to see who you've assigned items to when you are squad leader.",
    Messages_Communication_Assign_Format_Label                                      =    "Assign Format",
    Messages_Communication_Assign_Format_ToolTip                                    =    "Can't be customized because receiving end is hardcoded.",



    Messages_Events_Distribution_OnRollNobody_Enabled_Label                             =    "On Roll Nobody",                                                          
    Messages_Events_Distribution_OnRollNobody_Enabled_ToolTip                           =    "When a roll ends without anyone rolling",
    Messages_Events_Distribution_OnRollNobody_Channels_Squad_Enabled_Label              = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label,
    Messages_Events_Distribution_OnRollNobody_Channels_Squad_Enabled_ToolTip            = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip,
    Messages_Events_Distribution_OnRollNobody_Channels_Squad_Format_Label               = Generic_Messages_Events_X_Event_Channels_Squad_Format_Label,
    Messages_Events_Distribution_OnRollNobody_Channels_Squad_Format_ToolTip             = Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip,
    Messages_Events_Distribution_OnRollNobody_Channels_Notifications_Enabled_Label      = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label,
    Messages_Events_Distribution_OnRollNobody_Channels_Notifications_Enabled_ToolTip    = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip,
    Messages_Events_Distribution_OnRollNobody_Channels_Notifications_Format_Label       = Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label,
    Messages_Events_Distribution_OnRollNobody_Channels_Notifications_Format_ToolTip     = Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip,
    Messages_Events_Distribution_OnRollNobody_Channels_System_Enabled_Label             = Generic_Messages_Events_X_Event_Channels_System_Enabled_Label,
    Messages_Events_Distribution_OnRollNobody_Channels_System_Enabled_ToolTip           = Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip,
    Messages_Events_Distribution_OnRollNobody_Channels_System_Format_Label              = Generic_Messages_Events_X_Event_Channels_System_Format_Label,
    Messages_Events_Distribution_OnRollNobody_Channels_System_Format_ToolTip            = Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip,
    Messages_Events_Distribution_OnAssignItem_Enabled_Label                             =    "On Assign Item",
    Messages_Events_Distribution_OnAssignItem_Enabled_ToolTip                           =    "When somebody is assigned an item",
    Messages_Events_Distribution_OnAssignItem_Channels_Squad_Enabled_Label              = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label,
    Messages_Events_Distribution_OnAssignItem_Channels_Squad_Enabled_ToolTip            = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip,
    Messages_Events_Distribution_OnAssignItem_Channels_Squad_Format_Label               = Generic_Messages_Events_X_Event_Channels_Squad_Format_Label,
    Messages_Events_Distribution_OnAssignItem_Channels_Squad_Format_ToolTip             = Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip,
    Messages_Events_Distribution_OnAssignItem_Channels_Notifications_Enabled_Label      = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label,
    Messages_Events_Distribution_OnAssignItem_Channels_Notifications_Enabled_ToolTip    = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip,
    Messages_Events_Distribution_OnAssignItem_Channels_Notifications_Format_Label       = Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label,
    Messages_Events_Distribution_OnAssignItem_Channels_Notifications_Format_ToolTip     = Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip,
    Messages_Events_Distribution_OnAssignItem_Channels_System_Enabled_Label             = Generic_Messages_Events_X_Event_Channels_System_Enabled_Label,
    Messages_Events_Distribution_OnAssignItem_Channels_System_Enabled_ToolTip           = Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip,
    Messages_Events_Distribution_OnAssignItem_Channels_System_Format_Label              = Generic_Messages_Events_X_Event_Channels_System_Format_Label,
    Messages_Events_Distribution_OnAssignItem_Channels_System_Format_ToolTip            = Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip,
    Messages_Events_Distribution_OnDistributeItem_Enabled_Label                         =    "On Distribute Item",
    Messages_Events_Distribution_OnDistributeItem_Enabled_ToolTip                       =    "When an item is being assigned",
    Messages_Events_Distribution_OnDistributeItem_Channels_Squad_Enabled_Label          = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label,
    Messages_Events_Distribution_OnDistributeItem_Channels_Squad_Enabled_ToolTip        = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip,
    Messages_Events_Distribution_OnDistributeItem_Channels_Squad_Format_Label           = Generic_Messages_Events_X_Event_Channels_Squad_Format_Label,
    Messages_Events_Distribution_OnDistributeItem_Channels_Squad_Format_ToolTip         = Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip,
    Messages_Events_Distribution_OnDistributeItem_Channels_Notifications_Enabled_Label  = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label,
    Messages_Events_Distribution_OnDistributeItem_Channels_Notifications_Enabled_ToolTip= Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip,   Messages_Events_Distribution_OnDistributeItem_Channels_Notifications_Format_Label   = Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label,
    Messages_Events_Distribution_OnDistributeItem_Channels_Notifications_Format_ToolTip = Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip,
    Messages_Events_Distribution_OnDistributeItem_Channels_System_Enabled_Label         = Generic_Messages_Events_X_Event_Channels_System_Enabled_Label,
    Messages_Events_Distribution_OnDistributeItem_Channels_System_Enabled_ToolTip       = Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip,
    Messages_Events_Distribution_OnDistributeItem_Channels_System_Format_Label          = Generic_Messages_Events_X_Event_Channels_System_Format_Label,
    Messages_Events_Distribution_OnDistributeItem_Channels_System_Format_ToolTip        = Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip,
    Messages_Events_Distribution_OnRolls_Enabled_Label                                  =    "On Rolls",
    Messages_Events_Distribution_OnRolls_Enabled_ToolTip                                =    "When a roll is calculated",
    Messages_Events_Distribution_OnRolls_Channels_Squad_Enabled_Label                   = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label,
    Messages_Events_Distribution_OnRolls_Channels_Squad_Enabled_ToolTip                 = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip,
    Messages_Events_Distribution_OnRolls_Channels_Squad_Format_Label                    = Generic_Messages_Events_X_Event_Channels_Squad_Format_Label,
    Messages_Events_Distribution_OnRolls_Channels_Squad_Format_ToolTip                  = Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip,
    Messages_Events_Distribution_OnRolls_Channels_Notifications_Enabled_Label           = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label,
    Messages_Events_Distribution_OnRolls_Channels_Notifications_Enabled_ToolTip         = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip,
    Messages_Events_Distribution_OnRolls_Channels_Notifications_Format_Label            = Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label,
    Messages_Events_Distribution_OnRolls_Channels_Notifications_Format_ToolTip          = Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip,
    Messages_Events_Distribution_OnRolls_Channels_System_Enabled_Label                  = Generic_Messages_Events_X_Event_Channels_System_Enabled_Label,
    Messages_Events_Distribution_OnRolls_Channels_System_Enabled_ToolTip                = Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip,
    Messages_Events_Distribution_OnRolls_Channels_System_Format_Label                   = Generic_Messages_Events_X_Event_Channels_System_Format_Label,
    Messages_Events_Distribution_OnRolls_Channels_System_Format_ToolTip                 = Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip,
    Messages_Events_Distribution_OnRollAccept_Enabled_Label                             =    "On Roll Accept",
    Messages_Events_Distribution_OnRollAccept_Enabled_ToolTip                           =    "When a roll gets accepted",
    Messages_Events_Distribution_OnRollAccept_Channels_Squad_Enabled_Label              = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label,
    Messages_Events_Distribution_OnRollAccept_Channels_Squad_Enabled_ToolTip            = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip,
    Messages_Events_Distribution_OnRollAccept_Channels_Squad_Format_Label               = Generic_Messages_Events_X_Event_Channels_Squad_Format_Label,
    Messages_Events_Distribution_OnRollAccept_Channels_Squad_Format_ToolTip             = Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip,
    Messages_Events_Distribution_OnRollAccept_Channels_Notifications_Enabled_Label      = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label,
    Messages_Events_Distribution_OnRollAccept_Channels_Notifications_Enabled_ToolTip    = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip,
    Messages_Events_Distribution_OnRollAccept_Channels_Notifications_Format_Label       = Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label,
    Messages_Events_Distribution_OnRollAccept_Channels_Notifications_Format_ToolTip     = Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip,
    Messages_Events_Distribution_OnRollAccept_Channels_System_Enabled_Label             = Generic_Messages_Events_X_Event_Channels_System_Enabled_Label,
    Messages_Events_Distribution_OnRollAccept_Channels_System_Enabled_ToolTip           = Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip,
    Messages_Events_Distribution_OnRollAccept_Channels_System_Format_Label              = Generic_Messages_Events_X_Event_Channels_System_Format_Label,
    Messages_Events_Distribution_OnRollAccept_Channels_System_Format_ToolTip            = Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip,
    Messages_Events_Distribution_OnRollBusy_Enabled_Label                               =    "On Roll Busy",
    Messages_Events_Distribution_OnRollBusy_Enabled_ToolTip                             =    "When there is an attempt to start a new roll, but we're already busy rolling for something else",
    Messages_Events_Distribution_OnRollBusy_Channels_Squad_Enabled_Label                = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label,
    Messages_Events_Distribution_OnRollBusy_Channels_Squad_Enabled_ToolTip              = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip,
    Messages_Events_Distribution_OnRollBusy_Channels_Squad_Format_Label                 = Generic_Messages_Events_X_Event_Channels_Squad_Format_Label,
    Messages_Events_Distribution_OnRollBusy_Channels_Squad_Format_ToolTip               = Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip,
    Messages_Events_Distribution_OnRollBusy_Channels_Notifications_Enabled_Label        = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label,
    Messages_Events_Distribution_OnRollBusy_Channels_Notifications_Enabled_ToolTip      = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip,
    Messages_Events_Distribution_OnRollBusy_Channels_Notifications_Format_Label         = Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label,
    Messages_Events_Distribution_OnRollBusy_Channels_Notifications_Format_ToolTip       = Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip,
    Messages_Events_Distribution_OnRollBusy_Channels_System_Enabled_Label               = Generic_Messages_Events_X_Event_Channels_System_Enabled_Label,
    Messages_Events_Distribution_OnRollBusy_Channels_System_Enabled_ToolTip             = Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip,
    Messages_Events_Distribution_OnRollBusy_Channels_System_Format_Label                = Generic_Messages_Events_X_Event_Channels_System_Format_Label,
    Messages_Events_Distribution_OnRollBusy_Channels_System_Format_ToolTip              = Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip,
    Messages_Events_Distribution_OnRollChange_Enabled_Label                             =    "On Roll Change",
    Messages_Events_Distribution_OnRollChange_Enabled_ToolTip                           =    "When a roll gets changed",
    Messages_Events_Distribution_OnRollChange_Channels_Squad_Enabled_Label              = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label,
    Messages_Events_Distribution_OnRollChange_Channels_Squad_Enabled_ToolTip            = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip,
    Messages_Events_Distribution_OnRollChange_Channels_Squad_Format_Label               = Generic_Messages_Events_X_Event_Channels_Squad_Format_Label,
    Messages_Events_Distribution_OnRollChange_Channels_Squad_Format_ToolTip             = Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip,
    Messages_Events_Distribution_OnRollChange_Channels_Notifications_Enabled_Label      = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label,
    Messages_Events_Distribution_OnRollChange_Channels_Notifications_Enabled_ToolTip    = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip,
    Messages_Events_Distribution_OnRollChange_Channels_Notifications_Format_Label       = Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label,
    Messages_Events_Distribution_OnRollChange_Channels_Notifications_Format_ToolTip     = Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip,
    Messages_Events_Distribution_OnRollChange_Channels_System_Enabled_Label             = Generic_Messages_Events_X_Event_Channels_System_Enabled_Label,
    Messages_Events_Distribution_OnRollChange_Channels_System_Enabled_ToolTip           = Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip,
    Messages_Events_Distribution_OnRollChange_Channels_System_Format_Label              = Generic_Messages_Events_X_Event_Channels_System_Format_Label,
    Messages_Events_Distribution_OnRollChange_Channels_System_Format_ToolTip            = Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip,
    Messages_Events_Distribution_OnAcceptingRolls_Enabled_Label                         =    "On Accepting Rolls",
    Messages_Events_Distribution_OnAcceptingRolls_Enabled_ToolTip                       =    "When the addon is listening for roll declarations",
    Messages_Events_Distribution_OnAcceptingRolls_Channels_Squad_Enabled_Label          = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label,
    Messages_Events_Distribution_OnAcceptingRolls_Channels_Squad_Enabled_ToolTip        = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip,
    Messages_Events_Distribution_OnAcceptingRolls_Channels_Squad_Format_Label           = Generic_Messages_Events_X_Event_Channels_Squad_Format_Label,
    Messages_Events_Distribution_OnAcceptingRolls_Channels_Squad_Format_ToolTip         = Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip,
    Messages_Events_Distribution_OnAcceptingRolls_Channels_Notifications_Enabled_Label  = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label,
    Messages_Events_Distribution_OnAcceptingRolls_Channels_Notifications_Enabled_ToolTip= Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip,   Messages_Events_Distribution_OnAcceptingRolls_Channels_Notifications_Format_Label   = Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label,
    Messages_Events_Distribution_OnAcceptingRolls_Channels_Notifications_Format_ToolTip = Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip,
    Messages_Events_Distribution_OnAcceptingRolls_Channels_System_Enabled_Label         = Generic_Messages_Events_X_Event_Channels_System_Enabled_Label,
    Messages_Events_Distribution_OnAcceptingRolls_Channels_System_Enabled_ToolTip       = Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip,
    Messages_Events_Distribution_OnAcceptingRolls_Channels_System_Format_Label          = Generic_Messages_Events_X_Event_Channels_System_Format_Label,
    Messages_Events_Distribution_OnAcceptingRolls_Channels_System_Format_ToolTip        = Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip,
    Messages_Events_Detection_OnLootStolen_Enabled_Label                                =    "On Loot Stolen",
    Messages_Events_Detection_OnLootStolen_Enabled_ToolTip                              =    "When somebody loots an item that was assigned to someone else",
    Messages_Events_Detection_OnLootStolen_Channels_Squad_Enabled_Label                 = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label,
    Messages_Events_Detection_OnLootStolen_Channels_Squad_Enabled_ToolTip               = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip,
    Messages_Events_Detection_OnLootStolen_Channels_Squad_Format_Label                  = Generic_Messages_Events_X_Event_Channels_Squad_Format_Label,
    Messages_Events_Detection_OnLootStolen_Channels_Squad_Format_ToolTip                = Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip,
    Messages_Events_Detection_OnLootStolen_Channels_Notifications_Enabled_Label         = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label,
    Messages_Events_Detection_OnLootStolen_Channels_Notifications_Enabled_ToolTip       = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip,
    Messages_Events_Detection_OnLootStolen_Channels_Notifications_Format_Label          = Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label,
    Messages_Events_Detection_OnLootStolen_Channels_Notifications_Format_ToolTip        = Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip,
    Messages_Events_Detection_OnLootStolen_Channels_System_Enabled_Label                = Generic_Messages_Events_X_Event_Channels_System_Enabled_Label,
    Messages_Events_Detection_OnLootStolen_Channels_System_Enabled_ToolTip              = Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip,
    Messages_Events_Detection_OnLootStolen_Channels_System_Format_Label                 = Generic_Messages_Events_X_Event_Channels_System_Format_Label,
    Messages_Events_Detection_OnLootStolen_Channels_System_Format_ToolTip               = Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip,
    Messages_Events_Detection_OnLootClaimed_Enabled_Label                               =    "On Loot Claimed",
    Messages_Events_Detection_OnLootClaimed_Enabled_ToolTip                             =    "When somebody loots an item that the addon had not found",
    Messages_Events_Detection_OnLootClaimed_Channels_Squad_Enabled_Label                = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label,
    Messages_Events_Detection_OnLootClaimed_Channels_Squad_Enabled_ToolTip              = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip,
    Messages_Events_Detection_OnLootClaimed_Channels_Squad_Format_Label                 = Generic_Messages_Events_X_Event_Channels_Squad_Format_Label,
    Messages_Events_Detection_OnLootClaimed_Channels_Squad_Format_ToolTip               = Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip,
    Messages_Events_Detection_OnLootClaimed_Channels_Notifications_Enabled_Label        = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label,
    Messages_Events_Detection_OnLootClaimed_Channels_Notifications_Enabled_ToolTip      = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip,
    Messages_Events_Detection_OnLootClaimed_Channels_Notifications_Format_Label         = Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label,
    Messages_Events_Detection_OnLootClaimed_Channels_Notifications_Format_ToolTip       = Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip,
    Messages_Events_Detection_OnLootClaimed_Channels_System_Enabled_Label               = Generic_Messages_Events_X_Event_Channels_System_Enabled_Label,
    Messages_Events_Detection_OnLootClaimed_Channels_System_Enabled_ToolTip             = Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip,
    Messages_Events_Detection_OnLootClaimed_Channels_System_Format_Label                = Generic_Messages_Events_X_Event_Channels_System_Format_Label,
    Messages_Events_Detection_OnLootClaimed_Channels_System_Format_ToolTip              = Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip,
    Messages_Events_Detection_OnLootDespawn_Enabled_Label                               =    "On Loot Despawn",
    Messages_Events_Detection_OnLootDespawn_Enabled_ToolTip                             =    "When a tracked item despawns",
    Messages_Events_Detection_OnLootDespawn_Channels_Squad_Enabled_Label                = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label,
    Messages_Events_Detection_OnLootDespawn_Channels_Squad_Enabled_ToolTip              = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip,
    Messages_Events_Detection_OnLootDespawn_Channels_Squad_Format_Label                 = Generic_Messages_Events_X_Event_Channels_Squad_Format_Label,
    Messages_Events_Detection_OnLootDespawn_Channels_Squad_Format_ToolTip               = Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip,
    Messages_Events_Detection_OnLootDespawn_Channels_Notifications_Enabled_Label        = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label,
    Messages_Events_Detection_OnLootDespawn_Channels_Notifications_Enabled_ToolTip      = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip,
    Messages_Events_Detection_OnLootDespawn_Channels_Notifications_Format_Label         = Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label,
    Messages_Events_Detection_OnLootDespawn_Channels_Notifications_Format_ToolTip       = Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip,
    Messages_Events_Detection_OnLootDespawn_Channels_System_Enabled_Label               = Generic_Messages_Events_X_Event_Channels_System_Enabled_Label,
    Messages_Events_Detection_OnLootDespawn_Channels_System_Enabled_ToolTip             = Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip,
    Messages_Events_Detection_OnLootDespawn_Channels_System_Format_Label                = Generic_Messages_Events_X_Event_Channels_System_Format_Label,
    Messages_Events_Detection_OnLootDespawn_Channels_System_Format_ToolTip              = Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip,
    Messages_Events_Detection_OnLootReceived_Enabled_Label                              =    "On Loot Received",
    Messages_Events_Detection_OnLootReceived_Enabled_ToolTip                            =    "When someone who won an item loots that item",
    Messages_Events_Detection_OnLootReceived_Channels_Squad_Enabled_Label               = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label,
    Messages_Events_Detection_OnLootReceived_Channels_Squad_Enabled_ToolTip             = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip,
    Messages_Events_Detection_OnLootReceived_Channels_Squad_Format_Label                = Generic_Messages_Events_X_Event_Channels_Squad_Format_Label,
    Messages_Events_Detection_OnLootReceived_Channels_Squad_Format_ToolTip              = Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip,
    Messages_Events_Detection_OnLootReceived_Channels_Notifications_Enabled_Label       = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label,
    Messages_Events_Detection_OnLootReceived_Channels_Notifications_Enabled_ToolTip     = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip,
    Messages_Events_Detection_OnLootReceived_Channels_Notifications_Format_Label        = Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label,
    Messages_Events_Detection_OnLootReceived_Channels_Notifications_Format_ToolTip      = Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip,
    Messages_Events_Detection_OnLootReceived_Channels_System_Enabled_Label              = Generic_Messages_Events_X_Event_Channels_System_Enabled_Label,
    Messages_Events_Detection_OnLootReceived_Channels_System_Enabled_ToolTip            = Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip,
    Messages_Events_Detection_OnLootReceived_Channels_System_Format_Label               = Generic_Messages_Events_X_Event_Channels_System_Format_Label,
    Messages_Events_Detection_OnLootReceived_Channels_System_Format_ToolTip             = Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip,
    Messages_Events_Detection_OnLootSnatched_Enabled_Label                              =    "On Loot Snatched",
    Messages_Events_Detection_OnLootSnatched_Enabled_ToolTip                            =    "When somebody loots an item that the addon had not yet assigned",
    Messages_Events_Detection_OnLootSnatched_Channels_Squad_Enabled_Label               = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label,
    Messages_Events_Detection_OnLootSnatched_Channels_Squad_Enabled_ToolTip             = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip,
    Messages_Events_Detection_OnLootSnatched_Channels_Squad_Format_Label                = Generic_Messages_Events_X_Event_Channels_Squad_Format_Label,
    Messages_Events_Detection_OnLootSnatched_Channels_Squad_Format_ToolTip              = Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip,
    Messages_Events_Detection_OnLootSnatched_Channels_Notifications_Enabled_Label       = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label,
    Messages_Events_Detection_OnLootSnatched_Channels_Notifications_Enabled_ToolTip     = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip,
    Messages_Events_Detection_OnLootSnatched_Channels_Notifications_Format_Label        = Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label,
    Messages_Events_Detection_OnLootSnatched_Channels_Notifications_Format_ToolTip      = Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip,
    Messages_Events_Detection_OnLootSnatched_Channels_System_Enabled_Label              = Generic_Messages_Events_X_Event_Channels_System_Enabled_Label,
    Messages_Events_Detection_OnLootSnatched_Channels_System_Enabled_ToolTip            = Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip,
    Messages_Events_Detection_OnLootSnatched_Channels_System_Format_Label               = Generic_Messages_Events_X_Event_Channels_System_Format_Label,
    Messages_Events_Detection_OnLootSnatched_Channels_System_Format_ToolTip             = Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip,
    Messages_Events_Detection_OnIdentify_Enabled_Label                                  =    "On Identify",
    Messages_Events_Detection_OnIdentify_Enabled_ToolTip                                =    "When the addon has discovered a new item",
    Messages_Events_Detection_OnIdentify_Channels_Squad_Enabled_Label                   = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_Label,
    Messages_Events_Detection_OnIdentify_Channels_Squad_Enabled_ToolTip                 = Generic_Messages_Events_X_Event_Channels_Squad_Enabled_ToolTip,
    Messages_Events_Detection_OnIdentify_Channels_Squad_Format_Label                    = Generic_Messages_Events_X_Event_Channels_Squad_Format_Label,
    Messages_Events_Detection_OnIdentify_Channels_Squad_Format_ToolTip                  = Generic_Messages_Events_X_Event_Channels_Squad_Format_ToolTip,
    Messages_Events_Detection_OnIdentify_Channels_Notifications_Enabled_Label           = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_Label,
    Messages_Events_Detection_OnIdentify_Channels_Notifications_Enabled_ToolTip         = Generic_Messages_Events_X_Event_Channels_Notifications_Enabled_ToolTip,
    Messages_Events_Detection_OnIdentify_Channels_Notifications_Format_Label            = Generic_Messages_Events_X_Event_Channels_Notifications_Format_Label,
    Messages_Events_Detection_OnIdentify_Channels_Notifications_Format_ToolTip          = Generic_Messages_Events_X_Event_Channels_Notifications_Format_ToolTip,
    Messages_Events_Detection_OnIdentify_Channels_System_Enabled_Label                  = Generic_Messages_Events_X_Event_Channels_System_Enabled_Label,
    Messages_Events_Detection_OnIdentify_Channels_System_Enabled_ToolTip                = Generic_Messages_Events_X_Event_Channels_System_Enabled_ToolTip,
    Messages_Events_Detection_OnIdentify_Channels_System_Format_Label                   = Generic_Messages_Events_X_Event_Channels_System_Format_Label,
    Messages_Events_Detection_OnIdentify_Channels_System_Format_ToolTip                 = Generic_Messages_Events_X_Event_Channels_System_Format_ToolTip,



    Panels_Enabled_Label                                                                =    "Enable Panels",
    Panels_Enabled_ToolTip                                                              =    "The addon will attach Panels onto item drops, allowing you to inspect the item in detail when up close.",


    Panels_Display_AssignedTo_Label                                                     =    "Display AssignedTo",
    Panels_Display_AssignedTo_ToolTip                                                   =    "Display who the item has been assigned to on the panel header.",
    Panels_Display_AssignedToHideNil_Label                                              =    "Hide AssignedTo Not assigned",
    Panels_Display_AssignedToHideNil_ToolTip                                            =    "Only show AssignedTo text when item has been assigned - don\'t display \"Not assigned\".",

    Panels_Mode_Label                               =    "Mode",
    Panels_Mode_ToolTip                             =    "Overall Panel display mode\nStandard: Full view\nSmall: Only header is shown", Panels_ColorMode_ItemName_Label                                                      =    "Item Name Color",
    Panels_ColorMode_ItemName_ToolTip                                                    =    "Set the color of the item name text on the panel header.",
    Panels_ColorMode_ItemNameCustomValue_Label                                           =    "Custom Item Name Color",    Panels_ColorMode_ItemNameCustomValue_ToolTip                                         =    "Set the color of the item name text on the panel header for the Custom option.",    Panels_ColorMode_HeaderBar_Label                                                     =    "Header Color",
    Panels_ColorMode_HeaderBar_ToolTip                                                   =    "Set the color of the background of the panel header.",
    Panels_ColorMode_HeaderBarCustomValue_Label                                          =    "Custom Header Color",
    Panels_ColorMode_HeaderBarCustomValue_ToolTip                                        =    "Set the color of the background of the panel header for the Custom option.",


    Panels_Color_AssignedTo_Nil_Label                                             =    "AssignedTo Color Not assigned",
    Panels_Color_AssignedTo_Nil_ToolTip                                           =    "Set the color of the Assigned To text when the item has not been assigned.",
    Panels_Color_AssignedTo_Free_Label                                            =    "AssignedTo Color Free for all",
    Panels_Color_AssignedTo_Free_ToolTip                                          =    "Set the color of the Assigned To text when the item has been declared free for all.",
    Panels_Color_AssignedTo_Player_Label                                          =    "AssignedTo Color For you",
    Panels_Color_AssignedTo_Player_ToolTip                                        =    "Set the color of the Assigned To text when the item has been assigned to you.",
    Panels_Color_AssignedTo_Other_Label                                           =    "AssignedTo Color For other",
    Panels_Color_AssignedTo_Other_ToolTip                                         =    "Set the color of the Assigned To text when the item has been assigned to someone else.",

    Core_Enabled_Label                                                                  =    "Enabled",
    Core_Enabled_ToolTip                                                                =    "The addon will be enabled. This option is mainly suitable if you wish to tempoarily disable the addon, without modifying any other options. Please note that this doesn't truly stop the addon from functioning - it merely suppresses actions that would otherwise signify that the addon is active. If you are suspecting compatability issues with other addons, it would be better to tempoarily remove the addon in order to verify whether or not it is part of the issue.",
    Core_VersionMessage_Label                                                           =    "Version Message",
    Core_VersionMessage_ToolTip                                                         =    "Upon being loaded, the addon will send a System message announcing it is active, including its version number.",  

    Waypoints_Enabled_Label                                                             =    "Enable Waypoints",
    Waypoints_Enabled_ToolTip                                                           =    "The addon will attach Waypoints to tracked items, helping you quickly locate drops over larger distances.",

    Waypoints_ShowOnHud_Label                       =    "Show On Hud",
    Waypoints_ShowOnHud_ToolTip                     =    "Show Waypoints on the HUD",
    Waypoints_ShowOnWorldMap_Label                  =    "Show On WorldMap",
    Waypoints_ShowOnWorldMap_ToolTip                =    "Show Waypoints on the World Map",
    Waypoints_ShowOnRadar_Label                     =    "Show On Radar",
    Waypoints_ShowOnRadar_ToolTip                   =    "Show Waypoints on the Radar",
    Waypoints_TrailAssigned_Label                   =    "Trail when loot is assigned to me",
    Waypoints_TrailAssigned_ToolTip                 =    "When an item is assigned to you, the navigation trail is set to its waypoint. Requires 'Display Navigation' setting in 'Gameplay' options checked.",
    Waypoints_PingAssigned_Label                    =    "Ping when loot is assigned to me",
    Waypoints_PingAssigned_ToolTip                  =    "When an item is assigned to you, its waypoint will be pinged - drawing attention to it.",                          


    Waypoints_RadarEdgeMode_Label                   =    "Radar Edge Mode",
    Waypoints_RadarEdgeMode_ToolTip                 =    "Behavior for Waypoint icons on the radar when outside range and the icon attaches to the radar edge\nNone : Hidden \nArrow: Nonspecific arrow icon \nIcon : Keep showing the same icon",



    Debug_Enabled_Label                                                                 =    "Debug",
    Debug_Enabled_ToolTip                                                               =    "The addon will enter Debug mode, logging messages in the console that are helpful for the addon creator in order to track down problems. Additional Debug options in this group will also become available.",

    Debug_FakeOnSquadRoster_Label                                                       =    "Fake Squad Roster",
    Debug_FakeOnSquadRoster_ToolTip                                                     =    "If not in a squad but override squad leader, put fake squad members in the roster",
    Debug_LogLootableTargets_Label                                                      =    "Log Loot Detected",
    Debug_LogLootableTargets_ToolTip                                                    =    "Extra debug messages, spammy.\nLogs info on detected items, helpful when errors are occuring during item detection.",
    Debug_LogLootableCollection_Label                                                   =    "Log Loot Collected",
    Debug_LogLootableCollection_ToolTip                                                 =    "Extra debug messages, spammy.\nLogs info on looted items, helpful when errors are occuring during item removal.",
    Debug_LogOptionChange_Label                                                         =    "Log Option Changes",
    Debug_LogOptionChange_ToolTip                                                       =    "Extra debug messages, spammy.\nLogs option changes, helpful when errors are occuring with the interface options.",

    Sounds_Enabled_Label                                                                =    "Enable Sounds",
    Sounds_Enabled_ToolTip                                                              =    "The addon will play sounds in order to notify you when certain events occur.",
    
    Sounds_Mute_Label                               =    "Mute",
    Sounds_Mute_ToolTip                             =    "If checked, no sounds will play",
    Sounds_OnIdentify_Label                         =    "Item Detected",
    Sounds_OnIdentifyRollable_Label                 =    "NYI?",
    Sounds_OnAssignItemToMe_Label                   =    "Item Assigned To You",
    Sounds_OnAssignItemToOther_Label                =    "Item Assigned To Other",

    Tracker_Enabled_Label                           =    "Enable Tracker",
    Tracker_Enabled_ToolTip                         =    "The addon will display information about currently tracked item drops, allowing you to keep track of things at a glance, as well as to perform actions with ease, or inspect the items in more detail, when in mousemode.",

    Tracker_Visibility_Label                        =    "Visibility",
    Tracker_Visibility_ToolTip                      =    "When to display the tracker.\nAlways - I wanna be with you~\nHUD - Follow suit with rest of HUD\nMousemode - Only when in Mousemode",


    Tracker_Tooltip_Enabled_Label           =  "Enable Tooltips",
    Tracker_Tooltip_Enabled_ToolTip         =  "When hovering over an entry in the Tracker list, a tooltip representation of the item will be displayed on the cursor.",
    Tracker_Tooltip_Mode_Label              =  "Tooltip Style",
    Tracker_Tooltip_Mode_ToolTip            =  "Tooltips in Firefall look different everywhere. This option will hopefully let you choose between the most common ones.",
    Tracker_PlateMode_Label                 =  "Plate Style",
    Tracker_PlateMode_ToolTip               =  "Affects the plates of entries in the Tracker.",
    Tracker_IconMode_Label                  =  "Icon Style ",
    Tracker_IconMode_ToolTip                =  "Affects the item icon of entries in the Tracker. ",


    Distribution_Enabled_Label                                                          =    "Enable Distribution",
    Distribution_Enabled_ToolTip                                                        =    "When you are in a Squad as the Squad Leader, the addon will assist you with distributing the items you find between the members of your Squad. This feature heavily relies on the Messages feature, as otherwise the addon can not comunicate with your Squad.",
                                                                                                             
    Distribution_AutoDistribute_Label                                                   =    "Auto distribute",
    Distribution_AutoDistribute_ToolTip                                                 =    "If checked the addon will automatically distribute/roll items according to the current ruleset as soon as they are identified",

    Distribution_RollMin_Label                                                          =    "Roll range minimum",
    Distribution_RollMin_ToolTip                                                        =    "Minimum roll value",           
    Distribution_RollMax_Label                                                          =    "Roll range maximum",
    Distribution_RollMax_ToolTip                                                        =    "Maximum roll value",   
    Distribution_AlwaysSquadLeader_Label                                                =    "Always Squad Leader",
    Distribution_AlwaysSquadLeader_ToolTip                                              =    "The addon will ignore what the game says about your status, as you are in fact the undeniable Squad Leader. This allows the addon to perform Distribution even if you are not the Squad Leader. Unfortunately, the addon cannot always convince other players of your greatness on its own.",    Distribution_RollTypeDefault_Label                                                  =    "Default Roll Type",
    Distribution_RollTypeDefault_ToolTip                                                =    "This roll type is selected for any users who do not declare a roll type before the timeout.",
    Distribution_RollTimeout_Label                                                      =    "Roll timeout",
    Distribution_RollTimeout_ToolTip                                                    =    "Time limit in seconds for people to declare their roll type in Need before Greed.",




    Mode_Choice_Simple_Label                                =    "Simple",
    Mode_Choice_Simple_ToolTip                              =    "",
    Mode_Choice_Advanced_Label                              =    "Advanced",
    Mode_Choice_Advanced_ToolTip                            =    "",
    TierThreshold_Choice_Tier2_Label                        =    "Tier 2",
    TierThreshold_Choice_Tier2_ToolTip                      =    "",
    TierThreshold_Choice_Tier1_Label                        =    "Tier 1",
    TierThreshold_Choice_Tier1_ToolTip                      =    "",
    TierThreshold_Choice_Tier4_Label                        =    "Tier 4",
    TierThreshold_Choice_Tier4_ToolTip                      =    "",
    TierThreshold_Choice_Any_Label                          =    "Any",
    TierThreshold_Choice_Any_ToolTip                        =    "",
    TierThreshold_Choice_Tier3_Label                        =    "Tier 3",
    TierThreshold_Choice_Tier3_ToolTip                      =    "",
    QualityThreshold_Choice_Legendary_Label                 =    "Legendary",
    QualityThreshold_Choice_Legendary_ToolTip               =    "",
    QualityThreshold_Choice_Custom_Label                    =    "Custom",
    QualityThreshold_Choice_Custom_ToolTip                  =    "",
    QualityThreshold_Choice_Common_Label                    =    "Common",
    QualityThreshold_Choice_Common_ToolTip                  =    "",
    QualityThreshold_Choice_Epic_Label                      =    "Epic",
    QualityThreshold_Choice_Epic_ToolTip                    =    "",
    QualityThreshold_Choice_Uncommon_Label                  =    "Uncommon",
    QualityThreshold_Choice_Uncommon_ToolTip                =    "",
    QualityThreshold_Choice_Any_Label                       =    "Any",
    QualityThreshold_Choice_Any_ToolTip                     =    "",
    QualityThreshold_Choice_Rare_Label                      =    "Rare",
    QualityThreshold_Choice_Rare_ToolTip                    =    "",
    LootMode_Choice_Dice_Label                              =    "Dice",
    LootMode_Choice_Dice_ToolTip                            =    "",
    LootMode_Choice_NeedBeforeGreed_Label                   =    "Need before Greed",
    LootMode_Choice_NeedBeforeGreed_ToolTip                 =    "",
    LootMode_Choice_LootMaster_Label                        =    "Loot Master",
    LootMode_Choice_LootMaster_ToolTip                      =    "",
    LootMode_Choice_YayNay_Label                            =    "Yay/Nay",
    LootMode_Choice_YayNay_ToolTip                          =    "",
    LootMode_Choice_Random_Label                            =    "Random",
    LootMode_Choice_Random_ToolTip                          =    "",
    LootMode_Choice_RoundRobin_Label                        =    "Round-robin",
    LootMode_Choice_RoundRobin_ToolTip                      =    "",
    Weighting_Choice_Battleframe_Label                      =    "Battleframe",
    Weighting_Choice_Battleframe_ToolTip                    =    "",
    Weighting_Choice_Archetype_Label                        =    "Archetype",
    Weighting_Choice_Archetype_ToolTip                      =    "",
    Weighting_Choice_None_Label                             =    "None",
    Weighting_Choice_None_ToolTip                           =    "",
    RollType_Choice_Greed_Label                             =    "Greed",
    RollType_Choice_Greed_ToolTip                           =    "",
    RollType_Choice_Pass_Label                              =    "Pass",
    RollType_Choice_Pass_ToolTip                            =    "",
    RollType_Choice_Need_Label                              =    "Need",
    RollType_Choice_Need_ToolTip                            =    "asd",
    ColorModes_Choice_Custom_Label                          =    "Custom",
    ColorModes_Choice_Custom_ToolTip                        =    "",
    ColorModes_Choice_MatchItem_Label                       =    "Match Item",
    ColorModes_Choice_MatchItem_ToolTip                     =    "",
    TrackerVisibility_Choice_Always_Label                   =    "Always",
    TrackerVisibility_Choice_Always_ToolTip                 =    "",
    TrackerVisibility_Choice_MouseMode_Label                =    "Mousemode",
    TrackerVisibility_Choice_MouseMode_ToolTip              =    "",
    TrackerVisibility_Choice_HUD_Label                      =    "HUD",
    TrackerVisibility_Choice_HUD_ToolTip                    =    "",

    RadarEdgeModes_Choice_None_Label                        =    "None",
    RadarEdgeModes_Choice_None_ToolTip                      =    "None",
    RadarEdgeModes_Choice_Arrow_Label                       =    "Arrow",
    RadarEdgeModes_Choice_Arrow_ToolTip                     =    "Arrow",
    RadarEdgeModes_Choice_Icon_Label                        =    "Icon",
    RadarEdgeModes_Choice_Icon_ToolTip                      =    "Icon",


    TrackerTooltipModes_Choice_ProgressionStyle_Label       =    "Progression Style",
    TrackerTooltipModes_Choice_ProgressionStyle_ToolTip     =    "Progression Style",
    TrackerTooltipModes_Choice_ItemStyle_Label              =    "Items Style",
    TrackerTooltipModes_Choice_ItemStyle_ToolTip            =    "Items Style",

    TrackerPlateModeOptions_Choice_None_Label               =    "None",
    TrackerPlateModeOptions_Choice_None_ToolTip             =    "None",
    TrackerPlateModeOptions_Choice_Decorated_Label          =    "Decorated",
    TrackerPlateModeOptions_Choice_Decorated_ToolTip        =    "Decorated",
    TrackerPlateModeOptions_Choice_Simple_Label             =    "Simple",
    TrackerPlateModeOptions_Choice_Simple_ToolTip           =    "Simple",

    TrackerIconModeOptions_Choice_None_Label                =    "None",
    TrackerIconModeOptions_Choice_None_ToolTip              =    "None",
    TrackerIconModeOptions_Choice_Decorated_Label           =    "Decorated",
    TrackerIconModeOptions_Choice_Decorated_ToolTip         =    "Decorated",
    TrackerIconModeOptions_Choice_Simple_Label              =    "Simple",
    TrackerIconModeOptions_Choice_Simple_ToolTip            =    "Simple",
    TrackerIconModeOptions_Choice_IconOnly_Label            =    "IconOnly",
    TrackerIconModeOptions_Choice_IconOnly_ToolTip          =    "IconOnly",


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
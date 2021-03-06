--[[
    xSounds

    A bunch of sounds extracted by Xsear
    This is a prety halfassed util for now
]]--

if xSounds then return end

xSounds = {}
local PRIVATE = {}

function xSounds.GetSounds()
    return PRIVATE.uiSounds
end


PRIVATE.uiSounds = { 
    {
        label='Sounds_Option_none',
        val=false,
    },
    {
        label='Sounds_Option_UI_ARESMIssions_Pickup_Generic01',
        val='Play_UI_ARESMIssions_Pickup_Generic01',
    },
    {
        label='Sounds_Option_UI_Ability_Selection',
        val='Play_UI_Ability_Selection',
    },
    --[[
    {
        label='Sounds_Option_UI_Ability_Trigger',
        val='Play_UI_Ability_Trigger',
    },
    --]]
    {
        label='Sounds_Option_ui_abilities_cooldown_complete',
        val='Play_ui_abilities_cooldown_complete',
    },
    {
        label='Sounds_Option_UI_Beep_06',
        val='Play_UI_Beep_06'
    },
    {
        label='Sounds_Option_UI_Beep_08',
        val='Play_UI_Beep_08'
    },
    {
        label='Sounds_Option_UI_Beep_09',
        val='Play_UI_Beep_09'
    },
    {
        label='Sounds_Option_UI_Beep_10',
        val='Play_UI_Beep_10'
    },
    {
        label='Sounds_Option_UI_Beep_12',
        val='Play_UI_Beep_12'
    },
    {
        label='Sounds_Option_UI_Beep_13',
        val='Play_UI_Beep_13'
    },
    {
        label='Sounds_Option_UI_Beep_20',
        val='Play_UI_Beep_20'
    },
    {
        label='Sounds_Option_UI_Beep_23',
        val='Play_UI_Beep_23'
    },
    {
        label='Sounds_Option_UI_Beep_26',
        val='Play_UI_Beep_26'
    },
    {
        label='Sounds_Option_UI_Beep_27',
        val='Play_UI_Beep_27'
    },
    {
        label='Sounds_Option_UI_Beep_35',
        val='Play_UI_Beep_35'
    },
    {
        label='Sounds_Option_UI_CharacterCreate_Confirm',
        val='Play_UI_CharacterCreate_Confirm',
    },
    {
        label='Sounds_Option_UI_DailyRewardsScreen_Close',
        val='Play_UI_DailyRewardsScreen_Close',
    },
    {
        label='Sounds_Option_UI_DailyRewardsScreen_Open',
        val='Play_UI_DailyRewardsScreen_Open',
    },
    {
        label='Sounds_Option_UI_DailyRewardsScreen_ProgressShift',
        val='Play_UI_DailyRewardsScreen_ProgressShift',
    },
    {
        label='Sounds_Option_UI_DailyRewardsScreen_RewardGranted',
        val='Play_UI_DailyRewardsScreen_RewardGranted',
    },
    --[[
    {
        label='Sounds_Option_UI_Friendly_Distress',
        val='Play_UI_Friendly_Distress',
    },
    --]]
    {
        label='Sounds_Option_UI_Garage_CPUUgrade',
        val='Play_UI_Garage_CPUUgrade',
    },
    {
        label='Sounds_Option_UI_Garage_MassUpgrade',
        val='Play_UI_Garage_MassUpgrade',
    },
    {
        label='Sounds_Option_UI_Garage_PowerUpgrade',
        val='Play_UI_Garage_PowerUpgrade',
    },
    {
        label='Sounds_Option_UI_Garage_UnlockSlot',
        val='Play_UI_Garage_UnlockSlot',
    },
    {
        label='Sounds_Option_UI_Interact_Available',
        val='Play_UI_Interact_Available',
    },
    {
        label='Sounds_Option_UI_Intermission',
        val='Play_UI_Intermission',
    },
    {
        label='Sounds_Option_UI_Login',
        val='Play_UI_Login',
    },
    {
        label='Sounds_Option_UI_Login_Back',
        val='Play_UI_Login_Back',
    },
    {
        label='Sounds_Option_UI_Login_Click',
        val='Play_UI_Login_Click',
    },
    {
        label='Sounds_Option_UI_Login_Confirm',
        val='Play_UI_Login_Confirm',
    },
    {
        label='Sounds_Option_UI_Login_Keystroke',
        val='Play_UI_Login_Keystroke',
    },
    {
        label='Sounds_Option_UI_MapClose',
        val='Play_UI_MapClose',
    },
    {
        label='Sounds_Option_UI_MapMarker_GetFocus',
        val='Play_UI_MapMarker_GetFocus',
    },
    {
        label='Sounds_Option_UI_MapMarker_LostFocus',
        val='Play_UI_MapMarker_LostFocus',
    },
    {
        label='Sounds_Option_UI_MapOpen',
        val='Play_UI_MapOpen',
    },
    {
        label='Sounds_Option_UI_Map_DetailClose',
        val='Play_UI_Map_DetailClose',
    },
    {
        label='Sounds_Option_UI_Map_DetailOpen',
        val='Play_UI_Map_DetailOpen',
    },
    {
        label='Sounds_Option_UI_Map_ZoomIn',
        val='Play_UI_Map_ZoomIn',
    },
    {
        label='Sounds_Option_UI_Map_ZoomOut',
        val='Play_UI_Map_ZoomOut',
    },
    {
        label='Sounds_Option_UI_NavWheel_Close',
        val='Play_UI_NavWheel_Close',
    },
    {
        label='Sounds_Option_UI_NavWheel_MouseLeftButton',
        val='Play_UI_NavWheel_MouseLeftButton',
    },
    {
        label='Sounds_Option_UI_NavWheel_MouseLeftButton_Initiate',
        val='Play_UI_NavWheel_MouseLeftButton_Initiate',
    },
    {
        label='Sounds_Option_UI_NavWheel_MouseRightButton',
        val='Play_UI_NavWheel_MouseRightButton',
    },
    --[[
    {
        label='Sounds_Option_UI_NavWheel_MouseScroll',
        val='Play_UI_NavWheel_MouseScroll',
    },
    --]]
    {
        label='Sounds_Option_UI_NavWheel_Open',
        val='Play_UI_NavWheel_Open',
    },
    {
        label='Sounds_Option_UI_RewardNotification',
        val='Play_UI_RewardNotification',
    },
    {
        label='Sounds_Option_UI_RewardScreenOpen',
        val='Play_UI_RewardScreenOpen',
    },
    {
        label='Sounds_Option_UI_RewardsAward',
        val='Play_UI_RewardsAward',
    },
    {
        label='Sounds_Option_UI_SINView_Mode',
        val='Play_UI_SINView_Mode',
    },
    {
        label='Sounds_Option_UI_SIN_Acquired',
        val='Play_UI_SIN_Acquired',
    },
    {
        label='Sounds_Option_UI_SIN_ExtraInfo_Off',
        val='Play_UI_SIN_ExtraInfo_Off',
    },
    {
        label='Sounds_Option_UI_SIN_ExtraInfo_On',
        val='Play_UI_SIN_ExtraInfo_On',
    },
    {
        label='Sounds_Option_UI_SlideNotification',
        val='Play_UI_SlideNotification',
    },
    {
        label='Sounds_Option_UI_Squad_Join',
        val='Play_UI_Squad_Join',
    },
    {
        label='Sounds_Option_UI_Squad_Leave',
        val='Play_UI_Squad_Leave',
    },
    {
        label='Sounds_Option_UI_StatsAward',
        val='Play_UI_StatsAward',
    },
    {
        label='Sounds_Option_UI_Ticker_1stStageIntro',
        val='Play_UI_Ticker_1stStageIntro',
    },
    {
        label='Sounds_Option_UI_Ticker_2ndStageIntro',
        val='Play_UI_Ticker_2ndStageIntro',
    },
    {
        label='Sounds_Option_UI_Ticker_LoudSecondTick',
        val='Play_UI_Ticker_LoudSecondTick',
    },
    {
        label='Sounds_Option_UI_Ticker_LowPulse',
        val='Play_UI_Ticker_LowPulse',
    },
    {
        label='Sounds_Option_UI_Ticker_QuietSecondTick',
        val='Play_UI_Ticker_QuietSecondTick',
    },
    {
        label='Sounds_Option_UI_Ticker_ZeroTick',
        val='Play_UI_Ticker_ZeroTick',
    },
    --[[
    {
        label='Sounds_Option_UI_VOIP_CloseChannel',
        val='Play_UI_VOIP_CloseChannel',
    },
    {
        label='Sounds_Option_UI_VOIP_OpenChannel',
        val='Play_UI_VOIP_OpenChannel',
    },
    --]]
    {
        label='Sounds_Option_UI_ZoneSelect_Confirm',
        val='Play_UI_ZoneSelect_Confirm',
    },
    {
        label='Sounds_Option_SFX_UI_AbilitySelect01_v4',
        val='Play_SFX_UI_AbilitySelect01_v4',
    },
    {
        label='Sounds_Option_SFX_UI_AbilitySelect03_v4',
        val='Play_SFX_UI_AbilitySelect03_v4',
    },
    {
        label='Sounds_Option_SFX_UI_AchievementEarned',
        val='Play_SFX_UI_AchievementEarned',
    },
    --[[
    {
        label='Sounds_Option_SFX_UI_E_Initiate_Loop_Fail',
        val='Stop_SFX_UI_E_Initiate_Loop_Fail',
    },
    {
        label='Sounds_Option_SFX_UI_E_Initiate_Loop_Success',
        val='Stop_SFX_UI_E_Initiate_Loop_Success',
    },
    {
        label='Sounds_Option_SFX_UI_E_Initiate_Loop',
        val='Play_SFX_UI_E_Initiate_Loop',
    },
    --]]
    {
        label='Sounds_Option_UI_NavWheel_MouseScroll',
        val='Stop_UI_NavWheel_MouseScroll',
    },
    {
        label='Sounds_Option_SFX_UI_Ding',
        val='Play_SFX_UI_Ding',
    },
    {
        label='Sounds_Option_SFX_UI_End',
        val='Play_SFX_UI_End',
    },
    {
        label='Sounds_Option_SFX_UI_FriendOffline',
        val='Play_SFX_UI_FriendOffline',
    },
    {
        label='Sounds_Option_SFX_UI_FriendOnline',
        val='Play_SFX_UI_FriendOnline',
    },
    {
        label='Sounds_Option_SFX_UI_GeneralAnnouncement',
        val='Play_SFX_UI_GeneralAnnouncement',
    },
    {
        label='Sounds_Option_SFX_UI_GeneralConfirm14_v2',
        val='Play_SFX_UI_GeneralConfirm14_v2',
    },
    {
        label='Sounds_Option_SFX_UI_Loot_Abilities',
        val='Play_SFX_UI_Loot_Abilities',
    },
    {
        label='Sounds_Option_SFX_UI_Loot_Backpack_Pickup',
        val='Play_SFX_UI_Loot_Backpack_Pickup',
    },
    {
        label='Sounds_Option_SFX_UI_Loot_Basic',
        val='Play_SFX_UI_Loot_Basic',
    },
    {
        label='Sounds_Option_SFX_UI_Loot_Battleframe_Pickup',
        val='Play_SFX_UI_Loot_Battleframe_Pickup',
    },
    {
        label='Sounds_Option_SFX_UI_Loot_Crystite',
        val='Play_SFX_UI_Loot_Crystite',
    },
    {
        label='Sounds_Option_SFX_UI_Loot_Flyover',
        val='Play_SFX_UI_Loot_Flyover',
    },
    {
        label='Sounds_Option_SFX_UI_Loot_PowerUp',
        val='Play_SFX_UI_Loot_PowerUp',
    },
    {
        label='Sounds_Option_SFX_UI_Loot_Weapon_Pickup',
        val='Play_SFX_UI_Loot_Weapon_Pickup',
    },
    {
        label='Sounds_Option_SFX_UI_OCT_1MinWarning',
        val='Play_SFX_UI_OCT_1MinWarning',
    },
    {
        label='Sounds_Option_SFX_UI_SIN_CooldownFail',
        val='Play_SFX_UI_SIN_CooldownFail',
    },
    {
        label='Sounds_Option_SFX_UI_Ticker',
        val='Play_SFX_UI_Ticker',
    },
    {
        label='Sounds_Option_SFX_UI_TipPopUp',
        val='Play_SFX_UI_TipPopUp',
    },
    {
        label='Sounds_Option_UI_sfx_warning_Ammo',
        val='Play_UI_sfx_warning_Ammo',
    },
    {
        label='Sounds_Option_SFX_WebUI_Close',
        val='Play_SFX_WebUI_Close',  
    },
    {
        label='Sounds_Option_SFX_WebUI_Equip_BackpackModule',
        val='Play_SFX_WebUI_Equip_BackpackModule',  
    },
    {
        label='Sounds_Option_SFX_WebUI_Equip_Battleframe',
        val='Play_SFX_WebUI_Equip_Battleframe',  
    },
    {
        label='Sounds_Option_SFX_WebUI_Equip_BattleframeModule',
        val='Play_SFX_WebUI_Equip_BattleframeModule',  
    },
    {
        label='Sounds_Option_SFX_WebUI_Equip_Weapon',
        val='Play_SFX_WebUI_Equip_Weapon',  
    },
    {
        label='Sounds_Option_SFX_WebUI_ModalWindow',
        val='Play_SFX_WebUI_ModalWindow',  
    },
    {
        label='Sounds_Option_SFX_WebUI_Open',
        val='Play_SFX_WebUI_Open',  
    },
    {
        label='Sounds_Option_SFX_UI_WhisperTickle',
        val='Play_SFX_UI_WhisperTickle',
    },
    {
        label='Sounds_Option_SlotMachine_PullLever',
        val='Play_SlotMachine_PullLever',
    },
    {
        label='Sounds_Option_SlotMachine_InsertCoin',
        val='Play_SlotMachine_InsertCoin',
    },
    {
        label='Sounds_Option_SlotMachine_EpicDecryption',
        val='Play_SlotMachine_EpicDecryption',
    },
    {
        label='Sounds_Option_SlotMachine_Decryption',
        val='Play_SlotMachine_Decryption',
    },
}
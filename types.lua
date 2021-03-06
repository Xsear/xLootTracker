-- There's room for improvement here...


uiSounds = xSounds.GetSounds()


Locale = {
    SystemDefault = 'DEFAULT',
    English = 'en',
    Chinese = 'zh',
    German = 'de',
    French = 'fr',
    Spanish = 'es',
}

OptionsLocaleDropdown = {
    [1] = Locale.SystemDefault,
    [2] = Locale.English,
    [3] = Locale.Chinese,
    --[4] = Locale.German,
    --[4] = Locale.French,
    --[4] = Locale.Spanish,
}


TornadoPocketZoneIds = {
    805, -- Epicenter
    865, -- Abyss
    868, -- Cinerarium
}

LootState = {
    Available  = 'available', -- Has a valid entityId
    Looted     = 'looted',    -- Was Available, then looted
    Lost       = 'lost',      -- Was Available, then hit by OnEntityLost
    Unknown    = 'unknown',
}

LootCategory = {
    Equipment    = 'equipment',
    Modules      = 'modules',
    Salvage      = 'salvage',
    Components   = 'components',
    --Biomaterials = 'biomaterials',
    Metals       = 'metals',
    Consumable   = 'consumable',
    Currency     = 'currency',
    Unknown      = 'unknown',
}


LootCategoryIconsRegion = {
    [LootCategory.Equipment]   = 'armory',
    [LootCategory.Modules]     = 'spawn', -- 'comet'
    [LootCategory.Salvage]     = 'power',
    [LootCategory.Components]  = 'refining',
    [LootCategory.Metals]      = 'raw_resource',
    [LootCategory.Consumable]  = 'aid',
    [LootCategory.Currency]    = 'crystite',
    [LootCategory.Unknown]     = 'mystery',
}

FilterableLootCategories = { -- Used by options to generate filtering options
    Equipment  = LootCategory.Equipment,
    Modules    = LootCategory.Modules,
    Salvage    = LootCategory.Salvage,
    Metals     = LootCategory.Metals,
    Components = LootCategory.Components,
    Consumable = LootCategory.Consumable,
    Currency   = LootCategory.Currency,
}

LootRarity = { -- Note: This is used in UIHELPER_FilterCategory to generate Rarity filters, so don't carelessly add new rarity values.
    Salvage = 'salvage',
    Common = 'common',
    Uncommon = 'uncommon',
    Rare = 'rare',
    Epic = 'epic',
    Legendary = 'legendary',
}

OptionsLootRarityDropdown = {
    [1] = LootRarity.Salvage,
    [2] = LootRarity.Common,
    [3] = LootRarity.Uncommon,
    [4] = LootRarity.Rare,
    [5] = LootRarity.Epic,
    [6] = LootRarity.Legendary,
}

TriggerModeOptions = {
    Simple = 'simple',
    Advanced = 'advanced',
}

OptionsTriggerModeDropdown = {
    [1] = TriggerModeOptions.Simple,
    [2] = TriggerModeOptions.Advanced,
}

LootPanelModes = {
    Standard = 'standard',
    Small = 'small',
}

OptionsLootPanelModes = {
    [1] = LootPanelModes.Standard,
    [2] = LootPanelModes.Small,
}

ColorModes = {
    MatchItem = 'matchitem',
    Custom = 'custom',
}

OptionsColorModesDropdown = {
    [1] = ColorModes.MatchItem,
    [2] = ColorModes.Custom,
}


HUDTrackerVisibilityOptions = {
    Always = 'always',
    HUD = 'hud',
    MouseMode = 'mousemode',
    SinMode = 'sinmode',
}

OptionsHUDTrackerVisibilityDropdown = {
    [1] = HUDTrackerVisibilityOptions.HUD,
    [2] = HUDTrackerVisibilityOptions.MouseMode,
    [3] = HUDTrackerVisibilityOptions.SinMode,
    [4] = HUDTrackerVisibilityOptions.Always,
}

HUDTrackerPlateModeOptions = {
    Decorated = 'decorated',
    Simple = 'simple',
    None = 'none',
}

OptionsHUDTrackerPlateModeDropdown = {
    [1] = HUDTrackerPlateModeOptions.Decorated,
    [2] = HUDTrackerPlateModeOptions.Simple,
    [3] = HUDTrackerPlateModeOptions.None,
}

HUDTrackerIconModeOptions = {
    Decorated = 'decorated',
    Simple = 'simple',
    --IconOnly = 'icon-only',
    None = 'none',
}

OptionsHUDTrackerIconModeDropdown = {
    [1] = HUDTrackerIconModeOptions.Decorated,
    [2] = HUDTrackerIconModeOptions.Simple,
    [3] = HUDTrackerIconModeOptions.None,
}

RadarEdgeModes = {
    None = MapMarker.EDGE_NONE,
    Arrow = MapMarker.EDGE_ARROW,
    Icon = MapMarker.EDGE_ICON,
}

OptionsRadarEdgeModesDropdown = {
    [1] = RadarEdgeModes.None,
    [2] = RadarEdgeModes.Arrow,
    [3] = RadarEdgeModes.Icon,
}

OptionsFontTypes = {
    UbuntuRegular = 'UbuntuRegular',
    UbuntuMedium = 'UbuntuMedium',
    UbuntuBold = 'UbuntuBold',
    Demi = 'Demi',
    Bold = 'Bold',
    Wide = 'Wide',
    Narrow = 'Narrow',
}

OptionsFontTypeDropdown = {
    [1] = OptionsFontTypes.UbuntuRegular,
    [2] = OptionsFontTypes.UbuntuMedium,
    [3] = OptionsFontTypes.UbuntuBold,
    [4] = OptionsFontTypes.Demi,
    [5] = OptionsFontTypes.Bold,
    [6] = OptionsFontTypes.Wide,
    [7] = OptionsFontTypes.Narrow,
}


TrackerUpdateMode = {
    Global = 'global',
    Individual = 'individual',
}
OptionsTrackerUpdateModeDropdown = {
    [1] = TrackerUpdateMode.Global,
    [2] = TrackerUpdateMode.Individual,
}

PanelsTimerMode = {
    Countdown = 'countdown',
    Normal = 'normal',
    Disabled = 'disabled',
}
OptionsPanelsTimerModeDropdown = {
    [1] = PanelsTimerMode.Normal,
    [2] = PanelsTimerMode.Countdown,
}

AnimationType = {
    EaseIn = "ease-in",
    EaseOut = "ease-out",
    Linear = "linear",
    Smooth = "smooth",
}
OptionsAnimationTypeDropdown = {
    [1] = AnimationType.EaseIn,
    [2] = AnimationType.EaseOut,
    [3] = AnimationType.Linear,
    [4] = AnimationType.Smooth,
}
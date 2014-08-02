
-- Fixme: Some of these don't need to be global, though some do. >_<
-- do this better


uiSounds = xSounds.GetSounds()



TierOptions = {
    Any = 'any',
--    Tier1 = '1',
    Tier2 = '2',
    Tier3 = '3',
    Tier4 = '4',
}

QualityOptions = {
    Any = 'any',
--    Common = 'common',
    Uncommon = 'uncommon',
    Rare = 'rare',
    Epic = 'epic',
--    Legendary = 'legendary',
    Custom = 'custom',
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

HUDTrackerVisibilityOptions = {
    Always = 'always',
    HUD = 'hud',
    MouseMode = 'mousemode',
}


HUDTrackerPlateModeOptions = {
    Decorated = 'decorated',
    Simple = 'simple',
    None = 'none',
}

HUDTrackerIconModeOptions = {
    Decorated = 'decorated',
    Simple = 'simple',
    --IconOnly = 'icon-only',
    None = 'none',
}



LootCategory = {
    Equipment  = 'equipment',
    Modules    = 'modules',
    Salvage    = 'salvage',
    Components = 'components',
    Consumable = 'consumable',
    Currency   = 'currency',
    Unknown    = 'unknown',
}

FilterableLootCategories = { -- Used by options to generate filtering options
    Equipment  = LootCategory.Equipment,
    Modules    = LootCategory.Modules,
    Salvage    = LootCategory.Salvage,
    Components = LootCategory.Components,
    Consumable = LootCategory.Consumable,
}

LootState = {
    Available  = "available", -- Has a valid entityId
    Looted     = "looted",    -- Was Available, then looted
    Lost       = "lost",      -- Was Available, then hit by OnEntityLost
    Unknown    = "unknown",
}

LootRarity = {
    Salvage = "salvage",
    Common = "common",
    Uncommon = "uncommon",
    Rare = "rare",
    Epic = "epic",
    Prototype = "prototype",
    Legendary = "legendary",
}

LootRarityIndex = {
    ["salvage"] = 1,
    ["common"] = 2,
    ["uncommon"] = 3,
    ["rare"] = 4,
    ["epic"] = 5,
    ["prototype"] = 6,
    ["legendary"] = 7,
}

OptionsLootRarityDropdown = {
    [1] = LootRarity.Salvage,
    [2] = LootRarity.Common,
    [3] = LootRarity.Uncommon,
    [4] = LootRarity.Rare,
    [5] = LootRarity.Epic,
    [6] = LootRarity.Prototype,
    [7] = LootRarity.Legendary,
}


TriggerModeOptions = {
    Simple = 'simple',
    Advanced = 'advanced',
}

OptionsTriggerModeDropdown = {
    [1] = TriggerModeOptions.Simple,
    [2] = TriggerModeOptions.Advanced,
}




OptionsRadarEdgeModesDropdown = {
    [1] = RadarEdgeModes.None,
    [2] = RadarEdgeModes.Arrow,
    [3] = RadarEdgeModes.Icon,
}



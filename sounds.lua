Sounds = {}
Private = {}

function Sounds.OnTrackerNew(args)
    if Options['Sounds']['Enabled'] then

        local loot = Tracker.GetLootById(args.lootId)

        if LootFiltering(loot, Options['Sounds']) then
            local categoryKey, rarityKey = GetLootFilteringOptionsKeys(loot, Options['Sounds']['Filtering'])

            System.PlaySound(Options['Sounds']['Filtering'][categoryKey][rarityKey]['SoundsNewLoot'])
        end
    end
end

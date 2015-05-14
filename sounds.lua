--[[
    Sounds
    Plays sounds on tracker events.
--]]
Sounds = {}

local Private = {}

--[[
    Sounds.OnTrackerNew(args)
    Called when Tracker has added a new item.
    Plays the New Loot sound as configured for the item.
--]]
function Sounds.OnTrackerNew(args)
    if Options['Sounds']['Enabled'] then

        local loot = Tracker.GetLootById(args.lootId)

        if not Options['Blacklist']['Sounds'][tostring(loot:GetTypeId())] and Filtering.Filter(loot, Options['Sounds']) then

            local categoryKey, rarityKey = Filtering.GetFilteringOptionsKeys(loot, Options['Sounds']['Filtering'])

            System.PlaySound(Options['Sounds']['Filtering'][categoryKey][rarityKey]['SoundsNewLoot'])
        end
    end
end

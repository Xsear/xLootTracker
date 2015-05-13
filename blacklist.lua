--[[
    Blacklist
    Handles the Blacklist that is used to ignore items.
--]]
Blacklist = {}

local Private = {
    legitScopeKey = {
        ["Tracker"] = true,
        ["Panels"] = true,
        ["Sounds"] = true,
        ["HUDTracker"] = true,
        ["Messages"] = true,
        ["Waypoints"] = true,
    }
}

--[[
    Blacklist.Setup(args)
    Called OnComponentLoad, fixes a corrupted options error.
--]]
function Blacklist.Setup(args)
    -- Fix for bug that existed in versions 1.13 to v1.15
    if Component.GetSetting('Core_Blacklist') then
        Options['Blacklist'] = Component.GetSetting('Core_Blacklist')

        local blacklistStructure = {
                ['Tracker'] = {},
                ['Panels'] = {},
                ['Sounds'] = {},
                ['HUDTracker'] = {},
                ['Messages'] = {},
                ['Waypoints'] = {},
        }

        for key, table in pairs(blacklistStructure) do
            if not Options['Blacklist'][key] then
                Debug.Log('Restoring Blacklist Structure: Adding key ' .. tostring(key))
                Options['Blacklist'][key] = {}
            end
        end

        Component.SaveSetting('Core_Blacklist', Options['Blacklist'])
    end
end

--[[
    Blacklist.Get(args)
    Returns the data of a scope of the Blacklist.
    args.scopeKey = The scope to get. Required.
--]]
function Blacklist.Get(args)
    -- Get arguments
    local scopeKey = args.scopeKey

    -- Validate arguments
    if not Private.VerifyScopeKey(scopeKey) then return end

    -- Return blacklist data
    return Options['Blacklist'][scopeKey]
end

--[[
    Blacklist.Clear(args)
    Clears a scope of the Blacklist, removing all entries.
    Returns the number of entries cleared, or 0 if none.
    args.scopeKey = The scope to clear. Required.
--]]
function Blacklist.Clear(args)
    -- Get arguments
    local scopeKey = args.scopeKey
    
    -- Validate arguments
    if not Private.VerifyScopeKey(scopeKey) then return end

    -- Initialize counter
    local count = 0

    -- Check for empty table
    if not _table.empty(Options['Blacklist'][scopeKey]) then

        -- Clear each entry, and increment counter.
        for itemTypeId, value in pairs(Options['Blacklist'][scopeKey]) do
            Options['Blacklist'][scopeKey][itemTypeId] = nil
            count = count + 1
        end

        -- Save
        Private.Save()
    end

    -- Return number of cleared entries
    return count
end

--[[
    Blacklist.Add(args)
    Adds an item to a scope of the Blacklist.
    Returns true on success, false if the item was already on the list, nil if arguments were not valid. 
    args.scopeKey = The scope to clear. Required.
    args.itemTypeId = The itemTypeId to add to the blacklist. Required.
--]]
function Blacklist.Add(args)
    -- Get arguments
    local scopeKey = args.scopeKey
    local itemTypeId = tostring(args.itemTypeId)

    -- Validate arguments
    if not Private.VerifyScopeKey(args.scopeKey) then
        Debug.Warn("Blacklist.Add(), args.scopeKey not valid or missing")
        return 
    end
    if not itemTypeId then
        Debug.Warn("Blacklist.Add(), args.itemTypeId missing")
        return 
    end

    -- If no existing entry
    if not Options['Blacklist'][scopeKey][itemTypeId] then
        -- Insert
        Options['Blacklist'][scopeKey][itemTypeId] = true

        -- Save
        Private.Save()

        -- Return success
        return true

    -- If already existing entry
    else
        -- Return failure
        return false
    end
end

--[[
    Blacklist.Remove(args)
    Removes an item from a scope of the Blacklist.
    Returns true on success, false if the item was not on the list, nil if arguments were not valid. 
    args.scopeKey = The scope to clear. Required.
    args.itemTypeId = The itemTypeId to add to the blacklist. Required.
--]]
function Blacklist.Remove(args)
    -- Get arguments
    local scopeKey = args.scopeKey
    local itemTypeId = args.itemTypeId and tostring(args.itemTypeId)

    -- Validate arguments
    if not Private.VerifyScopeKey(args.scopeKey) then
        Debug.Warn("Blacklist.Remove(), args.scopeKey not valid or missing")
        return 
    end
    if not itemTypeId then
        Debug.Warn("Blacklist.Remove(), args.itemTypeId missing")
        return 
    end

    -- If existing entry
    if Options['Blacklist'][scopeKey][itemTypeId] then
        -- Remove
        Options['Blacklist'][scopeKey][itemTypeId] = nil;

        -- Save
        Private.Save()

        -- Return success
        return true

    -- If no existing entry
    else
        -- Return failure
        return false
    end
end

function Private.VerifyScopeKey(scopeKey)
    return Private.legitScopeKey[scopeKey] or false
end

function Private.Save()
    Component.SaveSetting('Core_Blacklist', Options['Blacklist'])
end
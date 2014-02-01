RollTracker = {}

local Private = {
    currentlyRolling = {}
}


function RollTracker.IsRolling()
    if next(Private.currentlyRolling) ~= nil then
        if Options['Debug']['RollTracker'] then Debug.Log('RollTracker: IsRolling() : true') end
        return true
    end
    if Options['Debug']['RollTracker'] then Debug.Log('RollTracker: IsRolling() : false') end
    return false
end

function RollTracker.IsBeingRolled(itemIdentity)
    -- Allow argument to be an Item
    if type(itemIdentity) == 'table' then
        itemIdentity = itemIdentity.identityId
    end

    if RollTracker.IsRolling() then
        for _, identity in ipairs(Private.currentlyRolling) do
            if identity == itemIdentity then
                if Options['Debug']['RollTracker'] then Debug.Log('RollTracker: IsBeingRolled('..tostring(itemIdentity)..') : true') end
                return true
            end
        end
    end
    if Options['Debug']['RollTracker'] then Debug.Log('RollTracker: IsBeingRolled('..tostring(itemIdentity)..') : false') end
    return false
end

function RollTracker.Count()
    return #Private.currentlyRolling
end

function RollTracker.GetFirst()
    return Private.currentlyRolling[1]
end

function RollTracker.GetAll()
    return Private.currentlyRolling
end

function RollTracker.Add(itemIdentity)
    if not RollTracker.IsBeingRolled(itemIdentity) then
        Private.currentlyRolling[#Private.currentlyRolling + 1] = itemIdentity
        if Options['Debug']['RollTracker'] then Debug.Log('RollTracker: Now tracking '..tostring(itemIdentity)) end
    else
        if Options['Debug']['RollTracker'] then Debug.Log('RollTracker: Attempt to track '..tostring(itemIdentity)..', but already tracking.') end
    end
end

function RollTracker.Remove(itemIdentity)
    if RollTracker.IsBeingRolled(itemIdentity) then

        for i, identity in ipairs(Private.currentlyRolling) do
            if identity == itemIdentity then
                table.remove(Private.currentlyRolling, i)
                break
            end
        end

        if Options['Debug']['RollTracker'] then Debug.Log('RollTracker: No longer tracking '..tostring(itemIdentity)) end
    else
        if Options['Debug']['RollTracker'] then Debug.Log('RollTracker: Attempt to remove '..tostring(itemIdentity)..', but wasnt being tracked.') end
    end
end

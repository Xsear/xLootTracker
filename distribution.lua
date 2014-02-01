


Distribution = {}
local Private = {}



function Distribution.DistributeItem(item, distributionMode, weightingMode)
    -- We must have an item to distribute!
    if not item then
        Debug.Warn('DistributeItem was not called with an item.', tostring(args))
        return
    elseif not bInSquad then
        Debug.Warn('DistributeItem but bInSquad is false.')
        SendFilteredMessage('system', 'Unable to distribute %i. We are not in a squad at the moment.', {item=item})
        return
    end

    -- If not specified, default distribution and weighting modes.
    distributionMode = distributionMode or DistributionMode.Random
    weightingMode = weightingMode or WeightingOptions.None

    -- If we're doing a Need Before Greed roll, we won't get a winner now, so let's handle that first
    if distributionMode == DistributionMode.NeedBeforeGreed then

        Private.NeedBeforeGreed(item, aSquadRoster.members, Distribution.GetEntitled(item, weightingMode))

    -- For all other kinds of rolls, we'll determine the winner here and now!
    else

        -- Vars
        local members
        local winner
        local rolls

        -- Weighting is not compatible with Round-robin
        if distributionMode ~= DistributionMode.RoundRobin then
            members = Distribution.GetEntitled(item, weightingMode)
        else
            members = aSquadRoster
        end

        -- If x, do x! \o/ Best code.
        if distributionMode == DistributionMode.Random then
            winner = Private.GetWinnerByRandom(members)
        elseif distributionMode == DistributionMode.Dice then
            winner, rolls = Private.GetWinnerByDice(members)
        elseif distributionMode == DistributionMode.RoundRobin then
            winner = Private.GetWinnerByRoundRobin()
        end

        -- Announce that we've distributed an item.
        OnDistributeItem({item=item, distributionMode=distributionMode, weightingMode = weightingMode, rolls=rolls})

        -- If we have a winner (I sure hope we do...), assign him the item! :D
        if winner then
            Distribution.AssignItem(item.entityId, winner, rolls)
        end
    end
end



--[[
    AssignItem(loot|entityId, winner)
    Assigns an item to a player.
    The first param can be either a table with an entityId property, or an entityId. If neither a table nor a string, tostring() will be applied.
]]--
function Distribution.AssignItem(ref, winner, rolls)
    
    local entityId = ''
    if type(ref) == 'table' then
        entityId = tostring(ref.entityId)
    
    elseif type(ref) == 'string' then
        entityId = ref

    else
        entityId = tostring(ref)
    end

    local winningRoll
    if rolls then
        for _, row in ipairs(rolls) do
            if row.rolledBy == winner then
                winningRoll = row.roll
            end
        end
    end

    if not _table.empty(aIdentifiedLoot) then
        for num, item in ipairs(aIdentifiedLoot) do 
            if tostring(item.entityId) == entityId then
                local shouldComm = true

                if item.assignedTo == winner then
                    shouldComm = false
                end

                item.assignedTo = winner


                if shouldComm then
                    Communication.SendAssign(item, winner)
                end

                OnAssignItem({
                    item = item,
                    assignedTo = winner,
                    playerName = winner,
                    roll = winningRoll,
                })
                return
            end
        end
    end
    Debug.Warn('AssignItem failed to assign item :( '..tostring(entityId)..' to '..winner)
end

--[[
    GetEntitled(item, weightingMode)
    Returns a list of people able to roll for this item in a certain weightingMode.
]]--
function Distribution.GetEntitled(item, weightingMode)

    -- Get the data we need to be able to weigh
    local entitledRoster = {}
    local eligibleArchetypes = {}
    local eligibleFrames = {}

    -- If it's an equipment item, check local data
    if IsEquipmentItem(item.itemInfo) and item.craftingTypeId then
        local itemArchetype, itemFrame = xBattleframes.GetInfoByCraftingTypeId(tostring(item.craftingTypeId))
        if itemArchetype then
            eligibleArchetypes[#eligibleArchetypes + 1] = itemArchetype
        end
        if itemFrame then
            eligibleFrames[#eligibleFrames + 1] = itemFrame
        end
    -- Else If it's a crafting component, check local data
    elseif IsCraftingComponent(item.itemInfo) and item.itemTypeId then
        for k, v in pairs(data_CraftingComponents) do
            if v.itemTypeId == tostring(item.itemTypeId) and v.classes then
                for i, class in ipairs(v.classes) do
                    eligibleArchetypes[#eligibleArchetypes + 1] = class
                end
            end
        end
    -- Else If itemInfo has classes, use those
    elseif item.itemInfo.classes then
        for i, class in ipairs(item.itemInfo.classes) do
            eligibleArchetypes[#eligibleArchetypes + 1] = class
        end
    end

    Debug.Table({eligibleArchetypes=eligibleArchetypes, eligibleFrames=eligibleFrames})

    -- Weigh by Archetype
    if weightingMode == WeightingOptions.Archetype then
        for num, member in ipairs(aSquadRoster.members) do
            for i, archetype in ipairs(eligibleArchetypes) do
                if member.battleframe == archetype then
                    table.insert(entitledRoster, member)
                    break
                end
            end
        end
    end

    -- Return entitled roster if it has at least one entry
    if #entitledRoster > 0 then
        return entitledRoster
    end

    -- Return an unmodified roster if we had no entries in the entitled roster
    return aSquadRoster.members
end




function Private.GetWinnerByRandom(members)
    return members[math.random(#members)].name
end

function Private.GetWinnerByDice(members)

    local highest = nil
    local winner = ''
    local rolls = {}

    -- Roll for each member in order to determine winner
    for num, member in ipairs(members) do

        -- Calc roll
        roll = math.random(Options['Distribution']['RollMin'], Options['Distribution']['RollMax'])

        -- Determine if highest roll
        if highest == nil -- First roll automatically becomes the highest 
        or roll > highest -- Subsequent rolls must be larger than the highest in order to become the highest (Yeah!)
        then
            highest = roll
            winner = member.name -- Determine winner as we roll
        end

        -- Append to rolls table
        table.insert(rolls, {roll=roll, rolledBy=member.name})
    end

    return winner, rolls

end

function Private.GetWinnerByRoundRobin(members)
    Debug.Log('Round Robin')
    Debug.Log('iRoundRobinIndex: '..tostring(iRoundRobinIndex))
    if not aSquadRoster or not aSquadRoster.members then

        Debug.Log('bInSquad: '..tostring(bInSquad))
        Debug.Log('bIsSquadLeader: '..tostring(bIsSquadLeader))
        Debug.Warn('GetWinnerByRoundRobin, but no squad?')
    end
    Debug.Log('#members: '..tostring(#members))

    local winner = ''

    -- Determine winner
    for num, member in ipairs(members) do
        if num == iRoundRobinIndex then
            winner = members[iRoundRobinIndex].name
            Debug.Log('Squad Member '..tostring(num)..', '..tostring(winner)..' is the winner.')
            break
        end
    end

    -- Setup for next winner
    Debug.Log('Setting up for next winner, should index be reset?')
    if iRoundRobinIndex + 1 > #members then
        Debug.Log('true')
        iRoundRobinIndex = 1
        Debug.Log('Reseting iRoundRobinIndex to '..tostring(iRoundRobinIndex))
    else
        Debug.Log('false')
        iRoundRobinIndex = iRoundRobinIndex + 1
        Debug.Log('Increasing iRoundRobinIndex to '..tostring(iRoundRobinIndex))
    end

    return winner
end

function Private.NeedBeforeGreed(item, members, eligible)
    Debug.Log('Need Before Greed')
    Debug.Table({item=item, members=members, eligible=eligible})

    -- If there is already rolls data for this item, that's probably not good.
    if item.rollData then
        Debug.Warn('Need Before Greed roll on an item that already has rolls information. Dumping and forcing to nil.', item.rollData)
        item.rollData = nil
    end

    -- Track the roll
    RollTracker.Add(item.identityId)

    -- Fill data
    local rollData = {}
    for num, member in ipairs(members) do
        local row = {}
        -- Setup new fields
        row.canNeed = false
        row.name = member.name
        row.hasRolled = false
        row.battleframe = member.battleframe
        row.rollType = false
        row.rollValue = nil

        -- Determine if this person is eligible for need rolls
        for i, v in ipairs(eligible) do
            if namecompare(row.name, v.name) then
                row.canNeed = true
            end
        end

        rollData[#rollData + 1] = row
    end

    -- Establish table in item
    item.rollData = rollData

    -- Start roll timeout timer
    item.timer:SetAlarm('roll_timeout', item.timer:GetTime() + Options['Distribution']['RollTimeout'], RollTimeout, {item=item})

    -- Announce that we're rolling
    OnAcceptingRolls({item=item, members=members, eligible=eligible, distributionMode=DistributionMode.NeedBeforeGreed})

    -- Communicate
    Communication.SendRollStart(item)
end







--[[
    RollTimeout(args)
    Behavior for when a roll has timed out.
    Triggered by timer alarm when a roll has timed out.
]]--
function RollTimeout(args)
    if args.item.identityId and RollTracker.IsBeingRolled(args.item.identityId) then
        SendFilteredMessage('system', 'RollTimeout for %i', {item=args.item})
        RollFinish({item=args.item})
    end
end

--[[
    RollCancel(args)
    Behavior for when a roll is cancelled.
    Calls neccesary functions to clean up.

    args.item.identityId
    [args.reason]
    args.item > SendFilteredMessage
    args > RollCleanup
]]--
function RollCancel(args)

    if not args.item then
        if args.identity then
            args.item = GetItemByIdentity(args.identity)
        elseif RollTracker.IsRolling() then
            args.item = GetItemByIdentity(RollTracker.GetFirst()) -- Fixme:  Super totally tempoary bandaid shit
        else
            Debug.Warn('Not enough arguments for RollCancel, needs item')
        end
    end

    if args.item.identityId and RollTracker.IsBeingRolled(args.item.identityId) then
        local message = 'RollCancel for %i'

        if args and args.reason then
            message = message..'\nReason: '..args.reason
        end

        SendFilteredMessage('system', message, {item=args.item})
        RollCleanup(args)
    end
end

--[[
    RollCleanup(args)
    Resets roll variables so that we are ready to start a new roll.
    
    args.item.identityId
    args.item.timer

]]--
function RollCleanup(args)
    if args.item.identityId and RollTracker.IsBeingRolled(args.item.identityId) then
        args.item.timer:KillAlarm('roll_timeout')
        Debug.Log('RollCleanup killing roll timeout alarm')
        RollTracker.Remove(args.item.identityId)
    end
end


--[[
    RollDecision(args)
    Called by OnChatMessage when somebody declares their rolltype (if there is an active roll)
    Checks that author is eligible for rolltype, corrects it if not and then stores rolltype in list of rolls.

    Calls RollFinish() If the roll declaration is the final one
    Calls OnRollChange if the rolltype is changed (because author was not eligible for the rollType)
    Calls OnRollAccept when the rolltype is saved to the list of rolls
    
    args.identityId or args.item.identityId
    args.rollType
    args.author 

]]--
function RollDecision(args)

    local identityId = args.identityId or args.item.identityId
    if not identityId then Debug.Warn('RollDecision called without identityId') end

    if RollTracker.IsBeingRolled(identityId) then 

        -- Get item
        local item = args.item or GetItemByIdentity(identityId)

        -- Let's see if the author is actually allowed to roll
        local totalRemaining = 0
        local needRemaining = 0
        local didChange = false
        local someoneHasNeeded = false

        -- Go through all the people who can roll
        for num, row in ipairs(item.rollData) do

            -- If we've found the person who sent this message and he has not yet selected rollType
            if namecompare(args.author, row.name) and row.rollType == false then

                -- If he wants to roll need but isn't allowed to, change his roll to greed (y bastard)
                if args.rollType == RollType.Need and row.canNeed == false then
                    args.rollType = RollType.Greed
                    OnRollChange({item=item, rollType=args.rollType, playerName=args.author})
                end

                -- Set the roll type and acknowledge
                row.rollType = args.rollType
                didChange = true
                OnRollAccept({item=item, rollType=args.rollType, playerName=args.author})
            end

            -- If the rollType is not yet set, this is a person who has yet to roll
            if row.rollType == false then 
                totalRemaining = totalRemaining + 1

                -- If this user can need roll, this is a person who has yet to roll and could need
                if row.canNeed then
                    needRemaining = needRemaining + 1
                end

            elseif row.rollType == RollType.Need then
                someoneHasNeeded = true
            end

        end

        Debug.Log('RollDecision','NeedRemaining: '..tostring(needRemaining), 'totalRemaining: '..tostring(totalRemaining))

        -- If this was the last call needed, do rolls
        if totalRemaining == 0 or (needRemaining == 0 and someoneHasNeeded) then
            RollFinish({item=item})
        elseif didChange then
            Communication.SendRollUpdate(item)
        end
    end
end

--[[
    RollFinish()
    Executes rolls, determines winner, assigns item, cleans up.
]]--
function RollFinish(args)

    local identityId = args.identityId or args.item.identityId
    if not identityId then Debug.Warn('RollDecision called without identityId') end


    if RollTracker.IsBeingRolled(identityId) then

        local item = args.item or GetItemByIdentity(args.identityId)

        item.timer:KillAlarm('roll_timeout') -- Prevent timeout callback
        Debug.Log('RollFinish killing roll timeout alarm')

        -- Declare vars
        local winner = ''
        local highest = nil
        local rolls = {}

        -- Figure out if someone has need rolled, and set any un-decided roll types to the default
        local someoneHasNeeded = false
        for num, row in ipairs(item.rollData) do
            if row.rollType == RollType.Need then
                someoneHasNeeded = true
            elseif row.rollType == false then
                row.rollType = Options['Distribution']['RollTypeDefault']
            end
        end

        -- Go through rolls
        for num, row in ipairs(item.rollData) do
            -- Inverted logic because Lua doesn't have continue
            -- Skip greed rolls if someone has needed, as well as any pass rolls
            if not(someoneHasNeeded and row.rollType == RollType.Greed) and not (row.rollType == RollType.Pass or row.rollType == false) then

                -- Calc roll
                roll = math.random(Options['Distribution']['RollMin'], Options['Distribution']['RollMax'])

                -- Determine if highest roll
                if highest == nil -- First roll automatically becomes the highest 
                or roll > highest -- Subsequent rolls must be larger than the highest in order to become the highest (Yeah!)
                then
                    highest = roll
                    winner = row.name -- Determine winner as we roll
                end

                -- Store it in the rollData so that we can use it later
                row.rollValue = roll

                -- Append to rolls table
                table.insert(rolls, {roll=roll, rolledBy=row.name})
            end 
        end

        -- If there were no rolls, assign free for all and send event
        if next(rolls) == nil then
            item.assignedTo = AssignedTo.FreeForAll
            OnRollNobody({item=item})

        -- Otherwise, send distribute event and assign to the winner
        else
            OnDistributeItem({item=item, rolls=rolls, distributionMode=DistributionMode.NeedBeforeGreed})
            Distribution.AssignItem(item.entityId, winner, rolls)
        end

        -- Update loot panels
        UpdatePanel(item)

        -- Update tracker
        Tracker.Update()

        -- Clean up after this roll
        RollCleanup({item=item})

        -- If auto distribute start next roll
        if Options['Distribution']['AutoDistribute'] then DistributeNextItem() end

    else
        Debug.Warn('RollFinish but not currently rolling')
    end
end








--[[
    Ugly function not really part of this class but nowhere better to put it
    Attempts to distribute the next unrolled item, if there is any.
]]--
function DistributeNextItem()
    -- If we have loot to distribute and we're the leader
    if not _table.empty(aIdentifiedLoot) and bIsSquadLeader then

        -- Get the first unrolled item from the list of identified loot
        for num, item in ipairs(aIdentifiedLoot) do 

            -- If the item is not assigned and not currently being rolled, and passes our distribution filters
            if not IsAssigned(item.entityId) and not RollTracker.IsBeingRolled(item.identityId) and ItemPassesFilter(item, Options['Distribution']) then 
                    
                local typeKey, stageKey = GetItemOptionsKeys(item, Options['Distribution']) 
                local distributionMode = Options['Distribution'][typeKey][stageKey]['LootMode']
                local weightingMode = Options['Distribution'][typeKey][stageKey]['Weighting']

                Distribution.DistributeItem(item, distributionMode, weightingMode)
                break

            end

        end

    end

end


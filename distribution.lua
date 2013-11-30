--[[
    DistributeItem
    Main logic.
]]--
function DistributeItem()
    -- Check that we are allowed to distribute loot
    if not bIsSquadLeader or not Options['Core']['Enabled'] then return end

    -- Check that we have any loot at all
    if not _table.empty(aIdentifiedLoot) then

        -- Get the first unrolled item from the list of identified loot
        local loot = nil

        for num, item in ipairs(aIdentifiedLoot) do 
            if not IsAssigned(item.entityId) and ItemPassesFilter(item, Options['Distribution']) then 
                loot = item
                break
            end
        end

        if loot ~= nil then

            -- Determine which rules to use
            local typeKey, stageKey = GetItemOptionsKeys(loot, Options['Distribution']) 

            -- Ruleset
            -- Note: Btw we can assume we will do distribution for this item because we've already done ItemPassesFilter before getting here
            -- Fixme: inotherwords were doin it wroong
            local distributionMode = Options['Distribution'][typeKey][stageKey]['LootMode']

            -- Weighting
            local weightedRoster = GetEntitled(loot)


            -- Random looting mode
            if distributionMode == DistributionMode.Random then
                local winner = weightedRoster[math.random(#weightedRoster)].name

                OnDistributeItem({item=loot})
                AssignItem(loot.entityId, winner)

            -- dice looting mode
            elseif distributionMode == DistributionMode.Dice then
                local highest = nil
                local winner = ''
                local rolls = {}
                -- Roll for each member in order to determine winner
                for num, member in ipairs(weightedRoster) do

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

                OnDistributeItem({item=loot, rolls=rolls})
                AssignItem(loot.entityId, winner)

            -- round-robin looting mode
            -- Todo: Support for Weighting?
            elseif distributionMode == DistributionMode.RoundRobin then
                
                Debug.Log('Round Robin')
                Debug.Log('iRoundRobinIndex: '..tostring(iRoundRobinIndex))
                Debug.Log('#aSquadRoster.members: '..tostring(#aSquadRoster.members))
                local winner = ''
                -- Determine winner
                for num, member in ipairs(aSquadRoster.members) do
                    if num == iRoundRobinIndex then
                        winner = aSquadRoster.members[iRoundRobinIndex].name
                        Debug.Log('Squad Member '..tostring(num)..', '..tostring(winner)..' is the winner.')
                        break
                    end
                end

                -- Setup for next winner
                Debug.Log('Setting up for next winner, should index be reset?')
                if iRoundRobinIndex + 1 > #aSquadRoster.members then
                    Debug.Log('true')
                    iRoundRobinIndex = 1
                    Debug.Log('Reseting iRoundRobinIndex to '..tostring(iRoundRobinIndex))
                else
                    Debug.Log('false')
                    iRoundRobinIndex = iRoundRobinIndex + 1
                    Debug.Log('Increasing iRoundRobinIndex to '..tostring(iRoundRobinIndex))
                end

                -- Distribute
                OnDistributeItem({item=loot})
                AssignItem(loot.entityId, winner)
            elseif distributionMode == DistributionMode.NeedBeforeGreed then

                -- Check that we're not busy rolling something else
                if mCurrentlyRolling then
                    OnRollBusy({item=loot})
                    return
                end

                -- Okay, lock us down while we roll
                mCurrentlyRolling = loot

                -- Use a list from the global scope to store data for this roll
                aCurrentlyRolling = aSquadRoster.members

                Debug.Log('Pre Setup: ')
                Debug.Log('aCurrentlyRolling')
                Debug.Table(aCurrentlyRolling)
                Debug.Log('weightedRoster')
                Debug.Table(weightedRoster)

                -- Prep roll list
                local eligibleNames = '' -- used for output later on, comma separated string of names eligible for need

                for num, row in ipairs(aCurrentlyRolling) do
                    -- Setup new fields
                    row.hasRolled = false
                    row.rollType = false
                    row.rollValue = nil
                    row.canNeed = false

                    -- Determine if this person can need under current weighting settings
                    for i, v in ipairs(weightedRoster) do
                        if namecompare(row.name, v.name) then
                            row.canNeed = true

                            if eligibleNames ~= '' then
                                eligibleNames = eligibleNames..', '..row.name
                            else
                                eligibleNames = row.name
                            end
                        end
                    end
                end

                if eligibleNames == '' then eligibleNames = Lokii.GetString('UI_Messages_Distribution_NobodyEligible') end

                -- Start roll timeout timer
                mCurrentlyRolling.timer:SetAlarm('roll_timeout', mCurrentlyRolling.timer:GetTime() + Options['Distribution']['RollTimeout'], RollTimeout, {item=loot})

                -- Announce that we're rolling
                OnAcceptingRolls({item=loot, eligibleNames=eligibleNames})

            end
        else
            Debug.Log(Lokii.GetString('UI_Messages_System_NoRollableForDistribute'))
        end
    else
        Debug.Log(Lokii.GetString('UI_Messages_System_NoIdentifiedForDistribute'))
    end
end

--[[
    RollTimeout(args)
    Behavior for when a roll has timed out.
    Triggered by timer alarm when a roll has timed out.
]]--
function RollTimeout(args)
    if mCurrentlyRolling then
        SendChatMessage('system', 'RollTimeout for ['..FixItemNameTag(mCurrentlyRolling.name, mCurrentlyRolling.quality)..']')
        RollFinish()
    end
end

--[[
    RollCancel(args)
    Behavior for when a roll is cancelled.
    Calls neccesary functions to clean up.
]]--
function RollCancel(args)
    if mCurrentlyRolling then
        SendChatMessage('system', 'RollCancel for ['..FixItemNameTag(mCurrentlyRolling.name, mCurrentlyRolling.quality)..']')
        RollCleanup()
    end
end

--[[
    RollCleanup()
    Resets roll variables so that we are ready to start a new roll.
]]--
function RollCleanup()
    if mCurrentlyRolling then
        mCurrentlyRolling.timer:KillAlarm('roll_timeout')
        Debug.Log('RollCleanup killing roll timeout alarm')
        mCurrentlyRolling = false
        aCurrentlyRolling = {}
    end
end


--[[
    RollDecision(args)
    Called by OnChatMessage when somebody declares their rolltype (if there is an active roll)
    Checks that author is eligible for rolltype, corrects it if not and then stores rolltype in list of rolls.

    Calls RollFinish() If the roll declaration is the final one
    Calls OnRollChange if the rolltype is changed (because author was not eligible for the rollType)
    Calls OnRollAccept when the rolltype is saved to the list of rolls
]]--
function RollDecision(args)

    if mCurrentlyRolling then 
        -- Let's see if the author is actually allowed to roll
        local totalRemaining = 0
        local needRemaining = 0
        -- Go through all the people who can roll
        for num, row in ipairs(aCurrentlyRolling) do
            -- If we've found the person who sent this message and he has not yet selected rollType
            if args.author == row.name and row.rollType == false then
                -- If he wants to roll need but isn't allowed to, change his roll to greed (y bastard)
                if args.rollType == RollType.Need and row.canNeed == false then
                    args.rollType = RollType.Greed
                    OnRollChange({item=mCurrentlyRolling, rollType=args.rollType, playerName=args.author})
                end

                -- Set the roll type and acknowledge
                row.rollType = args.rollType
                OnRollAccept({item=mCurrentlyRolling, rollType=args.rollType, playerName=args.author})
            end

            -- If the rollType is not yet set, this is a person who has yet to roll
            if row.rollType == false then 
                totalRemaining = totalRemaining + 1

                -- If this user can need roll, this is a person who has yet to roll and could need
                if row.canNeed then
                    needRemaining = needRemaining + 1
                end

            end

        end

        Debug.Log('RollDecision','NeedRemaining: '..tostring(needRemaining), 'totalRemaining: '..tostring(totalRemaining))

        -- If this was the last call needed, do rolls
        if totalRemaining == 0 or needRemaining == 0 then
            RollFinish()
        end
    end
end

--[[
    RollFinish()
    Executes rolls, determines winner, assigns item, cleans up.
]]--
function RollFinish()

    if mCurrentlyRolling then
        mCurrentlyRolling.timer:KillAlarm('roll_timeout') -- Prevent timeout callback
        Debug.Log('RollFinish killing roll timeout alarm')

        -- Declare vars
        local winner = ''
        local highest = nil
        local rolls = {}

        -- Figure out if someone has need rolled, and set any un-decided roll types to the default
        local someoneHasNeeded = false
        for num, row in ipairs(aCurrentlyRolling) do
            if row.rollType == RollType.Need then
                someoneHasNeeded = true
            elseif row.rollType == false then
                row.rollType = Options['Distribution']['RollTypeDefault']
            end
        end

        -- Go through rolls
        for num, row in ipairs(aCurrentlyRolling) do
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

                -- Append to rolls table
                table.insert(rolls, {roll=roll, rolledBy=row.name})

            end
            
        end

        -- If there were no rolls, assign free for all and send event
        if next(rolls) == nil then
            mCurrentlyRolling.assignedTo = true -- Fixme: wtf
            OnRollNobody({item=mCurrentlyRolling})

        -- Otherwise, send distribute event and assign to the winner
        else
            OnDistributeItem({item=mCurrentlyRolling, rolls=rolls})
            AssignItem(mCurrentlyRolling.entityId, winner)
        end

        -- Update loot panels
        UpdatePanel(mCurrentlyRolling)

        -- Clean up after this roll
        RollCleanup()

        -- If auto distribute start next roll
        if Options['Distribution']['AutoDistribute'] then DistributeItem() end

    else
        Debug.Warn('RollFinish but not currently rolling')
    end
end

--[[
    AssignItem(loot|entityId, winner)
    Assigns an item to a player.
    The first param can be either a table with an entityId property, or an entityId. If neither a table nor a string, tostring() will be applied.
]]--
function AssignItem(ref, winner)
    
    local entityId = ''
    if type(ref) == 'table' then
        entityId = tostring(ref.entityId)
    
    elseif type(ref) == 'string' then
        entityId = ref

    else
        entityId = tostring(ref)
    end

    if not _table.empty(aIdentifiedLoot) then
        for num, item in ipairs(aIdentifiedLoot) do 
            if tostring(item.entityId) == entityId then
                item.assignedTo = winner
                OnAssignItem({
                    item = item,
                    assignedTo = winner,
                    playerName = winner,
                })
                return
            end
        end
    end
    Debug.Warn('AssignItem failed to assign item :( '..tostring(entityId)..' to '..winner)
end
--[[
    GetEntitled(loot)
    Returns a list of people able to roll for loot under the current loot weighing settings
    Todo: Make this function less terrible
]]--
function GetEntitled(loot)

    -- Get Options type and stage keys for this item
    local typeKey, stageKey = GetItemOptionsKeys(loot, Options['Distribution']) 

    -- Build entitled roster if weighting options are enabled
    if Options['Distribution'][typeKey][stageKey]['Weighting'] ~= WeightingOptions.None then 

        local entitledRoster = {}
        local eligibleArchetypes = {}
        local eligibleFrames = {}

        -- If itemInfo has classes, use those
        if loot.itemInfo.classes then
            for i, class in ipairs(loot.itemInfo.classes) do
                eligibleArchetypes[#eligibleArchetypes + 1] = class
            end
        end

        -- If it's an equipment item, check local data
        if IsEquipmentItem(loot.itemInfo) and loot.craftingTypeId then
            local itemArchetype, itemFrame = xBattleframes.GetInfoByCraftingTypeId(tostring(loot.craftingTypeId))
            if itemArchetype then
                eligibleArchetypes[#eligibleArchetypes + 1] = itemArchetype
            end
            if itemFrame then
                eligibleFrames[#eligibleFrames + 1] = itemFrame
            end 
        end

        -- If it's a crafting component, check local data
        if IsCraftingComponent(loot.itemInfo) and loot.itemTypeId then
            for k, v in pairs(data_CraftingComponents) do
                if v.itemTypeId == tostring(loot.itemTypeId) and v.classes then
                    for i, class in ipairs(v.classes) do
                        eligibleArchetypes[#eligibleArchetypes + 1] = class
                    end
                end
            end
        end

        Debug.Table({eligibleArchetypes=eligibleArchetypes, eligibleFrames=eligibleFrames})

        -- Add entitled under Archetype setting
        if Options['Distribution'][typeKey][stageKey]['Weighting'] == WeightingOptions.Archetype then
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
    end
    -- Return an unmodified roster if weighting options are disabled or if we had no entires in the entitled roster
    return aSquadRoster.members
end
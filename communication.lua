--[[
    For addon-to-addon communication events.
    
    Option checking is done in Private.SendLink and Private.CanReceive
    Non-options related conditions must be checked explicitly.

]]--

Communication = {
    
}

local Private = {
    
}



local ChatLink = {
    PairBreak = ChatLib.GetLinkTypeIdBreak(),
    Endcap = ChatLib.GetEndcapString(),
    DataBreak = ':',
    SubDataBreak = ';',
    BooleanValue = '>',
}

local ChatLinkId = {
    Assign = 'xslm_a',
    ItemIdentity = 'xslm_ii',
    RollStart = 'xslm_r_s',
    RollDecision = 'xslm_r_d',
    RollUpdate = 'xslm_r_u'
}


function Communication.Setup()
    ChatLib.RegisterCustomLinkType(ChatLinkId.Assign, Communication.ReceiveAssign)
    ChatLib.RegisterCustomLinkType(ChatLinkId.ItemIdentity, Communication.ReceiveItemIdentity)
    ChatLib.RegisterCustomLinkType(ChatLinkId.RollStart, Communication.ReceiveRollStart)
    ChatLib.RegisterCustomLinkType(ChatLinkId.RollDecision, Communication.ReceiveRollDecision)
    ChatLib.RegisterCustomLinkType(ChatLinkId.RollUpdate, Communication.ReceiveRollUpdate)
end


function Communication.SendItemIdentity(item)
    -- Requires that you are the squad leader
    if not bIsSquadLeader then return end

    -- Genereate
    local link = ChatLink.Endcap..ChatLinkId.ItemIdentity..ChatLink.PairBreak..EncodeItemReference(item)..ChatLink.PairBreak..EncodeItemIdentity(item)..ChatLink.PairBreak..ChatLink.Endcap

    -- Send
    Private.SendLink(link, 'ItemIdentity')
end

function Communication.ReceiveItemIdentity(args)
    -- Requires that we can receive this link
    if not Private.CanReceive('ItemIdentity') then return end

    -- Only listen if author is the master and it's not us
    if IsSquadLeader(args.author) and not namecompare(args.author, Player.GetInfo()) then

        Debug.Log('ItemIdentity declaration acknowledged, attempting to decode')

        -- Generic pattern
        local dataPattern = '(.-)('..ChatLink.PairBreak..')' -- Todo: Globalize me

        -- Prepare parts
        local data = args.link_data
        local itemDataPart
        local identityDataPart

        -- Separate data parts
        for a, b in unicode.gmatch(data, dataPattern) do
            Debug.Table({'ItemIdentity Parts Gmatch', a=a, b=b})
            if not itemDataPart then
                itemDataPart = a
            else
                identityDataPart = a
            end
        end

        -- Decode each part
        local itemTypeId, quality, quantity = DecodeItemReference(itemDataPart)
        local identityId = DecodeItemIdentity(identityDataPart)

        -- See if we can assign the identityId
        local success = false
        for _, item in ipairs(aIdentifiedLoot) do
            
            -- We shouldn't overwrite an existing identityId
            if not item.identityId then

                -- Does it match the references?
                if tostring(item.itemTypeId) == tostring(itemTypeId) and tostring(item.quality) == tostring(quality) then

                    -- It does! Great success :D Set!
                    item.identityId = identityId
                    success = true
                    break
                end
            end
        end

        -- Debug the result
        if not success then
            Debug.Log('Failed to match item identity, but it could have already been assigned or something.')
        else
            Debug.Log('Succesfully set the item identity')
        end
    end

end

function Communication.SendAssign(item, assignTarget)
    -- Requires that you are the squad leader
    if not bIsSquadLeader then return end

    -- If the assignValue is a boolean, convert it to 0/1 so that it can be easily determined later
    local assignValue = assignTarget
    if type(assignTarget) == 'boolean' then
        assignValue = tostring(tonumber(assignTarget))
    end

    -- Genereate
    local link = ChatLink.Endcap..ChatLinkId.Assign..ChatLink.PairBreak..EncodeItemIdentity(item)..ChatLink.PairBreak..assignValue..ChatLink.PairBreak..ChatLink.Endcap

    -- Send
    Private.SendLink(link, 'Assign')
end


function Communication.ReceiveAssign(args)
    -- Requires that we can receive this link
    if not Private.CanReceive('Assign') then return end

    -- Only listen to the master, and don't listen to ourselves
    if IsSquadLeader(args.author) and not namecompare(args.author, Player.GetInfo()) then

        -- Generic data pattern
        local dataPattern = '(.-)('..ChatLink.PairBreak..')' -- Todo: Globalize me

        -- Parts
        local identityPart
        local assignTargetPart

        -- Get parts
        for contents, separator in unicode.gmatch(args.link_data, dataPattern) do
            Debug.Table('ReceiveAssign Part Gmatch', {contents=contents, separator=separator})

            if not identityPart then 
                identityPart = contents
            else 
                assignTargetPart = contents
            end
        end

        -- Decode parts into data
        local identityId = DecodeItemIdentity(identityPart)
        local assignTarget = DecodeBooleanValue(assignTargetPart) -- Note: Assign Target is not always a boolean value. Sorry. :D

        -- Identify item
        local localItem = GetItemByIdentity(identityId)

        -- If we found the item, assign it
        if localItem then

            -- Because it matters yo
            if IsAssigned(localItem.entityId) then
                SendFilteredMessage('system', 'Squad Leader is reassigning %i from %a to %n', {item=localItem, assignedTo = localItem.assignedTo, playerName = tostring(assignTarget)})
            end

            -- Assign
            Distribution.AssignItem(localItem.entityId, tostring(assignTarget))
        else
            Debug.Log('Fail, didnt find the item to assign')
        end

    end

end

function Communication.SendRollDecision(item, rollType)
    -- Debug
    Debug.Table({func='Communication.SendRollDecision', item=item, rollType=rollType})

    -- Genereate
    local link = ChatLink.Endcap..ChatLinkId.RollDecision..ChatLink.PairBreak..EncodeItemIdentity(item)..ChatLink.PairBreak..rollType..ChatLink.PairBreak..ChatLink.Endcap

    -- Send
    Private.SendLink(link, 'RollDecision')
end


function Communication.ReceiveRollDecision(args)
    -- Requires that we can receive this link
    if not Private.CanReceive('RollDecision') then return end

    -- Requires that you are the squad leader
    if not bIsSquadLeader then return end

    -- Requires that we are listening for a roll
    if not RollTracker.IsRolling() then return end


    -- Generic pattern
    local dataPattern = '(.-)('..ChatLink.PairBreak..')' -- Todo: Globalize me

    -- Part holders
    local data = args.link_data
    local identityPart
    local rollTypePart

    -- Get the parts
    for contents, separator in unicode.gmatch(data, dataPattern) do
        Debug.Table('ReceiveAssign Part Gmatch', {contents=contents, separator=separator})

        if not identityPart then 
            identityPart = contents
        else 
            rollTypePart = contents
        end
    end

    -- Decode parts into data
    local identityId = DecodeItemIdentity(identityPart)
    local rollType = rollTypePart

    -- Figure out which item we are receiving a roll decision for
    local localItem = GetItemByIdentity(identityId)

    -- If we found the item, forward the roll decision
    if localItem then

        -- The item has to be the one we're rolling though, for now
        if RollTracker.IsBeingRolled(localItem.identityId) then
            RollDecision({item = localItem, author = data.author, rollType = rollType})
        else
            Debug.Log('Received a roll declaration, but couldnt find a roll for that item')
        end

    else
        Debug.Log('Fail, didnt find the item to assign')
    end
end


function Communication.SendRollStart(item)
    -- We should only be sending this if we are the master
    if not bIsSquadLeader then return end

    local distributionMode = DistributionMode.NeedBeforeGreed -- TODO: Send me

    -- Generate
    local link = ChatLink.Endcap..ChatLinkId.RollStart..ChatLink.PairBreak..EncodeItemIdentity(item)..ChatLink.PairBreak..EncodeRollData(item.rollData)..ChatLink.PairBreak..ChatLink.Endcap

    -- Send
    Private.SendLink(link)
end

function Communication.ReceiveRollStart(args)
    -- Verify that we can recieve this link
    if not Private.CanReceive('RollStart') then return end

    -- Only listen to the master, and don't listen to ourselves
    if IsSquadLeader(args.author) and not namecompare(args.author, Player.GetInfo()) then

        -- Generic pattern to breakup string
        local dataPattern = '(.-)('..ChatLink.PairBreak..')' -- Todo: Globalize me

        -- Prepare for parts
        local identityPart
        local rollDataPart

        -- Get parts
        for contents, separator in unicode.gmatch(args.link_data, dataPattern) do
            
            Debug.Table('Link Part Gmatch', {contents=contents, separator=separator})

            if not identityPart then 
                identityPart = contents
            else 
                rollDataPart = contents..ChatLink.SubDataBreak
            end
        end

        -- Decode parts
        local identityId = DecodeItemIdentity(identityPart)   
        local rollData = DecodeRollData(rollDataPart)

        -- Debug
        Debug.Table({identityId=itentityId, rollData=rollData})

        -- Find the item that we received roll data for
        local localItem = GetItemByIdentity(identityId)

        -- If we were able to find the item, update it with the new roll data
        if localItem then
            -- Update data
            localItem.rollData = rollData

            -- Force a tracker update :)
            Tracker.Update()
        end
    end
end


function Communication.SendRollUpdate(item)
    -- We should only be sending this if we are the master
    if not bIsSquadLeader then return end

    -- Generate
    local link = ChatLink.Endcap..ChatLinkId.RollUpdate..ChatLink.PairBreak..EncodeItemIdentity(item)..ChatLink.PairBreak..EncodeRollData(item.rollData)..ChatLink.PairBreak..ChatLink.Endcap

    -- Send
    Private.SendLink(link, 'RollUpdate')
end

function Communication.ReceiveRollUpdate(args)
    -- Verify that we can recieve this link
    if not Private.CanReceive('RollUpdate') then return end

    -- Don't listen to ourselves
    if not namecompare(args.author, Player.GetInfo()) then

        -- Generic pattern to breakup string
        local dataPattern = '(.-)('..ChatLink.PairBreak..')' -- Todo: Globalize me

        -- Prepare for parts
        local identityPart
        local rollDataPart

        -- Get parts
        for contents, separator in unicode.gmatch(args.link_data, dataPattern) do
            
            Debug.Table('Link Part Gmatch', {contents=contents, separator=separator})

            if not identityPart then 
                identityPart = contents
            else 
                rollDataPart = contents..ChatLink.SubDataBreak
            end
        end

        -- Decode parts
        local identityId = DecodeItemIdentity(identityPart)   
        local rollData = DecodeRollData(rollDataPart)

        -- Debug
        Debug.Table({'Communication.ReceiveRollUpdate', identityId=itentityId, rollData=rollData})

        -- Find the item that we received roll data for
        local localItem = GetItemByIdentity(identityId)

        -- If we were able to find the item, update it with the new roll data
        if localItem then
            -- Update data
            localItem.rollData = rollData

            -- Force a tracker update :)
            Tracker.Update()
        end
    end
end








function EncodeItemIdentity(item)
    local identityId = item.identityId
    if not identityId then
        Debug.Warn('Attempted to EncodeItemIdenttiy on an item with no identityId')
        return ''
    end

    return identityId..ChatLink.DataBreak
end

function DecodeItemIdentity(identityDataPart)
    Debug.Log('DecodeItemIdentity: '..identityDataPart)
    local identityId
    local identityPattern = '(.-)'..ChatLink.DataBreak

    for a, b in unicode.gmatch(identityDataPart, identityPattern) do
        identityId = a
    end

    Debug.Log('Decoded itemIdentity result: '..tostring(identityId))

    return identityId
end

function EncodeItemReference(item)
    local itemTypeId = tostring(item.itemTypeId)
    local quality = math.max(0, tonumber(item.quality))
    local quantity = math.max(0, tonumber(item.quantity))

    return itemTypeId..ChatLink.DataBreak..quality..ChatLink.DataBreak..quantity..ChatLink.DataBreak
end

function DecodeItemReference(itemDataPart)
    local itemReferencePattern = '(.-)'..ChatLink.DataBreak..'(.-)'..ChatLink.DataBreak..'(.-)'..ChatLink.DataBreak

    local itemTypeId
    local quality
    local quantity

    for a, b, c in unicode.gmatch(itemDataPart, itemReferencePattern) do
        itemTypeId = a
        quality = tonumber(b)
        quantity = tonumber(c)
    end

    Debug.Table({'Decoded itemReference', itemTypeId=itemTypeId, quality=quality, quantity=quantity})
    return itemTypeId, quality, quantity
end



function EncodeRollData(rollData)
    local rollTable = {}

    local tempMembersTable = {}

    for i, member in ipairs(rollData) do

        Debug.Log(member)

        local tempMemberSubPair = ''

        for j, value in pairs(member) do

            Debug.Table({j=j, value=value})

            local valueType = ChatLink.DataBreak
            local linkValue = value

            if type(value) == 'boolean' then
                valueType = ChatLink.BooleanValue
                linkValue = tonumber(value)
            end

            tempMemberSubPair = tempMemberSubPair..tostring(linkValue)..valueType

        end

        tempMembersTable[#tempMembersTable + 1] = tempMemberSubPair

    end

    local membersDataPair = table.concat(tempMembersTable, ChatLink.SubDataBreak)

    Debug.Table('Encoded rollData result', membersDataPair)
    return membersDataPair
end

function DecodeRollData(rollDataPart)
    Debug.Log('DecodeRollData() called with following part: '..rollDataPart)

    local rollData = {}

    local membersCrushPattern = '(.-)('..ChatLink.SubDataBreak..')'
    local memberDataPattern = '(.-)(['..ChatLink.DataBreak..ChatLink.BooleanValue..'])'

    -- Break up the data into one segment for each member
    for contents, separator in unicode.gmatch(rollDataPart, membersCrushPattern) do
        Debug.Table('Members Member Gmatch: ', {contents=contents, separator=separator})

        -- Template
        local member = {
            canNeed = nil,
            name = nil,
            hasRolled = nil,
            battleframe = nil,
            rollType = nil,
        }

        -- For each value of this member
        for subcontents, valueType in unicode.gmatch(contents, memberDataPattern) do
            Debug.Table('Member Value Gmatch: ', {subcontents=subcontents, valueType=valueType})

            -- Value is string by default
            local value = subcontents

            -- If we had the boolean indicator, convert to number
            if valueType == ChatLink.BooleanValue then
                value = DecodeBooleanValue(value)
            end

            -- Fill in the fields in this very specific order :/
            if member.canNeed == nil then
                member.canNeed = value
            elseif member.name == nil then 
                member.name = value
            elseif member.hasRolled == nil then 
                member.hasRolled = value
            elseif member.battleframe == nil then 
                member.battleframe = value
            elseif member.rollType == nil then 
                member.rollType = value
            end

        end

        Debug.Table('Decoded member result', member)
        
        -- Add decoded member to rollData
        rollData[#rollData + 1] = member
    end

    Debug.Table('Decoded rollData result', rollData)

    return rollData
end


function DecodeBooleanValue(value)
    if value == tostring(0) then
        value = false
    elseif value == tostring(1) then
        value = true
    end
    return value
end


function Private.SendLink(link, linkKey)
    -- Communication must be enabled
    if not Options['Communication']['Enabled'] then return end
        
    -- Check general custom settings
    if Options['Communication']['Custom'] then
        if not Options['Communication']['Send'] then
            return
        end
    end

    -- Check specific custom settings
    if Options['Communication']['Custom'] then
        if not Options['Communication'][linkKey]['Enabled']
        or not Options['Communication'][linkKey]['Send']
        then
            return
        end
    end

    -- If all is well, send link
    SendMessageToChat('squad', link, false)
end

function Private.CanReceive(linkKey)
    -- Communication must be enabled
    if not Options['Communication']['Enabled'] then return false end
        
    -- Check general custom settings
    if Options['Communication']['Custom'] then
        if not Options['Communication']['Receive'] then
            return false
        end
    end

    -- Check specific custom settings
    if Options['Communication']['Custom'] then
        if not Options['Communication'][linkKey]['Enabled']
        or not Options['Communication'][linkKey]['Receive']
        then
            return false
        end
    end

    -- If all is well, return true
    return true
end
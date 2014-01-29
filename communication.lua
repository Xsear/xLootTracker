--[[
    For addon-to-addon communication events.

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


    local link = ChatLink.Endcap..ChatLinkId.ItemIdentity..ChatLink.PairBreak..EncodeItemReference(item)..ChatLink.PairBreak..EncodeItemIdentity(item)..ChatLink.PairBreak..ChatLink.Endcap

    Debug.Log('SendItemIdentity: '..link)

    --ChatLib.SystemMessage({text=link})
    Private.SendLink(link)
end

function Communication.ReceiveItemIdentity(args)

    Debug.Log('ReceiveItemIdentity')
    Debug.Table(args)

    -- Only listen if author is the master and it's not us
    if IsSquadLeader(args.author) and not namecompare(args.author, Player.GetInfo()) then
    --if true then

        Debug.Log('ItemIdentity declaration acknowledged, attempting to decode')

        local data = args.link_data
        local dataPattern = '(.-)('..ChatLink.PairBreak..')'

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

    local assignValue = assignTarget
    if type(assignTarget) == 'boolean' then
        assignValue = tostring(tonumber(assignTarget))
    end

    local link = ChatLink.Endcap..ChatLinkId.Assign..ChatLink.PairBreak..EncodeItemIdentity(item)..ChatLink.PairBreak..assignValue..ChatLink.PairBreak..ChatLink.Endcap

    Private.SendLink(link)
end


function Communication.ReceiveAssign(args)

    Debug.Log('ReceiveAssign')
    Debug.Table(args)

    local dataPattern = '(.-)('..ChatLink.PairBreak..')'

    local identityPart
    local assignTargetPart

    if IsSquadLeader(args.author) and not namecompare(args.author, Player.GetInfo()) then
    --if true then

        for contents, separator in unicode.gmatch(args.link_data, dataPattern) do
            Debug.Table('ReceiveAssign Part Gmatch', {contents=contents, separator=separator})

            if not identityPart then 
                identityPart = contents
            else 
                assignTargetPart = contents
            end
        end

        local identityId = DecodeItemIdentity(identityPart)
        local assignTarget = assignTargetPart

        if assignTargetPart == tostring(0) then
            assignTarget = false
        elseif assignTargetPArt == tostring(1) then
            assignTarget = true
        end


        -- Identify item
        local localItem = GetItemByIdentity(identityId)

        -- If we found the item, assign it
        if localItem then
            -- Because it matters yo
            if IsAssigned(localItem.entityId) then
                SendFilteredMessage('system', 'Squad Leader is reassigning %i from %a to %n', {item=localItem, assignedTo = localItem.assignedTo, playerName = tostring(assignTarget)})
            end

            Distribution.AssignItem(localItem.entityId, tostring(assignTarget))
        else
            Debug.Log('Fail, didnt find the item to assign')
        end

    end

end



function Communication.SendRollDecision(item, rollType)
    Debug.Table({func='Communication.SendRollDecision', item=item, rollType=rollType})

    local link = ChatLink.Endcap..ChatLinkId.RollDecision..ChatLink.PairBreak..EncodeItemIdentity(item)..ChatLink.PairBreak..rollType..ChatLink.PairBreak..ChatLink.Endcap

    Private.SendLink(link)
end




function Communication.ReceiveRollDecision(args)
    -- Requires that you are the squad leader
    if not bIsSquadLeader then return end

    -- Requires that we are listening for a roll
    if not mCurrentlyRolling then return end


    local dataPattern = '(.-)('..ChatLink.PairBreak..')'

    local identityPart
    local rollTypePart

    if IsSquadLeader(args.author) and not namecompare(args.author, Player.GetInfo()) then
    --if true then

        for contents, separator in unicode.gmatch(args.link_data, dataPattern) do
            Debug.Table('ReceiveAssign Part Gmatch', {contents=contents, separator=separator})

            if not identityPart then 
                identityPart = contents
            else 
                rollTypePart = contents
            end
        end

        local identityId = DecodeItemIdentity(identityPart)
        local rollType = rollTypePart

        -- Identify item
        local localItem = GetItemByIdentity(identityId)

        -- If we found the item, assign it
        if localItem then

            if localItem.identityId == mCurrentlyRolling.identityId then
                RollDecision({author = data.author, rollType = rollType})
            else
                Debug.Log('Received a roll declaration, but the item identity didnt match the one we were rolling')
            end

        else
            Debug.Log('Fail, didnt find the item to assign')
        end

    end

end





function Communication.SendRollStart(item)
    -- Requires that you are the squad leader
    if not bIsSquadLeader then return end

    Debug.Log('Com Send Roll Start')

    local distributionMode = DistributionMode.NeedBeforeGreed -- TODO: Send me

    local link = ChatLink.Endcap..ChatLinkId.RollStart..ChatLink.PairBreak..EncodeItemIdentity(item)..ChatLink.PairBreak..EncodeRollData(item.rollData)..ChatLink.PairBreak..ChatLink.Endcap

    --ChatLib.SystemMessage({text=link})
    Private.SendLink(link)
end


function Communication.SendRollUpdate(item)
    
    local link = ChatLink.Endcap..ChatLinkId.RollUpdate..ChatLink.PairBreak..EncodeItemIdentity(item)..ChatLink.PairBreak..EncodeRollData(item.rollData)..ChatLink.PairBreak..ChatLink.Endcap

    --ChatLib.SystemMessage({text=link})
    Private.SendLink(link)
end


function Communication.ReceiveRollStart(args)
    Debug.Table(args)

    local dataPattern = '(.-)('..ChatLink.PairBreak..')'

    local identityPart
    local rollDataPart

    for contents, separator in unicode.gmatch(args.link_data, dataPattern) do
        Debug.Table('Link Part Gmatch', {contents=contents, separator=separator})

        if not identityPart then 
            identityPart = contents
        else 
            rollDataPart = contents..ChatLink.SubDataBreak
        end
    end

 
    local identityId = DecodeItemIdentity(identityPart)   
    
    local rollData = DecodeRollData(rollDataPart)

    Debug.Table({identityId=itentityId, rollData=rollData})

    -- Identify item
    local localItem = GetItemByIdentity(identityId)

    if localItem then
        -- Update data
        localItem.rollData = rollData

        Tracker.Update()
    end

    
end


function GetItemByIdentity(identityId)
    local localItem
    for num, item in ipairs(aIdentifiedLoot) do
        if tostring(item.identityId) == identityId then
            localItem = item
            break
        end
    end

    -- If we don't know about this item we won't get info from it anyway, so just abort
    if not localItem then Debug.Warn('No matching item for identity id that squad leader is starting a roll for') end
    return localItem
end

function Communication.ReceiveRollUpdate(args)
    
    local rollData = DecodeRollData(args.link_data)

    Debug.Table('ReceiveRollUpdate', rollData)

    Tracker.Update()

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


function Private.SendLink(link)

    --Chat.SendChannelText('squad', link)
    SendMessageToChat('squad', link, false)

end


--[[



    function CompressTest(number)
        return _math.Base10ToBaseN(number, 64)
    end

    function DecompressTest(number)
        return _math.BaseNToBase10(number, 64)
    end



    function encodeTable(table)

        local ChatLink.DataBreak
        local c_NegDataBreak
        local ChatLink.PairBreak

        for _, value in pairs(table) do

            local breakValue = ChatLink.DataBreak



        end

    end

--]]
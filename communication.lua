--[[
    For addon-to-addon communication events.

]]--

Communication = {
    
}

local Private = {
    
}


function Communication.SendAssign()
    -- Requires that you are the squad leader
    if not bIsSquadLeader then return end

    --[[
        Relevant data:  itemTypeId, itemQuality, itemQuantity (maybe, for resources), unique reference id
    --]]

end



function Communication.SendRollDecision(item, rollType)
    Debug.Table({func='Communication.SendRollDecision', item=item, rollType=rollType})


end

function Communication.SendRollUpdate()
end


function Communication.ReceiveAssign()

end

function Communication.ReceiveRollUpdate()
    Tracker.Update()
end

function Communication.RecieveRollDecision()
    -- Requires that you are the squad leader
    if not bIsSquadLeader then return end

    -- Requires that we are listening for a roll
    if not mCurrentlyRolling then return end



    RollDecision({author = data.author, rollType = data.rollType})
end




    c_PairBreak = ChatLib.GetLinkTypeIdBreak()
    c_Endcap = ChatLib.GetEndcapString()
        
    c_DataBreak = ':'
    c_SubDataBreak = ';'

    c_BooleanValue = '>'


function Communication.SendRollStart(item)
    -- Requires that you are the squad leader
    if not bIsSquadLeader then return end


    Debug.Log('Com Send Roll Start')
    Debug.Table({itemName = item.name, itemTypeId = item.itemTypeId, itemQuality = item.quality, rollData = item.rollData})


    c_ItemLinkId = 'xslm_r_s'
    

    local link = c_ItemLinkId..c_PairBreak

    local dataTable = {}

    local itemTypeId = tostring(item.itemTypeId)
    local quality = math.max(0, tonumber(item.quality))
    local distributionMode = DistributionMode.NeedBeforeGreed

    dataTable[#dataTable + 1] = itemTypeId
    dataTable[#dataTable + 1] = quality
    dataTable[#dataTable + 1] = distributionMode

    link = link..table.concat(dataTable, c_DataBreak)..c_PairBreak

    -- Members
    local rollTable = {}

    local tempMembersTable = {}

    for i, member in ipairs(item.rollData) do

        Debug.Log(member)

        local tempMemberSubPair = ''

        for j, value in pairs(member) do

            Debug.Table({j=j, value=value})

            local valueType = c_DataBreak
            local linkValue = value

            if type(value) == 'boolean' then
                valueType = c_BooleanValue
                linkValue = tonumber(value)
            end

            tempMemberSubPair = tempMemberSubPair..tostring(linkValue)..valueType

        end

        tempMembersTable[#tempMembersTable + 1] = tempMemberSubPair

    end

    local membersDataPair = table.concat(tempMembersTable, c_SubDataBreak)

    link = link..membersDataPair..c_PairBreak


    

    link = c_Endcap..link..c_Endcap

    ChatLib.SystemMessage({text=link})

end


function Communication.ReceiveRollStart(args)
    Debug.Table(args)

    local crushPattern = '(.-)('..c_PairBreak..')'
    local membersCrushPattern = '(.-)('..c_SubDataBreak..')'

    local dataPart
    local membersPart

    for contents, separator in unicode.gmatch(args.link_data, crushPattern) do
        Debug.Table({p="Crush", contents=contents, separator=separator})

        if not dataPart then 
            dataPart = contents..c_DataBreak
        else 
            membersPart = contents..c_SubDataBreak
        end
    end

    Debug.Log('DataPart: '..dataPart)
    
    local dataPartPattern = '(.-)'..c_DataBreak..'(.-)'..c_DataBreak..'(.-)'..c_DataBreak

    local itemTypeId
    local quality
    local distributionMode

    for a, b, c in unicode.gmatch(dataPart, dataPartPattern) do
        itemTypeId = a
        quality = b
        distributionMode = c
    end

    Debug.Table({itemTypeId=itemTypeId, quality=quality, distributionMode=distributionMode})


    Debug.Log('MembersPart: '..membersPart)

    local members = {}

    for contents, separator in unicode.gmatch(membersPart, membersCrushPattern) do
        Debug.Table({p='membersCrush', contents=contents, separator=separator})

        local member = {
            canNeed = nil,
            name = nil,
            hasRolled = nil,
            battleframe = nil,
            rollType = nil,
        }

        local memberDataPattern = '(.-)(['..c_DataBreak..c_BooleanValue..'])'

        for subcontents, valueType in unicode.gmatch(contents, memberDataPattern) do
            Debug.Table({subcontents=subcontents, valueType=valueType})

            local value = subcontents

            if valueType == c_BooleanValue then
                value = tonumber(value)
            end

            if not member.canNeed then
                member.canNeed = value
            elseif not member.name then 
                member.name = value
            elseif not member.hasRolled then 
                member.hasRolled = value
            elseif not member.battleframe then 
                member.battleframe = value
            elseif not member.rollType then 
                member.rollType = value
            end
        end

        Debug.Table(member)
        members[#members + 1] = member
    end

    Debug.Table(members)



end



--[[

    "rollData" : [
        {
            "canNeed" : true, 
            "name" : "Xsear", 
            "hasRolled" : false, 
            "battleframe" : "medic", 
            "rollType" : false
        }, 
        {
            "canNeed" : true, 
            "name" : "SquadRosterUpdateFake1", 
            "hasRolled" : false, 
            "battleframe" : "berzerker", 
            "rollType" : false
        }, 
        {
            "canNeed" : true, 
            "name" : "SquadRosterUpdateFake2", 
            "hasRolled" : false, 
            "battleframe" : "recon", 
            "rollType" : false
        }
    ], 

    EncodeTest = function(itemTypeId, quality, attributes)
        itemTypeId = tostring(itemTypeId)
        quality = math.max(0, tonumber(quality)) --nil becomes -1; need min of 0
        attributes = lf.FormatAttributes(attributes or {})
        local link = c_ItemLinkId..c_PairBreak..lf.Compress(itemTypeId)..c_DataBreak..lf.Compress(quality)
        for _, attribute in ipairs(attributes) do
            local value_break = c_DataBreak
            local value = attribute.value
            if value < 0 then
                value_break = c_NegDataBreak
                value = -value
            end
            value = math.floor(0.5 + (value * c_PreserveDecimal))
            link = link..c_PairBreak..lf.Compress(attribute.id)..value_break..lf.Compress(value)
        end
        return c_Endcap..link..c_Endcap
    end




    function CompressTest(number)
        return _math.Base10ToBaseN(number, 64)
    end

    function DecompressTest(number)
        return _math.BaseNToBase10(number, 64)
    end



    function encodeTable(table)

        local c_DataBreak
        local c_NegDataBreak
        local c_PairBreak

        for _, value in pairs(table) do

            local breakValue = c_DataBreak



        end

    end

--]]
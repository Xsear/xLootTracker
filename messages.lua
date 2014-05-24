
Messages = {}

local Private = {
    ci_MessageLengthLimit = 255 -- Character limit of chat messages. Used to split too long messages into multiple. One character reserved for alerts.
}

--[[
    Messages.SendChatMessage(channel, message, [alert])
    For normal chat messages.
]]--
function Messages.SendChatMessage(channel, message, alert)
    -- Requires that Core and Messages are Enabled
    if not (Options['Core']['Enabled'] and Options['Messages']['Enabled']) then return end

    -- Requires that you are the squad leader in order to send messages on squad channel
    if channel == 'squad' and not bIsSquadLeader then return end

    -- Handle optional arguments
    alert = false -- Fixme: Deprecate

    -- Setup prefix
    local prefix = Options['Messages']['Prefix']

    -- Calculate message content length limit
    local messageContentLengthLimit = Private.ci_MessageLengthLimit - unicode.len(Options['Messages']['Prefix'])

    -- If the message is to long to send in one go, attempt to split lines into multiple messages
    if unicode.len(message) > messageContentLengthLimit then
        -- Explode the message on each new line
        local messages = explode('\n', message)
        local currentMessage = ''

        -- For each line in the message
        for num, line in ipairs(messages) do
            Debug.Log(tostring(num)..' : Length: '..unicode.len(message)..'/'..tostring(messageContentLengthLimit)..' : Line: '..line)
            Debug.Log('Message: '..currentMessage)

            -- Warn if line is too long
            if unicode.len(line) > messageContentLengthLimit then 
                Debug.Warn('Unable to properly accommodate for message length, too many characters on line '..tostring(num))
            end

            -- On the very first iteration, just add message
            if currentMessage == '' then
                currentMessage = line

            -- On subsequent iterations, we're gonna do some shit
            else
                -- If adding the next line exceeds the character limit
                if unicode.len(currentMessage..'\n'..line) > messageContentLengthLimit then
                    -- Send the current line and start a new message for the next line
                    Messages.SendMessageToChat(channel, prefix..currentMessage, alert)
                    currentMessage = line

                -- Otherwise
                else
                    -- Add the next line to the current line
                    currentMessage = currentMessage..'\n'..line
                end
            end
        end
        -- Make sure we send the last message
        if currentMessage ~= '' then Messages.SendMessageToChat(channel, prefix..currentMessage, alert) end

    -- Otherwise, send message normally
    else
        Messages.SendMessageToChat(channel, prefix..message, alert)
    end
end


function Messages.SendFilteredMessage(channel, message, args)
    message = Private.RunMessageFilters(message, args)
    Messages.SendChatMessage(channel, message)
end

-- Function to handle the actual sending of messages
function Messages.SendMessageToChat(channel, message, alert)
    channel = unicode.lower(channel)
    if Options['Debug']['Enabled'] and Options['Debug']['SquadToArmy'] and channel == 'squad' then channel = 'army' end
    local alertprefix = ''
    if alert then alertprefix = '!' end
    if channel == 'system' then
        ChatLib.SystemMessage({text=message})
    elseif channel == 'notification' or channel == 'notifications' then
        ChatLib.Notification({text=message})
    else
        Chat.SendChannelText(channel, alertprefix..message)
    end
end

--[[
    Messages.MessageEvent(eventClass, eventName, eventArgs, [canSend])
    Generic function used to handle the process of sending messages in response to events, based on specific options.
    Use the optional canSend argument to override bIsSquadLeader when determining whether or not to do anything.
--]]
function Messages.MessageEvent(eventClass, eventName, eventArgs, canSend)
    canSend = canSend or bIsSquadLeader
    if canSend and Options['Messages']['Events'][eventClass][eventName]['Enabled'] then
        for channelKey, channelValue in pairs(Options['Messages']['Events'][eventClass][eventName]['Channels']) do
            -- Var
            local message = ''

            -- Add event message
            if Options['Messages']['Events'][eventClass][eventName]['Channels'][channelKey]['Enabled'] then
                message = Private.RunMessageFilters(Options['Messages']['Events'][eventClass][eventName]['Channels'][channelKey]['Format'], eventArgs)
            end

            -- If we have rolls data, and OnRolls message is enabled, add
            if eventArgs.rolls and eventArgs.item and Options['Messages']['Events']['Distribution']['OnRolls']['Enabled'] and Options['Messages']['Events']['Distribution']['OnRolls']['Channels'][channelKey]['Enabled'] then

                local rollsMessage = Private.RollsFormater(Options['Messages']['Events']['Distribution']['OnRolls']['Channels'][channelKey]['Format'], eventArgs.rolls, eventArgs.item)
                
                if message == '' then
                    message = rollsMessage
                else
                    message = message..'\n'..rollsMessage
                end
            end

            -- Send message if we have one
            if message ~= '' then
                Messages.SendChatMessage(channelKey, message, eventArgs)
            end
        end
    end
end

--[[
    RollFormater
    Helper function to generate the proper format for multi-line roll messages
]]--
function Private.RollsFormater(format, rolls, item)
    local t = {}
    for num, row in ipairs(rolls) do
        t[#t+1] = Private.RunMessageFilters(format, {roll=row.roll, playerName=row.rolledBy, item=item})
    end
    return table.concat(t, '\n')
end

--[[
    Private.RunMessageFilters(message, args)
    Runs gsub filters for message formats.
    Pretty poorly implemented at the moment.
]]--
function Private.RunMessageFilters(message, args)

    local undefinedValue = ''
    if Options['Debug']['Enabled'] and Options['Debug']['UndefinedFilterArguments'] then undefinedValue = 'NOT_SET' end

    -- Fix undefined arguments
    args.item                = args.item or {}
    args.item.name           = args.item.name               or undefinedValue
    args.item.quality        = args.item.quality            or undefinedValue
    args.item.entityId       = args.item.entityId           or undefinedValue
    args.item.itemTypeId     = args.item.itemTypeId         or undefinedValue
    args.item.craftingTypeId = args.item.craftingTypeId     or undefinedValue
    args.item.craftingTypeId = args.item.easyId             or undefinedValue
    args.playerName          = args.playerName              or undefinedValue
    args.roll                = args.roll                    or undefinedValue
    args.rollType            = args.rollType                or undefinedValue
    args.lootedTo            = args.lootedTo                or undefinedValue
    args.assignedTo          = args.assignedTo              or undefinedValue
    args.distributionMode    = args.distributionMode        or undefinedValue

    args.members             = args.members                 or undefinedValue
    args.eligible            = args.eligible                or undefinedValue

    -- Item (Text)
    local itemAsText = ChatLib.CreateItemText({name = args.item.name}, args.item.quality)

    -- Item (Linked)
    local itemAsLink = ChatLib.EncodeItemLink(args.item.itemTypeId, args.item.quality, Game.GetItemAttributeModifiers(args.item.itemTypeId, args.item.quality))

    -- Item coordinates (Link)
    local itemCoordLink = ChatLib.EncodeCoordLink(args.item.pos)

    -- Item entityId
    local itemEntityId = tostring(args.item.entityId)
    -- Item itemTypeId
    local itemItemTypeId = tostring(args.item.itemTypeId)
    -- Item craftingTypeId
    local itemCraftingTypeId = tostring(args.item.craftingTypeId)
    -- Item easyId
    local itemEasyId = tostring(args.item.easyId)


    -- Player Subject (Link)
    local playerAsLink = undefinedValue
    if args.playerName ~= undefinedValue then
        playerAsLink = ChatLib.EncodePlayerLink(args.playerName)
    end
    -- Player Looted To (Link)
    local playerLootedToAsLink = undefinedValue
    if args.lootedTo ~= undefinedValue then
        playerLootedToAsLink = ChatLib.EncodePlayerLink(args.lootedTo)
    end
    -- Player Assigned To (Link)
    local playerAssignedToAsLink = undefinedValue
    if args.assignedTo ~= undefinedValue then
        playerAssignedToAsLink = ChatLib.EncodePlayerLink(args.assignedTo)
    end

    -- Members (Links)
    local membersAsLinks = {}
    if args.members ~= undefinedValue then
        for _, player in ipairs(args.members) do
            membersAsLinks[#membersAsLinks+1] = ChatLib.EncodePlayerLink(player.name)
        end
    end
    membersAsLinks = table.concat(membersAsLinks, ', ')

    -- Eligible (Links)
    local eligibleAsLinks = {}
    if args.eligible ~= undefinedValue then
        for _, player in ipairs(args.eligible) do
            eligibleAsLinks[#eligibleAsLinks+1] = ChatLib.EncodePlayerLink(player.name)
        end
    end
    eligibleAsLinks = table.concat(eligibleAsLinks, ', ')

    -- Distribution Mode
    local distributionMode = args.distributionMode -- Might need a formatter here

    -- Archetype/Frame replacements
    local itemForArchetype = undefinedValue
    local itemForFrame = undefinedValue


        local eligibleArchetypes = {}
        local eligibleFrames = {}

        if args.item.itemInfo then

            -- If it's an equipment item, check local data
            if IsEquipmentItem(args.item.itemInfo) and args.item.craftingTypeId then
                local itemArchetype, itemFrame = xBattleframes.GetInfoByCraftingTypeId(tostring(args.item.craftingTypeId))
                if itemArchetype then
                    eligibleArchetypes[#eligibleArchetypes + 1] = itemArchetype
                end
                if itemFrame then
                    eligibleFrames[#eligibleFrames + 1] = itemFrame
                end
            -- Else If it's a crafting component, check local data
            elseif IsCraftingComponent(args.item.itemInfo) and args.item.itemTypeId then
                for k, v in pairs(data_CraftingComponents) do
                    if v.itemTypeId == tostring(args.item.itemTypeId) and v.classes then
                        for i, class in ipairs(v.classes) do
                            eligibleArchetypes[#eligibleArchetypes + 1] = class
                        end
                    end
                end
            -- Else If itemInfo has classes, use those
            elseif args.item.itemInfo.classes then
                for i, class in ipairs(args.item.itemInfo.classes) do
                    eligibleArchetypes[#eligibleArchetypes + 1] = class
                end
            end
        end

    if #eligibleArchetypes == 1 then
        itemForArchetype = xBattleframes.GetDisplayNameOfArchetype(eligibleArchetypes[1])
    end
    if #eligibleFrames == 1 then
        itemForFrame = eligibleFrames[1]
    end


    -- Start building the output
    local output = message


    -- Item entityId
    output = unicode.gsub(output, '%%eId', itemEntityId)

    -- Item itemTypeId
    output = unicode.gsub(output, '%%tId', itemItemTypeId)

    -- Item craftingTypeId
    output = unicode.gsub(output, '%%cId', itemCraftingTypeId)

    -- Item For Archetype
    output = unicode.gsub(output, '%%fA', itemForArchetype)

    -- Item For Frame
    output = unicode.gsub(output, '%%fF', itemForFrame)

    -- Item easyId
    output = unicode.gsub(output, '%%id', itemEasyId)

    -- Item (Text)
    output = unicode.gsub(output, '%%it', itemAsText)

    -- Item (Linked)
    output = unicode.gsub(output, '%%i', itemAsLink)

    -- What sort of mode the item was distributed in
    output = unicode.gsub(output, '%%m', distributionMode)

    -- Player name
    output = unicode.gsub(output, '%%n', playerAsLink)

    -- Looted To
    output = unicode.gsub(output, '%%l', playerLootedToAsLink) 

    -- Assigned To
    output = unicode.gsub(output, '%%a', playerAssignedToAsLink)

    -- Roll
    output = unicode.gsub(output, '%%r', args.roll) 

    -- Roll type
    output = unicode.gsub(output, '%%t', args.rollType) 

    -- Members
    output = unicode.gsub(output, '%%p', membersAsLinks)

    -- Eligible
    output = unicode.gsub(output, '%%e', eligibleAsLinks)

    -- Item coordinates (Linked)
    output = unicode.gsub(output, '%%c', itemCoordLink)

   return output
end
local ciSquadMessageLengthLimit = 255 -- Character limit of Squad chat messages. Used to split too long messages into multiple. One character reserved for alerts.

--[[
    SendChatMessage(channel, message, [alert])
    For normal chat messages.
]]--
function SendChatMessage(channel, message, alert)
    -- Requires that Core and Messages are Enabled
    if not (Options['Core']['Enabled'] and Options['Messages']['Enabled']) then return end

    -- Requires that you are the squad leader in order to send messages on squad channel
    if channel == 'squad' and not bIsSquadLeader then return end

    -- Handle optional arguments
    alert = false -- Fixme: Remove thie functionality completely as it no longer exists in the game.

    -- Setup prefixe
    local prefix = Options['Messages']['Prefix']

    -- Function to handle the actual sending of messages
    local function SendMessageToChat(channel, message, alert)
        channel = unicode.lower(channel)
        --if channel == 'squad' then channel = 'army' end
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

    -- Calculate message content length limit
    local messageContentLengthLimit = ciSquadMessageLengthLimit - unicode.len(Options['Messages']['Prefix'])

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
                    SendMessageToChat(channel, prefix..currentMessage, alert)
                    currentMessage = line

                -- Otherwise
                else
                    -- Add the next line to the current line
                    currentMessage = currentMessage..'\n'..line
                end
            end
        end
        -- Make sure we send the last message
        if currentMessage ~= '' then SendMessageToChat(channel, prefix..currentMessage, alert) end

    -- Otherwise, send message normally
    else
        Debug.Log('Sending Chat Message: '..prefix..message)
        Debug.Log('Message Length: '..unicode.len(prefix..message))
        SendMessageToChat(channel, prefix..message, alert)
    end
end

--[[
    CommunicationEvent(type, eventArgs)
    For addon-to-addon communication events.
--]]
function CommunicationEvent(type, eventArgs)
    -- Requires that Core and Messages are Enabled
    if not (Options['Core']['Enabled'] and Options['Messages']['Enabled']) then return end

    -- Requires that you are the squad leader
    if not bIsSquadLeader then return end

    -- Requires that args.type is supplied
    if type == nil then 
        Debug.Error('CommunicationEvent called without a type supplied')
        return
    end

    -- Warn if custom communication settings are enabled
    if Options['Messages']['Communication']['Custom'] then
        Debug.Warn('Custom Communication Settings are enabled')
    end

    -- Requires that this communication message is enabled
    if not Options['Messages']['Communication'][type]['Enabled'] then return end

    -- Send message
    Chat.SendChannelText('squad', Options['Messages']['Communication']['Prefix']..RunMessageFilters(Options['Messages']['Communication'][type]['Format'], eventArgs))
end

--[[
    MessageEvent(eventClass, eventName, eventArgs, [canSend])
    Generic function used to handle the process of sending messages in response to events, based on specific options.
    Use the optional canSend argument to override bIsSquadLeader when determining whether or not to do anything.
--]]
function MessageEvent(eventClass, eventName, eventArgs, canSend)
    canSend = canSend or bIsSquadLeader
    if canSend and Options['Messages']['Events'][eventClass][eventName]['Enabled'] then
        for channelKey, channelValue in pairs(Options['Messages']['Events'][eventClass][eventName]['Channels']) do
            -- Var
            local message = ''

            -- Add event message
            if Options['Messages']['Events'][eventClass][eventName]['Channels'][channelKey]['Enabled'] then
                message = RunMessageFilters(Options['Messages']['Events'][eventClass][eventName]['Channels'][channelKey]['Format'], eventArgs)
            end

            -- If we have rolls data, and OnRolls message is enabled, add
            if eventArgs.rolls and eventArgs.item and Options['Messages']['Events']['Distribution']['OnRolls']['Enabled'] and Options['Messages']['Events']['Distribution']['OnRolls']['Channels'][channelKey]['Enabled'] then
                local rollsMessage = RollsFormater(Options['Messages']['Events']['Distribution']['OnRolls']['Channels'][channelKey]['Format'], eventArgs.rolls, eventArgs.item)
                if message == '' then
                    message = rollsMessage
                else
                    message = message..'\n'..rollsMessage
                end
            end

            -- Send message if we have one
            if message ~= '' then
                SendChatMessage(channelKey, message, eventArgs)
            end
        end
    end
end

--[[
    RollFormater
    Helper function to generate the proper format for multi-line roll messages
]]--
function RollsFormater(format, rolls, item)
    local message = ''
    for num, row in ipairs(rolls) do
        if message ~= '' then
            message = message..'\n'..RunMessageFilters(format, {roll=row.roll, playerName=row.rolledBy, item=item})
        else
            message = RunMessageFilters(format, {roll=row.roll, playerName=row.rolledBy, item=item})
        end
    end
    return message
end

--[[
    RunMessageFilters(message, args)
    Runs gsub filters for message formats.
    Pretty poorly implemented at the moment.
]]--
function RunMessageFilters(message, args)
    -- Fix undefined arguments
    args.item                = args.item or {}
    args.item.name           = args.item.name               or 'NOT_SET'
    args.item.quality        = args.item.quality            or 'NOT_SET'
    args.item.entityId       = args.item.entityId           or 'NOT_SET'
    args.item.itemTypeId     = args.item.itemTypeId         or 'NOT_SET'
    args.item.craftingTypeId = args.item.craftingTypeId     or 'NOT_SET'
    args.playerName          = args.playerName              or 'NOT_SET'
    args.roll                = args.roll                    or 'NOT_SET'
    args.rollType            = args.rollType                or 'NOT_SET'
    args.lootedTo            = args.lootedTo                or 'NOT_SET'
    args.assignedTo          = args.assignedTo              or 'NOT_SET'
    args.eligible            = args.eligibleNames           or 'NOT_SET'

    -- Create local mixes
    local itemNameQuality = FixItemNameTag(args.item.name, args.item.quality)

    -- Adjust item name
    local itemNameClean = FixItemNameTag(args.item.name)

    -- Archetype/Frame replacements
    local itemForArchetype, itemForFrame = 'NOT_SET'
    if args.item.craftingTypeId ~= 'NOT_SET' then
        itemForArchetype, itemForFrame = DWFrameIDX.ItemIdxString(args.item.craftingTypeId)
    end

    -- Start building the output
    local output = message

    -- Loot mode
    --output = unicode.gsub(output, '%%m', Options['Distribution']['LootMode'])

    -- Item name with quality
    output = unicode.gsub(output, '%%iq', itemNameQuality)

    -- Item name
    output = unicode.gsub(output, '%%i', itemNameClean)

    -- Item quality
    output = unicode.gsub(output, '%%q', args.item.quality)

    -- Item entityId
    output = unicode.gsub(output, '%%eId', tostring(args.item.entityId))

    -- Item itemTypeId
    output = unicode.gsub(output, '%%tId', tostring(args.item.itemTypeId))

    -- Item craftingTypeId
    output = unicode.gsub(output, '%%cId', tostring(args.item.craftingTypeId))

    -- Item For Archetype
    output = unicode.gsub(output, '%%fA', itemForArchetype)

    -- Item For Frame
    output = unicode.gsub(output, '%%fF', itemForFrame)

    -- Player name
    output = unicode.gsub(output, '%%n', args.playerName)

    -- Roll
    output = unicode.gsub(output, '%%r', args.roll) 

    -- Roll type
    output = unicode.gsub(output, '%%t', args.rollType) 

    -- Looted To
    output = unicode.gsub(output, '%%l', args.lootedTo) 

    -- Assigned To
    output = unicode.gsub(output, '%%a', args.assignedTo)

    -- Eligible (super hardcoded)
    output = unicode.gsub(output, '%%e', args.eligibleNames)

   return output
end
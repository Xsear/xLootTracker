--[[
    Messages
    Implements functions to send messages to chat, as well as a system for sending customizable messages in response to Tracker events.
--]]
Messages = {}

local Private = {
    messageLengthLimit = 255 -- Character limit of chat messages. Used to split too long messages into multiple. One character reserved for alerts.
}

--[[
    Messages.OnTrackerNew(args)
    Called when Tracker has added a new item.
    Triggers the OnLootNew MessageEvent.
--]]
function Messages.OnTrackerNew(args)
    Messages.MessageEvent('Tracker', 'OnLootNew', args)
end

--[[
    Messages.OnTrackerUpdate(args)
    Called when Tracker has updated the status of an item.
    Triggers the OnLootLooted and OnLootLost MessageEvents.
--]]
function Messages.OnTrackerUpdate(args)
    if args.previousState == LootState.Available then
        if args.newState == LootState.Looted then
            Messages.MessageEvent('Tracker', 'OnLootLooted', args)
        elseif args.newState == LootState.Lost then
            Messages.MessageEvent('Tracker', 'OnLootLost', args)
        end
    end
end

--[[
    Messages.MessageEvent(eventClass, eventName, eventArgs)
    Handles the process of figuring out what message to send for an event, based on its options.
--]]
function Messages.MessageEvent(eventClass, eventName, eventArgs)
    if Options['Messages']['Events'][eventClass][eventName]['Enabled'] then

        if eventArgs.lootId then
            local loot = Tracker.GetLootById(eventArgs.lootId)
            
            if loot then
                -- Blacklist Check
                if Options['Blacklist']['Messages'][tostring(loot:GetTypeId())] then
                    return
                end

                -- Filtering Check
                if not Filtering.Filter(loot, Options['Messages']['Events'][eventClass][eventName]) then
                    --Debug.Log('Not sending message because it did not pass filters')
                    return
                end

                -- Setup filtering options ref
                local categoryKey, rarityKey = Filtering.GetFilteringOptionsKeys(loot, Options['Messages']['Events'][eventClass][eventName]['Filtering'])
                local optionsRef = Options['Messages']['Events'][eventClass][eventName]['Filtering'][categoryKey][rarityKey]

                -- OnLootLooted Ignore Others Check
                if eventName == 'OnLootLooted' then
                    
                    if optionsRef['IgnoreOthers'] then
                        if namecompare(State.playerName, loot:GetLootedBy()) then
                            return
                        end
                    end
                end


                -- Event looks fine, proceed with the messages
                for channelKey, channelValue in pairs(optionsRef['Channels']) do
                    if Options['Messages']['Channels'][channelKey] then
                        -- Var
                        local message = ''

                        -- Add event message
                        if optionsRef['Channels'][channelKey]['Enabled'] then
                            message = Messages.TextFilters(optionsRef['Channels'][channelKey]['Format'], eventArgs)
                        end

                        -- Send message if we have one
                        if message ~= '' then
                            Messages.SendChatMessage(channelKey, message) -- , eventArgs
                        end
                    end
                end
            end
        end
    end
end

--[[
    Messages.SendFilteredMessage(channel, message, args)
    Allows for sending a formatted message outside of the event system.
--]]
function Messages.SendFilteredMessage(channel, message, args)
    message = Messages.TextFilters(message, args)
    Messages.SendChatMessage(channel, message)
end

--[[
    Messages.SendChatMessage(channel, message, [alert])
    Receives a full message to send to a channel, optionally as an alert.
]]--
function Messages.SendChatMessage(channel, message, alert)
    -- Requires that Core and Messages are Enabled
    if not (Options['Core']['Enabled'] and Options['Messages']['Enabled']) then return end

    -- Requires that you are the squad leader in order to send messages on squad channel
    if channel == 'squad' and (not State.isSquadLeader and Options['Messages']['OnlyWhenSquadLeader']) then return end

    -- Requires that you are the platoon leader in order to send messages on platoon channel
    if channel == 'platoon' and (not State.isPlatoonLeader and Options['Messages']['OnlyWhenPlatoonLeader']) then return end

    -- Handle optional arguments
    alert = alert or false

    -- Setup prefix
    local prefix = Options['Messages']['Prefix']

    -- Calculate message content length limit
    local messageContentLengthLimit = Private.messageLengthLimit - unicode.len(Options['Messages']['Prefix'])

    -- If the message is to long to send in one go, attempt to split lines into multiple messages
    if unicode.len(message) > messageContentLengthLimit then
        -- Explode the message on each new line
        local messages = explode('\n', message)
        local currentMessage = ''

        -- For each line in the message
        for num, line in ipairs(messages) do
            --Debug.Log(tostring(num)..' : Length: '..unicode.len(message)..'/'..tostring(messageContentLengthLimit)..' : Line: '..line)
            --Debug.Log('Message: '..currentMessage)

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

--[[
    Messages.SendSystemMessage(message)
    Convenience function to send a system message.
    Intended to be used by Slash commands.
--]]
function Messages.SendSystemMessage(message)
    local prefix = Lokii.GetString('SystemMessage_Prefix')
    Messages.SendMessageToChat('system', prefix..message)
end

--[[
    Messages.SendMessageToChat(channel, message, alert)
    Function to handle the actual sending of messages to chat.
    Trusts blindly, does not check any options.
--]]
function Messages.SendMessageToChat(channel, message, alert)
    channel = unicode.lower(channel)
    if Options['Debug']['Enabled'] and Options['Debug']['SquadToArmy'] and channel == 'squad' then channel = 'army' end
    local alertprefix = ''
    if alert and (channel == 'squad' or channel == 'platoon') then alertprefix = '!' end
    if channel == 'system' then
        ChatLib.SystemMessage({text=message})
    elseif channel == 'notification' or channel == 'notifications' then
        ChatLib.Notification({text=message})
    else
        Chat.SendChannelText(channel, alertprefix..message)
    end
end

--[[
    Messages.TextFilters(formatString, args)
    The function that inserts information into a formatted string.
    Pretty poorly implemented at the moment.
]]--
function Messages.TextFilters(formatString, args)
    --Debug.Table('Messages.TextFilters called on string '..tostring(formatString) .. ' with args: ', args)
    if not formatString then
        Debug.Log('Messages.TextFilters did not receive a formatString')
        return
    end
    local loot = args.loot or Tracker.GetLootById(args.lootId)
    if not loot then
        Debug.Warn('Messages.TextFilters NODATAERROR')
        return 'NODATAERROR'
    end

    local replacementVars = {
        itemName = loot:GetName(),
        itemRarity = Loot.GetDisplayNameOfRarity(loot:GetRarity()),
        itemLevel = tostring(loot:GetItemLevel()),
        itemReqLevel = tostring(loot:GetRequiredLevel()),
        itemAsLink = loot:GetAsLink(),
        itemAsText = loot:GetAsText(),
        itemCoordLink = loot:GetCoordLink(),
        lootedBy = loot:GetLootedBy(),
        lootedTo = loot:GetLootedTo(),
        state = loot:GetState(),
        entity = loot:GetEntityId(),
    }

    for key, value in pairs(replacementVars) do
        if type(value) == 'table' then
            Debug.Warn('Replacement key ' .. tostring(key) .. ' has table value : ' .. tostring(value))
        end
    end

    return Private.replace_vars(formatString, replacementVars)
end

-- Source: http://lua-users.org/wiki/StringInterpolation
-- Credit: http://lua-users.org/wiki/MarkEdgar
function Private.replace_vars(str, vars)
  -- Allow replace_vars{str, vars} syntax as well as replace_vars(str, {vars})
  if not vars then
    vars = str
    str = vars[1]
  end
  return (string.gsub(str, '({([^}]+)})',
    function(whole,i)
      return vars[i] or whole
    end))
end


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

function Communication.SendRollAnnouncement()
    -- Requires that you are the squad leader
    if not bIsSquadLeader then return end

    


end

function Communication.SendRollDecision(item, rollType)
    Debug.Table({func='Communication.SendRollDecision', item=item, rollType=rollType})


end


function Communication.ReceiveAssign()

end

function Communication.ReceiveRollAnnouncement()
    Tracker.Update()
end

function Communication.RecieveRollDecision()
    -- Requires that you are the squad leader
    if not bIsSquadLeader then return end

    -- Requires that we are listening for a roll
    if not mCurrentlyRolling then return end

    RollDecision({author = data.author, rollType = data.rollType})
end

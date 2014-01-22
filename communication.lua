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
        Relevant data:  itemTypeId, itemQuality, itemQuantity (maybe, for resources)
    --]]

end

function Communication.SendRollAnnouncement()
    -- Requires that you are the squad leader
    if not bIsSquadLeader then return end

    


end

function Communication.SendRollDecision()
end


function Communication.ReceiveAssign()
end

function Communicaiton.ReceiveRollAnnouncement()
end

function Communication.RecieveRollDecision()
    -- Requires that you are the squad leader
    if not bIsSquadLeader then return end

    -- Requires that we are listening for a roll
    if not mCurrentlyRolling then return end

end

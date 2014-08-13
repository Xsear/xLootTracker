-- Loot Entry Class



Loot = {
    id            = nil,
    entityId      = nil,
    targetInfo    = nil,
    itemInfo      = nil,
    category      = nil,

    createdAt     = nil,

    state = nil,



    -- should ideally not be here ?
    CYCLE_Update = nil,
    waypoint = nil,
    lootedBy = nil,
    lootedTo = nil,



};
Loot.__index = Loot


local Private = {
    idCounter = 0,
}

function Private.GenerateId()

    -- local player = tostring(Player.GetInfo()) -- Fixme: Get rid of army tag

    local time = tostring(System.GetLocalUnixTime())

    local occurance = tostring(Private.idCounter)
    Private.idCounter = Private.idCounter + 1

    -- Put it all together
    local id = time..occurance -- player..

    return id
end


function Loot.DetermineCategory(targetInfo, itemInfo)
    local category = LootCategory.Unknown

    if IsEquipment(itemInfo) then
        category = LootCategory.Equipment

    elseif IsModule(itemInfo) then 
        category = LootCategory.Modules

    elseif IsSalvage(itemInfo) then
        category = LootCategory.Salvage

    elseif IsComponent(itemInfo) then
        category = LootCategory.Components

    elseif IsConsumable(itemInfo) then
        category = LootCategory.Consumable

    end

    if category == LootCategory.Unknown then
        --Debug.Warn("Private.Identify LootCategory.Unknown", targetInfo, itemInfo)
        -- Well this is basically the "shit we dont care about category" now ;o
    end

    --Debug.Log(tostring(targetInfo.name) .. ' identified as ' .. tostring(category))

    return category
end

function Private.DetermineState(loot)
    local state = LootState.Unknown

    if loot:GetEntityId() then
        if Game.IsTargetAvailable(loot:GetEntityId()) then
            state = LootState.Available
        elseif Options['Debug']['Enabled'] and tonumber(loot:GetEntityId()) <= 2000 and tonumber(System.GetElapsedTime(loot.createdAt)) < 30 then
            state = LootState.Available -- Debug
        else
            if loot.lootedBy then
                state = LootState.Looted
            else
                state = LootState.Lost
            end
        end
    end

    if not state then Debug.Warn("dafaq, determine state returning nil, why?") Debug.Table("determinestate loot", loot) end

    return state
end

function Loot:Update()
    self.state = Private.DetermineState(self)
end

function Loot.Create(args)


    args.event = "Loot.Create"
    --Debug.Event(args)

    -- Setup vars from args
    local entityId     = args.entityId
    local targetInfo   = args.targetInfo
    local itemInfo     = args.itemInfo

    -- Check entityId
    if not entityId then
        -- We should have an entityId
        Debug.Warn("Loot.Create called without an entityId")
    end

    -- Setup targetInfo
    if not targetInfo then
        -- Do we have a valid entityId?
        if Game.IsTargetAvailable(entityId) then

            -- Get targetInfo by entityId
            targetInfo = Game.GetTargetInfo(entityId)

            -- Verify success
            if not targetInfo then
                Debug.Error('Loot.Create unable to acquire targetInfo for entityId '..tostring(entityId))
                return
            end

        -- If we don't have targetInfo, we must have an entityId that references a valid target, so that we can retrieve information.
        else
            Debug.Error('Loot.Create called without targetInfo, and lacks available entity.')
            return
        end
    end

    -- Setup itemInfo
    if not itemInfo then

        -- Do we have a valid itemTypeId?
        if targetInfo.itemTypeId then

            -- Get itemInfo by itemTypeId
            itemInfo = Game.GetItemInfoByType(targetInfo.itemTypeId)

            -- Verify success
            if not itemInfo then
                Debug.Error('Loot.Create was unable to acquire itemInfo for itemTypeId '..tostring(targetInfo.itemTypeId))
                return
            end

        -- We don't have a valid itemTypeId? Then what do we do...
        else
            Debug.Log("Loot.Create called without itemInfo, and lacks target with itemTypeId")
            Debug.Table({entityId, targetInfo, itemInfo})
            return
        end
    end

    -- Simplify testing a little -- Note: Still?
    targetInfo.name = targetInfo.name or itemInfo.name


    -- Create instance
    local instance = {}
    setmetatable(instance, Loot)

    instance.id              = Private.GenerateId()
    instance.createdAt       = System.GetClientTime()

    instance.entityId        = entityId
    instance.targetInfo      = targetInfo
    instance.itemInfo        = itemInfo

    instance.category        = Loot.DetermineCategory(targetInfo, itemInfo)
    
    instance.state           = Private.DetermineState(instance)

    return instance
end

function Loot:GetEntityId()
    return self.entityId
end

function Loot:GetId()
    return self.id
end

function Loot:GetTypeId()
    return self.targetInfo.itemTypeId
end


function Loot:GetName()
    if not self.targetInfo then
        Debug.Warn("Loot Get Name called but no targetInfo!?")
        Debug.Table(self)
    end

    return self.targetInfo.name
end

function Loot:GetColor()
    return LIB_ITEMS.GetItemColor(self.itemInfo)
end

function Loot:GetWebIcon()
    return self.itemInfo.web_icon
end

function Loot:GetTypeId()
    return self.itemInfo.itemTypeId
end

function Loot:GetPos()
    return self.targetInfo.lootPos or {x=0, y=0, z=0}
end

function Loot:Destroy()
    Debug.Log("Loot:Destroy for " ..self.id.. " "..self:GetName())
        
    self = nil
end



function Loot:SetState(newState)
    self.state = newState
end

function Loot:GetState()
    return self.state
end

function Loot:SetLootedBy(input)
    self.lootedBy = input
end

function Loot:SetLootedTo(input)
    self.lootedTo = input
end

function Loot:GetLootedBy()
    return self.lootedBy or false
end

function Loot:GetLootedTo()
    return self.lootedTo or false
end


function Loot:GetCategory()
    return self.category
end

function Loot:ToString()

    local output = {}
    table.insert(output, "Loot")
    table.insert(output, tostring(self:GetName()))
    table.insert(output, "Category:" .. tostring(self:GetCategory()))
    table.insert(output, "Id:" .. tostring(self:GetId()))
    table.insert(output, "TypeId:" .. tostring(self:GetTypeId()))
    table.insert(output, "State:" .. tostring(self:GetState()))

    if(self:GetState() == LootState.Available) then
        table.insert(output, "Entity:" .. tostring(self:GetEntityId()))
    elseif(self:GetState() == LootState.Looted) then
        table.insert(output, "LootedBy:" .. tostring(self.lootedBy))
        table.insert(output, "LootedTo:" .. tostring(self.lootedTo))
    end


    return table.concat(output, " | ")
end



function Loot:GetItemLevel()
    return self.itemInfo.item_level or 1
end

function Loot:GetRequiredLevel()
    return self.itemInfo.required_level or 0
end

function Loot:GetRarity()
    return self.itemInfo.rarity or -1
end

function Loot:GetRarityValue()
    return LIB_ITEMS.GetRarityValue(self:GetRarity()) or 0
end



function Loot:GetAsLink()
    return ChatLib.EncodeItemLink(self:GetTypeId()) or self:GetName()
end

function Loot.GetDisplayNameOfRarity(rarity)
    return ucfirst(rarity) or "ukwn"
end



function Loot:GetCoordLink()
    return ChatLib.EncodeCoordLink(self:GetPos()) or tostring(self:GetPos())
end








function Loot:GetAsText()
    --Debug.Log("Loot:GetAsText not yet implemented")
    -- Todo: Fixme: Remove?
    return self:GetName()
end


function Loot.GetRarityIndex(rarity) -- Deprecated
    return LIB_ITEMS.GetRarityValue(rarity) or 0
end


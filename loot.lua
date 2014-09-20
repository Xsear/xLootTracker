--[[
    Loot class
    An attempt to gather all the loot info in one object so that it can be retrieved identically and safely.
    In the event of changes to targetInfo/itemInfo, I hope this class will prove it's worth.
    I still let it give out the full targetInfo and itemInfo tables though, as that can be useful when using libraries and stuff.
--]]

Loot = {}
Loot.__index = Loot -- When calling functions on the instance tables, fallback to the one Loot table.

setmetatable(Loot, {
             -- Makes it possible to create instances like this: 'local loot = Loot(args)'
             __call = function(class, ...)
                        return class.Create(...)
                      end,
             })


local Private = {
    idCounter = 0,
}


--[[
***************************
    Static Functions
***************************
--]]



--[[
    Loot.Create(entityId, targetInfo, itemInfo)
    Constructor of Loot.
--]]
function Loot.Create(entityId, targetInfo, itemInfo)
    if Options['Debug']['LogLootCreateData'] then
        Debug.Log('Loot.Create on ' .. tostring(targetInfo.name))
        Debug.Log('entityId ' .. tostring(entityId))
        Debug.Table('targetInfo', targetInfo)
        Debug.Table('itemInfo', itemInfo)
    end

    -- Create instance
    local self = setmetatable({}, Loot)

    self.id              = Private.GenerateId()
    self.createdAt       = System.GetClientTime()

    self.entityId        = entityId
    self.targetInfo      = targetInfo
    self.itemInfo        = itemInfo

    self.category        = Loot.DetermineCategory(targetInfo, itemInfo)
    
    self.state           = Private.DetermineState(self)

    return self
end

--[[
    Loot.DetermineCategory(targetInfo, itemInfo)
    Determines the LootCategory from target and itemInfo (mostly itemInfo)
--]]
function Loot.DetermineCategory(targetInfo, itemInfo)
    local category = LootCategory.Unknown

    if IsEquipment(itemInfo) then
        category = LootCategory.Equipment

    elseif IsModule(itemInfo) then 
        category = LootCategory.Modules

    elseif IsSalvage(itemInfo) then
        category = LootCategory.Salvage

    elseif IsConsumable(itemInfo) then
        category = LootCategory.Consumable

    elseif IsMetal(itemInfo) then
        category = LootCategory.Metals

    elseif IsComponent(itemInfo) then
        category = LootCategory.Components

    elseif IsCurrency(itemInfo) then
        category = LootCategory.Currency

    end

    if category == LootCategory.Unknown then
        --Debug.Warn('Private.Identify LootCategory.Unknown', targetInfo, itemInfo)
        -- Well this is basically the 'shit we dont care about category' now ;o
    end

    if Options['Debug']['LogLootDetermineCategory'] then
        Debug.Log(tostring(targetInfo.name) .. ' identified as ' .. tostring(category))
    end

    return category
end

--[[
    Loot.GetDisplayNameOfRarity(rarity)
    Some shit right here...
--]]
function Loot.GetDisplayNameOfRarity(rarity)
    return ucfirst(rarity) or 'ukwn'
end

--[[
    DEPRECATED
    Loot.GetRarityIndex(rarity)
    Returns the rarity as a number in a series representative of the rarity
    I originally wrote and started using this function before I discovered that it had already been implemented in LIB_ITEMS.
--]]
function Loot.GetRarityIndex(rarity)
    return LIB_ITEMS.GetRarityValue(rarity) or 0
end


--[[
***************************
    Instance Functions
***************************
--]]

function Loot:Update()
    self.state = Private.DetermineState(self)
end

function Loot:Destroy()
    --Debug.Log('Loot:Destroy for ' ..self.id.. ' '..self:GetName())
        
    self = nil
end


-- Below follows a slew of Getters and Setters.

function Loot:GetId()
    return self.id
end

function Loot:GetEntityId()
    return self.entityId
end

function Loot:GetTypeId()
    return self.targetInfo.itemTypeId
end

function Loot:GetName()
    return self.targetInfo.name
end

function Loot:GetCategory()
    return self.category
end

function Loot:GetState()
    return self.state
end

function Loot:SetState(newState)
    self.state = newState
end

function Loot:GetPos()
    return self.targetInfo.lootPos or {x=0, y=0, z=0}
end

function Loot:GetItemLevel()
    return self.itemInfo.item_level or 1
end

function Loot:GetRequiredLevel()
    return self.itemInfo.required_level or 0
end

function Loot:GetRarity()
    return self.itemInfo.rarity or tostring(-1)
end

function Loot:GetRarityValue()
    return LIB_ITEMS.GetRarityValue(self:GetRarity()) or 0
end

function Loot:GetQuantity()
    return self.targetInfo.quantity or 1
end

function Loot:GetColor()
    return LIB_ITEMS.GetItemColor(self.itemInfo)
end

function Loot:GetWebIcon()
    return self.itemInfo.web_icon
end

function Loot:GetMultiArt(PARENT, forceWebIcon)
    -- Handle optional args
    forceWebIcon = forceWebIcon or false

    -- Create multiart
    local ICON = MultiArt.Create(PARENT)

    -- If ability, use ability icon
    if not forceWebIcon and self.itemInfo.type == 'ability_module' and self.itemInfo.abilityId then
        local abilityinfo = Player.GetAbilityInfo(tonumber(self.itemInfo.abilityId))
        if abilityinfo and abilityinfo.iconId then
            ICON:SetIcon(abilityinfo.iconId)
            return ICON
        end
    end

    -- Otherwise, use web icon
    ICON:SetUrl(self:GetWebIcon())
    return ICON
end

function Loot:GetLootedBy()
    return self.lootedBy or false
end

function Loot:SetLootedBy(input)
    self.lootedBy = input
end

function Loot:GetLootedTo()
    return self.lootedTo or false
end

function Loot:SetLootedTo(input)
    self.lootedTo = input
end

function Loot:GetAsText()
    --Debug.Log('Loot:GetAsText not yet implemented')
    -- Todo: Fixme: Remove?
    return self:GetName()
end

function Loot:GetAsLink()
    return ChatLib.EncodeItemLink(self:GetTypeId(), self.itemInfo.hidden_modules, self.itemInfo.slotted_modules) or self:GetName()
end

function Loot:GetCoordLink()
    -- In order to work around a problem caused by ChatLib.EncodeCoordLink erroring when there were issues with the Chat server, this function had to be extended a bit.
    -- In the event that a proper link cannot be created, this function returns normal text.

    local zone = State.zoneId
    local instance = Chat.WriteInstanceKey()
    local player = Player.GetCharacterId()
    if zone and instance and player then
        return ChatLib.EncodeCoordLink(self:GetPos(), zone, instance, player)       
    end

    return tostring(self:GetPos())
end

function Loot:ToString()

    local output = {}
    table.insert(output, 'Loot')
    table.insert(output, tostring(self:GetName()))
    table.insert(output, 'Category:' .. tostring(self:GetCategory()))
    table.insert(output, 'Id:' .. tostring(self:GetId()))
    table.insert(output, 'TypeId:' .. tostring(self:GetTypeId()))
    table.insert(output, 'State:' .. tostring(self:GetState()))

    if(self:GetState() == LootState.Available) then
        table.insert(output, 'Entity:' .. tostring(self:GetEntityId()))
    elseif(self:GetState() == LootState.Looted) then
        table.insert(output, 'LootedBy:' .. tostring(self.lootedBy))
        table.insert(output, 'LootedTo:' .. tostring(self.lootedTo))
    end


    return table.concat(output, ' | ')
end


function Loot:AppendToChat()
    Debug.Log('LootAppendToChat')
    ChatLib.AddItemLinkToChatInput(self:GetTypeId(), self.itemInfo.hidden_modules, self.itemInfo.slotted_modules)
end


--[[
***************************
    Private Functions
***************************
--]]

function Private.GenerateId()

    -- local player = tostring(Player.GetInfo()) -- Fixme: Get rid of army tag

    local time = tostring(System.GetLocalUnixTime())

    Private.idCounter = Private.idCounter + 1
    local occurance = tostring(Private.idCounter)

    -- Put it all together
    local id = time..occurance -- player..

    return id
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

    if not state then Debug.Warn('dafaq, determine state returning nil, why?') Debug.Table('determinestate loot', loot) end

    return state
end

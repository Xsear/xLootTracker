require "lib/lib_Tabs"
require "./lib/lib_SimpleDialog";

Filtering = {}

-- Previously LootFiltering()
function Filtering.Filter(loot, moduleOptions)
    -- Vars
    local categoryKey = nil
    local rarityKey = nil
    moduleOptions = moduleOptions['Filtering'] -- Note: this is gonna bite me in the ass someday
    
    -- Determine keys
    categoryKey, rarityKey = Filtering.GetFilteringOptionsKeys(loot, moduleOptions)

    -- Verify that type passes filter
    if moduleOptions[categoryKey]['Enabled'] then
        
        -- Verify that rarity passes filter
        -- Simple Mode: Rarity of Loot must be at or above Rarity Threshold
        if (rarityKey == 'Simple' and Loot.GetRarityIndex(loot:GetRarity()) >= Loot.GetRarityIndex(moduleOptions[categoryKey][rarityKey]['RarityThreshold']))
        -- Advanced Mode: The specific Rarity of the Loot must be Enabled
        or (rarityKey ~= 'Simple' and moduleOptions[categoryKey][rarityKey]['Enabled']) then

            -- Determine ItemLevel Threshold
            local itemLevelThreshold = tonumber(moduleOptions[categoryKey][rarityKey]['ItemLevelThreshold'])

            -- Determine RequiredLevel Threshold
            local requiredLevelThreshold = tonumber(moduleOptions[categoryKey][rarityKey]['RequiredLevelThreshold'])

            -- Verify that loot passes level thresholds
            if loot:GetItemLevel() >= itemLevelThreshold and loot:GetRequiredLevel() >= requiredLevelThreshold then
                -- Passed all filters
                return true
            end
        end

    elseif not moduleOptions[categoryKey] then
        Debug.Table('LootFiltering for ' .. loot:ToString() .. ' ran aground because there weren\'t any options for its categoryKey ' .. tostring(categoryKey) .. ' in the module options that were provided (no name to log here, so dumping table.): ', moduleOptions)
    end
    return false
end


-- Previously Filtering.GetFilteringOptionsKeys()
function Filtering.GetFilteringOptionsKeys(loot, moduleOptions) 
    -- Vars
    local categoryKey = nil
    local rarityKey = nil

    -- Determine typeKey
    categoryKey = loot:GetCategory()

    -- Determine rarityKey
    if moduleOptions[categoryKey]['Mode'] == TriggerModeOptions.Simple then
        rarityKey = 'Simple'
    else -- TriggerModeOptions.Advanced
        rarityKey = loot:GetRarity()
    end
    
    -- Return
    return categoryKey, rarityKey
end




NewFilteringCategory = {
    Armor = SubTypeIds.BattleframeCores, -- Is parent category for the new 4 slots
    Weapons = 58, -- NOT VERIFIED
    Abilities = 61, -- NOT VERIFIED
    Equipment = SubTypeIds.Equipment,
    Modules = SubTypeIds.Modules, -- Needs to be verified to be the actual modules and not some other kinda generic category
    Currency = SubTypeIds.Currency,
}

--[[
SubTypeIds = {
    PrimaryWeapon       = 59,
    SecondaryWeapon     = 60,
    Abilities           = 61,
    BattleframeCores    = 3623,
    Modules             = 3625,
    Consumable          = 82,
    Resource            = 15,
    Salvage             = 3617,
    Unlocks             = 3667,
    Thumping            = 80,
    Vehicles            = 83,
    Deployables         = 81,
    Pets                = 89,
    Currency            = 207,
    Equipment           = 3,
    AccountItems        = 3708,
    WeaponComponent     = 3724,
    AbilityComponent    = 3723,
    TinkerTools         = 3732,
    AuxiliaryWeapons    = 3736,
    MedicalSystem       = 3744,
    Fragments           = 3746,
    Gliders             = 3709,
}
--]]



Filtering.FilterParam = {
    Type = "type",
    Mode = "mode",
    Value = "value",
}

Filtering.FilterType = {
    Category = "CATEGORY",
    ItemLevel = "ITEM_LEVEL",
    Rarity = "RARITY",
    ItemRequiredLevel = "ITEM_REQUIRED_LEVEL",
}

Filtering.FilterMode = {
    LargerOrEqual = "LARGER_OR_EQUAL",
    LessOrEqual = "LESS_OR_EQUAL",
    Larger = "LARGER",
    Less = "LESS",
    Equal = "EQUAL",
}

Filtering.Comparators = {
    [Filtering.FilterMode.LargerOrEqual] = function(a, b) return a >= b end,
    [Filtering.FilterMode.LessOrEqual] = function(a, b) return a <= b end,
    [Filtering.FilterMode.Larger] = function(a, b) return a > b end,
    [Filtering.FilterMode.Less] = function(a, b) return a < b end,
    [Filtering.FilterMode.Equal] = function(a, b) return a == b end,
}

Filtering.UIRule = {}
Filtering.UIRule.FilterTypeAllowsMode = { -- Can you select a Mode for this filter Type selection? 
    [Filtering.FilterType.Category] = false, -- We cant have "larger than" "Abilities", so this must be false
    [Filtering.FilterType.ItemLevel] = true, -- Everything else has numerical values and should be fine
    [Filtering.FilterType.Rarity] = true, -- This should be numeric too but depending on values gotta be careful
    [Filtering.FilterType.ItemRequiredLevel] = true,
}

Filtering.UIRule.FilterTypeFixedValues = { -- For this filter Type, are the possible Values predefined?
    [Filtering.FilterType.Category] = true, -- "Armor", "Abilities", etc.
    [Filtering.FilterType.ItemLevel] = false, -- "43"
    [Filtering.FilterType.Rarity] = true, -- "Green", "Blue"
    [Filtering.FilterType.ItemRequiredLevel] = false, -- "40",
}









Filtering.HUDFilters = {}
Filtering.HUDFilters[1] = {
    enabled = true,
    name = "Green lvl 30 Armor",
    parameters = {
        {
            [Filtering.FilterParam.Type] = Filtering.FilterType.Category,
            [Filtering.FilterParam.Mode] = Filtering.FilterMode.Equal, -- not used
            [Filtering.FilterParam.Value] = NewFilteringCategory.Armor, -- Modules? Gear?
        },
        {
            [Filtering.FilterParam.Type] = Filtering.FilterType.ItemLevel,
            [Filtering.FilterParam.Mode] = Filtering.FilterMode.LargerOrEqual,
            [Filtering.FilterParam.Value] = 30,
        },
        {
            [Filtering.FilterParam.Type] = Filtering.FilterType.Rarity,
            [Filtering.FilterParam.Mode] = Filtering.FilterMode.LargerOrEqual,
            [Filtering.FilterParam.Value] = Loot.GetRarityIndex(LootRarity.Uncommon),
        },
    }
}

Filtering.HUDFilters[2] = {
    enabled = true,
    name = "Green lvl 40 Weapons",
    parameters = {
        {
            [Filtering.FilterParam.Type] = Filtering.FilterType.Category,
            [Filtering.FilterParam.Mode] = Filtering.FilterMode.Equal, -- not used
            [Filtering.FilterParam.Value] = NewFilteringCategory.Weapons, -- Modules? Gear?
        },
        {
            [Filtering.FilterParam.Type] = Filtering.FilterType.ItemLevel,
            [Filtering.FilterParam.Mode] = Filtering.FilterMode.LargerOrEqual,
            [Filtering.FilterParam.Value] = 40,
        },
        {
            [Filtering.FilterParam.Type] = Filtering.FilterType.Rarity,
            [Filtering.FilterParam.Mode] = Filtering.FilterMode.LargerOrEqual,
            [Filtering.FilterParam.Value] = Loot.GetRarityIndex(LootRarity.Uncommon),
        },
    }
}





function NewDetermineCategory(loot)
    local itemTypeId = loot:GetTypeId()
    local mostSpecificCategory = -1
    local mostSpecificCategoryKey = nil
    for category, subTypeId in pairs(NewFilteringCategory) do
        if Game.IsItemOfType(itemTypeId, subTypeId) then 
            if subTypeId > mostSpecificCategory then -- Good thing I wrote a comment about what the fuck I'm doing here, thanks
                mostSpecificCategory = subTypeId
                mostSpecificCategoryKey = category
            end
        end
    end

    if mostSpecificCategory == -1 then
        Debug.Error("No Loot Category for ", loot:ToString())
        return -1
    else
        return mostSpecificCategoryKey
    end
end

-- indev function name
function Filtering.Filt2(loot)

    Debug.Log("Filtering.Filt2 : ", loot:ToString())

    Debug.Log("Begin filtering loop")
    for i, filter in ipairs(Filtering.HUDFilters) do

        if filter.enabled then

            Debug.Log("Now checking Filter with name ", filter.name)

            local passesFilterParameters = true

            for j, parameter in ipairs(filter.parameters) do
                Debug.Divider()
                Debug.Table("Parameter " .. tostring(j), parameter)

                if parameter.type == Filtering.FilterType.Category then

                    local lootCategory = NewFilteringCategory[NewDetermineCategory(loot)]
                    local comparator = Filtering.Comparators.EQUALS
                    if not comparator(lootCategory, parameter.value) then
                        Debug.Log("lootValue ", lootCategory, " " .. parameter.mode .. " paramValue ", parameter.value, " : FALSE")
                        passesFilterParameters = false
                    end

                elseif parameter.type == Filtering.FilterType.Rarity then

                    local rarity = loot:GetRarityValue()
                    local comparator = Filtering.Comparators[parameter.mode]
                    if not comparator(rarity, parameter.value) then
                        Debug.Log("lootValue ", rarity, " " .. parameter.mode .. " paramValue ", parameter.value, " : FALSE")
                        passesFilterParameters = false
                    end

                elseif parameter.type == Filtering.FilterType.ItemLevel then

                    local ilvl = loot:GetItemLevel()
                    local comparator = Filtering.Comparators[parameter.mode]
                    if not comparator(ilvl, parameter.value) then
                        Debug.Log("lootValue ", ilvl, " " .. parameter.mode .. " paramValue ", parameter.value, " : FALSE")
                        passesFilterParameters = false
                    end

                elseif parameter.type == Filtering.FilterType.ItemRequiredLevel then

                    local reqlvl = loot:GetRequiredLevel()
                    local comparator = Filtering.Comparators[parameter.mode]
                    if not comparator(reqlvl, parameter.value) then
                        Debug.Log("lootValue ", reqlvl, " " .. parameter.mode .. " paramValue ", parameter.value, " : FALSE")
                        passesFilterParameters = false
                    end

                end

                if not passesFilterParameters then
                    Debug.Log("Failed Parameter " .. tostring(j))
                    Debug.Divider()
                    break
                end

                Debug.Log("Passed Parameter " .. tostring(j))
                Debug.Divider()
            end

            if passesFilterParameters then
                Debug.Log("Passed Filter with name " .. filter.name)
                Debug.Divider()
                return true
            end

            Debug.Log("Failed Filter with name " .. filter.name)
            Debug.Divider()
        end
    end
    Debug.Log("End filtering loop")

    Debug.Log("Must not have passed any filter :(")
    return false              

end




function RunFilteringTest()

    Debug.Log("RunFilteringTest")

    local testItems = {
        98002, -- lvl 29 epic bio needler
        98743, -- lvl 30 epic bio crossbow
        98725, -- lvl 30 rare bio crossbow
        98965, -- lvl 30 epic shotgun
        130178, -- lvl 30 rare chemical grenade
        102927, -- lvl 30 epic creeping death
        129010, -- lvl 30 rare medical system
        128440, -- lvl 30 epic reactor
        128678, -- lvl 30 rare legs
        136858, -- lvl 30 rare operating system
        123369, -- capacity booster mk 2
    }

    Debug.Log("Building lootTable")
    local lootTable = {}
    for i, itemTypeId in ipairs(testItems) do

        lootTable[#lootTable +1] = Loot.Create(i, {itemTypeId=itemTypeId}, Game.GetItemInfoByType(itemTypeId))

    end

    Debug.Log("Beginning test!")
    for i, loot in ipairs(lootTable) do
        Debug.Log("Filtering.Filt2 for ", loot:ToString(), " result = ", Filtering.Filt2(loot))
    end


    Debug.Log("Test over")

end








FiltUI = {}
FiltUI.firstOpen = true
FiltUI.State = {
    pane = "Blacklist",
    scope = "Tracker",
    subpane = nil,
}


FiltUI.FilteringState = {
    dialogOpen = false,

}



local ref = {
    MAIN = Component.GetFrame("Options"),
    WINDOW = Component.GetWidget("Window"),
    MOVABLE_PARENT = Component.GetWidget("MovableParent"),
    CLOSE_BUTTON = Component.GetWidget("close"),
    TITLE_TEXT = Component.GetWidget("title"),

    --LEFT_COLUMN = Component.GetWidget("LeftColumn"),
    --MAIN_AREA = Component.GetWidget("MainArea"),
    --FILTER_LIST = Component.GetWidget("FilterList"),

    --BUTTON_ADD = Component.GetWidget("ButtonAdd"),
    --BUTTON_DEL = Component.GetWidget("ButtonDel"),



    PANES = Component.GetWidget("Panes"),
    
    --BODY = Component.GetWidget("Body"),


    PANE_BLACKLIST,
    PANE_FILTERING,
    PANE_KEYBINDS,

}

local blacklist_ref = {
    filterList,
    filterActionBar,
    scopeList,
    TEST,
}

local filtering_ref = {
    filterList,
    filterActionBar,
    scopeList,
}



function FiltUI.ToggleWindow(show)
    if FiltUI.firstOpen then
        FiltUI.ChangeView("Filtering", "Tracker")
        FiltUI.firstOpen = false
    end
    FiltUI.Show(show);
end

function FiltUI.Setup(args)
    
    -- Register with PanelManager
    PanelManager.RegisterFrame(ref.MAIN, ToggleWindow, {show=false})
    
    -- Setup with MovablePanel
    MovablePanel.ConfigFrame({
        frame = ref.MAIN,
        MOVABLE_PARENT = ref.MOVABLE_PARENT
    })

    -- Setup close button
    local X = ref.CLOSE_BUTTON:GetChild("X");
    ref.CLOSE_BUTTON:BindEvent("OnMouseDown", function() FiltUI.Show(false) end)
    ref.CLOSE_BUTTON:BindEvent("OnMouseEnter", function()
        X:ParamTo("tint", Component.LookupColor("red"), 0.15);
        X:ParamTo("glow", "#30991111", 0.15);
    end)
    ref.CLOSE_BUTTON:BindEvent("OnMouseLeave", function()
        X:ParamTo("tint", Component.LookupColor("white"), 0.15);
        X:ParamTo("glow", "#00000000", 0.15);
    end)

    -- Set the title
    ref.TITLE_TEXT:SetText("Loot Tracker") -- FIXME: Localize

    -- Setup Tabs
    ref.TABS = Tabs.Create(2, ref.PANES)
    ref.TABS:SetTab(1, {label="Blacklist"}) -- FIXME: Localize
    ref.TABS:SetTab(2, {label="Filtering"}) -- FIXME: Localize
    --ref.TABS:SetTab(3, {label="Keybinds"}) -- FIXME: Localize


    ref.PANE_BLACKLIST = ref.TABS:GetBody(1)
    ref.PANE_FILTERING = ref.TABS:GetBody(2)
    --ref.PANE_KEYBINDS = ref.TABS:GetBody(3)

    -- Default to first tab
    ref.TABS:Select(2)


    -- Create Views

    -- BLACKLIST
    blacklist_ref.PANE = ref.PANE_BLACKLIST
    blacklist_ref.LAYOUT = Component.CreateWidget("TabPanelLayout_Main", blacklist_ref.PANE)
    blacklist_ref.LEFT_COLUMN = blacklist_ref.LAYOUT:GetChild("LeftColumn")
    blacklist_ref.MAIN_AREA = blacklist_ref.LAYOUT:GetChild("MainArea")
    blacklist_ref.FILTER_LIST = blacklist_ref.MAIN_AREA:GetChild("FilterList")

        -- Create filterlist header
        local header = Component.CreateWidget("BlacklistRow", blacklist_ref.MAIN_AREA)
        header:SetDims("width:100%; height:64;top:0;")
        local content = header:GetChild("content");
        Component.CreateWidget("RowField", content:GetChild("icon")):GetChild("text"):SetText("  Icon");
        Component.CreateWidget("RowField", content:GetChild("name")):GetChild("text"):SetText("Name");
        Component.CreateWidget("RowField", content:GetChild("typeid")):GetChild("text"):SetText("Type Id");
        Component.CreateWidget("RowField", content:GetChild("actions")):GetChild("text"):SetText("Actions");

        -- Create filterlist
        blacklist_ref.filterList = RowScroller.Create(blacklist_ref.FILTER_LIST);
        blacklist_ref.filterList:SetSpacing(2);
        blacklist_ref.filterList:ShowSlider(true);

        -- Filtering Action Bar :D
        blacklist_ref.filterActionBar = blacklist_ref.MAIN_AREA:GetChild("FilterActionBar")
        CreateLabelButton("width:23; height:16", "FilledButtonPrint", Component.CreateWidget('<Group dimensions="left:10%; width:20%; top:10%; height:80%"/>', blacklist_ref.filterActionBar), BlacklistAddButtonOnClick, "DialogWidgets", "accept")
        CreateLabelButton("width:23; height:16", "FilledButtonPrint", Component.CreateWidget('<Group dimensions="left:60%; width:20%; top:10%; height:80%"/>', blacklist_ref.filterActionBar), BlacklistClearButtonOnClick, "DialogWidgets", "cancel")

        -- Scope Selection
        blacklist_ref.scopeList = {}
        local margin = 70;
        local itMargin = 0;
        for key, value in pairs(Options['Blacklist']) do

            local widget = Component.CreateWidget("BlacklistScopeButton", blacklist_ref.LEFT_COLUMN)
            widget:SetTag("")
            widget:SetDims("width:98%; height:64; top:"..tostring(itMargin)..";")

            local text = widget:GetChild("text");
            local focus = widget:GetChild("focusBox");
            local bg = widget:GetChild("bg");
            local defaultBgAlpha = 0.4;
            -- Note: These buttons are updated in ChangeView as well, so note that when doing stuff in these events
            focus:BindEvent("OnMouseEnter", function()
                bg:ParamTo("tint", Component.LookupColor("RowHover"), 0.15);
                text:SetTextColor(Component.LookupColor("ScopeRowHoverText"));
                bg:ParamTo("alpha", 0.3, 0.15);
            end);
            focus:BindEvent("OnMouseLeave", function()
                bg:ParamTo("tint", Component.LookupColor("RowDefault"), 0.15);
                if widget:GetTag() == "selected" then
                    text:SetTextColor(Component.LookupColor("ScopeRowSelectedText"));
                else
                    text:SetTextColor(Component.LookupColor("ScopeRowDefaultText"));
                end
                bg:ParamTo("alpha", defaultBgAlpha, 0.15);
            end);
            focus:BindEvent("OnMouseDown", function() 
                FiltUI.ChangeView("Blacklist", key)
            end)
            text:SetText(key);

            blacklist_ref.scopeList[key] = widget;

            itMargin = itMargin + margin;
        end








    -- FILTERING
    filtering_ref.PANE = ref.PANE_FILTERING
    filtering_ref.LAYOUT = Component.CreateWidget("TabPanelLayout_Main", filtering_ref.PANE)
    filtering_ref.LEFT_COLUMN = filtering_ref.LAYOUT:GetChild("LeftColumn")
    filtering_ref.MAIN_AREA = filtering_ref.LAYOUT:GetChild("MainArea")
    filtering_ref.FILTER_LIST = filtering_ref.MAIN_AREA:GetChild("FilterList")


        -- Create filterlist
        filtering_ref.filterList = RowScroller.Create(filtering_ref.FILTER_LIST);
        filtering_ref.filterList:SetSpacing(2);
        filtering_ref.filterList:ShowSlider(true);

        -- Filtering Action Bar :D
        filtering_ref.filterActionBar = filtering_ref.MAIN_AREA:GetChild("FilterActionBar")
        CreateLabelButton("width:23; height:16", "FilledButtonPrint", Component.CreateWidget('<Group dimensions="left:10%; width:20%; top:10%; height:80%"/>', filtering_ref.filterActionBar), FilteringAddButtonOnClick, "DialogWidgets", "accept")


        --CreateSimpleButton("width:23; height:12", Component.CreateWidget('<Group dimensions="left:10%; width:20%; top:10%; height:80%"/>', filtering_ref.filterActionBar), "Add Filter", FilteringAddButtonOnClick)


        --CreateLabelButton("width:23; height:16", "FilledButtonPrint", Component.CreateWidget('<Group dimensions="left:60%; width:20%; top:10%; height:80%"/>', filtering_ref.filterActionBar), FilteringClearButtonOnClick, "DialogWidgets", "cancel")



        -- Scope Selection
        filtering_ref.scopeList = {}
        local margin = 70;
        local itMargin = 0;
        for key, value in pairs(Options['Blacklist']) do

            local widget = Component.CreateWidget("BlacklistScopeButton", filtering_ref.LEFT_COLUMN)
            widget:SetTag("")
            widget:SetDims("width:98%; height:64; top:"..tostring(itMargin)..";")

            local text = widget:GetChild("text");
            local focus = widget:GetChild("focusBox");
            local bg = widget:GetChild("bg");
            local defaultBgAlpha = 0.4;
            -- Note: These buttons are updated in ChangeView as well, so note that when doping stuff in these events
            focus:BindEvent("OnMouseEnter", function()
                bg:ParamTo("tint", Component.LookupColor("RowHover"), 0.15);
                text:SetTextColor(Component.LookupColor("ScopeRowHoverText"));
                bg:ParamTo("alpha", 0.3, 0.15);
            end);
            focus:BindEvent("OnMouseLeave", function()
                bg:ParamTo("tint", Component.LookupColor("RowDefault"), 0.15);
                if widget:GetTag() == "selected" then
                    text:SetTextColor(Component.LookupColor("ScopeRowSelectedText"));
                else
                    text:SetTextColor(Component.LookupColor("ScopeRowDefaultText"));
                end
                bg:ParamTo("alpha", defaultBgAlpha, 0.15);
            end);
            focus:BindEvent("OnMouseDown", function() 
                FiltUI.ChangeView("Filtering", key)
            end)
            text:SetText(key);

            filtering_ref.scopeList[key] = widget;

            itMargin = itMargin + margin;
        end




        local filteringTestButton = Component.CreateWidget('<Button dimensions="width:98%; height:64; top:'..tostring(itMargin)..';" />', filtering_ref.LEFT_COLUMN)
        filteringTestButton:SetText("Filtering Test")
        filteringTestButton:BindEvent("OnMouseDown", RunFilteringTest)

    --
    Debug.Log('FiltUI.Setup() complete')
end


function CreateSimpleButton(dims, parent, text, clickEvent)
    local button = Component.CreateWidget('<Button dimensions="'..dims..'" />', parent)
    button:SetText(text)
    button:BindEvent("OnMouseDown", clickEvent)
end


-- gently pilfered from inventory ;D
function CreateLabelButton(dims, blueprint, parent, action, texture, region)
    local LABEL = {GROUP=Component.CreateWidget(blueprint, parent)}
    LABEL.FOCUS = LABEL.GROUP:GetChild("focus")
    LABEL.ICON  = MultiArt.Create(LABEL.GROUP:GetChild("icon"))
    LABEL.BORDER = LABEL.GROUP:GetChild("outer")

    LABEL.ICON:EatMice(false)
    LABEL.ICON:SetTexture(texture, region)
    LABEL.ICON:SetDims(dims)

    LABEL.FOCUS:BindEvent("OnMouseEnter", function() LABEL.BORDER:ParamTo("exposure", .5, .15, "smooth") end)
    LABEL.FOCUS:BindEvent("OnMouseLeave", function() LABEL.BORDER:ParamTo("exposure", .25, .15, "smooth") end)
    LABEL.FOCUS:BindEvent("OnMouseDown", function() LABEL.BORDER:ParamTo("exposure", 1, .15, "smooth") end)
    LABEL.FOCUS:BindEvent("OnMouseUp", function(args) 
        LABEL.BORDER:ParamTo("exposure", .5, .25, "smooth") 
        args.parentWidget = parent
        action(args) 
    end)

    return LABEL
end


-- lel onclick func
function BlacklistRemoveButtonOnClick(args)
    Debug.Table("BlacklistRemoveButtonOnClick", args)

    local itemTypeId = args.parentWidget:GetTag()

    if Blacklist.Remove({scopeKey=FiltUI.State.section, itemTypeId=itemTypeId}) then
        -- Trigger UI update
        FiltUI.UpdateView()
    else
        Debug.Error("Failed to remove from blacklist on click :(")
    end

end

function BlacklistAddButtonOnClick(args)
    Debug.Table("BlacklistAddButtonOnClick", args)




    local theBody = Component.CreateWidget([[
                            <Group dimensions="top:26; width:269; center-x:50%; height:26;">
                                <StillArt dimensions="dock:fill" style="texture:colors; region:white; tint:#111111; eatsmice:false"/>
                                <Border dimensions="dock:fill" class="ButtonBorder" style="tint:InputBorder; alpha:.25 eatsmice:false"/>
                                <StillArt dimensions="left:8; center-y:50%; width:15; height:15;" style="texture:search_icon"/>
                                <TextInput name="SearchInput" dimensions="left:23; top:0; width:100%-23; height:100%" class="SearchInput" style="valign:center; maxlen:254; clip:true;">
                                    <Events>
                                        <OnGotFocus bind="SearchGotFocus"/>
                                        <OnLostFocus bind="SearchLostFocus"/>
                                        <OnTextChange bind="SearchTextChanged"/>
                                    </Events>
                                </TextInput>
                                <Text name="SearchLabel" dimensions="left:20; top:0; right:100%; height:100%;" key="SB_SEARCH" class="InputLabel"/>
                            </Group>]]
                                           , args.parentWidget)
    
    VALUE_INPUT_LABEL = theBody:GetChild("SearchLabel")
    VALUE_INPUT = theBody:GetChild("SearchInput")

    local c_SearchDelay = 1

    function SearchGotFocus(args)
        Debug.Event(args)
        VALUE_INPUT_LABEL:Show(false)
    end

    function SearchLostFocus(args)
        Debug.Event(args)
        if unicode.len(args.widget:GetText()) == 0 then
            VALUE_INPUT_LABEL:Show(true)
        end
    end

    function SearchTextChanged(args)
        Debug.Event(args)
        if args.user then
            UpdateSearchString(args.widget:GetText())
        end
    end

    function UpdateSearchString(text)
        g_SearchString = text
        if g_SearchCallback then
            cancel_callback(g_SearchCallback)
        end

        g_SearchCallback = callback(DoSearch, nil, c_SearchDelay)
    end

    function DoSearch()
        g_SearchCallback = nil
        


    end



    ShowDialog(
    {

        body = theBody,
        onYes = function()
            Debug.Log("BlacklistAddButtonDialog Yes!")
        end,
        onNo = function()
            Debug.Log("BlacklistAddButtonDialog No :(")
            Component.SetTextInput(nil)
            Component.RemoveWidget(VALUE_INPUT_LABEL)
            Component.RemoveWidget(VALUE_INPUT)
        end,

    })

end

function BlacklistClearButtonOnClick(args)
    Debug.Table("BlacklistClearButtonOnClick", args)

    ShowDialog(
    {
        body = "Do you want to clear this section?",
        onYes = function()
            Blacklist.Clear({scopeKey=FiltUI.State.section})
            FiltUI.UpdateView()
        end,
        onNo = function()

        end
    });

end



function FilteringAddButtonOnClick(args)
    Debug.Table("FilteringAddButtonOnClick", args)

    if FiltUI.FilteringState.dialogOpen then
        Debug.Warn("Dialog already open")
        return
    end


    local theBody = Component.CreateWidget([[
                        <!-- Container -->
                        <Group dimensions="top:0; width:300; height:150;">
                            
                            <!-- Param Type -->
                            <Group dimensions="top:20; width:269; center-x:50%; height:26;">
                                <DropDown name="DropDownType" dimensions="left:0; top:0; right:100%; height:100%;"/>
                            </Group>

                            <!-- Param Mode -->
                            <Group dimensions="top:60; width:269; center-x:50%; height:26;">
                                <DropDown name="DropDownMode" dimensions="left:0; top:0; right:100%; height:100%;"/>
                            </Group>

                            <!-- Param Value (Dropdown) -->
                            <Group dimensions="top:100; width:269; center-x:50%; height:26;">
                                <DropDown name="DropDownValue" dimensions="left:0; top:0; right:100%; height:100%;"/>
                            </Group>

                            <!-- Param Value (TextInput) -->
                            <Group dimensions="top:140; width:269; center-x:50%; height:26;">
                                <StillArt dimensions="dock:fill" style="texture:colors; region:white; tint:#111111; eatsmice:false"/>
                                <Border dimensions="dock:fill" class="ButtonBorder" style="tint:InputBorder; alpha:.25 eatsmice:false"/>
                                <StillArt dimensions="left:8; center-y:50%; width:15; height:15;" style="texture:search_icon"/>
                                <TextInput name="TextInputValue" dimensions="left:23; top:0; width:100%-23; height:100%" class="SearchInput" style="valign:center; maxlen:254; clip:true;">
                                    <Events>
                                        <OnGotFocus bind="SearchGotFocus"/>
                                        <OnLostFocus bind="SearchLostFocus"/>
                                        <OnTextChange bind="SearchTextChanged"/>
                                    </Events>
                                </TextInput>
                                <Text name="TextInputValueLabel" dimensions="left:20; top:0; right:100%; height:100%;" key="SB_SEARCH" class="InputLabel"/>
                            </Group>

                        </Group>]], args.parentWidget)
    


    TYPE_DROPDOWN = theBody:GetChild(1):GetChild("DropDownType")
    for k, v in pairs(Filtering.FilterType) do
        TYPE_DROPDOWN:AddItem(v)
    end
    TYPE_DROPDOWN:BindEvent("OnSelect", function()
            local charName, charIdx = TYPE_DROPDOWN:GetSelected();
            Debug.Table("OnSelect Type", {charName=charName, charIdx=charIdx})
            UpdateAddFilterParamPopup(Filtering.FilterParam.Type, charName)
        end)

    MODE_DROPDOWN = theBody:GetChild(2):GetChild("DropDownMode")
    for k, v in pairs(Filtering.FilterMode) do
        MODE_DROPDOWN:AddItem(v)
    end

    VALUE_DROPDOWN = theBody:GetChild(3):GetChild("DropDownValue")
    for k, v in pairs(NewFilteringCategory) do
        VALUE_DROPDOWN:AddItem(k)
    end

    VALUE_INPUT_LABEL = theBody:GetChild(4):GetChild("TextInputValueLabel")
    VALUE_INPUT_LABEL:SetText("Manual Value");
    VALUE_INPUT = theBody:GetChild(4):GetChild("TextInputValue")
    VALUE_INPUT_GROUP = theBody:GetChild(4)




    function UpdateAddFilterParamPopup(paramChanged, paramNewValue)
        
        -- If user changed type, we will need to change things up a bit
        if paramChanged == Filtering.FilterParam.Type then

            Debug.Log("New type selected")

            -- If the new type does not allow mode, set mode to equals and lock it
            if not Filtering.UIRule.FilterTypeAllowsMode[paramNewValue] then
                Debug.Log("Forcing equals and disabling mode")

                -- Force equals
                --MODE_DROPDOWN:Set(Filtering.FilterMode.Equals) -- Hardcoded reference to Equals 

                -- Hide dropdown
                MODE_DROPDOWN:Disable()
                MODE_DROPDOWN:SetFocusable(false) -- TODO: Doesn't actually lock the drop down :<
                MODE_DROPDOWN:ParamTo("alpha", 0.2, 0.5)

                


            -- Otherwise, ensure its selectable
            else
                Debug.Log("Allowing mode")
                
                

                -- Show dropdown
                MODE_DROPDOWN:Enable()
                MODE_DROPDOWN:SetFocusable(true)
                MODE_DROPDOWN:ParamTo("alpha", 1, 0.5)
            end

            -- If this type only allows fixed values, prepare the value dropdown and hide the text input field
            if Filtering.UIRule.FilterTypeFixedValues[paramNewValue] then

                -- Hide textinput
                --VALUE_INPUT:Enable(false) -- TODO: Figure out what function is used to disable/enable textinput
                VALUE_INPUT_GROUP:Show(false)

                -- Show value dropdown
                VALUE_DROPDOWN:Show(true)
                SetupTheValueDropdownForType(paramNewValue)

            -- Else, show text input field
            else

                -- Hide dropdown
                VALUE_DROPDOWN:Show(false)

                -- Show textinput
                --VALUE_INPUT:Enable(true) -- TODO: Figure out what function is used to disable/enable textinput
                VALUE_INPUT_GROUP:Show(true)

            end



        -- If the user just changed mode or value, we don't need to do anything
        else

        end

    end


    function GetSelectedDropdownValue(DROPDOWN)
        local value, index = DROPDOWN:GetSelected();
        return value
    end

    function GetFilterParamState()
        local state = {
                        [Filtering.FilterParam.Type] = GetSelectedDropdownValue(TYPE_DROPDOWN),
                        [Filtering.FilterParam.Mode] = GetSelectedDropdownValue(MODE_DROPDOWN),
                        }

        if(Filtering.UIRule.FilterTypeFixedValues[state[Filtering.FilterParam.Type]]) then
            state[Filtering.FilterParam.Value] = GetSelectedDropdownValue(VALUE_DROPDOWN)
        else
            state[Filtering.FilterParam.Value] = VALUE_INPUT:GetText()
        end
    end


    function SetupTheValueDropdownForType(paramTypeValue)
        VALUE_DROPDOWN:ClearItems()

        if paramTypeValue == Filtering.FilterType.Category then
   
            for k, v in pairs(NewFilteringCategory) do
                VALUE_DROPDOWN:AddItem(k)
            end

        elseif paramTypeValue == Filtering.FilterType.Rarity then

            for k, v in pairs(LootRarity) do
                VALUE_DROPDOWN:AddItem(k)
            end

        end

    end


    local c_SearchDelay = 1

    function SearchGotFocus(args)
        Debug.Event(args)
        VALUE_INPUT_LABEL:Show(false)
    end

    function SearchLostFocus(args)
        Debug.Event(args)
        if unicode.len(args.widget:GetText()) == 0 then
            VALUE_INPUT_LABEL:Show(true)
        end
    end

    function SearchTextChanged(args)
        Debug.Event(args)
        if args.user then
            UpdateSearchString(args.widget:GetText())
        end
    end

    function UpdateSearchString(text)
        g_SearchString = text
        if g_SearchCallback then
            cancel_callback(g_SearchCallback)
        end

        g_SearchCallback = callback(DoSearch, nil, c_SearchDelay)
    end

    function DoSearch()
        g_SearchCallback = nil
        


    end


    -- init
    UpdateAddFilterParamPopup(Filtering.FilterParam.Type, Filtering.FilterType.LargerOrEqual)


    FiltUI.FilteringState.dialogOpen = true
    ShowDialog(
    {

        body = theBody,
        title = "New Filter Parameter",
        onYes = function()
            Debug.Log("FilteringAddButtonDialog Yes!")
            FiltUI.FilteringState.dialogOpen = false

            Debug.Table("Data: ", {
                        [Filtering.FilterParam.Type] = GetSelectedDropdownValue(TYPE_DROPDOWN),
                        [Filtering.FilterParam.Mode] = GetSelectedDropdownValue(MODE_DROPDOWN),
                        [Filtering.FilterParam.Value] = GetSelectedDropdownValue(VALUE_DROPDOWN),
                        })

        end,
        onNo = function()
            Debug.Log("FilteringAddButtonDialog No :(")
            Component.SetTextInput(nil)
            FiltUI.FilteringState.dialogOpen = false
        end,
        onClose = function() Debug.Log("FilteringAddButtonDialog Close") FiltUI.FilteringState.dialogOpen = false end
    })

end





function ShowDialog(args)
    local closeFunc = function()
        args.onClose()
        SimpleDialog.Hide();
        Component.RemoveWidget(args.body);
    end

    SimpleDialog.Display(args.body, closeFunc);
    SimpleDialog.SetTitle(args.title or "Confirm");

    SimpleDialog.AddOption("CONFIRM", function()
        if args.onYes then args.onYes(); end
        SimpleDialog.Hide();
        Component.RemoveWidget(args.body);
    end, {color = "#00ff00"});

    SimpleDialog.AddOption("ABORT", function()
        if args.onNo then args.onNo(); end
        SimpleDialog.Hide();
        Component.RemoveWidget(args.body);
    end, {color = "#ff3000"});

    

end

function FiltUI.UpdateView()
    Debug.Log("FiltUI.UpdateView")
    FiltUI.ChangeView(FiltUI.State.page, FiltUI.State.section)
end

function FiltUI.ChangeView(page, section)

    Debug.Table({_func="FiltUI.ChangeView", page=page, section=section})

    -- Save previous values for reference
    local oldPage = FiltUI.State.page
    local oldSection = FiltUI.State.section

    -- Update to new values
    FiltUI.State.page = page
    FiltUI.State.section = section

    -- Force reset because that seems like a good idea
    if FiltUI.State.subpane ~= nil and page ~= "Filtering" then FiltUI.State.subpane = nil end

    -- Update path
    --Component.GetWidget("pathText"):SetText("Filtering >> " .. FiltUI.State.page .. " >> " .. FiltUI.State.section)

    -- Do stuffz
    if page == "Blacklist" then

        -- Scope List
        for key, widget in pairs(blacklist_ref.scopeList) do
            widget:SetTag("")
            widget:GetChild("bg"):ParamTo("tint", Component.LookupColor("RowDefault"), 0.15);
            widget:GetChild("text"):SetTextColor(Component.LookupColor("ScopeRowDefaultText"));
        end

        if blacklist_ref.scopeList[section] then
            blacklist_ref.scopeList[section]:SetTag("selected")
            --blacklist_ref.scopeList[section]:GetChild("bg"):ParamTo("tint", Component.LookupColor("RowSelected"), 0.15);
            blacklist_ref.scopeList[section]:GetChild("text"):SetTextColor(Component.LookupColor("ScopeRowSelectedText"))
        end


        -- Lock Filter List while we update
        blacklist_ref.filterList:LockUpdates()

        -- Clear existing list data
        blacklist_ref.filterList:Reset()

        -- Create up-to-date list
        if not _table.empty(Options['Blacklist'][section]) then

            -- Loop through section data
            for itemTypeId, value in pairs(Options['Blacklist'][section]) do

                -- Get info
                local itemInfo = Game.GetItemInfoByType(itemTypeId)
                if not itemInfo then
                    Debug.Warn('Invalid itemTypeId in blacklist: ', itemTypeId) 
                else
                    -- Create row widget
                    local widget = Component.CreateWidget("BlacklistRow", blacklist_ref.FILTER_LIST)
                    widget:SetDims("width:100%; height:64;")
                    local content = widget:GetChild("content");
                    local focus = widget:GetChild("focusBox");
                    local bg = widget:GetChild("bg");
                    local defaultBgAlpha = 0.4;
                    focus:BindEvent("OnMouseEnter", function()
                        bg:ParamTo("tint", Component.LookupColor("RowHover"), 0.15);
                        bg:ParamTo("alpha", 0.3, 0.15);
                    end);
                    focus:BindEvent("OnMouseLeave", function()
                        bg:ParamTo("tint", Component.LookupColor("RowDefault"), 0.15);
                        bg:ParamTo("alpha", defaultBgAlpha, 0.15);
                    end);
                    content:GetChild("icon"):SetIcon(itemInfo.web_icon_id)

                    -- Create row field widgets
                    Component.CreateWidget("RowField", content:GetChild("name")):GetChild("text"):SetText(tostring(itemInfo.name));
                    Component.CreateWidget("RowField", content:GetChild("typeid")):GetChild("text"):SetText(tostring(itemInfo.itemTypeId));

                    -- Create Action Buttons :D
                    local actions = content:GetChild("actions")
                    local removeButtonRef = actions:GetChild("removeButton")
                    removeButtonRef:SetTag(tostring(itemTypeId))
                    local removeButton = CreateLabelButton("width:23; height:16", "FilledButtonPrint", removeButtonRef, BlacklistRemoveButtonOnClick, "DialogWidgets", "cancel")

                    -- Append to list
                    blacklist_ref.filterList:AddRow(widget)

                end

            end

        end


        -- We're done updating, so unlock list
        blacklist_ref.filterList:UnlockUpdates()

    
    elseif page == "Filtering" then

        if FiltUI.State.subpane == nil then

            -- Lock Filter List while we update
            filtering_ref.filterList:LockUpdates()

            -- Clear existing list data
            filtering_ref.filterList:Reset()


            -- Generate list items
            for index, filter in pairs(Filtering.HUDFilters) do

                -- Create row widget
                local widget = Component.CreateWidget("FilterOverviewRow", filtering_ref.FILTER_LIST)
                widget:SetDims("width:100%; height:64;")
                local content = widget:GetChild("content");
                local focus = widget:GetChild("focusBox");
                local bg = widget:GetChild("bg");
                local defaultBgAlpha = 0.4;
                focus:BindEvent("OnMouseEnter", function()
                    bg:ParamTo("tint", Component.LookupColor("RowHover"), 0.15);
                    bg:ParamTo("alpha", 0.3, 0.15);
                end);
                focus:BindEvent("OnMouseLeave", function()
                    bg:ParamTo("tint", Component.LookupColor("RowDefault"), 0.15);
                    bg:ParamTo("alpha", defaultBgAlpha, 0.15);
                end);
                focus:BindEvent("OnMouseDown", function()
                    Debug.Log("Hiyagiyahia")
                    FiltUI.State.subpane = {subpane="filter/edit", filter=filter}
                    FiltUI.UpdateView()

                end);

                -- Create row field widgets
                Component.CreateWidget("RowField", content:GetChild("name")):GetChild("text"):SetText("Filter # " .. tostring(index) .. " - " .. filter.name );

                -- Create Action Buttons :D
                local actions = content:GetChild("actions")

                local toggleButtonRef = actions:GetChild("toggleButton")
                toggleButtonRef:SetTag(tostring(itemTypeId))
                local toggleButton = CreateLabelButton("width:23; height:16", "FilledButtonPrint", toggleButtonRef, BlacklistRemoveButtonOnClick, "DialogWidgets", "checkbox")

                local editButtonRef = actions:GetChild("editButton")
                editButtonRef:SetTag(tostring(itemTypeId))
                local editButton = CreateLabelButton("width:23; height:16", "FilledButtonPrint", editButtonRef, BlacklistRemoveButtonOnClick, "DialogWidgets", "clearinput")

                local removeButtonRef = actions:GetChild("removeButton")
                removeButtonRef:SetTag(tostring(itemTypeId))
                local removeButton = CreateLabelButton("width:23; height:16", "FilledButtonPrint", removeButtonRef, BlacklistRemoveButtonOnClick, "DialogWidgets", "cancel")

                -- Append to list
                filtering_ref.filterList:AddRow(widget)

            end


            -- We're done updating, so unlock list
            filtering_ref.filterList:UnlockUpdates()

        -- this looks worse than it was supposed to
        elseif FiltUI.State.subpane.subpane and FiltUI.State.subpane.subpane == "filter/edit" then

            -- FiltUI.State.subpane = {subpane="filter/edit", filter=filter}

            Debug.Log("Showing the filter/edit view!")

        end

    end

end

function FiltUI.Show(show) 

    ref.MAIN:Show(show)

    Component.SetInputMode(show and "cursor" or "none");
    if (show) then
        PanelManager.OnShow(ref.MAIN)
    else
        PanelManager.OnHide(ref.MAIN)
    end

end
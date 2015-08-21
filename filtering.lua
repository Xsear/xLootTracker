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



Filtering.HUDFilters = {}
Filtering.HUDFilters[1] = {
    enabled = true,
    name = "Green lvl 30 Armor",
    parameters = {
        {
            ["type"] = "CATEGORY",
            ["mode"] = "EQUALS", -- not used
            ["value"] = NewFilteringCategory.Armor, -- Modules? Gear?
        },
        {
            ["type"] = "ITEM_LEVEL",
            ["mode"] = "LARGER_OR_EQUALS",
            ["value"] = 30,
        },
        {
            ["type"] = "RARITY",
            ["mode"] = "LARGER_OR_EQUALS",
            ["value"] = Loot.GetRarityIndex(LootRarity.Uncommon),
        },
    }
}


Filtering.Comparators = {
    ["LARGER_OR_EQUALS"] = function(a, b) return a >= b end,
    ["LESS_OR_EQUALS"] = function(a, b) return a <= b end,
    ["LARGER"] = function(a, b) return a > b end,
    ["LESS"] = function(a, b) return a < b end,
    ["EQUALS"] = function(a, b) return a == b end,
}


function NewDetermineCategory(loot)
    local itemTypeId = loot:GetTypeId()
    local mostSpecificCategory = -1
    local mostSpecificCategoryKey = nil
    for category, subTypeId in pairs(NewFilteringCategory) do
        if Game.IsItemOfType(itemTypeId, subTypeId) then
            if subTypeId > mostSpecificCategory then 
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

                if parameter.type == "CATEGORY" then

                    local lootCategory = NewFilteringCategory[NewDetermineCategory(loot)]
                    local comparator = Filtering.Comparators.EQUALS
                    if not comparator(lootCategory, parameter.value) then
                        Debug.Log("lootValue ", lootCategory, " " .. parameter.mode .. " paramValue ", parameter.value, " : FALSE")
                        passesFilterParameters = false
                    end

                elseif parameter.type == "RARITY" then

                    local rarity = loot:GetRarityValue()
                    local comparator = Filtering.Comparators[parameter.mode]
                    if not comparator(rarity, parameter.value) then
                        Debug.Log("lootValue ", rarity, " " .. parameter.mode .. " paramValue ", parameter.value, " : FALSE")
                        passesFilterParameters = false
                    end

                elseif parameter.type == "ITEM_LEVEL" then

                    local ilvl = loot:GetItemLevel()
                    local comparator = Filtering.Comparators[parameter.mode]
                    if not comparator(ilvl, parameter.value) then
                        Debug.Log("lootValue ", ilvl, " " .. parameter.mode .. " paramValue ", parameter.value, " : FALSE")
                        passesFilterParameters = false
                    end

                elseif parameter.type == "ITEM_REQUIRED_LEVEL" then

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
        FiltUI.ChangeView("Blacklist", "Tracker")
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
    ref.TABS:Select(1)


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




    local filteringTestButton = Component.CreateWidget('<Button dimensions="dock:fill" />', filtering_ref.LEFT_COLUMN)
    filteringTestButton:SetText("Filtering Test")
    filteringTestButton:BindEvent("OnMouseDown", RunFilteringTest)

    --
    Debug.Log('FiltUI.Setup() complete')
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

function ShowDialog(args)
    SimpleDialog.Display(args.body);
    SimpleDialog.SetTitle("Confirm");

    SimpleDialog.AddOption("ABORT", function()
        if args.onNo then args.onNo(); end
        SimpleDialog.Hide();
    end, {color = "#ffffff"});

    SimpleDialog.AddOption("YES", function()
        if args.onYes then args.onYes(); end
        SimpleDialog.Hide();
    end, {color = "#00ff00"});

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
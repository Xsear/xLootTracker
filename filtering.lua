require "lib/lib_Tabs"


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
    scopeList,
    TEST,
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

    if not ref.PANE_BLACKLIST then Debug.Error("missing ref") end 

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


    -- create filterlist header
    local header = Component.CreateWidget("BlacklistRow", blacklist_ref.MAIN_AREA)
    header:SetDims("width:100%; height:64;top:0;")
    local content = header:GetChild("content");
    Component.CreateWidget("RowField", content:GetChild("icon")):GetChild("text"):SetText("  Icon");
    Component.CreateWidget("RowField", content:GetChild("name")):GetChild("text"):SetText("Name");
    Component.CreateWidget("RowField", content:GetChild("typeid")):GetChild("text"):SetText("Type Id");
    Component.CreateWidget("RowField", content:GetChild("actions")):GetChild("text"):SetText("Actions");


    -- init filterlist
    blacklist_ref.filterList = RowScroller.Create(blacklist_ref.FILTER_LIST);
    blacklist_ref.filterList:SetSpacing(2);
    blacklist_ref.filterList:ShowSlider(true);



    -- Scope Selection
    local margin = 70;
    local itMargin = 0;
    blacklist_ref.scopeList = {}
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

    
    



    --Component.GetWidget("pathText"):SetText("Filtering >> " .. FiltUI.State.page .. " >> " .. FiltUI.State.section)

    --[[

    local addButton = Button.Create(ref.BUTTON_ADD);
    addButton:SetText("Change Scope");
    addButton:TintPlate(Button.DEFAULT_GREEN_COLOR);
    addButton:Bind(function()
        
        FiltUI.ChangeView("Blacklist", (FiltUI.State.section == "Tracker" and "Waypoints") or "Tracker") -- Debug input, toggles between "all" and "tracker"

        

    end);

    
    local delButton = Button.Create(ref.BUTTON_DEL);
    delButton:SetText("Debug Blacklist");
    delButton:TintPlate(Button.DEFAULT_RED_COLOR);
    delButton:Bind(function()
        Debug.Table(Options['Blacklist'])
        --]]
        --[[

        Private.ShowDialog(
        {
            body = Component.LookupText("DELETE_FILTER_SET"):format(activeFilterSet or ""),
            onYes = DeleteFilterSet,
            onNo = function()
            
            end
        });
        --]]
    --[[
    end);

--]]


    --
    Debug.Log('filtui setup complete')
    
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
    LABEL.FOCUS:BindEvent("OnMouseUp", function() 
        LABEL.BORDER:ParamTo("exposure", .5, .25, "smooth") 
        action() 
    end)

    return LABEL
end


-- lel onclick func
local deleteFunction = function() Debug.Log("We should delete " .. tostring(itemTypeId)) end

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


        -- Filter list

        blacklist_ref.filterList:LockUpdates()

        -- clear
        blacklist_ref.filterList:Reset()




        -- list active stuff
        if not _table.empty(Options['Blacklist'][section]) then


            for itemTypeId, value in pairs(Options['Blacklist'][section]) do
                local itemInfo = Game.GetItemInfoByType(itemTypeId)
                if not itemInfo then
                    Debug.Warn('Invalid itemTypeId in blacklist') 
                else
                    --results[#results + 1] = tostring(itemInfo.name) .. ' (' .. tostring(itemInfo.itemTypeId) ..')'


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


                    local ICON = MultiArt.Create(content:GetChild("icon"))
                    ICON:SetUrl(itemInfo.web_icon)

                    Component.CreateWidget("RowField", content:GetChild("name")):GetChild("text"):SetText(tostring(itemInfo.name));
                    Component.CreateWidget("RowField", content:GetChild("typeid")):GetChild("text"):SetText(tostring(itemInfo.itemTypeId));



                    

                   

                    -- action button :D
                    local actions = content:GetChild("actions")
                    local removeButtonRef = actions:GetChild("removeButton")
                    
                    local removeButton = CreateLabelButton("width:23; height:16", "FilledButtonPrint", removeButtonRef, deleteFunction, "DialogWidgets", "cancel")


                     blacklist_ref.filterList:AddRow(widget)

                end

            end
            
             

        end


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
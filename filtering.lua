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



local ref = {
    MAIN = Component.GetFrame("Options"),
    WINDOW = Component.GetWidget("Window"),
    MOVABLE_PARENT = Component.GetWidget("MovableParent"),
    CLOSE_BUTTON = Component.GetWidget("close"),
    TITLE_TEXT = Component.GetWidget("title"),

    LEFT_COLUMN = Component.GetWidget("LeftColumn"),
    MAIN_AREA = Component.GetWidget("MainArea"),
    FILTER_LIST = Component.GetWidget("FilterList"),

    BUTTON_ADD = Component.GetWidget("ButtonAdd"),
    BUTTON_DEL = Component.GetWidget("ButtonDel"),



    PANES = Component.GetWidget("Tabs"),
    
    BODY = Component.GetWidget("Body"),
}

ref.TABS = Tabs.Create(3, ref.PANES)

FiltUI.State = {
    page = "Blacklist",
    section = "Tracker"
}

FiltUI.Instance = {
    filterList,
}

function FiltUI.Setup(args)
    
    
    MovablePanel.ConfigFrame({
        frame = ref.MAIN,
        MOVABLE_PARENT = ref.MOVABLE_PARENT
    })

    PanelManager.RegisterFrame(ref.MAIN, ToggleWindow, {show=false})

    -- Setup close button
    ref.CLOSE_BUTTON:BindEvent("OnMouseDown", function() FiltUI.Show(false) end)
    local X = ref.CLOSE_BUTTON:GetChild("X");
    ref.CLOSE_BUTTON:BindEvent("OnMouseEnter", function()
        X:ParamTo("tint", Component.LookupColor("red"), 0.15);
        X:ParamTo("glow", "#30991111", 0.15);
    end)
    ref.CLOSE_BUTTON:BindEvent("OnMouseLeave", function()
        X:ParamTo("tint", Component.LookupColor("white"), 0.15);
        X:ParamTo("glow", "#00000000", 0.15);
    end)

    ref.TITLE_TEXT:SetText("Loot Tracker") -- fixme: hardcoded


    -- Setup Tabs
    ref.TABS:SetTab(1, {label="Blacklist"})
    ref.TABS:SetTab(2, {label="Filtering"})
    ref.TABS:SetTab(3, {label="Keybinds"})

    ref.TABS:Select(1)







    
    --Component.GetWidget("pathText"):SetText("Filtering >> " .. FiltUI.State.page .. " >> " .. FiltUI.State.section)


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
        --[[

        Private.ShowDialog(
        {
            body = Component.LookupText("DELETE_FILTER_SET"):format(activeFilterSet or ""),
            onYes = DeleteFilterSet,
            onNo = function()
            
            end
        });
        --]]
    end);

    
    -- init
    FiltUI.Instance.filterList = RowScroller.Create(ref.FILTER_LIST);
    FiltUI.Instance.filterList:SetSpacing(2);
    FiltUI.Instance.filterList:ShowSlider(true);

    FiltUI.ChangeView("Blacklist", "Tracker")

end

function Options.ToggleFilteringUI(args)
    ToggleWindow(true)
end


function ToggleWindow(show)
    FiltUI.Show(show);
end


function FiltUI.ChangeView(page, section)

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


        FiltUI.Instance.filterList:LockUpdates()

        -- clear
        FiltUI.Instance.filterList:Reset()

        -- list active stuff
        if not _table.empty(Options['Blacklist'][section]) then



            for itemTypeId, value in pairs(Options['Blacklist'][section]) do
                local itemInfo = Game.GetItemInfoByType(itemTypeId)
                if not itemInfo then
                    Debug.Warn('Invalid itemTypeId in blacklist') 
                else
                    --results[#results + 1] = tostring(itemInfo.name) .. ' (' .. tostring(itemInfo.itemTypeId) ..')'


                    widget = Component.CreateWidget("BlacklistRow", ref.FILTER_LIST)
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




                    FiltUI.Instance.filterList:AddRow(widget)

                end

            end
            
             

        end


        FiltUI.Instance.filterList:UnlockUpdates()



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
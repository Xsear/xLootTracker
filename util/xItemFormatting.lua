--[[
    xItemFormatting.lua
    
    Lifted code form lib_Items.
    Funcs written to be used by the tooltips made by lib_Items, that are totally useful if you want to make your own tooltips :D
    
]]--

if xItemFormatting then return end

xItemFormatting = {}


-- Setup stuff

local c_BOOST_COLOR = "#00FF80";
local c_DROP_COLOR = "#808080";
local c_CRITICAL_COLOR = "#FF4040";
local c_LABEL_COLOR = "#CCCCCC";    -- e.g. "Splash Radius"
local c_STAT_COLOR = "#FFFFFF"; -- e.g. "2.00m"
local c_COLON_SPACING = ": ";

c_IgnoreStats = { 
    ["ammoPerBurst"] = "ammoPerBurst",
    ["roundsPerBurst"] = "roundsPerBurst",
    --["damagePerRound"] = "damagePerRound",
    ["roundsPerMinute"] = "roundsPerMinute",    -- redundant with DPS
    --["maxAmmo"] = "maxAmmo",
    ["rating"] = "rating",
}

-- these are stats where a lower number is better
c_InvertStats = {
    ["reloadTime"] = "reloadTime",
    ["reload"] = "reload",
}

local d_Certs = { };    -- my certifications (d_Certs[battleframeTypeId][certId] = true)
local c_PROGRESSION_CERTS = {};
local c_URL_CERTS;

local function UpdateCerts(resp, err)
    if (resp) then
        for bframe_idx,certs in pairs(resp) do
            d_Certs[bframe_idx] = {};
            for i,certId in ipairs(certs) do
                certId = tostring(certId);
                d_Certs[bframe_idx][certId] = true;
            end
        end
    end
end

local function InitCerts()
    if (not Player or not Player.IsReady()) then
        callback(InitCerts, nil, 1);
        -- try again later
        return;
    end
    -- collect progression certs
    c_PROGRESSION_CERTS = {};
    local progression = Game.GetProgressionUnlocks();
    for lvl,unlock in pairs(progression) do
        for branch,cert_id in pairs(unlock.certs) do
            c_PROGRESSION_CERTS[tostring(cert_id)] = true;
        end
    end
    -- Subscribe to certs web updates
    local name, faction, race, sex, char_id = Player.GetInfo();
    c_URL_CERTS = WebCache.MakeUrl("certs", char_id);
    WebCache.Subscribe(c_URL_CERTS, UpdateCerts);
end
InitCerts();

local context = nil

-- Available stuff

function xItemFormatting.GetStatDisplayName( stat )
    return Component.LookupText( "STAT_"..stat )
end


-- MergeStats takes stats and attributes and calculates the difference between the items
function xItemFormatting.MergeStats( base, comp )
    local merged = {
        attributes = {},
        stats = {},
    };
    
    -- merge attribute data
    if (base.attributes) then
        -- populate existing attributes
        if( base.attributes ) then
            for i, att in ipairs(base.attributes) do
                merged.attributes[att.name] = {
                    id = att.id,
                    value = att.value,
                    display_name = att.display_name,
                    format = att.format,
                    inverse = att.inverse,
                    delta = 0,
                }
            end
        end
        
        -- compare attributes
        if( comp.attributes ) then
            for i, att in ipairs(comp.attributes) do
                if( not merged.attributes[att.name] ) then
                    -- populate missing attributes
                    merged.attributes[att.name] = {
                        id = att.id,
                        value = 0,
                        display_name = att.display_name,
                        format = att.format,
                        inverse = att.inverse,
                        delta = -att.value,
                    }
                else
                    merged.attributes[att.name].delta = merged.attributes[att.name].value - att.value;
                end
            end
        end 
    end
    
    -- merge stat data
    if( base.stats ) then
        for name, value in pairs(base.stats) do
            if( not c_IgnoreStats[name] ) then
                local delta = value;
                if( comp.stats[name] ) then
                    delta = value - comp.stats[name];
                end
                merged.stats[name] = {
                    value = value,
                    delta = delta,
                    inverse = c_InvertStats[name],
                };
            end
        end      
    end
    if (comp.stats ) then
        for name, value in pairs(comp.stats) do
            if( not c_IgnoreStats[name] and not merged.stats[name]) then
                merged.stats[name] = {
                    value = 0,
                    delta = -value,
                };
            end
        end
    end
    
    return merged;
end

function xItemFormatting.SortAttributes(A,B)
    return A.sort_weight < B.sort_weight;
end


function xItemFormatting.FormatDeltaString(delta, format)
    if (not format or format == "") then
        format = "%.2f";
    end
    local sign = "+";
    if (delta < 0) then
        sign = "";  -- negatives already have a '-'
    end
    return sign..unicode.format(format, delta);
end

function xItemFormatting.FormatStatToLine(stat_name, stat_val, stat_delta)
    -- for use in PrintLines
    local display_name = xItemFormatting.GetStatDisplayName(stat_name);
    local line = {
        textFormat = TextFormat.Create(),
        super_sort = 2,
        sub_sort = Component.RemoveLocalizationTracking(display_name),
    };
    line.textFormat:AppendColor(c_LABEL_COLOR);
    line.textFormat:AppendText(display_name..c_COLON_SPACING);
    line.textFormat:AppendColor(c_STAT_COLOR);
    line.textFormat:AppendText(unicode.format("%.2f", stat_val));
    if (stat_delta and stat_delta ~= 0) then
        if ((stat_delta < 0) == (c_InvertStats[name] ~= nil)) then
            line.textFormat:AppendColor(c_BOOST_COLOR);
        else
            line.textFormat:AppendColor(c_DROP_COLOR);
        end
        line.textFormat:AppendText(" ("..FormatDeltaString(stat_delta)..")");
    end
    return line;
end

function xItemFormatting.FormatCertsToLine(certs, context)
    local line = {
        textFormat = TextFormat.Create(),
        super_sort = -1,
        sub_sort = 0,
    };
    
    local my_certs = {};
    if (context and context.frameTypeId) then
        my_certs = d_Certs[tostring(context.frameTypeId)] or {};
    else
        -- try to find the closest match
        for frameTypeId, frame_certs in pairs(d_Certs) do
            local found_match = true;
            for _,certId in pairs(certs) do
                if (not frame_certs[certId] and not c_PROGRESSION_CERTS[certId]) then
                    -- missing critical cert
                    found_match = false;
                    break;
                end
            end
            if (found_match) then
                -- collect this frame's certs
                for cert_id,_ in pairs(frame_certs) do
                    my_certs[cert_id] = true;
                end
            end
        end
    end
    
    -- order the certs
    local ordered_certs = {};
    for _,certId in pairs(certs) do
        if (c_PROGRESSION_CERTS[certId]) then
            ordered_certs[#ordered_certs+1] = certId;
        else
            table.insert(ordered_certs, 1, certId);
        end
    end
    
    if (#ordered_certs == 0) then
        -- early out
        return nil;
    end
    
    for i,certId in pairs(ordered_certs) do
        certId = tostring(certId);
        local certInfo = Game.GetCertificationInfo(certId);
    
        if (not my_certs or not my_certs[certId]) then
            line.textFormat:AppendColor(c_CRITICAL_COLOR);
        else
            line.textFormat:AppendColor(c_LABEL_COLOR);
        end
        line.textFormat:AppendText(Component.LookupText("REQUIRES_CERT", certInfo.name));
        if (i < #ordered_certs) then
            line.textFormat:AppendText("\n");
        end
    end
    return line;
end

function xItemFormatting.FormatConstraintToLine(key, value, delta)
    local FIELDS = {
        ["mass"] = {sort=3, unit=""},
        ["power"] = {sort=2, unit=""},
        ["cpu"] = {sort=1, unit=""},
    };
    local line = {
        textFormat = TextFormat.Create(),
        super_sort = 0,
        sub_sort = FIELDS[key].sort,
    };
    
    local value_str;
    
    line.textFormat:AppendColor(c_LABEL_COLOR);
    line.textFormat:AppendText(Component.LookupText(key)..c_COLON_SPACING);
    line.textFormat:AppendColor(c_STAT_COLOR);
    line.textFormat:AppendText(unicode.format("%d", math.abs(value)));
    
    if (delta and delta ~= 0) then
        if (delta < 0) then
            -- less efficient
            line.textFormat:AppendColor(c_DROP_COLOR);
        else
            -- more efficient
            line.textFormat:AppendColor(c_BOOST_COLOR);
        end
        line.textFormat:AppendText(" ("..FormatDeltaString(-delta, "%d")..")");
    end
    return line;
end

function xItemFormatting.FormatAttributeToLine(att, delta)
    -- for use in PrintLines
    local line = {
        textFormat = TextFormat.Create(),
        super_sort = 1,
        sub_sort = Component.RemoveLocalizationTracking(att.display_name),
    };
    local value_display;
    if( att.format and att.format ~= "" ) then
        if (unicode.find(att.format, " %% ")) then
            warn("Bad format "..tostring(att.format));
            value_display = tostring(att.value);
        else
            value_display = unicode.format(att.format, att.value);
        end
    else
        value_display = unicode.format( "%.2f", att.value)
    end
    line.textFormat:AppendColor(c_LABEL_COLOR);
    line.textFormat:AppendText(att.display_name..c_COLON_SPACING);
    line.textFormat:AppendColor(c_STAT_COLOR);
    line.textFormat:AppendText(value_display);
    
    if (delta and delta ~= 0) then
        if ((delta < 0) == att.inverse) then
            line.textFormat:AppendColor(c_BOOST_COLOR);
        else
            line.textFormat:AppendColor(c_DROP_COLOR);
        end
        line.textFormat:AppendText(" ("..FormatDeltaString(delta, att.format)..")");
    end
    
    return line;
end

function xItemFormatting.FormatDurabilityToLine(durability, comp_durability)
    -- ignore comp_durability
    if (durability and durability.current or durability.unbreakable) then
        local line = {
            textFormat = TextFormat.Create(),
            super_sort = 3,
            sub_sort = 1,
        };
        local MAX_DURABILITY = 1000;
        line.textFormat:AppendColor(c_LABEL_COLOR);
        line.textFormat:AppendText(unicode.format("%s: ", Component.LookupText("DURABILITY")));
        if (durability.unbreakable) then
            line.textFormat:AppendColor(Colors.MakeGradient("condition", 1));
            line.textFormat:AppendText(Component.LookupText("INFINITY_SYMBOL"));
        else
            line.textFormat:AppendColor(Colors.MakeGradient("condition", durability.current / MAX_DURABILITY));
            line.textFormat:AppendText(unicode.format("%d/%d", durability.current, MAX_DURABILITY));
            
            if (durability.pool) then
                line.textFormat:AppendColor(Colors.MakeGradient("condition", durability.pool / 3000));
                line.textFormat:AppendText(unicode.format(" (%d)", durability.pool));
            end
        end
        
        return line;
    end
    --return nil;
end

function xItemFormatting.PrintLines(lines, TEXT_WIDGET)
    -- lines[idx] = {display_text, super_sort, sub_sort, color}
    local sorted = {};
    
    for k,value in pairs(lines) do
        table.insert(sorted, value);
    end
    
    table.sort(sorted, function(A,B)
        -- super_sort: separates entries into 'categories'
        if (A.super_sort == B.super_sort) then
            -- sub_sort: sorting within categories
            return A.sub_sort > B.sub_sort;
        else
            return A.super_sort > B.super_sort;
        end
    end);
    
    local lines = {};
    local n = #sorted;
    if (n > 0) then
        local my_TF = TextFormat.Create();
        for i,entry in ipairs(sorted) do
            my_TF:Concat(entry.textFormat);
            if (i < n) then
                my_TF:AppendText("\n");
            end
        end
        -- set text
        TextFormat.Clear(TEXT_WIDGET);
        my_TF:ApplyTo(TEXT_WIDGET);
        TEXT_WIDGET:Show();
        TEXT_WIDGET:SetDims( "height:"..TEXT_WIDGET:GetTextDims().height ); 
    else
        TEXT_WIDGET:Show(false);
        TEXT_WIDGET:SetDims("height:0");
    end
end


-- Custom code
--[[
context = {
    frameTypeId = battleframe type id
}
--]]
function xItemFormatting.setContext(c)
    context = c
end

function xItemFormatting.getStatLines(itemInfo)

    local stats_lines = {};
    if (itemInfo.attributes) then
        for k,v in pairs(itemInfo.attributes) do
            table.insert(stats_lines, xItemFormatting.FormatAttributeToLine(v));
        end
    end
    if (itemInfo.stats) then
        for name,v in pairs(itemInfo.stats) do
            if( not c_IgnoreStats[name] ) then
                table.insert(stats_lines, xItemFormatting.FormatStatToLine(name, v, nil));
            end
        end
    end
    
    
    return stats_lines
end


function xItemFormatting.getRequirementLines(itemInfo)

    local has_constraints = false;
    local requirements_lines = {};
    if( itemInfo.constraints ) then
        for k,v in pairs(itemInfo.constraints) do
            local line = xItemFormatting.FormatConstraintToLine(k, v);
            if (v > 0) then
                table.insert(stats_lines, line);
            else
                table.insert(requirements_lines, line);             
            end
            if (v ~= 0) then
                has_constraints = true;
            end
        end
    end
    if (not has_constraints) then
        requirements_lines = {};
    end
    
    if (itemInfo.durability) then
        local line = xItemFormatting.FormatDurabilityToLine(itemInfo.durability);
        if (line) then
            table.insert(stats_lines, line);
        end
    end
    
    -- display cert req's   
    local line = xItemFormatting.FormatCertsToLine(itemInfo.certifications, context);
    if (line) then
        table.insert(requirements_lines, line);
        has_constraints = true;
    end
    
    return requirements_lines
end
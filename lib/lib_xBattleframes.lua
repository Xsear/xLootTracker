--[[
    lib_xBattleframes.lua

    A helper library for dealing with Battleframes.

    Reference
        Functions
            xBattleframes.GetFrameByCraftingTypeId (craftingTypeId)
            xBattleframes.GetArchetypeByCraftingTypeId (craftingTypeId)
            xBattleframes.GetInfoByCraftingTypeId (craftingTypeId)
            xBattleframes.GetColorOfArchetype (archetype)
            xBattleframes.GetDisplayNameOfArchetype (archetype)
            
        Data Collection
            xBattleframes.DataCollection.IdentifyFrameCraftingTypeIds ()

        Data
            FrameCraftingTypeIdIndex
            FrameWebIconIndex
            ArchetypeDisplayNameIndex

    Changelog

        2013-10-12
            Revamped from a util into a small library

        2013-08-28
            Extended with Arsenal data on 2013-08-28
        
        Original
            Code written by DeadWalking, extracted from MahDurabiliteh 1.0 (0.7.1683)
]]--

if xBattleframes then return end

xBattleframes = {}
DataCollection = {}
xBattleframes.DataCollection = DataCollection
xBattleframes.Version = "1.1"

function xBattleframes.GetInfoByCraftingTypeId(cid)
    local baseIdx
    local typeIdx
    for i,v in pairs(PRIVATE.FrameCraftingTypeIdIndex) do
        for j,x in pairs(v) do
            for k,y in pairs(x) do
                if tostring(y) == cid then 
                    baseIdx = i
                    typeIdx = j
                    break
                end
            end
            if baseIdx then break end
        end
        if baseIdx then break end
    end
    return baseIdx, typeIdx;
end

function xBattleframes.GetFrameByCraftingTypeId(cid)
    return xBattleframes.GetInfoByCraftingTypeId(cid).typeIdx
end

function xBattleframes.GetArchetypeByCraftingTypeId(cid)
    return xBattleframes.GetInfoByCraftingTypeId(cid).baseIdx
end

function xBattleframes.GetColorOfArchetype(archetype)
    return Component.LookupColor(archtype)
end

function xBattleframes.GetDisplayNameOfArchetype(archetype)
    return PRIVATE.ArchetypeDisplayNameIndex[archetype]
end

function DataCollection.IdentifyFrameCraftingTypeIds()
    local tempFound = {};
    for itemId = 1,200000 do
        local itemId = tostring(itemId)
        local itemInfo = Game.GetItemInfoByType(itemId);
        if itemInfo and itemInfo.name and itemInfo.name ~= "" and 
            (not string.find(itemInfo.name,"Accord") or (string.find(itemInfo.name,"Accord") and string.find(itemInfo.name,"Elite"))) and 
            not string.find(itemInfo.name,"Stock") and not string.find(itemInfo.name,"Stock") and not string.find(itemInfo.name,"test") and 
            not string.find(itemInfo.name,"Test") and not string.find(itemInfo.name,"Omnidyne") and not string.find(itemInfo.name,"Kisuton") and not string.find(itemInfo.name,"Astrek") and
            ((itemInfo.type == "weapon" and itemInfo.slotIdx == 1) or itemInfo.type == "frame_module" or itemInfo.type == "ability_module") and
            itemInfo.craftingTypeId and itemInfo.craftingTypeId ~= 1 and itemInfo.craftingTypeId ~= 3
        then
            local found;
            for archType,archTbl in pairs(FRAME_IDX) do
                for frameType,frameTbl in pairs(archTbl) do
                    for _,craftId in ipairs(frameTbl) do
                        if tostring(craftId) == tostring(itemInfo.craftingTypeId) then
                            found = true;
                        end
                    end
                end
            end
            if not found and not tempFound[itemInfo.craftingTypeId] then 
                tempFound[itemInfo.craftingTypeId] = true;
                log("ITEMCRAFTINGIDS: "..(itemInfo.name)..": "..tostring(itemInfo.craftingTypeId));
            end
        end
    end
end


local PRIVATE = {}

PRIVATE.FrameCraftingTypeIdIndex = {                                 
    ["berzerker"] = {
        ["Assault"] = {
            612,295,265,254,240,14,15,115,16,644,645,646,649,681,722,741,757,787,799,836,
        },
        ["Firecat"] = {
            327,266,329,269,267,268,684,685,687,689,724,743,782,831,
        },
        ["Tigerclaw"] = {
            264,328,262,18,330,331,647,648,650,682,683,723,742,759,826,
        },
    },
    ["guardian"] = {    
        ["Dreadnaught"] = {
            614,286,244,19,284,33,35,285,36,669,670,671,700,702,704,728,746,756,788,801,805,806,838,839,
        },
        ["Rhino"] = {
            297,296,293,294,291,292,652,654,655,656,706,730,747,771,834,849,
        },
        ["Mammoth"] = {
            617,290,128,34,287,289,288,653,657,658,659,660,729,748,829,
        },
        ["Arsenal"] = {
            663,639,636,249,640,857,862,633,854,851,852,853,855,856,
        },
    },
    ["bunker"] = {  
        ["Engineer"] = {
            274,587,602,599,272,38,271,273,615,661,662,663,707,708,709,731,750,764,798,803,840,
        },
        ["Electron"] = {
            279,278,277,209,275,276,664,665,666,667,668,733,751,833,
        },
        ["Bastion"] = {
            283,282,281,191,39,280,672,673,674,710,732,752,772,773,828,
        },
    },
    ["medic"] = {   
        ["Biotech"] = {
            613,314,147,313,25,24,21,23,234,691,692,725,744,758,760,762,795,800,837,
        },
        ["Recluse"] = {
            324,326,325,323,67,580,696,697,698,727,761,768,769,770,827,
        },
        ["Dragonfly"] = {
            318,320,315,319,26,317,651,693,726,745,763,848,765,766,832,
        },
    },
    ["recon"] = {   
        ["Recon"] = {
            616,302,588,105,29,300,608,301,299,711,712,713,734,753,767,774,775,791,807,841,
        },
        ["Raptor"] = {
            312,308,310,309,138,311,675,676,677,720,736,755,776,835,
        },
        ["Nighthawk"] = {
            306,305,303,30,22,304,714,715,716,717,718,735,754,830,
        },
    },
}

PRIVATE.FrameWebIconIndex = {
    ['Assault'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/AccordAssault.png",
    ['Firecat'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Firecat.png",
    ['Tigerclaw'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Tigerclaw.png",

    ['Dreadnaught'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/AccordDread.png",
    ['Rhino'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Rhino.png",
    ['Mammoth'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Mammoth.png",
    ['Arsenal'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Arsenal.png",

    ['Engineer'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/AccordEngineer.png",
    ['Electron'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Electron.png",
    ['Bastion'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Bastion.png",

    ['Biotech'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/AccordBiotech.png",
    ['Recluse'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Recluse.png",
    ['Dragonfly'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Dragonfly.png",

    ['Recon'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/AccordRecon.png",
    ['Raptor'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Raptor.png",
    ['Nighthawk'] = "https://ingame-v01-ew1.firefallthegame.com/assets/items/64/Nighthawk.png",
}

PRIVATE.ArchetypeDisplayNameIndex = {
    ["berzerker"] = "Assault",
    ["guardian"] = "Dreadnaught",
    ["bunker"] = "Engineer",
    ["medic"] = "Biotech",
    ["recon"] = "Recon",
}

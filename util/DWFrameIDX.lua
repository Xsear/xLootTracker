--[[
    Code written by DeadWalking, extracted from MahDurabiliteh 1.0 (0.7.1683) by Xsear
    
    Provides function and library to retreive which battleframe/archetype that a craftingTypeId is tied to.

    Extended with Arsenal data on 2013-08-28 by Xsear

]]--

if DWFrameIDX then return end

DWFrameIDX = {}
local PRIVATE = {}

-- Table used to determine which specific battleframe a itemInfo.craftingTypeId is tied to.
PRIVATE.FRAME_IDX = {                                 
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


-- Function to get specific battleframe and archetype that itemInfo.craftingTypeId is tied to.
function DWFrameIDX.ItemIdxString(id)
    local baseIdx;
    local typeIdx;
    for i,v in pairs(PRIVATE.FRAME_IDX) do
        for j,x in pairs(v) do
            for k,y in pairs(x) do
                if tostring(y) == id then 
                    baseIdx = i;
                    typeIdx = j;
                    break; 
                end
            end
            if baseIdx then break end
        end
        if baseIdx then break end
    end
    
    return baseIdx, typeIdx;
end

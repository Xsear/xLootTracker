require 'string'

--[[
    RemoveAllChildren(PARENT)
    UI Helper function, removes children of a frame node~
]]--
function RemoveAllChildren(PARENT)
    for i = PARENT:GetChildCount(), 1, -1 do
        Component.RemoveWidget(PARENT:GetChild(i))
    end
end


-- Why the fucking fuck are these not standard functions
function _table.empty(table)
    if not table or next(table) == nil then
       return true
    end
    return false
end

function _table.compare(t1,t2,ignore_mt)
    local ty1 = type(t1)
    local ty2 = type(t2)
    if ty1 ~= ty2 then return false end
    -- non-table types can be directly compared
    if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
    -- as well as tables which have the metamethod __eq
    local mt = getmetatable(t1)
    if not ignore_mt and mt and mt.__eq then return t1 == t2 end
    for k1,v1 in pairs(t1) do
        local v2 = t2[k1]
        if v2 == nil or not _table.compare(v1,v2) then return false end
    end
    for k2,v2 in pairs(t2) do
        local v1 = t1[k2]
        if v1 == nil or not _table.compare(v1,v2) then return false end
    end
    return true
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- Source: http://lua-users.org/wiki/MakingLuaLikePhp
-- Credit: http://richard.warburton.it/
function explode(div,str)
    if (div=='') then return false end
    local pos,arr = 0,{}
    -- for each divider found
    for st,sp in function() return unicode.find(str,div,pos,true) end do
        table.insert(arr,unicode.sub(str,pos,st-1)) -- Attach chars left of current divider
        pos = sp + 1 -- Jump past current divider
    end
    table.insert(arr,unicode.sub(str,pos)) -- Attach chars right of last divider
    return arr
end


-- from: http://lua-users.org/wiki/SplitJoin
function splitExplode(d,p)
  local t, ll
  t={}
  ll=0
  if(#p == 1) then return {p} end
    while true do
      l=string.find(p,d,ll,true) -- find the next d in the string
      if l~=nil then -- if 'not not' found then..
        table.insert(t, string.sub(p,ll,l-1)) -- Save it in our array.
        ll=l+1 -- save just after where we found it for searching next time.
      else
        table.insert(t, string.sub(p,ll)) -- Save what's left in our array.
        break -- Break at end, as it should be, according to the lua manual.
      end
    end
  return t
end

--http://stackoverflow.com/questions/2421695/first-character-uppercase-lua
function ucfirst(str)
    return (string.gsub(str, '^%l', string.upper))
end

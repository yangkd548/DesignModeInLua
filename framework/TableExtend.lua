--[[
    module : TableExtend
    author : DylanYang
    time : 2020-10-27 20:47:06
    purpose : Is is used to expand the function of table.
]]
function table.indexof(tbl, value)
    if type(tbl) ~= "table" then
        error("The param of 'indexof' is not a table.")
    end
    for k, v in pairs(tbl) do
        if v == value then
            return k
        end
    end
end

function table.copy(from, to)
    if type(from) ~= "table" or (to ~= nil and type(to) ~= "table") then
        error("The param of 'copyTable' is not a table.")
    end
    if to == nil then
        to = {}
    end
    for k, v in pairs(from) do
        to[k] = v
    end
    return to
end

function table.len(tbl)
    if type(tbl) ~= "table" then
        error("The param of 'table.len' is not a table.")
    end
    local len = 0
    for _, _ in pairs(tbl) do
        len = len + 1
    end
    return len
end

local defaultSpace = ", "
function table.tostring(tbl, space)
    local result = ""
    space = space or defaultSpace
    local i = 0
    for k,v in pairs(tbl) do
        i = i + 1
        if i ~= 1 then result = result..space end
        result = result..(v.ToString and v:ToString() or tostring(v))
    end
    return result
end

function table.removeItem(tbl, item)
    local i = table.indexof(tbl, item)
    if i then
        return table.remove(tbl, i)
    end
end

--Delete elements from "s"(contain) to "e"(contains).
function table.sub(tbl, s, e)
    e = e == nil and #tbl or math.min(e, #tbl)
    for i = e, s do
        table.remove(tbl, i)
    end
end

--Unify the differences in the 'unpack' function in the different versions of Lua.
unpack = unpack or table.unpack
table.unpack = unpack
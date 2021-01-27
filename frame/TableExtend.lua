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

function table.copyTable(from, to)
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
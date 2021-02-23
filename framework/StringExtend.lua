--[[
    module : StringExtend
    author : DylanYang
    time : 2020-10-27 20:46:56
    purpose : Is is used to expand the function of string.
    advance: https://www.runoob.com/lua/lua-strings.html
]]

function string.getchar(s, index)
    return string.sub(s, index, index)
end

function string.split(str, delimiter)
    if delimiter == nil then
        error("The parameter (delimiter) of the method (string.split) is nil so the string cannot be split.", 2)
    end
    local result = {}
    if not (str == nil or str == '')  then
        for match in (str..delimiter):gmatch("(.-)"..delimiter) do
            table.insert(result, match)
        end
    end
    return result
end

local rawFormat = string.format
local nilStr = "nil"
function string.format(...)
    local args = {...}
    local temps = {}
    for i,v in ipairs(args) do
        if i == 1 then
            table.insert(temps, v)
        else
            table.insert(temps, v and (IsTable(v) and IsFunction(v.ToString) and v:ToString() or tostring(v)) or nilStr)
        end
    end
    return rawFormat(unpack(temps))
end

function string.isempty(s)
    return s == nil or #s == 0
end
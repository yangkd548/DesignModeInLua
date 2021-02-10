--[[
    module : StringExtend
    author : DylanYang
    time : 2020-10-27 20:46:56
    purpose : Is is used to expand the function of string.
]]

function string.getchar(s, index)
    return string.sub(s, index, index)
end

function string.split(str, delimiter)
    local result = {}
    if not (str == nil or str == '' or delimiter == nil) then
        for match in (str..delimiter):gmatch("(.-)"..delimiter) do
            table.insert(result, match)
        end
    end
    return result
end
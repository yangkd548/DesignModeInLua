--[[
    module:Properties
    author:DylanYang
    time:2021-02-09 22:19:27
]]
--This class is used to retrieve attributes and their values from text information.
local _M = Class("Properties")
local public = _M.public

_M.props = {}

function public:Load(fileReader)
    -- local str = fileReader.string
    local str = 
[[
hyuki@hyuki.com=Hiroshi Yuki
hanako@hyuki.com=Hanako Sato
tomura@hyuki.com=Tomura
mamoru@hyuki.com=Mamoru Takahashi
]]
    local members = string.split(str, "\n")
    for i, v in pairs(members) do
        local pairs = string.split(v, "=")
        if #pairs == 2 then
            self.props[pairs[1]] = pairs[2]
        end
    end
end

function public:GetProperty(key)
    return self.props[key]
end

return _M
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
    local str = fileReader.string
    --需要从str中解析出来属性，及其数值
    self.props["hyuki@hyuki.com"] = "Hiroshi Yuki"
    self.props["hanako@hyuki.com"] = "Hanako Sato"
    self.props["tomura@hyuki.com"] = "Tomura"
    self.props["mamoru@hyuki.com"] = "Mamoru Takahashi"
end

function public:GetProperty(key)
    return self.props[key]
end

return _M
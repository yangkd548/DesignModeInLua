--[[
    module:RealImage
    author:DylanYang
    time:2021-02-11 15:16:27
]]
local super = require("patterns.structural.proxy.Image")
local _M = Class("RealImage", super)
local public = _M.public

_M.fileName = nil

function _M:ctor(fileName)
    self.fileName = fileName
    self:LoadFromDisk()
end

function public:Display()
    print(string.format("Displaying : %s", self.fileName))
end

function _M:LoadFromDisk()
    print(string.format("Loading : %s", self.fileName))
end

return _M
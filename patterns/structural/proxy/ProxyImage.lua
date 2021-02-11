--[[
    module:ProxyImage
    author:DylanYang
    time:2021-02-11 15:20:55
]]
local RealImage = require("patterns.structural.proxy.RealImage")

local super = require("patterns.structural.proxy.Image")
local _M = Class("ProxyImage", super)
local public = _M.public

_M.realImage = nil
_M.fileName = nil

function _M:ctor(fileName)
    self.fileName = fileName
end

function public:Display()
    if self.realImage == nil then
        self.realImage = RealImage.new(self.fileName)
    end
    self.realImage:Display()
end

return _M
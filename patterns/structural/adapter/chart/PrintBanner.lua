--[[
    module:PrintBanner
    author:DylanYang
    time:2021-02-09 10:26:32
]]
local Banner = require("patterns.structural.adapter.chart.Banner")

local super = require("patterns.structural.adapter.chart.Print")
local _M = Class("PrintBanner", super)

_M.banner = nil

function _M:ctor(str)
    self.banner = Banner.new(str)
end

function _M.public:PrintWeak()
    self.banner:ShowWithParen()
end

function _M.public:PrintStrong()
    self.banner:ShowWithAstar()
end

return _M
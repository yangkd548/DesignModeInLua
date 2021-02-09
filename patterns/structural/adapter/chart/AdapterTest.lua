--[[
    module:AdapterTest
    author:DylanYang
    time:2021-02-09 10:18:05
]]
local PrintBanner = require("patterns.structural.adapter.chart.PrintBanner")

local super = require("patterns.BaseTest")
local _M = Class("AdapterTest", super)

function _M.protected:DoExecTest()
    --Generate an instance of the proxy.
    local printer = PrintBanner.new("Hello")
    --Then, the proxy's method is executed. The proxy invokes the specified method of an existing module.
    printer:PrintWeak()
    printer:PrintStrong()
end

return _M
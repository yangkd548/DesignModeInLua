--[[
    module:ProxyTest
    author:DylanYang
    time:2021-02-11 01:08:05
]]
local ProxyImage = require("patterns.structural.proxy.ProxyImage")

local super = require("patterns.BaseTest")
local _M = Class("ProxyTest", super)
local public = _M.public

function _M.protected:DoExecTest()
    local image = ProxyImage.new("test_10mb.jpg")
    image:Display() 
    print("")
    image:Display()
end

return _M
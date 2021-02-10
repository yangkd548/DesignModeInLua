--[[
    module:ProxyTest
    author:DylanYang
    time:2021-02-11 01:08:05
]]
local super = require("patterns.BaseTest")
local _M = Class("ProxyTest", super)
local public = _M.public

function _M.protected:DoExecTest()
    print("-----准备开发“代理模式Proxy”")
end

return _M
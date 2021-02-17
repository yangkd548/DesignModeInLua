--[[
    module:MediatorTest
    author:DylanYang
    time:2021-02-18 01:39:56
]]
local super = require("patterns.BaseTest")
local _M = Class("MediatorTest", super)

function _M.protected:DoExecTest()
    print("准备开发 Mediator模式")
end

return _M
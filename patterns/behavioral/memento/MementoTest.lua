--[[
    module:MementoTest
    author:DylanYang
    time:2021-02-18 01:46:09
]]
local super = require("patterns.BaseTest")
local _M = Class("MementoTest", super)

function _M.protected:DoExecTest()
    print("准备开发 Memento 模式")
end

return _M
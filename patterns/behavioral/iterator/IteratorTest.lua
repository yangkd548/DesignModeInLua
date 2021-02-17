--[[
    module:IteratorTest
    author:DylanYang
    time:2021-02-18 01:33:59
]]
local super = require("patterns.BaseTest")
local _M = Class("IteratorTest", super)

function _M.protected:DoExecTest()
    print("准备开发 Iterator 模式")
end

return _M
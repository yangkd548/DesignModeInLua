--[[
    module:FacadeTest
    author:DylanYang
    time:2021-02-09 18:29:47
]]
local super = require("patterns.BaseTest")
local _M = Class("FacadeTest", super)

function _M.protected:DoExecTest()
    print("准备开发 Facade Pattern!")
end

return _M
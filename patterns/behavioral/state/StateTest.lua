--[[
    module:  StateTest
    author:  DylanYang
    time:    2021-02-23 01:10:45
	idea:    
	advance: 
]]
local super = require("patterns.BaseTest")
local _M = Class("StateTest", super)

function _M.protected:DoExecTest()
    print("准备 开发 State状态模式！")
end

return _M
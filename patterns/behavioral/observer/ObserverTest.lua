--[[
    module:  ObserverTest
    author:  DylanYang
    time:    2021-02-21 21:09:42
	idea:    
	advance: 
]]
local super = require("patterns.BaseTest")
local _M = Class("ObserverTest", super)

function _M.protected:DoExecTest()
    printl("Hello")
    printlt("xiao mi!")
    printl()
    printl("xiao hong!-1")
    -- printl("xiao hong!-2")
    -- printl("xiao hong!-3")
    -- printl("xiao hong!-4")
    printlt("This way please!")
    printlb()
    printl("zhang qiao!")
    printlb()
    printlb("Byebye!")
end

return _M
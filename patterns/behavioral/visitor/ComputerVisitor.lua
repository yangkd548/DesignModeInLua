--[[
    module:  ComputerVisitor
    author:  DylanYang
    time:    2021-02-24 24:50:40
	idea:    
	advance: 
]]
local interface = require("patterns.behavioral.visitor.IVisitor")
local _M = Class("ComputerVisitor", interface)
local public = _M.public

function public:Visit(element)
    printl(string.format("Displaying : %s.", element.name))
end

return _M
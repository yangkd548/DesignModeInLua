--[[
    module:  GraphObserver
    author:  DylanYang
    time:    2021-02-21 23:28:07
	idea:    
	advance: 
]]
local interface = require("patterns.behavioral.observer.IObserver")
local _M = Class("GraphObserver", interface)
local public = _M.public

function public:Update(generator)
    printl("GraphObserver:")
    local count = generator.number
    local str = ""
    for i = 1, count do
        str = str .. "*"
    end
    printlt(str.."\n")
    printlb()
end

return _M
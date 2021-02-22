--[[
    module:  DigitObserver
    author:  DylanYang
    time:    2021-02-21 23:24:41
	idea:
	advance:
]]
local interface = require("patterns.behavioral.observer.IObserver")
local _M = Class("DigitObserver", interface)
local public = _M.public

function public:Update(generator)
    printl("DigitObserver:"..generator.number)
end

return _M
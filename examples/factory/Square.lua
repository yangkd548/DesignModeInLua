--[[
    module:Square
    author:DylanYang
    time:2021-01-26 19:22:09
]]
local interface = require("examples.factory.Shape")
local _M = Class("Square", interface)
local public = _M.public

function public:Draw()
    print(string.format("Factory Test: I'm a %s !", "Square（正方形）"))
end

return _M
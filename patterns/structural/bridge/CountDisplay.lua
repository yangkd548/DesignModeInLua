--[[
    module:CountDisplay
    author:DylanYang
    time:2021-02-09 11:19:56
]]
local super = require("patterns.structural.bridge.Display")
local _M = Class("CountDisplay", super)

function _M.public:MultiDisplay(times)
    self:Open()
    for i = 1, times do
        self:Print(i)
    end
    self:Close()
end

return _M
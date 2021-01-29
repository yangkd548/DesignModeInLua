--[[
    module:Red
    author:DylanYang
    time:2021-01-28 14:55:41
]]
local _M = Class("Red")

function _M.public:Fill()
    print(string.format("Abstract Factory Test: I'm a %s !", self.__name, "（红色）"))
end

return _M
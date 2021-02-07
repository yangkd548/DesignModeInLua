--[[
    module:Blue
    author:DylanYang
    time:2021-01-28 14:59:20
]]
local _M = Class("Blue")

function _M.public:Fill()
    print(string.format("Abstract Factory Test: I'm a %s%s !", self.__name, "（蓝色）"))
end

return _M
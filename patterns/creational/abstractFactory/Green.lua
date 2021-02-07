--[[
    module:Green
    author:DylanYang
    time:2021-01-28 14:58:25
]]
local _M = Class("Green")

function _M.public:Fill()
    print(string.format("Abstract Factory Test: I'm a %s%s !", self.__name, "（绿色）"))
end

return _M
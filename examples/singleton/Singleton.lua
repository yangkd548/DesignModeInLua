--[[
    module:Singleton
    author:DylanYang
    time:2021-01-26 14:56:16
]]
--https://www.runoob.com/design-pattern/singleton-pattern.html
local _M = Class("Singleton")

local _instance = nil;
function _M.static.get:instance()
    if _instance == nil then
        _instance = _M.new()
    end
    return _instance
end

--需要OOP支持ctor设为private后，禁止OOP直接调用
-- function _M.private.ctor()
-- end

function _M.public:ShowMessage()
    print("Singleton Test: Hello World !");
end

return _M
--[[
    module:SingletonTest
    author:DylanYang
    time:2021-01-26 15:39:42
]]
local Singleton = require("examples.singleton.Singleton")

local _M = Class("SingletonTest")

function _M.public:ExecTest()
    Singleton.instance:ShowMessage()
end

return _M
--[[
    Module:SingletonTest
    Author:DylanYang
    Time:2021-01-26 15:39:42
]]
local Singleton = require("patterns.creational.singleton.Singleton")

local super = require("patterns.BaseTest")
local _M = Class("SingletonTest", super)

function _M.protected:DoExecTest()
    Singleton.instance:ShowMessage()
end

return _M
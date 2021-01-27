--[[
    Module:Main
    Author:DylanYang
    Time:2020-11-09 16:20:12
]]
require("oop.BaseExtend")
require("oop.TableExtend")
require("oop.StringExtend")
require("oop.Class")
Limit_G()

require("examples.singleton.SingletonTest").new():ExecTest()
require("examples.factory.FactoryTest").new():ExecTest()
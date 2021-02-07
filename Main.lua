--[[
    Module:Main
    Author:DylanYang
    Time:2020-11-09 16:20:12
]]
require("framework.ImportFrame")

require("patterns.creational.singleton.SingletonTest").new():ExecTest()
require("patterns.creational.factory.FactoryTest").new():ExecTest()
require("patterns.creational.abstractFactory.AbstractFactoryTest").new():ExecTest()
require("patterns.creational.builder.BuilderTest").new():ExecTest()
require("patterns.creational.prototype.PrototypeTest").new():ExecTest()
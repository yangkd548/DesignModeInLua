--[[
    Module:Main
    Author:DylanYang
    Time:2020-11-09 16:20:12
]]
require("framework.ImportFrame")
print(string.format("The current lua version is %s .", _VERSION))

-- require("patterns.creational.singleton.SingletonTest").new():ExecTest()
-- require("patterns.creational.factory.FactoryTest").new():ExecTest()
-- require("patterns.creational.abstractFactory.AbstractFactoryTest").new():ExecTest()
-- require("patterns.creational.builder.BuilderTest").new():ExecTest()
-- require("patterns.creational.prototype.PrototypeTest").new():ExecTest()

-- require("patterns.structural.adapter.cainiao.AdapterTest").new():ExecTest()
-- require("patterns.structural.adapter.chart.AdapterTest").new():ExecTest()
-- require("patterns.structural.bridge.BridgeTest").new():ExecTest()
-- require("patterns.structural.filter.FilterTest").new():ExecTest()
-- require("patterns.structural.composite.CompositeTest").new():ExecTest()
-- require("patterns.structural.decorator.DecoratorTest").new():ExecTest()
-- require("patterns.structural.facade.FacadeTest").new():ExecTest()
-- require("patterns.structural.flyweight.FlyweightTest").new():ExecTest()
require("patterns.structural.proxy.ProxyTest").new():ExecTest()

require("patterns.behavioral.chainOfResponsibility.ChainOfResponsibilityTest").new():ExecTest()

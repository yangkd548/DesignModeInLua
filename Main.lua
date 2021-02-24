--[[
    Module:Main
    Author:DylanYang
    Time:2021-01-26 16:20:12
]]
print(string.format("The current lua version is %s .", _VERSION))

require("framework.ImportFrame")

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
-- require("patterns.structural.proxy.ProxyTest").new():ExecTest()

-- require("patterns.behavioral.chainOfResponsibility.ChainOfResponsibilityTest").new():ExecTest()
-- require("patterns.behavioral.command.CommandTest").new():ExecTest()
-- require("patterns.behavioral.interpreter.InterPreterTest").new():ExecTest()
-- require("patterns.behavioral.iterator.IteratorTest").new():ExecTest()
-- require("patterns.behavioral.mediator.MediatorTest").new():ExecTest()
-- require("patterns.behavioral.memento.MementoTest").new():ExecTest()
-- require("patterns.behavioral.observer.ObserverTest").new():ExecTest()
-- require("patterns.behavioral.state.StateTest").new():ExecTest()
-- require("patterns.behavioral.nullObject.NullObjectTest").new():ExecTest()
-- require("patterns.behavioral.strategy.StrategyTest").new():ExecTest()
-- require("patterns.behavioral.template.TemplateTest").new():ExecTest()
-- require("patterns.behavioral.visitor.VisitorTest").new():ExecTest()

-- require("patterns.j2ee.mvc.MvcTest").new():ExecTest()
require("patterns.j2ee.businessDelegate.BusinessDelegateTest").new():ExecTest()
-- require("patterns.j2ee.compositeEntity.CompositeEntityTest").new():ExecTest()
-- require("patterns.j2ee.dataAccessObject.DataAccessObjectTest").new():ExecTest()
-- require("patterns.j2ee.frontController.FrontControllerTest").new():ExecTest()
-- require("patterns.j2ee.interceptingFilter.InterceptingFilterTest").new():ExecTest()
-- require("patterns.j2ee.serverLocator.ServerLocatorTest").new():ExecTest()
-- require("patterns.j2ee.transferObject.TransferObjectTest").new():ExecTest()
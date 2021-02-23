--[[
    module:  TemplateTest
    author:  DylanYang
    time:    2021-02-23 23:35:48
	idea:    
	advance: 
]]
local CharDisplay = require("patterns.behavioral.template.CharDisplay")
local StringDisplay = require("patterns.behavioral.template.StringDisplay")

local super = require("patterns.BaseTest")
local _M = Class("TemplateTest", super)

function _M.protected:DoExecTest()
    -- 生成一个持有'H'的CharDisplay类的实例 
    local d1 = CharDisplay.new('H')
    -- 生成一个持有"Hello, world."的StringDisplay类的实例 
    local d2 = StringDisplay.new("Hello, world.")
    -- 生成一个持有"你好，世界。"的StringDisplay类的实例 
    local d3 = StringDisplay.new("你好，世界。")
    -- 由于d1、d2和d3都是AbstractDisplay类的子类
    d1:Display()
    -- 可以调用继承的display方法
    d2:Display()
    d3:Display()
end

return _M
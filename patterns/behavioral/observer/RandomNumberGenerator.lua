--[[
    module:  RandomNumberGenerator
    author:  DylanYang
    time:    2021-02-21 23:30:18
	idea:    
	advance: 
]]
local super = require("patterns.behavioral.observer.BaseGenerator")
local _M = Class("RandomNumberGenerator", super)
local public = _M.public


_M._number = nil

function public.get:number()
    return self._number
end

function public:Execute()
    print("开始 RandomNumber 测试：")
    printlt()
    for i= 1, 5 do
        self._number = random.nextInt(50)
        self:NotifyObservers()
    end
    printlb()
    print("结束 RandomNumber 测试---")
end

return _M
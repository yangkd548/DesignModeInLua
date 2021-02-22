--[[
    module:  NumberGenerator
    author:  DylanYang
    time:    2021-02-21 23:31:38
	idea:    
	advance: 
]]
local super = require("patterns.behavioral.observer.BaseGenerator")
local _M = Class("NumberGenerator", super)
local public = _M.public

_M._number = 0

function public.get:number()
    return self._number
end

function public:Execute()
    print("开始 Number 测试：")
    printlt()
    for i= 1, 5 do
        self._number = self._number + 1
        self:NotifyObservers()
    end
    printlb()
    print("结束 Number 测试---")
end

return _M
--[[
    module:  Hand
    author:  DylanYang
    time:    2021-02-23 18:08:05
	idea:    
	advance: 
]]
local Hands = require("patterns.behavioral.strategy.Hands")

local _M = Class("Hand")
local public = _M.public

-- 表示猜拳中出的手势的值
_M.value = nil                      

function _M:ctor(value)
    self.value = value
end

-- 如果this胜了h则返回true
function public:IsStrongerThan(hand)
    return self:Fight(hand) == 1
end

-- 如果this输给了h则返回true
function public:IsWeakerThan(hand)
    return self:Fight(hand) == -1
end

-- 计分：平0, 胜1, 负-1
function public:Fight(hand)
    if self == h then
        return 0
    else 
        if (self.value + 1) % 3 == hand.value then
            return 1
        else
            return -1
        end
    end
end

-- 转换为手势值所对应的字符串
function public:ToString()
    return Hands.names[self.value]
end

return _M
--[[
    module:  Hands
    author:  DylanYang
    time:    2021-02-23 21:17:16
	idea:    
	advance: 
]]
local Hand = require("patterns.behavioral.strategy.Hand")

local _M = Class("Hands")
local static = _M.static

-- 表示猜拳中3种手势的实例
static.readonly.hands = {
    Hand.new(0),
    Hand.new(1),
    Hand.new(2),
}

-- 表示猜拳中手势所对应的字符串
static.readonly.names = {
    "石头", "剪刀", "布",
}

-- 根据手势的值获取其对应的实例
function static.public:GetHand(value)
    return self.hands[value]
end

return _M
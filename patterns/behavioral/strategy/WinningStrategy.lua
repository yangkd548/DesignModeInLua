--[[
    module:  WinningStrategy
    author:  DylanYang
    time:    2021-02-23 18:06:09
	idea:    
	advance: 
]]
local Hand = require("patterns.behavioral.strategy.Hand")
local Hands = require("patterns.behavioral.strategy.Hands")

local _M = Class("WinningStrategy")
local public = _M.public

_M.won = false
_M.prevHand = nil

function _M:ctor(seed)
    math.random(seed)
end

function public.get:nextHand()
    if not self.won then
        self.prevHand = Hands:GetHand(random.nextInt(3))
    end
    return self.prevHand
end

function public:Study(win)
    self.won = win
end

return _M
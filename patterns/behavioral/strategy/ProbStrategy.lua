--[[
    module:  ProbStrategy
    author:  DylanYang
    time:    2021-02-23 18:06:22
	idea:    
	advance: 
]]
local Hands = require("patterns.behavioral.strategy.Hands")

local _M = Class("ProbStrategy")
local public = _M.public

_M.preValue = 1
_M.curValue = 1
_M.history = {
    { 1, 1, 1, },
    { 1, 1, 1, },
    { 1, 1, 1, },
}

function _M:ctor(seed)
    math.randomseed(seed)
end

function public.get:nextHand()
    local bet = random.nextInt(self:GetSum(self.curValue))
    local curHis = self.history[self.curValue]
    local value
    if bet < curHis[1] then
        value = 1
    elseif bet < curHis[2] + curHis[3] then
        value = 2
    else
        value = 3
    end
    self.preValue = self.curValue
    self.curValue = value
    return Hands:GetHand(value)
end

function _M:GetSum(hv)
    local sum = 0
    for  i = 1, 3 do
        sum = sum + self.history[hv][i]
    end
    return sum
end

function public:Study(win)
    local pHis = self.history[self.preValue]
    if win then
        pHis[self.curValue] = pHis[self.curValue] + 1
    else
        local a = (self.curValue + 1) % 3 + 1
        local b = (self.curValue + 2) % 3 + 1
        pHis[a] = pHis[a] + 1
        pHis[b] = pHis[b] + 1
    end
    -- for i, v in ipairs(self.history) do
    --     print(string.format("[%s]", i), v[1], v[2], v[3])
    -- end
end

return _M
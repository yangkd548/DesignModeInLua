--[[
    module:  Player
    author:  DylanYang
    time:    2021-02-23 18:07:45
	idea:    
	advance: 
]]
local _M = Class("Player")
local public = _M.public

_M.name = nil
_M.strategy = nil
_M.wincount = 0
_M.losecount = 0
_M.gamecount = 0

-- 赋予姓名和策略
function _M:ctor(name, strategy)
    self.name = name
    self.strategy = strategy
end

-- 策略决定下一局要出的手势
function public.get:nextHand()
    return self.strategy.nextHand
end

-- 胜
function public:Win(i)
    self.strategy:Study(true)
    self.wincount = self.wincount + 1
    self.gamecount = self.gamecount + 1
    print(i, string.format("Winer: %s (%s)", self.name, self.wincount))
end

-- 负
function public:Lose()
    self.strategy:Study(false)
    self.losecount = self.losecount + 1
    self.gamecount = self.gamecount + 1
end

-- 平
function public:Even()
    self.gamecount = self.gamecount + 1
end

function public:ToString()
    return string.format("[%s: games: %s, win: %s, lose: %s]", self.name, self.gamecount, self.wincount, self.losecount)
end

return _M
--[[
    module:  StrategyTest
    author:  DylanYang
    time:    2021-02-23 16:58:02
	idea:    
	advance: 
]]
local Player = require("patterns.behavioral.strategy.Player")
local WinningStrategy = require("patterns.behavioral.strategy.WinningStrategy")
local ProbStrategy = require("patterns.behavioral.strategy.ProbStrategy")

local super = require("patterns.BaseTest")
local _M = Class("StrategyTest", super)

function _M.protected:DoExecTest()
    local player1 = Player.new("Tariabs-", WinningStrategy.new(random.nextInt(100, 200)))
    local player2 = Player.new("Hana", ProbStrategy.new(random.nextInt(100)))
    for i = 1, 10 do
        local nextHand1 = player1.nextHand
        local nextHand2 = player2.nextHand
        if nextHand1:IsStrongerThan(nextHand2) then
            player1:Win(i)
            player2:Lose()
        elseif nextHand2:IsStrongerThan(nextHand1) then
            player1:Lose()
            player2:Win(i)
        else
            print(i, "Even...")
            player1:Even()
            player2:Even()
        end
    end
    print("Total result:")
    printlt(player1)
    printl(player2)
end

return _M
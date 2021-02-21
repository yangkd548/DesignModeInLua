--[[
    module:MementoTest
    author:DylanYang
    time:2021-02-18 01:46:09
]]
local Originator = require("patterns.behavioral.memento.Originator")

local super = require("patterns.BaseTest")
local _M = Class("MementoTest", super)

function _M.protected:DoExecTest()
    --“状态”，可以用于快速恢复；Memento序列，可以支持“连续恢复Undo”和“连续撤销恢复Redo”，还需要有一个Memento序列的指针索引
    --“操作序列”，可以用于“从头再播放”到“指定位置”（帧同步，记录“操作序列”，也是为了播放和重播）
    --倒序播放，需要有2方面支持：1、“操作动画”支持倒序播放；2、“状态序列”可以作为Undo的回退目标（避免了开发回退操作的逻辑处理，避免强耦合！）
    local originator = Originator.new(100)         -- 最初的所持金钱数为100
    local memento = originator:CreateMemento(0)    -- 保存最初的状态
    for i = 1, 100 do
        local betInfo = originator:Bet(i)    -- 进行游戏 
        if betInfo then
            print("==== ", i, betInfo)        -- 显示掷骰子的次数
            printlt(string.format("操作后，状态:\n%s", originator))    -- 显示主人公现在的状态
            --只有钱变多的时候，才留存档；这样钱会越来越多
            if originator.money > memento.money then
                memento = originator:CreateMemento(i)
                print("立即存档：\n\t金钱 增加 许多")
            elseif originator.money < memento.money / 2 then
                -- originator:RestoreLast()
                --随机恢复，尝试在回退后，添加新存档时，删除可恢复的存档
                originator:RestoreRandom()
                print(string.format("恢复存档：（金钱 降到 存档的 ½ 下\t\t\t\t\t====\t%s)", originator.index))
                print(originator)
            end
            -- 等待一段时间
            --@TODO 实现Lua的协同功能
            -- try then
            --     Thread.sleep(1000)
            -- end catch (InterruptedException e) then
            -- end
            print("")
        end
    end
end

return _M
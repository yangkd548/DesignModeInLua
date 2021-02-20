--[[
    module:MementoTest
    author:DylanYang
    time:2021-02-18 01:46:09
]]
local Originator = require("patterns.behavioral.memento.Originator")

local super = require("patterns.BaseTest")
local _M = Class("MementoTest", super)

function _M.protected:DoExecTest()
    print("准备开发 Memento 模式")
    --“状态”，可以用于快速恢复；Memento序列，可以支持“连续恢复Undo”和“连续撤销恢复Redo”，还需要有一个Memento序列的指针索引
    --“操作序列”，可以用于“从头再播放”到“指定位置”（帧同步，记录“操作序列”，也是为了播放和重播）
    --倒序播放，需要有2方面支持：1、“操作动画”支持倒序播放；2、“状态序列”可以作为Undo的回退目标（避免了开发回退操作的逻辑处理，避免强耦合！）

    local originator = Originator.new(100)         -- 最初的所持金钱数为100
    local memento = originator:CreateMemento()    -- 保存最初的状态
    for i = 1, 100 do
        print("==== ",i)        -- 显示掷骰子的次数
        print(string.format("当前状态: %s", originator:ToString()))    -- 显示主人公现在的状态
        originator:Bet()    -- 进行游戏 
        print(string.format("所持金钱为 %s 元。", originator.money))
        -- 决定如何处理Memento
        if originator.money > memento.money then
            print("\t（所持金钱增加了许多，因此保存游戏当前的状态）")
            memento = originator:CreateMemento()
        elseif originator.money < memento.money / 2 then
            print("\t（所持金钱减少了许多，因此将游戏恢复至以前的状态）")
            originator:RestoreLast()
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

return _M
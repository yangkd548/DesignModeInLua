--[[
    module:MementoTest
    author:DylanYang
    time:2021-02-18 01:46:09
]]
local super = require("patterns.BaseTest")
local _M = Class("MementoTest", super)

function _M.protected:DoExecTest()
    print("准备开发 Memento 模式")
    --“状态”，可以用于快速恢复；Memento序列，可以支持“连续恢复Undo”和“连续撤销恢复Redo”，还需要有一个Memento序列的指针索引
    --“操作序列”，可以用于“从头再播放”到“指定位置”（帧同步，记录“操作序列”，也是为了播放和重播）
    --倒序播放，需要有2方面支持：1、“操作动画”支持倒序播放；2、“状态序列”可以作为Undo的回退目标（避免了开发回退操作的逻辑处理，避免强耦合！）
end

return _M
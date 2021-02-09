--[[
    module:AdapterTest
    author:DylanYang
    time:2021-02-07 16:29:46
]]
local AudioPlayer = require("patterns.structural.adapter.cainiao.AudioPlayer")

local super = require("patterns.BaseTest")
local _M = Class("AdapterTest", super)

function _M.protected:DoExecTest()
    local audioPlayer = AudioPlayer.new()

    audioPlayer:Play("mp3", "beyond the horizon.mp3")
    audioPlayer:Play("mp4", "alone.mp4")
    audioPlayer:Play("vlc", "far far away.vlc")
    audioPlayer:Play("avi", "mind me.avi")
end

return _M
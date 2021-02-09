--[[
    module:MediaAdapter
    author:DylanYang
    time:2021-02-07 17:11:40
]]
local VlcPlayer = require("patterns.structural.adapter.cainiao.VlcPlayer")
local Mp4Player = require("patterns.structural.adapter.cainiao.Mp4Player")

local super = require("patterns.structural.adapter.cainiao.MediaPlayer")
local _M = Class("MediaAdapter", super)
local public = _M.public

_M.vlcPlayer = nil
_M.mp4Player = nil

function _M:ctor()
    --如果体验可以接受的话，下面的代码，可以屏蔽掉，在首次播放的时候，载入相应的播放器
    -- self.vlcPlayer = VlcPlayer.new()
    -- self.mp4Player = Mp4Player.new()
end

function _M.public:Play(audioType, fileName)
    audioType = string.lower(audioType)
    if audioType == "vlc" then
        if self.vlcPlayer == nil then
            self.vlcPlayer = VlcPlayer.new()
        end
        self.vlcPlayer:PlayVlc(fileName)
    elseif audioType == "mp4" then
        if self.mp4Player == nil then
            self.mp4Player = Mp4Player.new()
        end
        self.mp4Player:PlayMp4(fileName)
    end
end

return _M
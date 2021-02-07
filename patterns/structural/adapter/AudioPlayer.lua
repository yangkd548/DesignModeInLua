--[[
    module:AudioPlayer
    author:DylanYang
    time:2021-02-07 17:45:08
]]
local MediaAdapter = require("patterns.structural.adapter.MediaAdapter")

local super = require("patterns.structural.adapter.MediaPlayer")
local _M = Class("AudioPlayer", super)

_M.mediaAdapter = nil

function _M:ctor()
    --如果体验可以接受的话，下面的代码，可以屏蔽掉，在首次播放的时候，载入相应的播放器
    -- self.mediaAdapter = MediaAdapter.new()
end

function _M.public:Play(audioType, fileName)
    audioType = string.lower(audioType)
    if audioType == "mp3" then
        print(string.format("Playing %s file by built-in player. \n\t Name:%s", audioType, fileName))
    elseif audioType == "vlc" or audioType == "mp4" then
        if self.mediaAdapter == nil then
            self.mediaAdapter = MediaAdapter.new()
        end
        self.mediaAdapter:Play(audioType, fileName)
    else
        print(string.format("Invalid media. \n\t '%s' format not supported !", audioType))
    end
end

return _M
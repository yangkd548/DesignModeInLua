--[[
    module:PrimaryColor
    author:DylanYang
    time:2021-02-18 16:20:34
]]
local Obj = require("framework.config.ColorObj")

local tbl = {
    white = Obj.new(0xff, 0xff, 0xff),
    red = Obj.new(0xff, 0x00, 0x00),
    blue = Obj.new(0x00, 0x00, 0xff),
    green = Obj.new(0x00, 0xff, 0x00),

    lightGray = Obj.new(0xd3, 0xd3, 0xd3)
}

Color = Readonly(tbl)
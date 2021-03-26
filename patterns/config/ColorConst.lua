--[[
    module: ColorConst
    author: DylanYang
    time:   2021-03-26 17:07:07
    idea:   Sets the usual colors that current project needs
]]
local _M = Class("ColorConst")
_M.singleton = true
local const = _M.public.static.readonly
local static = _M.public.static

--The following common colors can be customized according to the characteristics of the project.
--For example, the white of the current project may not be pure white.
const.White = _M.new(0xff, 0xff, 0xff)
const.Red = _M.new(0xff, 0x00, 0x00)
const.Blue = _M.new(0x00, 0x00, 0xff)
const.Green = _M.new(0x00, 0xff, 0x00)
const.LightGray = _M.new(0xd3, 0xd3, 0xd3)

return _M
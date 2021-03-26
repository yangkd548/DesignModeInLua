--[[
    module:Color
    author:DylanYang
    time:2021-02-18 16:26:05
]]
local _M = Class("Color")

_M.public.r = nil
_M.public.g = nil
_M.public.b = nil

function _M:ctor(r, g, b)
    self.r = r or 0
    self.g = g or 0
    self.b = b or 0
end

function static:ToString()
    return string.format("Color(r: %s, g: %s, b: %s)", self.r, self.g, self.b)
end

--Converts the value of the color channel to the range 0-1
function static:DecimalColor(c)
    return c.r / 255, c.g / 255, c.b / 255
end

function static:GetHexadecimal(c)
    local cps = {"r", "g", "b"}
    local cstr = ""
    for i = 1, #cps do
        cstr = cstr..string.format("%0x", c[cps[i]])
    end
    return cstr
end

function static:GetColorByType(c, t)
    if t == 1 then
        return self:GetHexadecimal(c)
    elseif t == 2 then
        return string.format("<color=#%s>%s</color>", self:GetHexadecimal(c), "%s")
    end
    return c
end

return _M
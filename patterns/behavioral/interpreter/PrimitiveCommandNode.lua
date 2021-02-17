--[[
    module:PrimitiveCommandNode
    author:DylanYang
    time:2021-02-12 21:43:55
]]
local _M = Class("PrimitiveCommandNode")
local public = _M.public

_M.name = nil

function public:Parse(context)
    self.name = context.curToken
    if not self.name == "go" and not self.name == "right" and not self.name == "left" then
        ParseException(string.format("%s is undefined.", self.name))
    end
    --In the case of a formal procedure, this would be the location where the actual original operation was performed.s
    context:SkipToken(self.name)
end

function public:ToString()
    return self.name
end

return _M
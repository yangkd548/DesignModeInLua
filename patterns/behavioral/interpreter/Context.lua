--[[
    module:Context
    author:DylanYang
    time:2021-02-12 21:43:26
]]
local StringTokenizer = require("framework.string.StringTokenizer")

local _M = Class("Context")
local public = _M.public

_M.tokenizer = nil
_M._curToken = nil

function _M:ctor(text)
    self.tokenizer = StringTokenizer.new(text)
    self:NextToken()
end

function public:NextToken()
    self._curToken = self.tokenizer:NextToken()
    return self._curToken
end

function public.get:curToken()
    return self._curToken
end

function public:SkipToken(token)
    --token需要字符串，转换成固定大小写
    if token ~= self._curToken then
        error(string.format("Warning: %s is expected, but %s is found.", token, self._curToken))
    end
    self:NextToken()
end

function public.get:curNumber()
    local int = math.floor(self._curToken)
    if type(int) == "number" then
        error("The cur token is NaN!")
    end
    return int
end

return _M
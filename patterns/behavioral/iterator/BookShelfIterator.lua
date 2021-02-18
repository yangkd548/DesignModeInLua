--[[
    module:BookShelfIterator
    author:DylanYang
    time:2021-02-18 09:55:41
]]
local _M = Class("BookShelfIterator")
local public = _M.public

_M.bookShelf = nil
_M.index = nil

function _M:ctor(bookShelf)
    self.bookShelf = bookShelf
    self.index = 0
end

function public.get:hasNext()
    return self.index < self.bookShelf.length
end

function public.get:next()
    self.index  = self.index + 1
    return self.bookShelf:GetBookAt(self.index)
end

return _M
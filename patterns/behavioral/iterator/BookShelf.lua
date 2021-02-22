--[[
    module:BookShelf
    author:DylanYang
    time:2021-02-18 10:02:55
]]
local CommonItetator = require("patterns.behavioral.iterator.CommonItetator")
local Book = require("patterns.behavioral.iterator.Book")

local super = require("patterns.behavioral.iterator.Aggregate")
local _M = Class("BookShelf", super)
local public = _M.public

_M.books = {}
_M.last = 0
_M.maxsize = nil
_M._iterator = nil

function _M:ctor(maxsize)
    self.maxsize = maxsize
end

function public:GetAt(index)
    return self.books[index]
end

function public.get:length()
    return self.last
end

function public.get:isFull()
    return self.length == self.maxsize
end

function public:AppendBook(book)
    if self.isFull then
        error("Unable to add over maximum capacity. Please check that it 'isFull' before adding it.")
    end
    self.last = self.last + 1
    self.books[self.last] = book
end

function public.get:iterator()
    return CommonItetator.new(self)
end

return _M
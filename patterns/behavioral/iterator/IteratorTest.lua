--[[
    module:IteratorTest
    author:DylanYang
    time:2021-02-18 01:33:59
]]
local BookShelf = require("patterns.behavioral.iterator.BookShelf")
local Book = require("patterns.behavioral.iterator.Book")

local super = require("patterns.BaseTest")
local _M = Class("IteratorTest", super)

function _M.protected:DoExecTest()
    local bookShelf = BookShelf.new(4);
    local bookNames = {
        "Around the World in 80 Days",
        "Bible",
        "Cinderella",
        "Daddy-Long-Legs"
    }
    for i, name in ipairs(bookNames) do
        if not bookShelf.isFull then
            --Let's create a Book, now we just give it a name. If you have more information, there will be more queries.
            bookShelf:AppendBook(Book.new(name))
        end
    end
    local it = bookShelf.iterator
    while it.hasNext do
        local book = it.next
        print(book.name)
    end
end

return _M
--[[
    module:PageMaker
    author:DylanYang
    time:2021-02-09 21:42:39
]]
local Database = require("patterns.structural.facade.Database")
local HtmlWriter = require("patterns.structural.facade.HtmlWriter")
local FileWriter = require("framework.io.FileWriter")

local _M = Class("PageMaker")

--Prevent external instances of PageMaker from being created, so declare it as a private method.
function _M.private:ctor()
end

function _M.static.public:MakeWelcomePage(mailaddr, filename)
    local mailprop = Database:GetProperties("maildata")
    local username = mailprop:GetProperty(mailaddr)
    local path = string.format("%s/%s", os.GetCurDir(), filename)
    local writer = HtmlWriter.new(FileWriter.new(path))
    writer:SetTitle(string.format("Welcome to %s's page!", username))
    writer:AddParagraph(string.format("欢迎来到 %s 的主页。", username))
    writer:AddParagraph("等着你的邮件哦！")
    writer:SetMailto(mailaddr, username)
    writer:Close()
    print(string.format("%s is created for %s (%s)", filename, mailaddr, username))
end

return _M
--[[
    module:HtmlWriter
    author:DylanYang
    time:2021-02-09 21:33:04
]]
local _M = Class("HtmlWriter")
local public = _M.public

_M.writer = nil

function _M:ctor(writer)
    self.writer = writer
end

function public:SetTitle(title)
    self.writer:Write("<html>");
    self.writer:Write("<head>");
    self.writer:Write("<title>" + title + "</title>");
    self.writer:Write("</head>");
    self.writer:Write("<body>\n");
    self.writer:Write("<h1>" + title + "</h1>\n");
end

function public:AddParagraph(msg)
    self.writer:Write("<p>" + msg + "</p>\n");
end

function public:SetLink(href, caption)
    self:AddParagraph("<a href=\"" + href + "\">" + caption + "</a>")
end

function public:SetMailto(mailaddr, username)
    self:SetLink("mailto:" .. mailaddr, username);
end

function public:Close()
    self.writer:Write("</body>");
    self.writer:Write("</html>\n");
    self.writer:Close();
end

return _M
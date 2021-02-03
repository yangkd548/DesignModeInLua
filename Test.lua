local cls = {__type = "SSS", __metatable = "PPP"}
local inst = setmetatable({__type = "ASB"}, cls)
local cls2 = {}
rawset(cls, "__metatable", nil)
setmetatable(inst, cls2)
print(66666)
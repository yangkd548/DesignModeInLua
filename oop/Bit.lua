--[[
    module:Bit
    author:DylanYang
    time:2020-10-28 09:00:01
]]
require("oop.Readonly")

local Bit = {data32 = {}}
for i = 1, 32 do
    Bit.data32[i] = 2 ^ (32 - i)
end

--十进制转二进制字符串
function Bit:NumToBitStr(int, valid, trace)
    local result = self:ToString(self:NumToBitArr(int), valid)
    if trace then
        print(string.format("Bit.NumToBitStr: %d-->%s", int, result))
    end
    return result
end

function string.getchar(s, index)
    return string.sub(s, index, index)
end

--二进制字符串转十进制
function Bit:BitStrToNum(s, trace)
    local n = tonumber(s)
    if n == nil then
        return nil
    end
    local pIndex = string.find(s, "/.")
    if pIndex then
        if pIndex == 1 then
            return 0
        else
            s = string.sub(s, 1, pIndex - 1)
        end
    end
    local bitArr = {}
    for i = 1, 32 do
        table.insert(bitArr, 1, tonumber(string.getchar(s, -i)) or 0)
    end
    local result = self:BitArrToNum(bitArr)
    if trace then
        print(string.format("Bit.BitStrToNum: %s-->%s", s, result))
    end
    return result
end

function Bit:NumToBitArr(int)
    local bitArr = {}
    for i = 1, 32 do
        if int >= self.data32[i] then
            bitArr[i] = 1
            int = int - self.data32[i]
        else
            bitArr[i] = 0
        end
    end
    return bitArr
end

function Bit:BitArrToNum(bitArr)
    local num = 0
    for i = 1, 32 do
        if bitArr[i] == 1 then
            num = num + 2 ^ (32 - i)
        end
    end
    return math.floor(num)
end

function Bit:Not(a)
    local op1 = self:NumToBitArr(a)
    local r = {}
    for i = 1, 32 do
        if op1[i] == 1 then
            r[i] = 0
        else
            r[i] = 1
        end
    end
    return self:BitArrToNum(r)
end

function Bit:And(a, b)
    local op1 = self:NumToBitArr(a)
    local op2 = self:NumToBitArr(b)
    local r = {}
    for i = 1, 32 do
        if op1[i] == 1 and op2[i] == 1 then
            r[i] = 1
        else
            r[i] = 0
        end
    end
    return self:BitArrToNum(r)
end

function Bit:Or(a, b)
    local op1 = self:NumToBitArr(a)
    local op2 = self:NumToBitArr(b)
    local r = {}
    for i = 1, 32 do
        if op1[i] == 1 or op2[i] == 1 then
            r[i] = 1
        else
            r[i] = 0
        end
    end
    return self:BitArrToNum(r)
end

function Bit:Xor(a, b)
    local op1 = self:NumToBitArr(a)
    local op2 = self:NumToBitArr(b)
    local r = {}
    for i = 1, 32 do
        if op1[i] == op2[i] then
            r[i] = 0
        else
            r[i] = 1
        end
    end
    return self:BitArrToNum(r)
end

function Bit:LeftShift(a, n)
    local op1 = self:NumToBitArr(a)
    local r = self:NumToBitArr(0)
    if n < 32 and n > 0 then
        for i = 1, n do
            for i = 1, 31 do
                op1[i] = op1[i + 1]
            end
            op1[32] = 0
        end
        r = op1
    end
    return self:BitArrToNum(r)
end

function Bit:RightShift(a, n)
    local op1 = self:NumToBitArr(a)
    local r = self:NumToBitArr(0)
    if n < 32 and n > 0 then
        for i = 1, n do
            for i = 31, 1, -1 do
                op1[i + 1] = op1[i]
            end
            op1[1] = 0
        end
        r = op1
    end
    return self:BitArrToNum(r)
end

function Bit:ToString(ta, valid)
    local str = ""
    local valided = not valid
    for i = 1, 32 do
        if valided or ta[i] ~= 0 then
            valided = true
            str = str .. ta[i]
        end
    end
    return str
end

function Bit:Print(ta, valid)
    print(Bit:ToString(ta, valid))
end

BitTool = Readonly(Bit)
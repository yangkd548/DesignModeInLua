require("framework.Bit")

print("二进制转换0：", Bit:NumToBitStr(3, true, true))
print("二进制转换1：", Bit:Or(0, 1))
print("二进制转换2：", Bit:Or(0, 2))
print("二进制转换3：", Bit:Or(1, 1))
print("二进制转换4：", Bit:Or(1, 2))
print("二进制转换5：", Bit:Or(2, 1))
print("二进制转换6：", Bit:Or(2, 2))
print("二进制转换7：", Bit:Or(3, 2))
print("二进制转换8：", Bit:Or(3, 1))

print("")

print("二进制‘与运算’0：", Bit:And(0, 1))
print("二进制‘与运算’1：", Bit:And(0, 2))
print("二进制‘与运算’2：", Bit:And(1, 1))
print("二进制‘与运算’3：", Bit:And(1, 2))
print("二进制‘与运算’4：", Bit:And(2, 1))
print("二进制‘与运算’5：", Bit:And(2, 2))
print("二进制‘与运算’6：", Bit:And(3, 2))
print("二进制‘与运算’7：", Bit:And(3, 1))

local tests = {}
tostring(tests)
local str = tostring(tests)
print(str)

require("framework.StringExtend")

local ss = string.split("6666666", "\n")
print(#ss, ss)
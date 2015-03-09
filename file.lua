-- 读取文件
--[[
dofile("./data.txt")
print(HERO)
print(cha[1].basic.Name)
--]]


dofile("./data.txt")	-- 操作文件
-- 修改数据，然后保存文件
function SaveTableContent(file, obj, t)		-- obj:修改的内容		t:判断是写的左边还是右边，出现｛｝，一定会读为右边，可设为nil

	local szType = type(obj)

	if szType == "number" then
		if t == "key" then
			file:write("[")
			file:write(obj);
			file:write("]")
		else
			file:write(obj)
		end

	elseif szType == "string" then
		if t == "key" then
			file:write(obj)
		else
			file:write(string.format("%q", obj))  	 -- 给obj加上""
		end

	elseif szType == "table" then
		file:write("{\n")

		for k,v in pairs(obj) do
			t = "key"
			SaveTableContent(file, k, t)
			file:write("=")
			t = "value"
			SaveTableContent(file, v, t)
			file:write(",\n")
		end
		file:write("}\n")

	else
		error("can't serialize a"..szType)

	end
end

function SaveTable()
	HERO = 3
	cha[1].name = "hehe"
	local file = io.open("Data.txt", "w") 	--打开文件
	assert(file) 		-- 检测是否获得文件句柄（一般检测文件打开和联网）
	file:write("HERO = ")
	file:write(HERO)
	file:write("\n")
	file:write("cha = {}\n")
	file:write("cha[1] = \n")
	SaveTableContent(file, cha[1], nil)
	file.close()
end

SaveTable()


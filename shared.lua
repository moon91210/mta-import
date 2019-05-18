local thisResourceName = getThisResource().name

function load()
	return [[
		function import(name)
			if type(name) ~= 'string' then
				error("Bad arg #1 to 'import' (string expected)", 3)
			end

			local content, err = exports.]]..thisResourceName..[[:getFileContents(name)

			if not content then
				error(string.format("Can't import '%s' (%s)", name, err), 2)
			end

			local str = 'return function()\n'..content..'\nend'
			return loadstring(str)()()
		end
	]]
end

function getFileContents(path)
	path = split(path, '/')

	local modulePath = table.concat(path, '/', 2)
	local ext = modulePath:sub(-4) == '.lua' and '' or '.lua'

	if modulePath then
		path = string.format(':%s/%s%s', path[1], modulePath, ext)
	else
		path = string.format('%s%s', path[1], ext)
	end
	
	if fileExists(path) then
		local f = fileOpen(path)

		if f then
			local content = f:read(f.size)
			f:close()

			print(string.format('%s imported %s', sourceResource.name, path))

			return content
		end
		
		return false, 'can\'t open file'
	end

	return false, 'file not found'
end
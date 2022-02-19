function onCreate()
	settings = loadSettings('./mods/data/Saves/savedata.txt')
	noteskin = settings[1]

	if toboolean(settings[2]) then
		addLuaScript('optionsdata/hitsound')
	end
	if toboolean(settings[3]) then
		addLuaScript('optionsdata/eduardo')
	end
end

function onCreatePost()
	changeNoteSkin(noteskin)
end

function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

function loadSettings(file)
	if not file_exists(file) then 
		return {'a'} 
	end
	local lines = {}
  	for line in io.lines(file) do 
    		table.insert(lines, line)
  	end
  	return lines
end

function changeNoteSkin(skin)
    if not (skin == 'vanilla') then
	for i = 0, getProperty('opponentStrums.length')-1 do
            setPropertyFromGroup('opponentStrums', i, 'texture', 'noteskins/'..skin)
        end
        for i = 0, getProperty('playerStrums.length')-1 do
            setPropertyFromGroup('playerStrums', i, 'texture', 'noteskins/'..skin)
        end
        for i = 0, getProperty('unspawnNotes.length')-1 do
            if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' then
                setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteskins/'..skin)
            end
        end
    end
end

function toboolean(str)
    local bool = false
    if str == "true" then
        bool = true
    end
    return bool
end
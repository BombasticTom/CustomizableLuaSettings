local countdownstarted = false
local noteskin = ''
local selection = 1
local chosenterm = 1

function returnNum(list, item)
    local index={}
    for k,v in pairs(list) do
           index[v]=k
    end
    return index[item]
end

function file_exists(file)
	local f = io.open(file, "rb")
  	if f then 
		f:close() 
	end
  	return f ~= nil
end

function read_lines(file)
	if not file_exists(file) then 
		return {'null value'} 
	end
	local lines = {}
  	for line in io.lines(file) do 
    		table.insert(lines, line)
  	end
  	return lines
end

local noteskins = nil

local options = {
    {'noteskin', 'custom', read_lines('./mods/data/Saves/skins.txt'), 'vanilla'},
    {'hitsound', 'bool', {'true', 'false'}, 'false'},
    {'well well well', 'bool', {'true', 'false'}, 'false'}
}

local noteskin = 'vanilla'

function onCreate()
        setProperty('healthBarBG.visible', false)
        makeLuaSprite('bg', 'menuBGMagenta', 0, 0)
        setObjectCamera('bg', 'hud')
        addLuaSprite('bg', true)
        
        makeLuaText('selectyostuff', 'Before you start, select some of these cool options because swag!', 700, 310, 10)
        setTextSize('selectyostuff', 30)
        setObjectCamera('selectyostuff', 'hud')
        addLuaText('selectyostuff')

        for num, item in pairs(options) do
            makeLuaText('option'..num, item[1], 550, 100, 150 + 50*num)
            setTextSize('option'..num, 30)
            setTextAlignment('option'..num, 'left')
            addLuaText('option'..num)
            changeOptionType(0)
            selection = selection + 1
        end
        selection = 1

        makeLuaText('optiondot', '.', 550, 50, 190)
        setTextSize('optiondot', 30)
        setTextAlignment('optiondot', 'left')
        addLuaText('optiondot')
end

function onCreatePost()
        setProperty('healthBar.visible', false)
        setProperty('healthBarBG.visible', false)
        setProperty('iconP1.visible', false)
        setProperty('iconP2.visible', false)
        setProperty('scoreTxt.visible', false)
end

function onStartCountdown()
    if countdownstarted == false then
        return Function_Stop;
    end

    removeLuaSprite('bg')
    setProperty('camHUD.alpha',1)
    setProperty('healthBar.visible', true)
    setProperty('healthBarBG.visible', true)
    setProperty('iconP1.visible', true)
    setProperty('iconP2.visible', true)
    setProperty('scoreTxt.visible', true)
    removeLuaText('selectyostuff', true)
    for num, item in pairs(options) do
        removeLuaText('option'..num, true)
    end
    removeLuaText('optiondot', true)
    return Function_Continue;
end

function onUpdate()
    if countdownstarted == false then
        if keyJustPressed('accept') then
            --changeNoteSkin(noteskin)
	    save('./mods/data/Saves/savedata.txt')
            endSong()
        end
        if keyJustPressed('right') then
            changeOptionType(1)
        end
        if keyJustPressed('left') then
            changeOptionType(-1)
        end
        if keyJustPressed('down') then
            changeSelection(1)
        end
        if keyJustPressed('up') then
            changeSelection(-1)
        end
    end
end

function onCountdownTick(counter)
    if counter == 0 and not isStoryMode and not noteskin == 'vanilla' then
    
    end
end


function changeOptionType(num)
    chosenterm = (returnNum(options[selection][3], options[selection][4])) + num
    if chosenterm > table.getn(options[selection][3]) then
        chosenterm = 1
    elseif chosenterm < 1 then
        chosenterm = table.getn(options[selection][3])
    end
    options[selection][4] = options[selection][3][chosenterm]
    setTextString('option'..selection, options[selection][1]..' <'..options[selection][4]..'>')
end

function changeSelection(num)
    selection = selection + num
    if selection > table.getn(options) then
        selection = 1
    elseif selection < 1 then
        selection = table.getn(options)
    end

    setProperty('optiondot.y', 150 + 50 * selection - 8)
end

function save(file)
	local f = io.open(file, 'w')
	if file_exists(file) then
		for num, setting in pairs(options) do
			f:write(setting[4]..'\n')
		end
	else
		return 0
	end
end
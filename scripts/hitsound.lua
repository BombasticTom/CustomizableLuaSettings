--[[ function onCreate()
	precacheSound('SNAP')
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if not isSustainNote then
		playSound('SNAP', 3)
	end
end --]]
function onCreate()
	precacheSound('hitsounds/SNAP')
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if not isSustainNote then
		playSound('hitsounds/SNAP', 3)
	end
end
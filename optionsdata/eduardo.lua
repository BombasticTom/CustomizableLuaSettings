function onCreate()
	addCharacterToList('eduardo')
end

function onCreatePost()
	triggerEvent('Change Character', 1, 'eduardo')
end
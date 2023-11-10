local BFNote = true
local DADNote = true
local settingon

function onUpdate()
	if getProperty('targetfadeSetting.visible') == true  then
		settingon = true
	end

	if getProperty('targetfadeSetting.visible') == false then
		settingon = false
	end


	if settingon == true then
	if mustHitSection == false then
		if DADNote == true then
		noteTweenAlpha("NoteAlpha2", 1, 1, 0.1, linear)
		noteTweenAlpha("NoteAlpha4", 3, 1, 0.1, linear)
		noteTweenAlpha("NoteAlpha3", 2, 1, 0.1, linear)
		noteTweenAlpha("NoteAlpha1", 0, 1, 0.1, linear)
		end

		if BFNote == true then
		noteTweenAlpha("NoteAlpha5", 4, 0.5, 0.1, linear)
		noteTweenAlpha("NoteAlpha6", 5, 0.5, 0.1, linear)
		noteTweenAlpha("NoteAlpha7", 6, 0.5, 0.1, linear)
		noteTweenAlpha("NoteAlpha8", 7, 0.5, 0.1, linear)
		end
	else
		if DADNote == true then
		noteTweenAlpha("NoteAlpha2", 1, 0.5, 0.1, linear)
		noteTweenAlpha("NoteAlpha4", 3, 0.5, 0.1, linear)
		noteTweenAlpha("NoteAlpha3", 2, 0.5, 0.1, linear)
		noteTweenAlpha("NoteAlpha1", 0, 0.5, 0.1, linear)
	end

		if BFNote == true then
		noteTweenAlpha("NoteAlpha5", 4, 1, 0.1, linear)
		noteTweenAlpha("NoteAlpha6", 5, 1, 0.1, linear)
		noteTweenAlpha("NoteAlpha7", 6, 1, 0.1, linear)
		noteTweenAlpha("NoteAlpha8", 7, 1, 0.1, linear)
	end
end
end

end

function onEvent(name,value1,value2)
	reversed = tonumber(value1);
	speed = tonumber(value2);
	if name == 'Note Fade' then
		if settingon == true then
		if reversed == 1 then
			DADNote = false
		end
		if reversed == 1.5 then
			DADNote = true
		end
		if reversed == 2 then
			BFNote = false
		end
		if reversed == 2.5 then
			BFNote = true
		end
	end
end
if name == 'MoveArrowsToMiddle' then
	if settingon == true then
	if speed == 1 then
		DADNote = false
	end
	if speed == 0 then
		DADNote = true
	end
end
end
end

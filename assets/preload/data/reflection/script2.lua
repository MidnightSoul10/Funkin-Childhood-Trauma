function onCreate()

	makeLuaSprite('darkness', 'darkness', 0, 1)

	setObjectCamera('darkness', 'camOther')
	setObjectOrder('darkness', 22)
	scaleObject('darkness', 1.7, 1.7)
	setProperty('darkness.alpha', 0)

	addLuaSprite('darkness', true)

end

function onStepHit()

	if curStep == 826 then
		setProperty('darkness.alpha', 1)
		
		end
	if curStep == 959 then
		setProperty('darkness.alpha', 0)
			
		end
end

---CODED BY NICKIDK

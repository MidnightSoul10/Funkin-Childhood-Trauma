function onCreate()
	CurAddTimeStep = 1;
	CurRemoveTimeStep = 1;
	--CurRemoveTimeStep = 50;


--                   !! Please don't touch anything below !!
--------------------------------------------------------------------------------

creditNamethingSize = 100

if songName == 'Idiotic' then
	Made = "Reza"
end

if songName == 'epicness' then
	Made = "TonyNoki"
end

if songName == 'Lomando' then
	Made = "Tinfoil"
end

if songName == 'lomando' then
	Made = "Tinfoil"
end

if songName == '8-pages' then
	Made = "silly goose"
end

if songName == '8-pages-old' then
	Made = "FBI Goes Brrrrr"
	creditNamethingSize = 90
end

if songName == 'fidlago' then
	Made = "JulianA.P."
end

if songName == 'reflection' then
	Made = "Reza"
end

if songName == 'Murder' then
	Made = "Reza"
end

if songName == 'theather' then
	Made = "JulianA.P."
end

if songName == 'glesgorv' then
	Made = "silly goose"
end

if songName == 'Souped' then
	Made = "Tinfoil"
end

if songName == 'blue-demon' then
	Made = "Tinfoil"
	creditNamethingSize = 90
end

if songName == 'blue-block' then
	Made = "Tinfoil"
	creditNamethingSize = 95
end

if songName == 'Untold Loneliness' then
	Made = "no one"
	creditNamethingSize = 57
end

if songName == 'maledictus' then
	Made = "Reza"
end

----

makeLuaText('creditUnder', Made, 0, -5000, 370)
setTextAlignment('creditUnder', 'center')
setTextSize('creditUnder', 55)
setObjectCamera('creditUnder', 'other')
addLuaText('creditUnder')
-----

end

function onUpdate()
	setObjectOrder('creditFrame', 50)
	setObjectCamera('creditFrame', 'other')
	setProperty('creditFrame.visible', true)
	setObjectOrder('creditName', 60)
	setObjectOrder('creditUnder', 60)
	setObjectCamera('creditName', 'other')
	setProperty('creditName.visible', true)
	setTextSize('creditName', creditNamethingSize)
	if Made == "no one" then
		setProperty('creditName.y', 325)
		setProperty('creditUnder.y', -5000)
	end
end

function onStartCountdown()
	doTweenX('pauseLeftTween', 'creditFrame', 0, 0.2, 'linear')
		doTweenX('creditNameGoingTween', 'creditName', 10, 0.2, 'linear')
		doTweenX('creditUnderGoingTween', 'creditUnder', 10, 0.2, 'linear')
end

function onGameOverStart()
	setTextString('creditUnder', '')
end

function onStepHit()
    ---if curStep == CurAddTimeStep then
		--doTweenX('pauseLeftTween', 'creditFrame', 0, 0.2, 'linear')
		--doTweenX('creditNameGoingTween', 'creditName', 10, 0.2, 'linear')
		--doTweenX('creditUnderGoingTween', 'creditUnder', 10, 0.2, 'linear')
	
    --end
	if curStep == CurRemoveTimeStep then
		doTweenX('pauseLeftBackTween', 'creditFrame', -5000, 0.2, 'linear')
		doTweenX('creditNameBackTween', 'creditName', -5000, 0.2, 'linear')
		doTweenX('creditUnderBackTween', 'creditUnder', -5000, 0.2, 'linear')
	
    end
end

---CODED BY NICKIDK

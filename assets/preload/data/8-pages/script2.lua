function onCreate()
	CodeOne = 00;
	makeLuaSprite('paper', 'stages/bosque/slenderpaper', 17, 575)

	setObjectCamera('paper', 'other')
	setObjectOrder('paper', 10)
	scaleObject('paper', 0.4, 0.4)

	addLuaSprite('paper', true)

	makeLuaText('papernummax', "/8", 0, 65, 605)
	setTextAlignment('papernummax', 'center')
	setTextSize('papernummax', 60)
	setObjectCamera('papernummax', 'other')
	setTextFont('papernummax', 'Slender.ttf')
	setProperty('papernummax.alpha', 0)
	addLuaText('papernummax')

	makeLuaText('num1', CodeOne, 0, 33, 605)
	setTextAlignment('num1', 'center')
	setTextSize('num1', 60)
	setTextFont('num1', 'Slender.ttf')
	setObjectCamera('num1', 'other')
	addLuaText('num1')

	setProperty('papernummax.alpha', 0)
	setProperty('paper.alpha', 0)
	 setProperty('num1.alpha', 0)


------
	

end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'paper' then
	CodeOne = CodeOne+1;
	playSound(collectpaper)
    end
end

function onUpdate(elapsed)
	setTextString('num1', CodeOne)
end

function onStepHit()
    if curStep == 1 then
	setProperty('papernummax.alpha', 1)
	setProperty('paper.alpha', 1)
	setProperty('num1.alpha', 1)
	
    end
	if curStep == 383 then
		doTweenAlpha('papernummax', 'papernummax', 0, 1, 'linear')
		doTweenAlpha('paper', 'paper', 0, 1, 'linear')
		doTweenAlpha('num1', 'num1', 0, 1, 'linear')
		doTweenAlpha('bosque', 'bosque', 0, 1, 'linear')
		
		end
		if curStep == 512 then
			doTweenAlpha('papernummax1', 'papernummax', 1, 0.1, 'linear')
			doTweenAlpha('paper1', 'paper', 1, 0.1, 'linear')
			doTweenAlpha('num11', 'num1', 1, 0.1, 'linear')
			
			end
			if curStep == 640 then
				doTweenAlpha('bosque1', 'bosque', 1, 0.1, 'linear')
				
				end
    if curStep == 1089 then
	if CodeOne < 8 then
		setProperty('health', 0);
	end
	
    end
end

---CODED BY NICKIDK

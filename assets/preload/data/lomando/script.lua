function onCreate()

	makeAnimatedLuaSprite('door', 'stages/lomandocat/lomando-door', 0, 0)
	setObjectCamera('door', 'camHUD')
	setObjectOrder('door', 0)
	scaleObject('door', 1.1, 1.1)
	addAnimationByPrefix('door', 'anim1', 'lomando-door opendoor0', 24, true)
	addAnimationByPrefix('door', 'anim2', 'lomando-door closedoor0', 24, true)
	playAnim('door', 'anim2', true)
	addLuaSprite('door', true)
    setProperty('door.visible', false);

end

function onCreatePost()
    setProperty('camGame.alpha', 0);
    setProperty('iconP2.alpha', 0);
    setProperty('lomandocat.visible', true);
end

function onStepHit()
  if curStep == 144 then
    doTweenAlpha('iconP2Visible', 'iconP2', 1, 10, 'linear')
  end
    if curStep == 288 then
      setProperty('pauseLeftg.alpha', 0)
        setProperty('door.visible', true);
        setProperty('lomandocat.visible', false);
        setProperty('iconP2.alpha', 0);
      end
      if curStep == 352 then
        playAnim('door', 'anim1', true)
      end
      if curStep == 416 then
        setProperty('pauseLeft.alpha', 1)
        setProperty('door.visible', false);
        setProperty('iconP2.alpha', 1);
      end
    if curStep == 800 then
      setProperty('pauseLeft.alpha', 0)
      setProperty('pauseLeftg.alpha', 1)
	  setProperty('lomandocat.visible', true);
    end
    if curStep == 1056 then
      setProperty('pauseLeft.alpha', 1)
      setProperty('pauseLeftg.alpha', 0)
        setProperty('lomandocat.visible', false);
      end
      if curStep == 1456 then
        setProperty('boyfriend.alpha', 0);
        doTweenAlpha('camGameon', 'camGame', 0.5, 0.01, 'linear')
      end
      if curStep == 1506 then
        doTweenAlpha('camGameonBoy', 'boyfriend', 0.5, 1, 'linear')
      end
      if curStep == 1520 then
        doTweenAlpha('camGameonGone', 'camGame', 0, 1, 'linear')
      end
      if curStep == 1571 then
        doTweenAlpha('camGameonBACK', 'camGame', 0.5, 1, 'linear')
      end
      if curStep == 1584 then
        doTweenAlpha('camGameonBoyBye', 'boyfriend', 0, 1, 'linear')
      end
      if curStep == 1635 then
        doTweenAlpha('camGameonBoyBack', 'boyfriend', 0.5, 1, 'linear')
      end
      if curStep == 1648 then
        doTweenAlpha('camGameonGone2', 'camGame', 0, 1, 'linear')
      end
      if curStep == 1700 then
        doTweenAlpha('camGameonBoyFullBack', 'boyfriend', 1, 2, 'linear')
      end
end

---CODED BY NICKIDK

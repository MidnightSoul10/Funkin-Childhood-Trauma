function onCreate()
--                   !! Please don't touch anything below !!
--------------------------------------------------------------------------------
	makeLuaSprite('black', 'BlackFull', 358, 29)

	setObjectCamera('black', 'camHUD')
	setObjectOrder('black', 28)
	scaleObject('black', 2.1, 2.1)

	addLuaSprite('black', true)

	setProperty('black.alpha', 0)

	makeAnimatedLuaSprite('jump', 'stages/bosque/slendermanpopup', 120, -30)

	setObjectCamera('jump', 'camOther')
	setObjectOrder('jump', 18)
	scaleObject('jump', 3.3, 3.3)

	addAnimationByPrefix('jump', 'anim1', 'slendermanpopup jumpscared0', 24, true)

	playAnim('jump', 'anim1', true)

	addLuaSprite('jump', true)


	makeLuaSprite('jump2', 'blackness', 0, 0)

	setObjectCamera('jump2', 'camOther')
	setObjectOrder('jump2', 18)
	scaleObject('jump2', 100, 100)

	addLuaSprite('jump2', true)

			setProperty('jump.alpha', 0)
			setProperty('jump2.alpha', 0)

end

---CODED BY NICKIDK

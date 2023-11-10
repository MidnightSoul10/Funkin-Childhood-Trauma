--Coded by NickIdk :)

function onCreate()
	setProperty('timeBarSCARY.x', 420)
	if downscroll then
		---makeLuaSprite('timeBarSCARY', 'health_IC/scary-timebar', 420, 683)
		setProperty('timeBarSCARY.y', 683)
	else
		setProperty('timeBarSCARY.y', 26)
		--makeLuaSprite('timeBarSCARY', 'health_IC/scary-timebar', 420, 26)
	end
end

function onCreatePost()
	setProperty('ScaryHealthBar.alpha',getProperty('healthBar.alpha'))

	setProperty('ScaryHealthBar.x', getProperty('healthBar.x') - 25)

	setProperty('ScaryHealthBar.y', getProperty('healthBar.y') - 15)
	scaleObject('ScaryHealthBar', 1, 0.8)

	--HEALTHBAR
	setObjectOrder('ScaryHealthBar',10000)
	setObjectOrder('iconP1',50000)
	setObjectOrder('iconP2',50000)

	--TIMEBAR
	setObjectOrder('scoreTxt',1004)
	setObjectOrder('timeBar', 10000)
	setObjectOrder('timeBarSCARY', 10000900)
	setObjectOrder('timeTxt', 100001)

	UpdateOrder()
	SetStuff()
end

function onUpdatePost(elapsed)

	UpdateOrder()
	SetStuff()

	if getProperty('timeBarSetting.visible') == false then
	setProperty('timeBarBG.visible', true)
	setProperty('timeBarBG.alpha', 1)
	end
	if getProperty('timeBarSetting.visible') == true then
		setProperty('timeBarBG.visible', false)
		setProperty('timeBarBG.alpha', 0)
	end

	if getProperty('healthBarSetting.visible') == true then
		setProperty('healthBarBG.visible', false)
		setProperty('healthBarBG.alpha', 0)
	end
	if getProperty('healthBarSetting.visible') == false then
		setProperty('healthBarBG.visible', true)
		setProperty('healthBarBG.alpha', 1)
	end
end

function UpdateOrder()
	--HEALTHBAR
	setObjectOrder('ScaryHealthBar',10000)
	setObjectOrder('iconP1',50000)
	setObjectOrder('iconP2',50000)

	--TIMEBAR
	setObjectOrder('scoreTxt',1004)
	setObjectOrder('timeBar', 10000)
	setObjectOrder('timeBarSCARY', 10000900)
	setObjectOrder('timeTxt', 100001)
end

function SetStuff()
	setObjectCamera('timeBarSCARY', 'camHUD')
	setObjectOrder('timeBarSCARY', 1000000)
	scaleObject('timeBarSCARY', 1, 1.1)
	setProperty('timeBar.visible', true)
	setProperty('timeBar.alpha', 1)
end

function onGameOver()
    setProperty('timeBarSCARY.visible', false)
end

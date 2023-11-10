fakePaused = false
cSelected = false
rSelected = false
eSelected = false
devmode = false
MadeBy = "Unknowed"
AssetBy = "Unknowed"
ChartBy = "Unknowed"
xsongtext = 840

canPause = true

local shaderName = "cross hatch"




function onGameOver()

canPause = false



end


function onPause()
	return Function_Stop;
end

function onCreate()

	if songName == '8-pages' then
		SongNameYes = "8 Pages";
		MadeBy = "silly goose"
         AssetBy = "Sacs + normalNam3"
         ChartBy = "Kracer"
		 xsongtext = 820
	
		CreditImage = "pauseScreen/characters/slenderman"
	end
	if songName == 'epicness' then
		SongNameYes = "Epicness";
		MadeBy = "TonyNoki"
        AssetBy = "Sacs"
        ChartBy = "YoshiMaster"
		xsongtext = 810
	
		CreditImage = "pauseScreen/characters/epicness"
	end
	if songName == 'glesgorv' then
		SongNameYes = "Glesgorv";
		MadeBy = "silly goose"
        AssetBy = "Sacs"
        ChartBy = "Sacs"
		xsongtext = 800
	
		CreditImage = "pauseScreen/characters/glesgorv"
	end
	if songName == 'Idiotic' then
		SongNameYes = "Idiotic";
		MadeBy = "Reza"
        AssetBy = "Sacs"
		
	
		CreditImage = "pauseScreen/characters/idiotic"
	end
	if songName == 'reflection' then
		SongNameYes = "Reflection";
		MadeBy = "Reza"
        AssetBy = "rafacxs2010"
        ChartBy = "diteso"
		xsongtext = 770
	
		CreditImage = "pauseScreen/characters/reflection"

		function onStepHit()
			if curStep == 512 then
				setProperty('pauseLeft.alpha', 1)
			end
		end
	end
	if songName == 'maledictus' then
		SongNameYes = "Maledictus";
		MadeBy = "Reza"
        AssetBy = "Sacs"
        ChartBy = "Sacs"
		xsongtext = 770
	
		CreditImage = "pauseScreen/characters/smiledog"
	end

	if songName == 'Murder' then
		SongNameYes = "Murder";
		MadeBy = "Reza"
        AssetBy = "Sacs"
        ChartBy = "DyeWhy_Funny1"
		xsongtext = 820
	
		CreditImage = "pauseScreen/characters/murder"
	end

	if songName == '8-pages-old' then
		SongNameYes = "8 Pages (OLD)";
		MadeBy = "FBI Goes Brrrrr"
        AssetBy = "Sacs"
        ChartBy = "RaspyFv"
		xsongtext = 750
	
		CreditImage = "pauseScreen/characters/slendermanOLD"
	end

	if songName == 'fidlago' then
		SongNameYes = "Fidlago";
		MadeBy = "JulianA.P."
        AssetBy = "Sacs"
        ChartBy = "Sacs"
		xsongtext = 820
	
		CreditImage = "pauseScreen/characters/fidlago"
	end

	if songName == 'Untold Loneliness' then
		SongNameYes = "Untold Loneliness";
		MadeBy = "DyeWhy_Funny1"
		AssetBy = "Sacs"
		CreditImage = "pauseScreen/characters/fidgun"
		xsongtext = 650
	end

	if songName == 'theather' then
		SongNameYes = "Theater";
		MadeBy = "JulianA.P."
        AssetBy = "Sacs"
        ChartBy = "YoshiMaster109"
		xsongtext = 811
	
		CreditImage = "pauseScreen/characters/theater"
	end

	if songName == 'blue-block' then
		SongNameYes = "Blue Block";
		MadeBy = "TinFoil"
        AssetBy = "Sacs"
        ChartBy = "YoshiMaster109"
		xsongtext = 770
	
		CreditImage = "pauseScreen/characters/blueblockman"
	end

	if songName == 'blue-demon' then
		SongNameYes = "Blue Demon";
		MadeBy = "TinFoil"
        AssetBy = "Sacs + rafacxs2010 + Vix"
        ChartBy = "corperator"
		xsongtext = 770
	
		CreditImage = "pauseScreen/characters/bluedemon"
	end

	if songName == 'Souped' then
		SongNameYes = "Souped";
		MadeBy = "TinFoil"
        AssetBy = "Sacs"
        ChartBy = "Vanchester"
		xsongtext = 818
	
		CreditImage = "pauseScreen/characters/blankroom"
	end

	if songName == 'lomando' then
		SongNameYes = "Lomando";
		MadeBy = "TinFoil"
        AssetBy = "rafacxs2010"
        ChartBy = "Kracer"
		xsongtext = 805
	
		CreditImage = "pauseScreen/characters/lomando"

		makeLuaSprite('pauseLeftg', "pauseScreen/characters/catgirl", -800, 0)
		addLuaSprite('pauseLeftg', true)
		setObjectCamera('pauseLeftg', 'camOther')
		setObjectOrder('pauseLeftg', 50)
	end

	
	
	
	--                   !! Please don't touch anything below !!
	--------------------------------------------------------------------------------

	precacheSound('pauseSounds/pause')
	precacheSound('pauseSounds/pauseScrollMenu')
	precacheSound('pauseSounds/unpause')
	makeLuaSprite('funniblackbg', '', 0, 0)
	makeGraphic('funniblackbg', 1280, 720, '000000')
	addLuaSprite('funniblackbg', true)
	setObjectCamera('funniblackbg', 'camOther')
	setProperty('funniblackbg.alpha', 0.4)
	setProperty('funniblackbg.visible', false)
	makeLuaSprite('pauseRight', 'pauseScreen/pauseMenu', 800, 0)
	addLuaSprite('pauseRight', true)
	makeLuaSprite('pauseLeft', CreditImage, -800, 0)
	addLuaSprite('pauseLeft', true)
	setObjectCamera('pauseLeft', 'camOther')
	setObjectOrder('pauseLeft', 50)
	makeLuaText('SongText', SongNameYes, 0, 3000, 0)
	setTextAlignment('SongText', 'center')
	setTextSize('SongText', 60)
	setObjectCamera('SongText', 'camOther')
	setTextFont('SongText', 'aAhaWow.ttf')
	addLuaText('SongText')
	makeLuaText('madeby', "Made by:", 0, 0, 0)
	setTextAlignment('madeby', 'center')
	setTextSize('madeby', 60)
	setObjectCamera('madeby', 'camOther')
	addLuaText('madeby')
	makeLuaText('madebyTxt', MadeBy, 0, 0, 50)
	setTextAlignment('madebyTxt', 'center')
	setTextSize('madebyTxt', 40)
	setObjectCamera('madebyTxt', 'camOther')
	addLuaText('madebyTxt')
	makeLuaText('assetby', "Asset by:", 0, 0, 100)
	setTextAlignment('assetby', 'center')
	setTextSize('assetby', 60)
	setObjectCamera('assetby', 'camOther')
	addLuaText('assetby')
	makeLuaText('assetbyTxt', AssetBy, 0, 0, 150)
	setTextAlignment('assetbyTxt', 'center')
	setTextSize('assetbyTxt', 40)
	setObjectCamera('assetbyTxt', 'camOther')
	addLuaText('assetbyTxt')
	makeLuaText('chartby', "Chart by:", 0, 0, 200)
	setTextAlignment('chartby', 'center')
	setTextSize('chartby', 60)
	setObjectCamera('chartby', 'camOther')
	addLuaText('chartby')
	makeLuaText('chartbyTxt', ChartBy, 0, 0, 250)
	setTextAlignment('chartbyTxt', 'center')
	setTextSize('chartbyTxt', 40)
	setObjectCamera('chartbyTxt', 'camOther')
	addLuaText('chartbyTxt')

	makeLuaText('BotplayText', "Botplay", 0, 0, 660)
	setTextAlignment('BotplayText', 'center')
	setTextSize('BotplayText', 40)
	setObjectCamera('BotplayText', 'camHUD')
	addLuaText('BotplayText')
	setProperty('BotplayText.alpha', 0)
	makeLuaText('WatermarkText', "Funkin Childhood Trauma", 0, 0, 700)
	setTextAlignment('WatermarkText', 'center')
	setTextSize('WatermarkText', 20)
	setObjectCamera('WatermarkText', 'camHUD')
	setProperty('WatermarkText.visible', true)
	addLuaText('WatermarkText')
	setObjectCamera('pauseRight', 'camOther')
	makeLuaSprite('continue', 'pauseScreen/Continue', 800, 0)
	addLuaSprite('continue', true)
	setObjectCamera('continue', 'camOther')
	makeLuaSprite('restart', 'pauseScreen/Restart', 800, 0)
	addLuaSprite('restart', true)
	setObjectCamera('restart', 'camOther')
	makeLuaSprite('exist', 'pauseScreen/Exit', 800, 0)
	addLuaSprite('exist', true)
	setObjectCamera('exist', 'camOther')
	makeLuaSprite('continuebold', 'pauseScreen/Continuebold', 800, 0)
	addLuaSprite('continuebold', true)
	setObjectCamera('continuebold', 'camOther')
	makeLuaSprite('restartbold', 'pauseScreen/Restartbold', 800, 0)
	addLuaSprite('restartbold', true)
	setObjectCamera('restartbold', 'camOther')
	makeLuaSprite('existbold', 'pauseScreen/Exitbold', 800, 0)
	addLuaSprite('existbold', true)
	setObjectCamera('existbold', 'camOther')
	setProperty('continuebold.alpha', 0)
	setProperty('restartbold.alpha', 0)
	setProperty('existbold.alpha', 0)

	setObjectOrder('funniblackbg', 10000)
	setObjectOrder('pauseRight', 10010)
	setObjectOrder('pauseLeft', 10010)
	setObjectOrder('SongText', 10050)
	setObjectOrder('BotplayText', 10010)
	setObjectOrder('continue', 10050)
	setObjectOrder('continuebold', 10050)
	setObjectOrder('exist', 10050)
	setObjectOrder('existbold', 10050)
	setObjectOrder('continuebold', 10050)
	setObjectOrder('restart', 10050)
	setObjectOrder('restartbold', 10050)
	setObjectOrder('madeby', 10060)
	setObjectOrder('madebyTxt', 10060)
	setObjectOrder('assetby', 10060)
	setObjectOrder('assetbyTxt', 10060)
	setObjectOrder('chartby', 10060)
	setObjectOrder('chartbyTxt', 10060)

	setTextFont('madeby', 'credit.ttf')
	--setTextFont('madebyTxt', 'credit.ttf')
	setTextFont('assetby', 'credit.ttf')
	--setTextFont('assetbyTxt', 'credit.ttf')
	setTextFont('chartby', 'credit.ttf')
	--setTextFont('chartbyTxt', 'credit.ttf')

	setProperty('madeby.visible', false)
	setProperty('madebyTxt.visible', false)
	setProperty('assetby.visible', false)
	setProperty('assetbyTxt.visible', false)
	setProperty('chartby.visible', false)
	setProperty('chartbyTxt.visible', false)

	if songName == 'reflection' then
		setProperty('pauseLeft.alpha', 0)
	end
	if songName == 'lomando' then
		setProperty('pauseLeft.alpha', 0)
		setObjectOrder('pauseLeftg', 10010)
	end
end
function onUpdatePost(elapsed)

	if songName == 'Untold Loneliness' then
		setTextString('madeby', "Cover Made by:")
			setProperty('chartby.visible', false)
		setProperty('chartbyTxt.visible', false)
	end
	if songName == 'lomando' then
		setObjectOrder('pauseLeftg', 10010)
	end
	if songName == 'credit' then
		canPause = false
	end

	setShaderFloat("cross hatch", "iTime", os.clock())

	setObjectOrder('funniblackbg', 10000)
	setObjectOrder('pauseRight', 10010)
	setObjectOrder('pauseLeft', 10010)
	setObjectOrder('SongText', 10050)
	setObjectOrder('BotplayText', 10010)
	setObjectOrder('continue', 10050)
	setObjectOrder('continuebold', 10050)
	setObjectOrder('exist', 10050)
	setObjectOrder('existbold', 10050)
	setObjectOrder('continuebold', 10050)
	setObjectOrder('restart', 10050)
	setObjectOrder('restartbold', 10050)
	setObjectOrder('madeby', 10060)
	setObjectOrder('madebyTxt', 10060)
	setObjectOrder('assetby', 10060)
	setObjectOrder('assetbyTxt', 10060)
	setObjectOrder('chartby', 10060)
	setObjectOrder('chartbyTxt', 10060)

	if keyJustPressed('accept') and fakePaused == false and not getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and canPause then
		playSound('pauseSounds/puase', 100, 'pause')
		doTweenX('pauseRightTween', 'pauseRight', 0, 0.2, 'linear')
		doTweenX('pauseLeftTween', 'pauseLeft', 0, 0.2, 'linear')
		doTweenX('SongTextTween', 'SongText', xsongtext, 0.2, 'linear')
		doTweenY('SongTextTweenY', 'SongText', 230, 0.2, 'linear')
		doTweenX('cTween', 'continue', 0, 0.2, 'linear')
		doTweenX('rTween', 'restart', 0, 0.2, 'linear')
		doTweenX('eTween', 'exist', 0, 0.2, 'linear')
		doTweenX('cbTween', 'continuebold', 0, 0.2, 'linear')
		doTweenX('rbTween', 'restartbold', 0, 0.2, 'linear')
		doTweenX('ebTween', 'existbold', 0, 0.2, 'linear')

		if songName == 'lomando' then
			doTweenX('pauseLeftgTween', 'pauseLeftg', 0, 0.2, 'linear')
		end

		setProperty('madeby.visible', true)
		setProperty('madebyTxt.visible', true)
		setProperty('assetby.visible', true)
		setProperty('assetbyTxt.visible', true)
		setProperty('chartby.visible', true)
		setProperty('chartbyTxt.visible', true)

		shaderCoordFix() -- initialize a fix for textureCoord when resizing game window
		setProperty('camGame.filtersEnabled', true)
		setProperty('camHUD.filtersEnabled', true)
   	 makeLuaSprite("cross hatch")
   	 makeGraphic("shaderImage", screenWidth, screenHeight)

  	 setSpriteShader("shaderImage", "cross hatch")


    	runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";
        
        game.initLuaShader(shaderName);
        
        var shader0 = game.createRuntimeShader(shaderName);
        game.camGame.setFilters([new ShaderFilter(shader0)]);
        game.getLuaObject("cross hatch").shader = shader0; // setting it into temporary sprite so luas can set its shader uniforms/properties
        game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("cross hatch").shader)]);

		FlxG.sound.music.play(Paths.music('PauseMenu'));
        return;
    ]])


		cSelected = true
		rSelected = false
		eSelected = false
		fakePaused = true
	elseif keyJustPressed('accept') and fakePaused == true and not getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') and canPause then
		plsHelp()
	end
	if cSelected == false then
		setProperty('continuebold.alpha', 0)
		setProperty('continue.alpha', 1)
	end
	if cSelected == true then
		setProperty('continuebold.alpha', 1)
		setProperty('continue.alpha', 0)
	end
	if rSelected == false then
		setProperty('restartbold.alpha', 0)
		setProperty('restart.alpha', 1)
	end
	if rSelected == true then
		setProperty('restartbold.alpha', 1)
		setProperty('restart.alpha', 0)
	end
	if eSelected == false then
		setProperty('existbold.alpha', 0)
		setProperty('exist.alpha', 1)
	end
	if eSelected == true then
		setProperty('existbold.alpha', 1)
		setProperty('exist.alpha', 0)
	end
	if fakePaused == true then
		setProperty('funniblackbg.visible', true)
		setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition') - elapsed * 1000  ) -- it is counted by milliseconds, 1000 = 1 second
		setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
		setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
		setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
		setProperty('vocals.volume', 0)
	elseif fakePaused == false and canPause then
		setProperty('funniblackbg.visible', false)
		setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 1)
		
	end
	---damnIWannaDie()

	--------------------------------

	if keyJustPressed('down') and fakePaused == true then
		if cSelected == true then
			cSelected = false
			rSelected = true
			playSound('pauseSounds/pausescrollmenu', 100, 'pausescroll')
		elseif rSelected == true then
			rSelected = false
			eSelected = true
			playSound('pauseSounds/pausescrollmenu', 100, 'pausescroll')
		elseif eSelected == true then
			eSelected = false
			cSelected = true
			playSound('pauseSounds/pausescrollmenu', 100, 'pausescroll')
		end
	end
	if keyJustPressed('up') and fakePaused == true then
		if cSelected == true then
			cSelected = false
			eSelected = true
			playSound('pauseSounds/pausescrollmenu', 100, 'pausescroll')
		elseif rSelected == true then
			rSelected = false
			cSelected = true
			playSound('pauseSounds/pausescrollmenu', 100, 'pausescroll')
		elseif eSelected == true then
			eSelected = false
			rSelected = true
			playSound('pauseSounds/pausescrollmenu', 100, 'pausescroll')
		end
	end
	if keyJustPressed('left') and fakePaused == true and devmode == true then
			setProperty('cpuControlled', true)
			setProperty('BotplayText.alpha', 1)
			playSound('pauseSounds/pausescrollmenu', 100, 'pausescroll')
end

	if keyJustPressed('right') and fakePaused == true and devmode == true then
		setProperty('cpuControlled', false)
		setProperty('BotplayText.alpha', 0)
		playSound('pauseSounds/pausescrollmenu', 100, 'pausescroll')
end

function damnIWannaDie()
	if keyJustPressed('down') and fakePaused == true then
		if cSelected == true then
			cSelected = false
			rSelected = true
			playSound('pauseSounds/pausescrollmenu', 100, 'pausescroll')
		elseif rSelected == true then
			rSelected = false
			eSelected = true
			playSound('pauseSounds/pausescrollmenu', 100, 'pausescroll')
		elseif eSelected == true then
			eSelected = false
			cSelected = true
			playSound('pauseSounds/pausescrollmenu', 100, 'pausescroll')
		end
	end
	if keyJustPressed('up') and fakePaused == true then
		if cSelected == true then
			cSelected = false
			eSelected = true
			playSound('pauseSounds/pausescrollmenu', 100, 'pausescroll')
		elseif rSelected == true then
			rSelected = false
			cSelected = true
			playSound('pauseSounds/pausescrollmenu', 100, 'pausescroll')
		elseif eSelected == true then
			eSelected = false
			rSelected = true
			playSound('pauseSounds/pausescrollmenu', 100, 'pausescroll')
		end
	end
end

function plsHelp()
	if cSelected == true then
		playSound('pauseSounds/unpause', 100, 'unpause')
		setProperty('vocals.volume', 1)
		setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 1)
		doTweenX('pauseRightTween2', 'pauseRight', 800, 0.2, 'linear')
		doTweenX('pauseLeftTween2', 'pauseLeft', -800, 0.2, 'linear')
		doTweenX('SongTextTween2', 'SongText', 3000, 0.2, 'linear')
		doTweenX('cTween2', 'continue', 800, 0.2, 'linear')
		doTweenX('rTween', 'restart', 800, 0.2, 'linear')
		doTweenX('eTween', 'exist', 800, 0.2, 'linear')
		doTweenX('cbTween2', 'continuebold', 800, 0.2, 'linear')
		doTweenX('rbTween', 'restartbold', 800, 0.2, 'linear')
		doTweenX('ebTween', 'existbold', 800, 0.2, 'linear')

		if songName == 'lomando' then
			doTweenX('pauseLeftgTween2', 'pauseLeftg', -800, 0.2, 'linear')
		end

		runHaxeCode([[
			FlxG.sound.music.pause();
			return;
		]])
	

		removeLuaSprite("cross hatch")
		removeSpriteShader("cross hatch")
		removeLuaSprite("shaderName")
		setProperty('camGame.filtersEnabled', false)
		setProperty('camHUD.filtersEnabled', false)

		setProperty('madeby.visible', false)
	setProperty('madebyTxt.visible', false)
	setProperty('assetby.visible', false)
	setProperty('assetbyTxt.visible', false)
	setProperty('chartby.visible', false)
	setProperty('chartbyTxt.visible', false)

		cSelected = false
		rSelected = false
		eSelected = false
		fakePaused = false
	elseif rSelected == true then
		restartSong(true);
	elseif eSelected == true then
		playSound('pauseSounds/unpause', 100, 'unpause')
		doTweenX('pauseRightTween2', 'pauseRight', 800, 0.2, 'linear')
		doTweenX('pauseLeftTween2', 'pauseLeft', -800, 0.2, 'linear')
		doTweenX('SongTextTween2', 'SongText', 3000, 0.2, 'linear')
		doTweenX('cTween2', 'continue', 800, 0.2, 'linear')
		doTweenX('rTween', 'restart', 800, 0.2, 'linear')
		doTweenX('eTween', 'exist', 800, 0.2, 'linear')
		doTweenX('cbTween2', 'continuebold', 800, 0.2, 'linear')
		doTweenX('rbTween', 'restartbold', 800, 0.2, 'linear')
		doTweenX('ebTween', 'existbold', 800, 0.2, 'linear')

		if songName == 'lomando' then
			doTweenX('pauseLeftgTween2', 'pauseLeftg', -800, 0.2, 'linear')
		end
		exitSong(true)
	end
end
end

function shaderCoordFix()
    runHaxeCode([[
        resetCamCache = function(?spr) {
            if (spr == null || spr.filters == null) return;
            spr.__cacheBitmap = null;
            spr.__cacheBitmapData = null;
        }
        
        fixShaderCoordFix = function(?_) {
            resetCamCache(game.camGame.flashSprite);
            resetCamCache(game.camHUD.flashSprite);
            resetCamCache(game.camOther.flashSprite);
        }
    
        FlxG.signals.gameResized.add(fixShaderCoordFix);
        fixShaderCoordFix();
        return;
    ]])
    
    local temp = onDestroy
    function onDestroy()
        runHaxeCode([[
            FlxG.signals.gameResized.remove(fixShaderCoordFix);
            return;
        ]])
        if (temp) then temp() end
    end
end

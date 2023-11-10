function onCreate()
	-- background shit
	makeLuaSprite('white', 'white', -1400, -800);
	setScrollFactor('white', 1.8, 1.8);

	addLuaSprite('white', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
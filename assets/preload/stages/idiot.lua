function onCreate()
-- background shit bugfix by soulbf10
makeLuaSprite('white', 'white', -580, -190)
scaleObject('white', 1, 1)
setScrollFactor('white', 1.8, 1.8)
close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
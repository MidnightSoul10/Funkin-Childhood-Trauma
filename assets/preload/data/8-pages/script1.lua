function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'sgo', 'sgo'); --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'staticslender'); --put in mods/sounds/
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver'); --put in mods/music/
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd'); --put in mods/music/
end

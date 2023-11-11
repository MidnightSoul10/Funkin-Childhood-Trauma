function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'onibf-dead', 'onibf'); --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'aooni'); --put in mods/sounds/
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver'); --put in mods/music/
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd'); --put in mods/music/
end

package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import openfl.utils.Assets;

class DemoWarning extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create():Void
	{
		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end

		#if android
		addVirtualPad(NONE, A);
		#end

		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"Hello!\n
			This Verson is still a demo\n
			So story mode is locked.\n
			Also check the setting before playing.\n
			Ported By SoulBF10, Thanks For Playing.\n
			<- Click on in the bottom right corner or Click Spacebar or Enter key to Continue ->",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed:Float):Void
	{
		if(!leftState) {
			var space:Bool = FlxG.keys.justPressed.SPACE;
			if (controls.ACCEPT || space) {
				leftState = true;
					ClientPrefs.flashing = false;
					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxFlicker.flicker(warnText, 1, 0.1, false, true, function(flk:FlxFlicker) {
						new FlxTimer().start(0.5, function (tmr:FlxTimer) {
							MusicBeatState.switchState(new MainMenuState());
						});
					});
			}
		}
		super.update(elapsed);
	}
}

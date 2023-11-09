package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;
import openfl.Lib;

using StringTools;

class CreditsState extends MusicBeatState
{

	override function create()
	{
		#if android
		addVirtualPad(UP_DOWN, A_B);
		#end

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Credit", null);
		#end

		Lib.application.window.title = "Funkin Childhood Trauma V2 - Credits";

		PlayState.SONG = Song.loadFromJson('credit', 'credit');
		LoadingState.loadAndSwitchState(new PlayState());
}
}

package;

#if desktop
import Discord.DiscordClient;
#end
import editors.ChartingState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import lime.utils.Assets;
import openfl.Lib;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import WeekData;

#if MODS_ALLOWED
import sys.FileSystem;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;
	private static var curSelected:Int = 0;
	var curDifficulty:Int = -1;
	private static var lastDifficultyName:String = '';

	var scoreBG:FlxSprite;
	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;

	var SONGVISIBLE:Bool;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	var bg:FlxSprite;
	var bgTOP:FlxSprite;
	var freeplaytext:FlxSprite;
	var storymodetext:FlxSprite;
	var intendedColor:Int;
	var colorTween:FlxTween;
	var leText:String;
	var CustomMouse:FlxSprite;

	//BUTTONS
	var idioticbutton:FlxButton;
	var epicnessbutton:FlxButton;
	var fidlagobutton:FlxButton;
	var reflectionbutton:FlxButton;
	var lomandobutton:FlxButton;
	var glesgorvbutton:FlxButton;
	var placeholderbutton:FlxButton;
	var pagesbutton:FlxButton;
	var maledictionbutton:FlxButton;
	var blankroombutton:FlxButton;
	var theatherbutton:FlxButton;
	var bluedemonbutton:FlxButton;
	var murderbutton:FlxButton;
	var blueblockbutton:FlxButton;
	var untoldbutton:FlxButton;
	var pagesoldbutton:FlxButton;

	override function create()
	{
		//Paths.clearStoredMemory();
		//Paths.clearUnusedMemory();

		FlxG.mouse.visible = false;
		
		persistentUpdate = true;
		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);

		Lib.application.window.title = "Funkin Childhood Trauma V2 - Freeplay";

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Freeplay Menu", null);
		#end

		for (i in 0...WeekData.weeksList.length) {
			if(weekIsLocked(WeekData.weeksList[i])) continue;

			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var leSongs:Array<String> = [];
			var leChars:Array<String> = [];

			for (j in 0...leWeek.songs.length)
			{
				leSongs.push(leWeek.songs[j][0]);
				leChars.push(leWeek.songs[j][1]);
			}

			WeekData.setDirectoryFromWeek(leWeek);
			for (song in leWeek.songs)
			{
				var colors:Array<Int> = song[2];
				if(colors == null || colors.length < 3)
				{
					colors = [146, 113, 253];
				}
				addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]));
			}
		}
		WeekData.loadTheFirstEnabledMod();

		/*		//KIND OF BROKEN NOW AND ALSO PRETTY USELESS//

		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));
		for (i in 0...initSonglist.length)
		{
			if(initSonglist[i] != null && initSonglist[i].length > 0) {
				var songArray:Array<String> = initSonglist[i].split(":");
				addSong(songArray[0], 0, songArray[1], Std.parseInt(songArray[2]));
			}
		}*/

		bg = new FlxSprite().loadGraphic(Paths.image('menuBGFolderOpenBACK'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);
		bg.screenCenter();

		grpSongs = new FlxTypedGroup<Alphabet>();
		//add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(90, 320, songs[i].songName, true);
			songText.isMenuItem = true;
			songText.targetY = i - curSelected;
			grpSongs.add(songText);

			var maxWidth = 980;
			if (songText.width > maxWidth)
			{
				songText.scaleX = maxWidth / songText.width;
			}
			songText.snapToPosition();

			Paths.currentModDirectory = songs[i].folder;
			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}
		WeekData.setDirectoryFromWeek();

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);

		scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		//add(scoreBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		//add(diffText);

		//add(scoreText);

		if(curSelected >= songs.length) curSelected = 0;
		bg.color = songs[curSelected].color;
		intendedColor = bg.color;

		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));
		
		changeSelection();
		changeDiff();

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		textBG.alpha = 0.6;
		//add(textBG);
		
		var leText:String = "Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var size:Int = 18;

		var text:FlxText = new FlxText(textBG.x, textBG.y + 4, FlxG.width, leText, size);
		text.setFormat(Paths.font("vcr.ttf"), size, FlxColor.WHITE, RIGHT);
		text.scrollFactor.set();
		//add(text);

		bgTOP = new FlxSprite().loadGraphic(Paths.image('menuBGFolderOpen'));
		bgTOP.antialiasing = ClientPrefs.globalAntialiasing;
		//add(bgTOP);
		bgTOP.screenCenter();

		storymodetext = new FlxSprite().loadGraphic(Paths.image('storymodetext'));
		storymodetext.antialiasing = ClientPrefs.globalAntialiasing;
		add(storymodetext);
		storymodetext.screenCenter();
		storymodetext.visible = true;

		freeplaytext = new FlxSprite().loadGraphic(Paths.image('freeplaytext'));
		freeplaytext.antialiasing = ClientPrefs.globalAntialiasing;
		add(freeplaytext);
		freeplaytext.screenCenter();
		freeplaytext.visible = false;


var SONGVISIBLE:Bool = false;


		//STORY MODE
 
 
		var scale:Float = 1.5;
		idioticbutton = new FlxButton(50, 190, "");
		idioticbutton.frames = Paths.getSparrowAtlas('freeplayicon');
		idioticbutton.scale.x = scale;
		idioticbutton.scale.y = scale;
		idioticbutton.visible = true;
		idioticbutton.animation.addByPrefix('idiotic', "freeplayicon idiotic", 0);
		idioticbutton.animation.play('idiotic');
		add(idioticbutton);

		fidlagobutton = new FlxButton(200, 190, "");
		fidlagobutton.frames = Paths.getSparrowAtlas('freeplayicon');
		fidlagobutton.scale.x = scale;
		fidlagobutton.scale.y = scale;
		fidlagobutton.visible = true;
		fidlagobutton.animation.addByPrefix('fidlago', "freeplayicon fidlago", 0);
		fidlagobutton.animation.play('fidlago');
		add(fidlagobutton);

		bluedemonbutton = new FlxButton(350, 190, "");
		bluedemonbutton.frames = Paths.getSparrowAtlas('freeplayicon');
		bluedemonbutton.scale.x = scale;
		bluedemonbutton.scale.y = scale;
		bluedemonbutton.visible = true;
		bluedemonbutton.animation.addByPrefix('bluedemon', "freeplayicon bluedemon", 0);
		bluedemonbutton.animation.play('bluedemon');
		add(bluedemonbutton);

		pagesbutton = new FlxButton(500, 190, "");
		pagesbutton.frames = Paths.getSparrowAtlas('freeplayicon');
		pagesbutton.scale.x = scale;
		pagesbutton.scale.y = scale;
		pagesbutton.visible = true;
		pagesbutton.animation.addByPrefix('pages', "freeplayicon pages", 0);
		pagesbutton.animation.play('pages');
		add(pagesbutton);

		theatherbutton = new FlxButton(650, 190, "");
		theatherbutton.frames = Paths.getSparrowAtlas('freeplayicon');
		theatherbutton.scale.x = scale;
		theatherbutton.scale.y = scale;
		theatherbutton.visible = true;
		theatherbutton.animation.addByPrefix('theather', "freeplayicon theather", 0);
		theatherbutton.animation.play('theather');
		add(theatherbutton);

		glesgorvbutton = new FlxButton(800, 190, "");
		glesgorvbutton.frames = Paths.getSparrowAtlas('freeplayicon');
		glesgorvbutton.scale.x = scale;
		glesgorvbutton.scale.y = scale;
		glesgorvbutton.visible = true;
		glesgorvbutton.animation.addByPrefix('glesgorv', "freeplayicon glesgorv", 0);
		glesgorvbutton.animation.play('glesgorv');
		add(glesgorvbutton);

		maledictionbutton = new FlxButton(50, 370, "");
		maledictionbutton.frames = Paths.getSparrowAtlas('freeplayicon');
		maledictionbutton.scale.x = scale;
		maledictionbutton.scale.y = scale;
		maledictionbutton.visible = true;
		maledictionbutton.animation.addByPrefix('malediction', "freeplayicon malediction", 0);
		maledictionbutton.animation.play('malediction');
		add(maledictionbutton);

		murderbutton = new FlxButton(200, 370, "");
		murderbutton.frames = Paths.getSparrowAtlas('freeplayicon');
		murderbutton.scale.x = scale;
		murderbutton.scale.y = scale;
		murderbutton.visible = true;
		murderbutton.animation.addByPrefix('murder', "freeplayicon murder", 0);
		murderbutton.animation.play('murder');
		add(murderbutton);

		//BONUS SONGS

		epicnessbutton = new FlxButton(50, 190, "");
		epicnessbutton.frames = Paths.getSparrowAtlas('freeplayicon');
		epicnessbutton.scale.x = scale;
		epicnessbutton.scale.y = scale;
		epicnessbutton.visible = false;
		epicnessbutton.animation.addByPrefix('epicness', "freeplayicon epicness", 0);
		epicnessbutton.animation.play('epicness');
		add(epicnessbutton);

		reflectionbutton = new FlxButton(200, 190, "");
		reflectionbutton.frames = Paths.getSparrowAtlas('freeplayicon');
		reflectionbutton.scale.x = scale;
		reflectionbutton.scale.y = scale;
		reflectionbutton.visible = false;
		reflectionbutton.animation.addByPrefix('reflection', "freeplayicon reflection", 0);
		reflectionbutton.animation.play('reflection');
		add(reflectionbutton);

		lomandobutton = new FlxButton(350, 190, "");
		lomandobutton.frames = Paths.getSparrowAtlas('freeplayicon');
		lomandobutton.scale.x = scale;
		lomandobutton.scale.y = scale;
		lomandobutton.visible = false;
		lomandobutton.animation.addByPrefix('lomando', "freeplayicon lomando", 0);
		lomandobutton.animation.play('lomando');
		add(lomandobutton);

		blankroombutton = new FlxButton(500, 190, "");
		blankroombutton.frames = Paths.getSparrowAtlas('freeplayicon');
		blankroombutton.scale.x = scale;
		blankroombutton.scale.y = scale;
		blankroombutton.visible = false;
		blankroombutton.animation.addByPrefix('blankroom', "freeplayicon blankroom", 0);
		blankroombutton.animation.play('blankroom');
		add(blankroombutton);

		blueblockbutton = new FlxButton(650, 190, "");
		blueblockbutton.frames = Paths.getSparrowAtlas('freeplayicon');
		blueblockbutton.scale.x = scale;
		blueblockbutton.scale.y = scale;
		blueblockbutton.visible = false;
		blueblockbutton.animation.addByPrefix('blueblock', "freeplayicon blueblock", 0);
		blueblockbutton.animation.play('blueblock');
		add(blueblockbutton);

		untoldbutton = new FlxButton(800, 190, "");
		untoldbutton.frames = Paths.getSparrowAtlas('freeplayicon');
		untoldbutton.scale.x = scale;
		untoldbutton.scale.y = scale;
		untoldbutton.visible = false;
		untoldbutton.animation.addByPrefix('untold', "freeplayicon untold", 0);
		untoldbutton.animation.play('untold');
		add(untoldbutton);

		pagesoldbutton = new FlxButton(50, 370, "");
		pagesoldbutton.frames = Paths.getSparrowAtlas('freeplayicon');
		pagesoldbutton.scale.x = scale;
		pagesoldbutton.scale.y = scale;
		pagesoldbutton.visible = false;
		pagesoldbutton.animation.addByPrefix('pagesold', "freeplayicon pagesold", 0);
		pagesoldbutton.animation.play('pagesold');
		add(pagesoldbutton);
















//wdiojwdowaddaw,lawdl;,dwl;dwal;wdl;wadl;awdl;awdl;awdlwdal;dwl;ld;wlwd;ld;wal;dawl;awdl

		CustomMouse = new FlxSprite().loadGraphic(Paths.image('cursor'));
		CustomMouse.visible = true;
		add(CustomMouse);

		#if android
                addVirtualPad(UP_DOWN, A_B_C);
                #end

		super.create();
	}

	override function closeSubState() {
		changeSelection(0, false);
		persistentUpdate = true;
		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, color));
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!StoryMenuState.weekCompleted.exists(leWeek.weekBefore) || !StoryMenuState.weekCompleted.get(leWeek.weekBefore)));
	}

	/*public function addWeek(songs:Array<String>, weekNum:Int, weekColor:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);
			this.songs[this.songs.length-1].color = weekColor;

			if (songCharacters.length != 1)
				num++;
		}
	}*/

	var instPlaying:Int = -1;
	public static var vocals:FlxSound = null;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		idioticbutton.animation.play('idiotic');
		if (idioticbutton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			PlayState.SONG = Song.loadFromJson('idiotic-hard', 'Idiotic');
			LoadingState.loadAndSwitchState(new PlayState());
		}

		epicnessbutton.animation.play('epicness');
		if (epicnessbutton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			PlayState.SONG = Song.loadFromJson('epicness-hard', 'epicness');
			LoadingState.loadAndSwitchState(new PlayState());
		}

		fidlagobutton.animation.play('fidlago');
		if (fidlagobutton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			PlayState.SONG = Song.loadFromJson('fidlago-hard', 'fidlago');
			LoadingState.loadAndSwitchState(new PlayState());
		}
		reflectionbutton.animation.play('reflection');
		if (reflectionbutton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			PlayState.SONG = Song.loadFromJson('reflection-hard', 'reflection');
			LoadingState.loadAndSwitchState(new PlayState());
		}

		bluedemonbutton.animation.play('bluedemon');
		if (bluedemonbutton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			PlayState.SONG = Song.loadFromJson('blue-demon-hard', 'blue-demon');
			LoadingState.loadAndSwitchState(new PlayState());
		}

		pagesbutton.animation.play('pages');
		if (pagesbutton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			PlayState.SONG = Song.loadFromJson('8-pages-hard', '8-pages');
			LoadingState.loadAndSwitchState(new PlayState());
		}

		theatherbutton.animation.play('theather');
		if (theatherbutton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			PlayState.SONG = Song.loadFromJson('theather-hard', 'theather');
			LoadingState.loadAndSwitchState(new PlayState());
		}

		lomandobutton.animation.play('lomando');
		if (lomandobutton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			PlayState.SONG = Song.loadFromJson('lomando-hard', 'lomando');
			LoadingState.loadAndSwitchState(new PlayState());
		}

		glesgorvbutton.animation.play('glesgorv');
		if (glesgorvbutton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			PlayState.SONG = Song.loadFromJson('glesgorv-hard', 'glesgorv');
			LoadingState.loadAndSwitchState(new PlayState());
		}

		maledictionbutton.animation.play('malediction');
		if (maledictionbutton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			PlayState.SONG = Song.loadFromJson('maledictus-hard', 'maledictus');
			LoadingState.loadAndSwitchState(new PlayState());
		}

		blankroombutton.animation.play('blankroom');
		if (blankroombutton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			PlayState.SONG = Song.loadFromJson('souped-hard', 'Souped');
			LoadingState.loadAndSwitchState(new PlayState());
		}

		murderbutton.animation.play('murder');
		if (murderbutton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			PlayState.SONG = Song.loadFromJson('murder-hard', 'Murder');
			LoadingState.loadAndSwitchState(new PlayState());
		}

		blueblockbutton.animation.play('blueblock');
		if (blueblockbutton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			PlayState.SONG = Song.loadFromJson('blue-block-hard', 'blue-block');
			LoadingState.loadAndSwitchState(new PlayState());
		}

		untoldbutton.animation.play('untold');
		if (untoldbutton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			PlayState.SONG = Song.loadFromJson('untold-loneliness-hard', 'Untold Loneliness');
			LoadingState.loadAndSwitchState(new PlayState());
		}

		pagesoldbutton.animation.play('pagesold');
		if (pagesoldbutton.justPressed)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			PlayState.SONG = Song.loadFromJson('8-pages-old-hard', '8-pages-old');
			LoadingState.loadAndSwitchState(new PlayState());
		}









	if (!SONGVISIBLE)
	{
		storymodetext.visible = true;
		freeplaytext.visible = false;
		idioticbutton.visible = true;
		epicnessbutton.visible = false;
		fidlagobutton.visible = true;
		reflectionbutton.visible = false;
		bluedemonbutton.visible = true;
		pagesbutton.visible = true;
		theatherbutton.visible = true;
		lomandobutton.visible = false;
		glesgorvbutton.visible = true;
		maledictionbutton.visible = true;
		blankroombutton.visible = false;
		murderbutton.visible = true;
		blueblockbutton.visible = false;
		untoldbutton.visible = false;
		pagesoldbutton.visible = false;

		} else {
		storymodetext.visible = false;
		freeplaytext.visible = true;
		idioticbutton.visible = false;
		epicnessbutton.visible = true;
		fidlagobutton.visible = false;
		reflectionbutton.visible = true;
		bluedemonbutton.visible = false;
		pagesbutton.visible = false;
		theatherbutton.visible = false;
		lomandobutton.visible = true;
		glesgorvbutton.visible = false;
		maledictionbutton.visible = false;
		blankroombutton.visible = true;
		murderbutton.visible = false;
		blueblockbutton.visible = true;
		untoldbutton.visible = true;
		pagesoldbutton.visible = true;

	}







		var MouseIsaY = FlxG.mouse.y;
		var MouseIsaX = FlxG.mouse.x;

		CustomMouse.y = MouseIsaY;
		CustomMouse.x = MouseIsaX;

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(Highscore.floorDecimal(lerpRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
		positionHighscore();

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;
		var space = FlxG.keys.justPressed.SPACE;
		var ctrl = FlxG.keys.justPressed.CONTROL #if android || virtualPad.buttonC.justPressed #end;

		if(FlxG.keys.justPressed.L)
		{
			PlayState.SONG = Song.loadFromJson('darkness-hard', 'Darkness');
			LoadingState.loadAndSwitchState(new PlayState());
		}

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

		if(songs.length > 1)
		{
			//if (upP)
			//{
				//changeSelection(-shiftMult);
				//holdTime = 0;
			//}
			//if (downP)
			//{
				//changeSelection(shiftMult);
				//holdTime = 0;
			//}

			//if(controls.UI_DOWN || controls.UI_UP)
			//{
				//var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
				//holdTime += elapsed;
				//var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

				//if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
				//{
					//changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					//changeDiff();
				//}
			//}

			//if(FlxG.mouse.wheel != 0)
			//{
				//FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				//changeSelection(-shiftMult * FlxG.mouse.wheel, false);
				//changeDiff();
			//}
		}
if (!SONGVISIBLE)
	{
		
		if (controls.UI_LEFT_P)
		{
			//changeDiff(-1);
			SONGVISIBLE = true;
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
		}
		else if (controls.UI_RIGHT_P)
		{
			//changeDiff(1);
			SONGVISIBLE = true;
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
		}

		} else {

		if (controls.UI_LEFT_P)
		{
			//changeDiff(-1);
			SONGVISIBLE = false;
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
		}
		else if (controls.UI_RIGHT_P)
		{
			//changeDiff(1);
			SONGVISIBLE = false;
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
		}
		

	}
		//if (controls.UI_LEFT_P)
		//{
			//changeDiff(-1);
			//SONGVISIBLE = false;
			//FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
	//	}
	//	else if (controls.UI_RIGHT_P)
	//	{
	//		changeDiff(1);
	//		SONGVISIBLE = true;
	//		FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
	//	}
		//else if (upP || downP) changeDiff();

		if (controls.BACK)
		{
			persistentUpdate = false;
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		if(ctrl)
		{
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}
		//else if(space)
		//{
			//if(instPlaying != curSelected)
			//{
				//#if PRELOAD_ALL
				//destroyFreeplayVocals();
				//FlxG.sound.music.volume = 0;
				//Paths.currentModDirectory = songs[curSelected].folder;
				//var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);
				//PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
				//if (PlayState.SONG.needsVoices)
					//vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
				//else
					//vocals = new FlxSound();

				//FlxG.sound.list.add(vocals);
				//FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0.7);
				//vocals.play();
				//vocals.persist = true;
				//vocals.looped = true;
				//vocals.volume = 0.7;
				//instPlaying = curSelected;
				//#end
			//}
		//}

		//else if (accepted)
		//{
			//persistentUpdate = false;
			//var songLowercase:String = Paths.formatToSongPath(songs[curSelected].songName);
			//var poop:String = Highscore.formatSong(songLowercase, curDifficulty);
			/*#if MODS_ALLOWED
			//if(!sys.FileSystem.exists(Paths.modsJson(songLowercase + '/' + poop)) && !sys.FileSystem.exists(Paths.json(songLowercase + '/' + poop))) {
			//#else
			//if(!OpenFlAssets.exists(Paths.json(songLowercase + '/' + poop))) {
			//#end
				//poop = songLowercase;
				//curDifficulty = 1;
				//trace('Couldnt find file');
			//}*/
			//trace(poop);

			//PlayState.SONG = Song.loadFromJson(poop, songLowercase);
			//PlayState.isStoryMode = false;
			//PlayState.storyDifficulty = curDifficulty;

			//trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
			//if(colorTween != null) {
				//colorTween.cancel();
			//}
			
			//if (FlxG.keys.pressed.SHIFT){
				//LoadingState.loadAndSwitchState(new ChartingState());
			//}else{
				//LoadingState.loadAndSwitchState(new PlayState());
			//}

			//FlxG.sound.music.volume = 0;
					
			//destroyFreeplayVocals();
		//}
		else if(controls.RESET)
		{
			persistentUpdate = false;
			openSubState(new ResetScoreSubState(songs[curSelected].songName, curDifficulty, songs[curSelected].songCharacter));
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
		super.update(elapsed);
	}

	public static function destroyFreeplayVocals() {
		if(vocals != null) {
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

		lastDifficultyName = CoolUtil.difficulties[curDifficulty];

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		PlayState.storyDifficulty = curDifficulty;
		diffText.text = '< ' + CoolUtil.difficultyString() + ' >';
		positionHighscore();
	}

	function changeSelection(change:Int = 0, playSound:Bool = true)
	{
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;
			
		var newColor:Int = songs[curSelected].color;
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
		
		Paths.currentModDirectory = songs[curSelected].folder;
		PlayState.storyWeek = songs[curSelected].week;

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5

		if(diffStr != null && diffStr.length > 0)
		{
			var diffs:Array<String> = diffStr.split(',');
			var i:Int = diffs.length - 1;
			while (i > 0)
			{
				if(diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if(diffs[i].length < 1) diffs.remove(diffs[i]);
				}
				--i;
			}

			if(diffs.length > 0 && diffs[0].length > 0)
			{
				CoolUtil.difficulties = diffs;
			}
		}
		
		if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty))
		{
			curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
		}
		else
		{
			curDifficulty = 0;
		}

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1)
		{
			curDifficulty = newPos;
		}
	}

	private function positionHighscore() {
		scoreText.x = FlxG.width - scoreText.width - 6;

		scoreBG.scale.x = FlxG.width - scoreText.x + 6;
		scoreBG.x = FlxG.width - (scoreBG.scale.x / 2);
		diffText.x = Std.int(scoreBG.x + (scoreBG.width / 2));
		diffText.x -= diffText.width / 2;
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";

	public function new(song:String, week:Int, songCharacter:String, color:Int)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.folder = Paths.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}

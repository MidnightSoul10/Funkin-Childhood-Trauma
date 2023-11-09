package;
 
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.addons.ui.FlxInputText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import openfl.Lib;
 
#if desktop
import Discord.DiscordClient;
#end
 
class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '2.0.0';
	
	var buttonBG:FlxSprite;
	var rightButtonBG:FlxSprite;
	var logoBl:FlxSprite;
	var mouseOverObject:Bool;
	var imageVisible:Bool;
	var holdingWindow:Bool;
	var IsPointing:Bool;
	var menuName:FlxText;
	var bto:FlxText;
 
	var storymodeButton:FlxButton;
	var storymodeSelectedButton:FlxSprite;
	var freeplayButton:FlxButton;
	var freeplaySelectedButton:FlxSprite;
	var creditButton:FlxButton;
	var creditSelectedButton:FlxSprite;
	var optionsButton:FlxButton;
	var optionsSelectedButton:FlxSprite;
	var chromeButton:FlxButton;
	var chromeSelectedButton:FlxSprite;
	var startButton:FlxButton;
	var startSelectedButton:FlxSprite;

	var booglelook:FlxInputText;

	public static var curSelected:Int = 0;
 
 
	var magenta:FlxSprite;
	var startmenu:FlxSprite;
	var boogle:FlxSprite;
	var booglet:FlxButton;
	var CustomMouse:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var logoBlMainMenu:FlxSprite;

 
	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		#end
 
		FlxG.mouse.visible = false;

		var holdingWindow:Bool = false;


 
		WeekData.loadTheFirstEnabledMod();

		Lib.application.window.title = "Funkin Childhood Trauma V2 - Main Menu";
 
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
 
		persistentUpdate = persistentDraw = true;
		var bgTex = Paths.getSparrowAtlas('fondo');
		var imageVisible:Bool = false;
		var IsPointing:Bool = false;
 
		var daBG = new FlxSprite();
		daBG.frames = bgTex;
		daBG.animation.addByPrefix('idle', 'espacio');
		daBG.animation.play('idle', true);
		daBG.setGraphicSize(Std.int(daBG.width * 2));
		daBG.updateHitbox();
		daBG.screenCenter();
		daBG.antialiasing = ClientPrefs.globalAntialiasing;
		add(daBG);

	var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);
 
		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);

		var taskbar:FlxSprite = new FlxSprite().loadGraphic(Paths.image('taskbar'));
    	taskbar.screenCenter();
		taskbar.scrollFactor.set();
    	add(taskbar);	

		//STORYMODE
 
 
		var scale:Float = 1.5;
		var YTHING:Float = 480;
		storymodeButton = new FlxButton(280, YTHING, "");
		storymodeButton.frames = Paths.getSparrowAtlas('mainmenu/menu_story_mode');
		storymodeButton.scale.x = scale;
		storymodeButton.scale.y = scale;
		storymodeButton.animation.addByPrefix('idle', "story_mode basic", 24);
		storymodeButton.animation.addByPrefix('selected', "story_mode white", 24);
		add(storymodeButton);
 
		storymodeSelectedButton = new FlxSprite(280, YTHING, "");
		storymodeSelectedButton.frames = Paths.getSparrowAtlas('mainmenu/menu_story_mode');
		storymodeSelectedButton.scale.x = scale;
		storymodeSelectedButton.scale.y = scale;
		storymodeSelectedButton.animation.addByPrefix('idle', "story_mode basic", 24);
		storymodeSelectedButton.animation.addByPrefix('selected', "story_mode white", 24);
		storymodeSelectedButton.animation.play('selected');
		storymodeSelectedButton.visible = false;
		add(storymodeSelectedButton);

		//FREEPLAY
 
		freeplayButton = new FlxButton(480, YTHING, "");
		freeplayButton.frames = Paths.getSparrowAtlas('mainmenu/menu_freeplay');
		freeplayButton.scale.x = scale;
		freeplayButton.scale.y = scale;
		freeplayButton.animation.addByPrefix('idle', "freeplay basic", 24);
		freeplayButton.animation.addByPrefix('selected', "freeplay white", 24);
		add(freeplayButton);
 
		freeplaySelectedButton = new FlxSprite(480, YTHING, "");
		freeplaySelectedButton.frames = Paths.getSparrowAtlas('mainmenu/menu_freeplay');
		freeplaySelectedButton.scale.x = scale;
		freeplaySelectedButton.scale.y = scale;
		freeplaySelectedButton.animation.addByPrefix('idle', "freeplay basic", 24);
		freeplaySelectedButton.animation.addByPrefix('selected', "freeplay white", 24);
		freeplaySelectedButton.animation.play('selected');
		freeplaySelectedButton.visible = false;
		add(freeplaySelectedButton);

		//credit
 
		creditButton = new FlxButton(680, YTHING, "");
		creditButton.frames = Paths.getSparrowAtlas('mainmenu/menu_credits');
		creditButton.scale.x = scale;
		creditButton.scale.y = scale;
		creditButton.animation.addByPrefix('idle', "credits basic", 24);
		creditButton.animation.addByPrefix('selected', "credits white", 24);
		add(creditButton);
 
		creditSelectedButton = new FlxSprite(680, YTHING, "");
		creditSelectedButton.frames = Paths.getSparrowAtlas('mainmenu/menu_credits');
		creditSelectedButton.scale.x = scale;
		creditSelectedButton.scale.y = scale;
		creditSelectedButton.animation.addByPrefix('idle', "credits basic", 24);
		creditSelectedButton.animation.addByPrefix('selected', "credits white", 24);
		creditSelectedButton.animation.play('selected');
		creditSelectedButton.visible = false;
		add(creditSelectedButton);

		//OPTIONS
 
		optionsButton = new FlxButton(880, YTHING, "");
		optionsButton.frames = Paths.getSparrowAtlas('mainmenu/menu_options');
		optionsButton.scale.x = scale;
		optionsButton.scale.y = scale;
		optionsButton.animation.addByPrefix('idle', "options basic", 24);
		optionsButton.animation.addByPrefix('selected', "options white", 24);
		add(optionsButton);
 
		optionsSelectedButton = new FlxSprite(880, YTHING, "");
		optionsSelectedButton.frames = Paths.getSparrowAtlas('mainmenu/menu_options');
		optionsSelectedButton.scale.x = scale;
		optionsSelectedButton.scale.y = scale;
		optionsSelectedButton.animation.addByPrefix('idle', "options basic", 24);
		optionsSelectedButton.animation.addByPrefix('selected', "options white", 24);
		optionsSelectedButton.animation.play('selected');
		optionsSelectedButton.visible = false;
		add(optionsSelectedButton);

		//CHROME

		chromeButton = new FlxButton();
		chromeButton.loadGraphic(Paths.image('chromelogo'));
		chromeButton.y = 665;
		chromeButton.x = 105;
		chromeButton.scale.x = 0.2;
		chromeButton.scale.y = 0.2;
		add(chromeButton);

		//STARTBUTTON

		startButton = new FlxButton(0, 695, "");
		startButton.frames = Paths.getSparrowAtlas('mainmenu/menu_start');
		startButton.scale.x = 1;
		startButton.scale.y = 1;
		startButton.animation.addByPrefix('idle', "start normal", 24);
		startButton.animation.addByPrefix('selected', "start glow", 24);
		add(startButton);
 
		startSelectedButton = new FlxSprite(880, YTHING, "");
		startSelectedButton.frames = Paths.getSparrowAtlas('mainmenu/menu_info');
		startSelectedButton.scale.x = 0.2;
		startSelectedButton.scale.y = 0.2;
		startSelectedButton.animation.addByPrefix('idle', "options basic", 24);
		startSelectedButton.animation.addByPrefix('selected', "options white", 24);
		startSelectedButton.animation.play('selected');
		startSelectedButton.visible = false;
		add(startSelectedButton);

		//LOGO
 		logoBlMainMenu = new FlxSprite(-450, -200);
		logoBlMainMenu.frames = Paths.getSparrowAtlas('TraumaLogo');

		logoBlMainMenu.antialiasing = ClientPrefs.globalAntialiasing;
		logoBlMainMenu.animation.addByPrefix('bump', 'TraumaLogo move', 24, false);
		logoBlMainMenu.animation.play('bump');
		logoBlMainMenu.scale.x = 0.9;
		logoBlMainMenu.scale.y = 0.9;
		logoBlMainMenu.updateHitbox();

		add(logoBlMainMenu);

		//TOP STUFF

		

		startmenu = new FlxSprite().loadGraphic(Paths.image('startmenu'));
		startmenu.screenCenter();
		startmenu.visible = false;
		startmenu.scrollFactor.set();
		add(startmenu);

		CustomMouse = new FlxSprite().loadGraphic(Paths.image('cursor'));
		CustomMouse.visible = true;
		add(CustomMouse);

		#if android
                addVirtualPad(UP_DOWN, A_B);
                #end

		super.create();
	}
 
	override function update(elapsed:Float)
	{
		var MouseIsaY = FlxG.mouse.y;
		var MouseIsaX = FlxG.mouse.x;

		CustomMouse.y = MouseIsaY;
		CustomMouse.x = MouseIsaX;

		//if (controls.BACK)
			//{
				//FlxG.sound.play(Paths.sound('cancelMenu'));
				//MusicBeatState.switchState(new TitleState());
			//}

		if (freeplayButton.justPressed)
			{
				freeplayButton.visible = false;
				freeplaySelectedButton.centerOffsets();
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxFlicker.flicker(freeplaySelectedButton, 1, 0.06, false, false, function(flick:FlxFlicker)
					{
 
 
								freeplaySelectedButton.visible = true;
								MusicBeatState.switchState(new FreeplayState());
 
 
					});
					FlxTween.tween(storymodeButton, {alpha: 0}, 0.4, {
						ease: FlxEase.quadOut,
						onComplete: function(twn:FlxTween)
						{
							storymodeButton.kill();
						}
					});

					FlxTween.tween(creditButton, {alpha: 0}, 0.4, {
					ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
						creditButton.kill();
					}
				});
 
 
					FlxTween.tween(optionsButton, {alpha: 0}, 0.4, {
						ease: FlxEase.quadOut,
						onComplete: function(twn:FlxTween)
						{
							optionsButton.kill();
						}
					});
 
 
 
 
							FlxG.mouse.visible = false;
 
			}

	if (creditButton.justPressed)
			{
				creditButton.visible = false;
				creditSelectedButton.centerOffsets();
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxFlicker.flicker(creditSelectedButton, 1, 0.06, false, false, function(flick:FlxFlicker)
					{
 
 
								creditSelectedButton.visible = true;
								MusicBeatState.switchState(new CreditsState());
 
 
					});
					FlxTween.tween(storymodeButton, {alpha: 0}, 0.4, {
						ease: FlxEase.quadOut,
						onComplete: function(twn:FlxTween)
						{
							storymodeButton.kill();
						}
					});
					FlxTween.tween(freeplayButton, {alpha: 0}, 0.4, {
						ease: FlxEase.quadOut,
						onComplete: function(twn:FlxTween)
						{
							freeplayButton.kill();
						}
					});
 
 
					FlxTween.tween(optionsButton, {alpha: 0}, 0.4, {
						ease: FlxEase.quadOut,
						onComplete: function(twn:FlxTween)
						{
							optionsButton.kill();
						}
					});
 
 
 
 
							FlxG.mouse.visible = false;
 
			}
 
 
		if (optionsButton.justPressed)
		{
			optionsButton.visible = false;
			optionsSelectedButton.centerOffsets();
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxFlicker.flicker(optionsSelectedButton, 1, 0.06, false, false, function(flick:FlxFlicker)
					{
 
 
						optionsSelectedButton.visible = true;
						LoadingState.loadAndSwitchState(new options.OptionsState());
 
 
					});
				FlxTween.tween(freeplayButton, {alpha: 0}, 0.4, {
					ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
						freeplayButton.kill();
					}
				});

				FlxTween.tween(creditButton, {alpha: 0}, 0.4, {
					ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
						creditButton.kill();
					}
				});
 
 
 
				FlxTween.tween(storymodeButton, {alpha: 0}, 0.4, {
					ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
						storymodeButton.kill();
					}
				});
 
				FlxG.mouse.visible = false;
		}

		if (chromeButton.justPressed)
			{
				CoolUtil.browserLoad('https://sites.google.com/view/funkin-trauma/main-page?authuser=0');

			}
		

		if (startButton.justPressed)
			{
				imageVisible = !imageVisible;
			}

		if (imageVisible)
			startmenu.visible = true;
			else
			startmenu.visible = false;
			
 
 
 
		super.update(elapsed);
	}

	override function beatHit()
	{
		super.beatHit();

		if(logoBlMainMenu != null)
			logoBlMainMenu.animation.play('bump', true);
	}
}

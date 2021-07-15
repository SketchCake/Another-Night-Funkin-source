package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitLeft2:FlxSprite;
	var portraitLeft3:FlxSprite;
	var portraitRight:FlxSprite;
	var darkportrait:FlxSprite;
	var darkportraitpolt:FlxSprite;
	var demon:FlxSprite;
	var demonaway:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'paranormal':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('Text_Boxes2');
				box.animation.addByPrefix('normalOpen', 'textbox', 24, false);
				box.animation.addByIndices('normal', 'textbox', [9], "", 24);
			case 'poltergeist':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('textboxes');
				box.animation.addByPrefix('normalOpen', 'textbox', 24, false);
				box.animation.addByIndices('normal', 'textbox', [9], "", 24);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

			portraitLeft = new FlxSprite(0, 48);
			portraitLeft.frames = Paths.getSparrowAtlas('text/polter1');
			portraitLeft.animation.addByPrefix('enter', 'textbox', 24, false);
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;

			portraitLeft2 = new FlxSprite(0, 48);
			portraitLeft2.frames = Paths.getSparrowAtlas('text/polter2');
			portraitLeft2.animation.addByPrefix('enter', 'textbox', 24, false);
			portraitLeft2.updateHitbox();
			portraitLeft2.scrollFactor.set();
			add(portraitLeft2);
			portraitLeft2.visible = false;

			portraitLeft3 = new FlxSprite(0, 48);
			portraitLeft3.frames = Paths.getSparrowAtlas('text/polter3');
			portraitLeft3.animation.addByPrefix('enter', 'textbox', 24, false);
			portraitLeft3.updateHitbox();
			portraitLeft3.scrollFactor.set();
			add(portraitLeft3);
			portraitLeft3.visible = false;

			portraitRight = new FlxSprite(0, 48);
			portraitRight.frames = Paths.getSparrowAtlas('text/bf1');
			portraitRight.animation.addByPrefix('enter', 'textbox', 24, false);
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;

			darkportrait = new FlxSprite(0, 48);
			darkportrait.frames = Paths.getSparrowAtlas('text/bfwait');
			darkportrait.animation.addByPrefix('enter', 'textbox', 24, false);
			darkportrait.updateHitbox();
			darkportrait.scrollFactor.set();
			add(darkportrait);
			darkportrait.visible = false;

			darkportraitpolt = new FlxSprite(0, 48);
			darkportraitpolt.frames = Paths.getSparrowAtlas('text/polterwait');
			darkportraitpolt.animation.addByPrefix('enter', 'textbox', 24, false);
			darkportraitpolt.updateHitbox();
			darkportraitpolt.scrollFactor.set();
			add(darkportraitpolt);
			darkportraitpolt.visible = false;

			demon = new FlxSprite(0, 48);
			demon.frames = Paths.getSparrowAtlas('text/demon');
			demon.animation.addByPrefix('enter', 'textbox', 24, false);
			demon.updateHitbox();
			demon.scrollFactor.set();
			add(demon);
			demon.visible = false;

			demonaway = new FlxSprite(0, 48);
			demonaway.frames = Paths.getSparrowAtlas('text/demonaway');
			demonaway.animation.addByPrefix('enter', 'textbox', 24, false);
			demonaway.updateHitbox();
			demonaway.scrollFactor.set();
			add(demonaway);
			demonaway.visible = false;

		box.animation.play('normalOpen');
		box.updateHitbox();
		add(box);	

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}
		if (PlayState.SONG.song.toLowerCase() == 'paranormal')
		{
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = 0xFF2452A6;
		}
		if (PlayState.SONG.song.toLowerCase() == 'poltergeist')
		{
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = 0xFFFF1FAD;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				darkportrait.visible = true;
				darkportraitpolt.visible = false;
				portraitLeft2.visible = false;
				portraitLeft3.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
					darkportrait.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				darkportrait.visible = false;
				darkportraitpolt.visible = true;
				portraitLeft2.visible = false;
				portraitLeft3.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
					darkportraitpolt.animation.play('enter');
				}
			case 'notalk':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				darkportrait.visible = true;
				darkportraitpolt.visible = true;
				portraitLeft2.visible = false;
				portraitLeft3.visible = false;
				if (!portraitRight.visible)
				{
					darkportraitpolt.animation.play('enter');
					darkportrait.animation.play('enter');
				}
			case 'dad2':
				portraitRight.visible = false;
				darkportrait.visible = true;
				darkportraitpolt.visible = false;
				portraitLeft3.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft2.visible = true;
					portraitLeft2.animation.play('enter');
					darkportrait.animation.play('enter');
				}
			case 'dad3':
				portraitRight.visible = false;
				darkportrait.visible = true;
				darkportraitpolt.visible = false;
				portraitLeft2.visible = false;
				portraitLeft.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft3.visible = true;
					portraitLeft3.animation.play('enter');
					darkportrait.animation.play('enter');
				}
			case 'demon':
				portraitRight.visible = false;
				darkportrait.visible = true;
				darkportraitpolt.visible = false;
				portraitLeft2.visible = false;
				portraitLeft.visible = false;
				portraitLeft3.visible = false;		
				demonaway.visible = false;
				if (!portraitLeft.visible)
				{
					demon.visible = true;
					demon.animation.play('enter');
					darkportrait.animation.play('enter');
				}
			case 'bfdemon':
				portraitLeft.visible = false;
				darkportrait.visible = false;
				darkportraitpolt.visible = false;
				portraitLeft2.visible = false;
				portraitLeft3.visible = false;
				demon.visible = false;
				demonaway.visible = true;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
					demonaway.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}

package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class CharacterSetting
{
	public var x(default, null):Int;
	public var y(default, null):Int;
	public var scale(default, null):Float;
	public var flipped(default, null):Bool;

	public function new(x:Int = 0, y:Int = 0, scale:Float = 1.0, flipped:Bool = false)
	{
		this.x = x;
		this.y = y;
		this.scale = scale;
		this.flipped = flipped;
	}
}

class MenuCharacter extends FlxSprite
{
	private static var settings:Map<String, CharacterSetting> = [
		'bf' => new CharacterSetting(-70, 0, 2.0, true),
		'gf' => new CharacterSetting(-50, 20, 2.0, true),
		'dee' => new CharacterSetting(-90, -30, 0.7, true),
		'polter' => new CharacterSetting(-90, -30, 1.0, true),
		'diz' => new CharacterSetting(-120, -40, 0.45, true)
	];

	private var flipped:Bool = false;

	public function new(x:Int, y:Int, scale:Float, flipped:Bool)
	{
		super(x, y);
		this.flipped = flipped;

		antialiasing = true;

		frames = Paths.getSparrowAtlas('CampaignUI');

		animation.addByPrefix('bf', "BFSymbol", 24);
		animation.addByPrefix('bfConfirm', 'confirmBFsymbol', 24, false);
		animation.addByPrefix('gf', "GFSymbol", 24);
		animation.addByPrefix('dee', "DeeSymbol", 24);
		animation.addByPrefix('polter', "PolterSymbol", 24);
		animation.addByPrefix('diz', "DizSymbol", 24);

		setGraphicSize(Std.int(width * scale));
		updateHitbox();
	}

	public function setCharacter(character:String):Void
	{
		if (character == '')
		{
			visible = false;
			return;
		}
		else
		{
			visible = true;
		}

		animation.play(character);

		var setting:CharacterSetting = settings[character];
		offset.set(setting.x, setting.y);
		setGraphicSize(Std.int(width * setting.scale));
		flipX = setting.flipped != flipped;
	}
}

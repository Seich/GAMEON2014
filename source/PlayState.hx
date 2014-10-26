package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

import flixel.ui.FlxAnalog;
import flixel.tile.FlxTilemap;
import openfl.Assets;

import Player;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var vpad:FlxAnalog;

	private var level:FlxTilemap;
	private var TILE_WIDTH:Int = 32;
	private var TILE_HEIGHT:Int = 32;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		// Virtual Joystick
		vpad = new FlxAnalog(50, FlxG.height - 50);
		add(vpad);


		// tilemap
		level = new FlxTilemap();
		level.loadMap(Assets.getText("assets/data/level_1.csv"), "assets/images/tiles.png", TILE_WIDTH, TILE_HEIGHT);
		add(level);

		// Player
		add(new Player(vpad));
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}
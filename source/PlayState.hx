package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

import flixel.ui.FlxAnalog;
import openfl.Assets;

import Player;
import Level;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var vpad:FlxAnalog;
	private var player: Player;
	private var level: Level;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		// tilemap
		level = new Level("assets/data/level_1.csv");
		add(level);

		// Virtual Joystick
		vpad = new FlxAnalog(50, FlxG.height - 50);
		vpad.alpha = 0.35;

		// Player
		player = new Player(vpad);
		add(player);

		FlxG.camera.follow(player, flixel.FlxCamera.STYLE_LOCKON);

		add(vpad);
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
		FlxG.collide(level, player);
		super.update();
	}	
}
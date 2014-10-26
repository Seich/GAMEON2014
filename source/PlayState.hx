package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

import flixel.ui.FlxAnalog;

import Player;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public static var vpad:FlxAnalog;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		vpad = new FlxAnalog(50, FlxG.height - 50);
		vpad.alpha = 0.35;
		add(new Player(vpad));

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
		super.update();
	}	
}
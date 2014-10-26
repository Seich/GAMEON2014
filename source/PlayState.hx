package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

import flixel.ui.FlxAnalog;
import openfl.Assets;

import flixel.group.FlxTypedGroup;

import Player;
import Enemy;
import Level;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var vpad:FlxAnalog;
	private var player: Player;
	private var level: Level;
	private var _grpEnemies:FlxTypedGroup<Enemy>;


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

		var item = new UpgradeItem(50,50);
		add(item);

		// Player
		player = new Player(vpad);
		add(player);

		FlxG.camera.follow(player, flixel.FlxCamera.STYLE_LOCKON);

		add(vpad);

		_grpEnemies = new FlxTypedGroup<Enemy>();
		add(_grpEnemies);

		_grpEnemies.add(new Enemy(50, 50, 1, 100));

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
		_grpEnemies.forEachAlive(function (e:Enemy) {
			checkEnemyVision(e);
			FlxG.collide(level, e);
		});

		super.update();
	}

	private function checkEnemyVision(e:Enemy):Void
	{
		if (e.getMidpoint().distanceTo(player.getMidpoint()) <= 50)
		{
			e.seesPlayer = true;
			e.playerPos.copyFrom(player.getMidpoint());
		}
		else
		{
			e.seesPlayer = false;
		}
	}
}
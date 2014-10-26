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
	private var movementPad:FlxAnalog;
	private var player: Player;
	private var level: Level;
	private var _grpEnemies:FlxTypedGroup<Enemy>;
	private var _grpItems:FlxTypedGroup<UpgradeItem>;


	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		// tilemap
		level = new Level("assets/data/level_1.csv");
		add(level);

		// Virtual Joystick
		movementPad = new FlxAnalog(50, FlxG.height - 50);
		movementPad.alpha = 0.35;
		_grpItems = new FlxTypedGroup<UpgradeItem>();
		add(_grpItems);
		_grpItems.add(new UpgradeItem(150, 150));
		// Player
		player = new Player(movementPad);
		add(player);
		FlxG.camera.bounds = new flixel.util.FlxRect(0, 0, 800, 800);
		_grpEnemies = new FlxTypedGroup<Enemy>();
		_grpEnemies.add(new Enemy(150, 250, 1, 100));
		add(_grpEnemies);
		FlxG.camera.follow(player, flixel.FlxCamera.STYLE_LOCKON);
		add(movementPad);
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
		FlxG.collide(player, level);
		_grpEnemies.forEachAlive(function (e:Enemy) {
			checkEnemyVision(e);
			FlxG.collide(level, e);
		});

		super.update();
		FlxG.overlap(player, _grpItems, playerTouchUpgrade);
		FlxG.overlap(player, _grpEnemies, playerTouchEnemy);
	}

	private function playerTouchUpgrade(P:Player, U:UpgradeItem):Void
	{
		if(P.alive && P.exists && U.alive && U.exists){
			U.kill();
			P.levelUp();
		}
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

	private function playerTouchEnemy(P:Player, E:Enemy):Void
	{
		if(P.alive && P.exists && E.alive && E.exists){
			P.levelDown();
		}
	}
}
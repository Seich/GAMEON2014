package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

import flixel.ui.FlxAnalog;
import flixel.ui.FlxVirtualPad;
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
	private var buttons: FlxVirtualPad;
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
		add(new FlxSprite(0, 0).loadGraphic("assets/images/hole.png"));
		add(new FlxSprite(90, 5).loadGraphic("assets/images/rock_1.png"));
		add(new FlxSprite(20, 150).loadGraphic("assets/images/rock_1.png"));
		add(new FlxSprite(200, 150).loadGraphic("assets/images/plant_1.png"));
		add(new FlxSprite(100, 200).loadGraphic("assets/images/pool.png"));
		add(new FlxSprite(300, 100).loadGraphic("assets/images/plant_1.png"));

		// Virtual Joystick
		movementPad = new FlxAnalog(50, FlxG.height - 50);
		movementPad.alpha = 0.35;

		_grpItems = new FlxTypedGroup<UpgradeItem>();
		add(_grpItems);
		_grpItems.add(new UpgradeItem(150, 150));
		// Player
		player = new Player(movementPad);
		add(player);

		FlxG.camera.bounds = new flixel.util.FlxRect(0, 0, 480, 480);

		_grpEnemies = new FlxTypedGroup<Enemy>();
		_grpEnemies.add(new Enemy(150, 250, 1));
		_grpEnemies.add(new Enemy(150, 290, 1));
		_grpEnemies.add(new Enemy(100, 265, 1));
		add(_grpEnemies);
		
		buttons = new FlxVirtualPad(DPadMode.NONE, ActionMode.A);
		buttons.alpha = 0.35;
		add(buttons);

		buttons.buttonA.onDown.callback = attack;

		FlxG.camera.follow(player, flixel.FlxCamera.STYLE_LOCKON);
		add(movementPad);
		super.create();
	}

	public function attack() {
		player.attack();
		_grpEnemies.forEachAlive(function(e: Enemy) {
			if (player.facing == flixel.FlxObject.RIGHT) {
				if (e.pixelsOverlapPoint(player.getMidpoint().add(player.width))) {
					e.hurt(150);
				}
			} else if (player.facing == flixel.FlxObject.LEFT) {
				if (e.pixelsOverlapPoint(player.getMidpoint().subtract(player.width))) {
					e.hurt(150);
				}
			} else if (player.facing == flixel.FlxObject.DOWN) {
				if (e.pixelsOverlapPoint(player.getMidpoint().add(0, player.height))) {
					e.hurt(150);
				}
			} else if (player.facing == flixel.FlxObject.UP) {
				if (e.pixelsOverlapPoint(player.getMidpoint().subtract(0, player.height))) {
					e.hurt(150);
				}
			}
		});
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
		if (e.getMidpoint().distanceTo(player.getMidpoint()) <= e.fovDistance)
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
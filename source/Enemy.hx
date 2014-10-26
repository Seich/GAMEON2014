
package ;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.util.FlxAngle;
import flixel.util.FlxVelocity;
import flixel.util.FlxSpriteUtil;

class Enemy extends FlxSprite
{

	public var currentHealth(default, null):UInt;
	public var maxHealth(default, null):UInt;
	public var speed:Float = 100;
	public var etype(default, null):Int;

	private var _brain:FSM;
	private var _idleTmr:Float;
	private var _moveDir:Float;
	public var seesPlayer:Bool = false;
	public var playerPos(default, null):FlxPoint;


	public function new(x:Float=0, y:Float=0, EType:Int, health: UInt) 
	{
		super(x, y);

		etype = EType;
		// loadGraphic("assets/images/enemy-" + Std.string(etype) + ".png", true, 32, 32);
		// setFacingFlip(FlxObject.LEFT, false, false);
		// setFacingFlip(FlxObject.RIGHT, true, false);
		// animation.add("d", [0, 1, 0, 2], 6, false);
		// animation.add("lr", [3, 4, 3, 5], 6, false);
		// animation.add("u", [6, 7, 6, 8], 6, false);
		drag.x = drag.y = 10;
		// width = 8;
		// height = 14;
		// offset.x = 4;
		// offset.y = 2;

		maxHealth = health;
		currentHealth = health;
		_brain = new FSM(idle);
		_idleTmr = 0;
		playerPos = FlxPoint.get();

		super.makeGraphic(16,16, FlxColor.RED);
	}

	override public function update() {
		_brain.update();
		super.update();
	}

	override public function destroy() {
		super.destroy();
	}

	public function damage(p: UInt):Void {
		if (p < currentHealth) {
			currentHealth -= p;
		} else {
			destroy();
		}
	}

	function move() {
		this.velocity.x = 70.71;
		this.velocity.y = 70.71;
	}

	public function idle():Void
	{
		if (seesPlayer)
		{
			_brain.activeState = chase;
		} else {
			velocity.x = velocity.y = 0;
		}
	}

	public function chase():Void
	{
		if (!seesPlayer)
		{
			_brain.activeState = idle;
		}
		else
		{
			FlxVelocity.moveTowardsPoint(this, playerPos, Std.int(speed));
		}
	}
}

package ;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.util.FlxAngle;
import flixel.util.FlxVelocity;
import flixel.util.FlxSpriteUtil;

class Enemy extends FlxSprite
{

	public var currentHealth(default, null):UInt;
	public var maxHealth(default, null):UInt;
	public var speed:Float = 80;
	public var etype(default, null):Int;
	public var fovDistance:Float = 128;

	private var _brain:FSM;
	private var _idleTmr:Float;
	private var _moveDir:Float;
	public var seesPlayer:Bool = false;
	public var playerPos(default, null):FlxPoint;


	public function new(x:Float=0, y:Float=0, EType:Int = 1) 
	{
		super(x, y);

		etype = EType;
		loadGraphic("assets/images/enemy-1.png", true, 64, 64);
		this.setGraphicSize(32,32);
		this.updateHitbox();
		animation.add("down", [0,1], 6, true);
		animation.add("up",[0,1], 6, true);
		animation.add("left",[0,1], 6, true);
		animation.add("right",[0,1], 6, true);
		drag.x = drag.y = 10;
		
		health = 100;
		_brain = new FSM(idle);
		_idleTmr = 0;
		playerPos = FlxPoint.get();
	}

	override public function draw()
	{
		if (velocity.x != 0 || velocity.y != 0)
		{
			switch(facing)
			{
				case FlxObject.LEFT:
					animation.play("left");
				case FlxObject.RIGHT:
					animation.play("right");
					
				case FlxObject.UP:
					animation.play("up");
					
				case FlxObject.DOWN:
					animation.play("down");
			}
		}
		super.draw();
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
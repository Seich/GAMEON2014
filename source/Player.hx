package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.ui.FlxAnalog;
import flixel.util.FlxColor;
import flixel.util.FlxAngle;
import flixel.util.FlxVelocity;

class Player extends FlxSprite
{
	
	private var vpad: FlxAnalog;

	public function new(vpad: FlxAnalog, X:Float = 0, Y:Float = 0) {
		super(X, Y);
		this.vpad = vpad;
		super.makeGraphic(16,16, FlxColor.BLUE);
		drag.x = drag.y = 1600;
	}

	override public function update() {
		move();
		super.update();
	}

	override public function destroy() {
		super.destroy();
	}

	function move() {
		if(this.vpad.acceleration.x < 0){
			this.velocity.x = -200;
		}
		else if (this.vpad.acceleration.x > 0){
			this.velocity.x = 200;
		}

		if(this.vpad.acceleration.y < 0){
			this.velocity.y = -200;
		}
		else if (this.vpad.acceleration.y > 0){
			this.velocity.y = 200;
		}
		trace(this.vpad.acceleration.x);
		trace(this.vpad.acceleration.y);
		/*var angle = this.vpad.getAngle();
		FlxVelocity.accelerateTowardsMouse(this,200,this.vpad.acceleration.x,this.vpad.acceleration.y);
		var status = this.vpad.status;
		this.acceleration.x = this.vpad.acceleration.x;
		this.acceleration.y = this.vpad.acceleration.y;
		if(status != 2) 
		{
			return;      
		}
		trace(this.vpad.acceleration.x);
		trace(this.vpad.acceleration.y);
		trace(angle);*/
	}

}
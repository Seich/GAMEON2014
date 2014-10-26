package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.ui.FlxAnalog;
import flixel.util.FlxColor;
import flixel.util.FlxAngle;
import flixel.util.FlxVelocity;
import flixel.util.FlxSpriteUtil;

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
		var status = this.vpad.status;
		if(status != 2) 
		{
			this.velocity.x = 0;
			this.velocity.y = 0;
			return;      
		}

		var angle = this.vpad.getAngle();
		if(angle < 22.5 && angle > -22.5){
			this.velocity.x = 150;
		} else if(angle < 67.5 && angle > 22.5){
			this.velocity.x = 106.06;
			this.velocity.y = 106.06;
		} else if(angle > 112.5 && angle < 157.5){
			this.velocity.x = -106.06;
			this.velocity.y = 106.06;
		} else if( angle > -157.5 && angle < -112.5){
			this.velocity.x = -106.06;
			this.velocity.y = -106.06;
		} else if(angle > -67.5 && angle < -22.5){
			this.velocity.x = 106.06;
			this.velocity.y = -106.06;
		}else if( angle > 157.5  || angle < -157.5){
			this.velocity.x = -150;
		} else if(angle >= -112.5 && angle <= -67.5){
			this.velocity.y = -150;
		} else if(angle > 67.5 && angle < 112.5){
			this.velocity.y = 150;
		}

		if(this.x <= 0){
		      this.x = 0;
		}

		if(this.x >= 800 - this.width){
		      this.x = 800 - this.width;
		}

		if(this.y <= 0){
		      this.y = 0;
		}

		if(this.y >= 800 -  this.height){
		      this.y = 800 - this.height;
		}
	}

}
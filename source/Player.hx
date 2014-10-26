package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.ui.FlxAnalog;
import flixel.util.FlxColor;
import flixel.util.FlxAngle;
import flixel.util.FlxVelocity;
import flixel.util.FlxSpriteUtil;
import flixel.effects.FlxFlicker;

class Player extends FlxSprite
{
	
	private var vpad: FlxAnalog;
	private var level:Int;
	private var minLevel:Int = 1;
	public function new(vpad: FlxAnalog, X:Float = 0, Y:Float = 0) {
		super(X, Y);
		this.level = 1;

		this.vpad = vpad;
		loadGraphic("assets/images/growlem_1.png",true,64,64,false);
		animation.add("UP", [0,1] ,6 ,false);
		animation.play("UP");
		drag.x = drag.y = 1600;
	}

	override public function update() {
		move();
		super.update();
	}

	override public function draw() {
		animation.play("UP");
		if (velocity.x != 0 || velocity.y != 0)
		{
			
		}
			
		super.draw();
	}

	override public function destroy() {
		super.destroy();
	}

	function move() {
		facing = FlxObject.UP;
		var status = this.vpad.status;
		if(status != 2) 
		{
			this.velocity.x = 0;
			this.velocity.y = 0;
			return;      
		}

		var angle = this.vpad.getAngle();
		if(angle < 22.5 && angle > -22.5){
			this.setVelocity(150,0);
		} else if(angle < 67.5 && angle > 22.5){
			this.setVelocity(106.06,106.06);
		} else if(angle > 112.5 && angle < 157.5){
			this.setVelocity(-106.06,106.06);
		} else if( angle > -157.5 && angle < -112.5){
			this.setVelocity(-106.06,-106.06);
		} else if(angle > -67.5 && angle < -22.5){
			this.setVelocity(106.06,-106.06);
		}else if( angle > 157.5  || angle < -157.5){
			this.setVelocity(-150,0);
		} else if(angle >= -112.5 && angle <= -67.5){
			this.setVelocity(0,-150);
		} else if(angle > 67.5 && angle < 112.5){
			this.setVelocity(0,150);
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

	private function setVelocity(X:Float, Y:Float){
		this.velocity.x = X;
		this.velocity.y = Y;
	}

	public function levelUp(){
		this.level++;
		super.makeGraphic(16,16, FlxColor.AQUAMARINE);
	}

	public function levelDown()
	{

		if (FlxFlicker.isFlickering(this)) 
		{
			return;
		}

		FlxFlicker.flicker(this, 3);

		this.level--;
		super.makeGraphic(16,16, FlxColor.AZURE);
		if(this.level < this.minLevel){
			this.kill();
		}
	}

}
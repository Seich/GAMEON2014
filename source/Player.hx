package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.ui.FlxAnalog;
import flixel.util.FlxColor;
import flixel.util.FlxAngle;
import flixel.util.FlxVelocity;
import flixel.util.FlxSpriteUtil;
import flixel.FlxObject;
import flixel.effects.FlxFlicker;

class Player extends FlxSprite
{
	
	private var movementPad: FlxAnalog;
	private var level:Int;
	private var minLevel:Int = 1;
	public function new(movementPad: FlxAnalog, X:Float = 0, Y:Float = 0) {
		super(X, Y);
		this.level = 1;
		this.movementPad = movementPad;
		updateSprite();
		animation.play("down");
		drag.x = drag.y = 1600;
	}

	override public function update() {
		move();
		super.update();
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

	override public function destroy() {
		super.destroy();
	}

	function move() {
		var status = this.movementPad.status;
		if(status != 2) 
		{
			this.velocity.x = 0;
			this.velocity.y = 0;
			return;      
		}

		var angle = this.movementPad.getAngle();
		if(angle < 22.5 && angle > -22.5){
			this.setVelocity(150,0);
			facing = FlxObject.RIGHT;
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
			facing = FlxObject.LEFT;
		} else if(angle >= -112.5 && angle <= -67.5){
			this.setVelocity(0,-150);
			facing = FlxObject.UP;
		} else if(angle > 67.5 && angle < 112.5){
			this.setVelocity(0,150);
			facing = FlxObject.DOWN;
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
		updateSprite();
	}

	public function levelDown(){
		if(FlxFlicker.isFlickering(this)){
		      return;
		}
		FlxFlicker.flicker(this,3);
		this.level--;
		if(this.level < this.minLevel){
			this.kill();
			FlxG.switchState(new GameOverState());
			return;
		}
		updateSprite();
	}

	private function updateSprite(){
		loadGraphic("assets/images/growlem_"+this.level+".png", true, 64, 64);
		this.setGraphicSize(32,32);
		this.updateHitbox();
		animation.add("down", [0,4], 6, false);
		animation.add("up",[1,5],6, false);
		animation.add("left",[2,6],6, false);
		animation.add("right",[3,7],6, false);
	}
}
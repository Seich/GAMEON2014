package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.ui.FlxAnalog;
import flixel.util.FlxColor;
import flixel.util.FlxAngle;

class Player extends FlxSprite
{
	public var speed:Float = 200;
	private var vpad: FlxAnalog;

	public function new(vpad: FlxAnalog, X:Float = 0, Y:Float = 0) {
		super(X, Y);
		this.vpad = vpad;
		super.makeGraphic(16,16, FlxColor.BLUE);
		drag.x = drag.y = 1600;
	}

	override public function update() {
		move();
	}

	override public function destroy() {
		super.destroy();
	}

	function move() {
		var angle = this.vpad.getAngle();
		var status = this.vpad.status;

		if(status != 2) 
		{
			return;      
		}

		trace(angle);
	}

}
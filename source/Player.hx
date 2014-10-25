package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.ui.FlxAnalog;

class Player extends FlxSprite
{
	private var vpad: FlxAnalog;

	public function new(vpad: FlxAnalog) {
		this.vpad = vpad;
		super();
	}

	override public function update() {
		super.makeGraphic(16, 16);

		move();

		super.update();
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
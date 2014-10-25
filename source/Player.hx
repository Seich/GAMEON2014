package;

import flixel.FlxSprite;
import flixel.FlxG;

class Player extends FlxSprite
{
	public function new() {
		super();
	}

	override public function update() {
		super.makeGraphic(16, 16);
		super.update();
	}

	override public function destroy() {
		super.destroy();
	}
}
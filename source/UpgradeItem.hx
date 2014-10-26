
package ;
import flixel.util.FlxColor;

class UpgradeItem extends Item
{
	public function new(X:Float = 0, Y:Float = 0){
		super(X, Y);
		super.makeGraphic(8,8, FlxColor.YELLOW);
	}

	override public function update() {

		super.update();
	}

	override public function destroy() {
		super.destroy();
	}
	

}
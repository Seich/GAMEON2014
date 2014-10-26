
package ;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import Math;

class UpgradeItem extends Item
{
	public function new(X:Float = 0, Y:Float = 0){
		super(X, Y);
		super.loadGraphic("assets/images/gem_"+FlxRandom.intRanged(1,3)+".png",false);
		this.setGraphicSize(16,16);
		this.updateHitbox();

	}

	override public function update() {

		super.update();
	}

	override public function destroy() {
		super.destroy();
	}
	

}
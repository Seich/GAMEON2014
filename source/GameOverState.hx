
package ;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxDestroyUtil;
using flixel.util.FlxSpriteUtil;

class GameOverState extends FlxState
{
	private var _btnRestart:FlxButton;

	override public function create():Void
	{
		var init_x = Math.floor(FlxG.width / 2 - 40);
		_btnRestart = new FlxButton(init_x, 80, "Volver a empezar", restartGame);
		add(_btnRestart);
		super.create();
	}

	override public function destroy():Void
	{
		super.destroy();
		_btnRestart = FlxDestroyUtil.destroy(_btnRestart);
	}

	override public function update():Void
	{
		super.update();
	}

	function restartGame():Void
	{
		FlxG.switchState(new PlayState());
	}


	

}
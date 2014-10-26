
package ;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxTypedButton;
import flixel.util.FlxMath;
import flixel.util.FlxDestroyUtil;
using flixel.util.FlxSpriteUtil;

class GameOverState extends FlxState
{
	private var _btnRestart:FlxTypedButton<FlxSprite>;
	private var gameOverBackground:FlxSprite;

	override public function create():Void
	{
		gameOverBackground = new FlxSprite(0,0, "assets/images/gameover.png");
		gameOverBackground.setGraphicSize(320, 240);
		add(gameOverBackground);

		var init_x = Math.floor(FlxG.width / 2 - 45);
		_btnRestart = new FlxTypedButton(init_x, 160, restartGame);
		_btnRestart.loadGraphic("assets/images/button_reinicio.png");
		_btnRestart.setGraphicSize(90);
		add(_btnRestart);

		super.create();
	}

	override public function destroy():Void
	{
		super.destroy();
		_btnRestart = FlxDestroyUtil.destroy(_btnRestart);
		gameOverBackground = FlxDestroyUtil.destroy(gameOverBackground);
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
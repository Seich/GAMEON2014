package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxTypedButton;
import flixel.util.FlxMath;
import flixel.util.FlxDestroyUtil;
using flixel.util.FlxSpriteUtil;
/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	var btnPlay:FlxTypedButton<FlxSprite>;

	override public function create():Void
	{
		var menuBackground = new FlxSprite(0, 0, "assets/images/mainmenu.png");
		menuBackground.setGraphicSize(320, 240);
		add(menuBackground);

		var logo = new FlxSprite(FlxG.width / 2 - 135, 10, "assets/images/logo.png");
		logo.setGraphicSize(270);
		add(logo);

		btnPlay = new FlxTypedButton(FlxG.width / 2 - 45, 160, newGame);
		btnPlay.loadGraphic("assets/images/button_inicio.png");
		btnPlay.setGraphicSize(90);
		add(btnPlay);
		super.create();
	}

	function newGame():Void 
	{
		FlxG.switchState(new PlayState());
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
		btnPlay = FlxDestroyUtil.destroy(btnPlay);
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}
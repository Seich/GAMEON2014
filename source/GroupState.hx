
package ;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.util.FlxDestroyUtil;

class GroupState extends FlxState
{

	private var groupLogo:FlxSprite;
	private var timer:FlxTimer;

	override public function create():Void
	{
		groupLogo = new FlxSprite(0, 0, "assets/images/groupmenu.png");
		groupLogo.setGraphicSize(320, 240);
		add(groupLogo);
		super.create();
		timer = new FlxTimer(1.5, nextState , 1);
	}

	function nextState(t:FlxTimer) {
		FlxG.switchState(new MenuState());
	}

	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		timer = FlxDestroyUtil.destroy(timer);
		groupLogo = FlxDestroyUtil.destroy(groupLogo);
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	

}
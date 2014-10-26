package ;

import flixel.tile.FlxTilemap;
import openfl.Assets;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.group.FlxTypedGroup;

class Level extends FlxTilemap
{
	private var TILE_WIDTH:Int = 32;
	private var TILE_HEIGHT:Int = 32;

	public function new(map: String, tileset = "assets/images/tiles.png")
	{
		super();

		this.loadMap(Assets.getText(map), tileset, TILE_WIDTH, TILE_HEIGHT, 0, 0);
		this.setTileProperties(0, FlxObject.NONE);
		this.setTileProperties(1, FlxObject.NONE);
		this.setTileProperties(2, FlxObject.ANY);
		FlxG.worldBounds.set(0, 0, this.width, this.height);
	}	
}
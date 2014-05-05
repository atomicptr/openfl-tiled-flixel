## openfl-tiled-flixel

Experimental glue to use [openfl-tiled](https://github.com/kasoki/openfl-tiled) with HaxeFlixel

### Reporting Issues

If you want to report issues please use the [openfl-tiled issue report](https://github.com/kasoki/openfl-tiled/issues)

### Install openfl-tiled-flixel

	haxelib install openfl-tiled-flixel
	
Please note that this package depends on openfl-tiled.

	
### How to install the development version?

To install the current development version you just need to run this in your terminal:

	haxelib git openfl-tiled-flixel https://github.com/kasoki/openfl-tiled-flixel dev

### Usage

You just need to use FlxTiledMap instead of TiledMap:

```haxe
var map = FlxTiledMap.fromAssets("assets/map.tmx");

this.add(map); // FlxTiledMap is a FlxGroup
```
	
Each layer is a FlxGroup of FlxSprites (each tile is a FlxSprite) which are not active (which means that the update method is not called). If you want to make a layer active to use it e.g. for collision detection read the snippet below:

```haxe
// TODO: add flixel import statements here
import openfl.tiled.FlxTiledMap;
import openfl.tiled.FlxLayer;

class TiledTestState extends FlxState {
	
	private var map:FlxTiledMap;
	private var sprite:FlxSprite;
	
	// FlxLayer is a FlxGroup of tiles
	private var colliderLayer:FlxLayer;
	
	public override function create():Void {
		super.create();
		
		map = FlxTiledMap.fromAssets("assets/map/test.tmx");
		
		sprite = new FlxSprite(30, 30);
		sprite.makeGraphic(32, 32, FlxColor.RED);
		
		sprite.acceleration.y = 200;
		
		// get the layer named "collider"
		colliderLayer = map.getLayerByName("collider");
		
		// set the layer to active (update method will be called -> collision detection will be enabled)
		colliderLayer.setActive(true);
		
		this.add(map);
		this.add(sprite);
	}
	
	public override function destroy():Void {
		super.destroy();
	}
	
	public override function update():Void {
		super.update();
		
		FlxG.collide(sprite, colliderLayer);
	}
}
```

### Licence

openfl-tiled-flixel is licenced under the terms of the MIT licence.

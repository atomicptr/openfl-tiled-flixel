## openfl-tiled-flixel

Experimental glue to use [openfl-tiled](https://github.com/kasoki/openfl-tiled) with HaxeFlixel

### Reporting Issues

If you want to report issues please use the [openfl-tiled issue report](https://github.com/kasoki/openfl-tiled/issues)

### Install openfl-tiled-flixel

	haxelib install openfl-tiled-flixel
	
Please note that this package depends on openfl-tiled.

### Usage

You just need to use FlxTiledMap instead of TiledMap:

	var map = FlxTiledMap.fromAssets("assets/map.tmx");
	
	this.add(map); // FlxTiledMap is a FlxGroup

### Licence

openfl-tiled-flixel is licenced under the terms of the MIT licence.
package openfl.tiled;

import flash.geom.Rectangle;
import flash.geom.Point;
import flash.display.BitmapData;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

import openfl.tiled.TiledMap;
import openfl.tiled.Tileset;
import openfl.tiled.TiledMapOrientation;

class FlxTiledMap extends FlxGroup {

	public var map(default, null):TiledMap;

	public var layers:Array<FlxGroup>;

	private function new(map:TiledMap) {
		super();

		this.map = map;
		this.layers = new Array<FlxGroup>();

		setup();
	}

	private function setup() {

		for(layer in this.map.layers) {

			var gidCounter:Int = 0;
			var layerGroup:FlxGroup = new FlxGroup();

			if(layer.visible) {
				for(y in 0...this.map.heightInTiles) {
					for(x in 0...this.map.widthInTiles) {
						var nextGID = layer.tiles[gidCounter].gid;

						if(nextGID != 0) {
							var position:Point = new Point();

							switch (this.map.orientation) {
								case TiledMapOrientation.Orthogonal:
									position = new Point(x * this.map.tileWidth, y * this.map.tileHeight);
								case TiledMapOrientation.Isometric:
									position = new Point((this.map.width + x - y - 1) * this.map.tileWidth * 0.5, (y + x) * this.map.tileHeight * 0.5);
							}

							var tileset:Tileset = this.map.getTilesetByGID(nextGID);
							var rect:Rectangle = tileset.getTileRectByGID(nextGID);
							var texture:BitmapData = tileset.image.texture;

							var sprite:FlxSprite = new FlxSprite();

							sprite.x = position.x;
							sprite.y = position.y;

							sprite.solid = true;
							sprite.immovable = true;

							var bitmapData:BitmapData = new BitmapData(32, 32, true);

							bitmapData.copyPixels(texture, rect, new Point(0, 0), null, null, true);

							sprite.pixels = bitmapData;

							layerGroup.add(sprite);
						}

						gidCounter++;
					}
				}
			}

			this.layers.push(layerGroup);
		}

		// add FlxGroup-layers to map
		for(layer in this.layers) {
			this.add(layer);
		}
	}

	public static function fromAssets(path:String):FlxTiledMap {
		var map = TiledMap.fromAssets(path);

		return new FlxTiledMap(map);
	}
}
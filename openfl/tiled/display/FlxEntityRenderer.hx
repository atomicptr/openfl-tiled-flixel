package openfl.tiled.display;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

import openfl.tiled.display.Renderer;

class FlxEntityRenderer implements Renderer {

	private var map:TiledMap;

	private var _tileCache:Map<Int, BitmapData>;

	public function new() {
		this._tileCache = new Map<Int, BitmapData>();
	}

	public function setTiledMap(map:TiledMap):Void {
		this.map = map;
	}

	public function drawLayer(on:Dynamic, layer:Layer):Void {
		var gidCounter:Int = 0;
		var flxLayer:FlxLayer = new FlxLayer(layer);

		if(layer.visible) {
			for(y in 0...map.heightInTiles) {
				for(x in 0...map.widthInTiles) {
					var tile = layer.tiles[gidCounter];

					var nextGID = tile.gid;

					if(nextGID != 0) {
						var position:Point = new Point();

						switch (map.orientation) {
							case TiledMapOrientation.Orthogonal:
								position = new Point(x * map.tileWidth, y * map.tileHeight);
							case TiledMapOrientation.Isometric:
								position = new Point((map.width + x - y - 1) * map.tileWidth * 0.5, (y + x) * map.tileHeight * 0.5);
						}

						var bitmapData:BitmapData;

						if(!this._tileCache.exists(nextGID)) {
							var tileset:Tileset = map.getTilesetByGID(nextGID);
							var rect:Rectangle = tileset.getTileRectByGID(nextGID);
							var texture:BitmapData = tileset.image.texture;

							bitmapData = new BitmapData(map.tileWidth, map.tileHeight,
								true, map.backgroundColor);

							bitmapData.copyPixels(texture, rect, new Point(0, 0));

							this._tileCache.set(nextGID, bitmapData);
						} else {
							bitmapData = this._tileCache.get(nextGID);
						}

						if(map.orientation == TiledMapOrientation.Isometric) {
							position.x += map.totalWidth/2;
						}

						var flxTile:FlxTile = new FlxTile(tile, bitmapData);

						flxTile.x = position.x;
						flxTile.y = position.y;

						flxLayer.add(flxTile);
					}

					gidCounter++;
				}
			}
		}

		flxLayer.setAll("alpha", layer.opacity);
		on.layers.push(flxLayer);
	}

	public function drawImageLayer(on:Dynamic, imageLayer:ImageLayer):Void {

	}

	public function clear(on:Dynamic):Void {
	}
}
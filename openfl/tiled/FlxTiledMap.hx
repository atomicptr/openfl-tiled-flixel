// Copyright (C) 2013 Christopher "Kasoki" Kaster
//
// This file is part of "openfl-tiled-flixel". <http://github.com/Kasoki/openfl-tiled-flixel>
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
package openfl.tiled;

import flash.geom.Rectangle;
import flash.geom.Point;
import flash.display.BitmapData;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

class FlxTiledMap extends FlxGroup {

	public var _map(default, null):TiledMap;

	public var layers:Array<FlxLayer>;

	private function new(map:TiledMap) {
		super();

		this._map = map;
		this.layers = new Array<FlxLayer>();

		setup();
	}

	private function setup() {

		for(layer in this._map.layers) {

			var gidCounter:Int = 0;
			var flxLayer:FlxLayer = new FlxLayer(layer);

			if(layer.visible) {
				for(y in 0...this._map.heightInTiles) {
					for(x in 0...this._map.widthInTiles) {
						var nextGID = layer.tiles[gidCounter].gid;

						if(nextGID != 0) {
							var position:Point = new Point();

							switch (this._map.orientation) {
								case TiledMapOrientation.Orthogonal:
									position = new Point(x * this._map.tileWidth, y * this._map.tileHeight);
								case TiledMapOrientation.Isometric:
									position = new Point((this._map.width + x - y - 1) * this._map.tileWidth * 0.5, (y + x) * this._map.tileHeight * 0.5);
							}

							var tileset:Tileset = this._map.getTilesetByGID(nextGID);
							var rect:Rectangle = tileset.getTileRectByGID(nextGID);
							var texture:BitmapData = tileset.image.texture;

							var sprite:FlxSprite = new FlxSprite();

							sprite.x = position.x;
							sprite.y = position.y;

							sprite.solid = true;
							sprite.immovable = true;
							sprite.active = false;

							var bitmapData:BitmapData = new BitmapData(32, 32, true);

							bitmapData.copyPixels(texture, rect, new Point(0, 0), null, null, true);

							sprite.pixels = bitmapData;

							flxLayer.add(sprite);
						}

						gidCounter++;
					}
				}
			}

			this.layers.push(flxLayer);
		}

		// add FlxLayer to map
		for(layer in this.layers) {
			this.add(layer);
		}
	}

	public function getLayerByName(name:String):FlxLayer {
		for(layer in this.layers) {
			if(layer._layer.name == name) {
				return layer;
			}
		}

		return null;
	}

	public static function fromAssets(path:String):FlxTiledMap {
		var map = TiledMap.fromAssets(path);

		return new FlxTiledMap(map);
	}
}
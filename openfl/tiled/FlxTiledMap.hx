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
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;

import openfl.tiled.display.Renderer;
import openfl.tiled.display.FlxEntityRenderer;

class FlxTiledMap extends FlxTypedGroup<FlxLayer> {

	public var _map(default, null):TiledMap;

	public var layers:Array<FlxLayer>;

	public var totalWidth(get, null):Int;
	public var totalHeight(get, null):Int;
	public var widthInTiles(get, null):Int;
	public var heightInTiles(get, null):Int;

	public var renderer(default, null):Renderer;

	private function new(map:TiledMap) {
		super();

		this._map = map;
		this.layers = new Array<FlxLayer>();

		this.renderer = this._map.renderer;

		setup();
	}

	private function setup() {
		for(layer in this._map.layers) {
			renderer.drawLayer(this, layer);
		}

		for(imageLayer in this._map.imageLayers) {
			renderer.drawImageLayer(this, imageLayer);
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

	private function get_totalWidth():Int {
		return this._map.totalWidth;
	}

	private function get_totalHeight():Int {
		return this._map.totalHeight;
	}

	private function get_widthInTiles():Int {
		return this._map.widthInTiles;
	}

	private function get_heightInTiles():Int {
		return this._map.heightInTiles;
	}

	public static function fromAssets(path:String):FlxTiledMap {
		var renderer = new FlxEntityRenderer();

		var map = TiledMap.fromAssetsWithAlternativeRenderer(path, renderer, false);

		return new FlxTiledMap(map);
	}
}
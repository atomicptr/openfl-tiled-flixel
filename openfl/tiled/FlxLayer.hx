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

import flixel.FlxG;
import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;

import openfl.tiled.Layer;

class FlxLayer extends FlxTypedGroup<FlxTile> {

	public var _layer:Layer;
	public var isActive(default, null):Bool;

	public function new(tiledLayer:Layer) {
		super();

		this._layer = tiledLayer;

		this.isActive = false;
	}

	public function setActive(active:Bool) {
		this.isActive = active;

		updateTiles();
	}

	private function updateTiles() {
		var layer:FlxLayer = this;

		this.forEach(function(basic:FlxBasic) {
			var tile:FlxTile = cast(basic, FlxTile);

			tile.active = layer.isActive;
		});
	}
}
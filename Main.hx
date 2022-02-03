package;

import h3d.Vector;

class StrokeHeapsFilter extends h3d.shader.ScreenShader{
	static var SRC = {
		@param var texture : Sampler2D;
		@param var size:Vec2 = vec2(1,1);
		@param var color:Vec4 = vec4(0,0,0,1);
		function fragment() {
			// Get original pixel color
			var sample:Vec4 = texture.get(calculatedUV);
			// If this pixel has no alpha
			if (sample.a == 0.) {
				// Get distance to check for surrounding pixels
				var w:Float = size.x / texture.size().x;
				var h:Float = size.y / texture.size().y;
				
				// If surrounding pixels exist up/down/left/right, extract the color
				if (texture.get(vec2(calculatedUV.x + w, calculatedUV.y)).a != 0.
				|| texture.get(vec2(calculatedUV.x - w, calculatedUV.y)).a != 0.
				|| texture.get(vec2(calculatedUV.x, calculatedUV.y + h)).a != 0.
				|| texture.get(vec2(calculatedUV.x, calculatedUV.y - h)).a != 0.) {
					sample = color;
				}
			}

			// Apply color
			pixelColor = sample;
		}
	}
}

class Main extends hxd.App {

	override function init() {
		var obj : h2d.Object;
		obj = new h2d.Object(s2d);
		obj.x = Std.int(s2d.width / 2);
		obj.y = Std.int(s2d.height / 2);

		// Add haxe logo to screen
		var tile = hxd.Res.hxlogo.toTile();
		tile = tile.center();
		var bmp = new h2d.Bitmap(tile, obj);

		// Create a thick read outline around the bitmap
		var filter = new StrokeHeapsFilter();
		filter.color = Vector.fromColor(0xff0000);
		filter.size = new Vector(5, 5);
		var filterShader = new h2d.filter.Shader(filter);

		// Attempting the same thing as above but with Outline2D (also doesn't completely work since outline isn't thick enough, but doesn't error at least)
		/*
		var shader = new h3d.shader.Outline2D();
		shader.color = Vector.fromColor(0xff0000);
		shader.size =  new Vector(5,5);
		var filterShader = new h2d.filter.Shader(shader);
		*/

		// Apply filter
		bmp.filter = filterShader;
	}

	override function update(dt:Float) {
	}

	static function main() {
		hxd.Res.initEmbed();
		new Main();
	}
}
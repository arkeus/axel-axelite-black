package net.axgl.black.world {
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import net.axgl.black.assets.Resource;
	import net.axgl.black.world.Tile;

	import org.axgl.tilemap.AxTilemap;

	public class WorldBuilder {
		public var map:AxTilemap;
		public var pixels:BitmapData;
		public var borders:BitmapData;

		private var x:uint;
		private var y:uint;

		private var cp:uint;
		private var lp:uint, rp:uint, dp:uint, up:uint;
		private var ulp:uint, urp:uint, dlp:uint, drp:uint;
		private var blp:uint, brp:uint, bdp:uint, bup:uint;
		private var l:Boolean, r:Boolean, d:Boolean, u:Boolean;
		private var ul:Boolean, ur:Boolean, dl:Boolean, dr:Boolean;
		private var bl:Boolean, br:Boolean, bd:Boolean, bu:Boolean;

		public function WorldBuilder(map:Class) {
			pixels = (new map as Bitmap).bitmapData;
		}

		public function build():WorldBuilder {
			preprocessPixels();
			var terrain:String = buildTerrain();
			map = new AxTilemap;
			map.build(terrain, Resource.TILESET, Tile.SIZE, Tile.SIZE, 1, 20, 20);
			return this;
		}

		private function buildTerrain():String {
			var rows:Vector.<String> = new Vector.<String>;
			var row:Vector.<uint> = new Vector.<uint>;
			for (var y:uint = 0; y < pixels.height; y++) {
				row.length = 0;
				for (var x:uint = 0; x < pixels.width; x++) {
					initializeTile(x, y);
					var tile:uint = getTile();
					row.push(tile);
				}
				rows.push(row.join(","));
			}
			return rows.join("\n");
		}

		private function initializeTile(x:uint, y:uint):void {
			this.x = x;
			this.y = y;

			cp = pixels.getPixel(x, y);
			up = pixels.getPixel(x, y - 1);
			lp = pixels.getPixel(x - 1, y);
			dp = pixels.getPixel(x, y + 1);
			rp = pixels.getPixel(x + 1, y);
			ulp = pixels.getPixel(x - 1, y - 1);
			urp = pixels.getPixel(x + 1, y - 1);
			dlp = pixels.getPixel(x - 1, y + 1);
			drp = pixels.getPixel(x + 1, y + 1);
			bup = borders.getPixel(x, y - 1);
			blp = borders.getPixel(x - 1, y);
			bdp = borders.getPixel(x, y + 1);
			brp = borders.getPixel(x + 1, y);
			l = cp == lp || x == 0;
			r = cp == rp || x == pixels.width - 1;
			d = cp == dp || y == pixels.height - 1;
			u = cp == up || y == 0;
			ul = cp == ulp || x == 0 || y == 0;
			ur = cp == urp || x == pixels.width - 1 || y == 0;
			dl = cp == dlp || x == 0 || y == pixels.height - 1;
			dr = cp == drp || x == pixels.width - 1 || y == pixels.height - 1;
			bl = BORDER == blp;
			br = BORDER == brp;
			bd = BORDER == bdp;
			bu = BORDER == bup;
		}

		private function getTile():uint {
			var start:uint = getTileStart();
			var offset:int = getTileOffset() + 1;
			var tile:uint = start + offset;

			if (isTerrain(cp)) {
				if (offset < 0) {
					return 1;
				}
				return tile;
			} else {
				return 0;
			}
		}

		private function getTileStart():uint {
			return 10;
		}

		private function getTileOffset():int {
			if (u && d && r && l && ul && ur && dl && dr) {
				if (bl && bu && br) {
					return 45;
				} else if (bu && br && bd) {
					return 46;
				} else if (br && bd && bl) {
					return 47;
				} else if (bd && bl && bu) {
					return 48;
				} else if (bl && bu) {
					return 16;
				} else if (bu && br) {
					return 17;
				} else if (bl && bd) {
					return 26;
				} else if (br && bd) {
					return 27;
				} else if (bd) {
					return 2;
				} else if (br) {
					return 20;
				} else if (bl) {
					return 24;
				} else if (bu) {
					return 42;
				}
				return -1;
			} else {
				if (u && l && d && r) {
					if (!ul) {
						return 33;
					} else if (!ur) {
						return 31;
					} else if (!dr) {
						return 11;
					} else if (!dl) {
						return 13;
					}
				} else if (u && l && d) {
					return 21;
				} else if (l && u && r) {
					return 12;
				} else if (u && r && d) {
					return 23;
				} else if (l && d && r) {
					return 32;
				} else if (d && r) {
					return 5;
				} else if (l && d) {
					return 8;
				} else if (u && r) {
					return 35;
				} else if (u && l) {
					return 38;
				}
				return 0;
			}
		}

		private function preprocessPixels():void {
			borders = new BitmapData(pixels.width, pixels.height, true, 0x00ff00ff);
			for (var x:uint = 0; x < pixels.width; x++) {
				for (var y:uint = 0; y < pixels.height; y++) {
					if (x == 0 || y == 0 || x == pixels.width - 1 || y == pixels.height - 1) {
						continue;
					}
					var pixel:uint = pixels.getPixel(x, y);
					if (isTerrain(pixel)) {
						var u:Boolean = pixels.getPixel(x, y - 1) != pixel;
						var d:Boolean = pixels.getPixel(x, y + 1) != pixel;
						var l:Boolean = pixels.getPixel(x - 1, y) != pixel;
						var r:Boolean = pixels.getPixel(x + 1, y) != pixel;
						var ul:Boolean = pixels.getPixel(x - 1, y - 1) != pixel;
						var ur:Boolean = pixels.getPixel(x + 1, y - 1) != pixel;
						var dl:Boolean = pixels.getPixel(x - 1, y + 1) != pixel;
						var dr:Boolean = pixels.getPixel(x + 1, y + 1) != pixel;
						if (u || d || l || r || ul || ur || dl || dr) {
							borders.setPixel32(x, y, 0xff000000 | BORDER);
						}
					}
				}
			}
		}

		private static const DIRT:uint = 0x754500;
		private static const BORDER:uint = 0xff0000;

		private function isTerrain(pixel:uint):Boolean {
			return pixel == DIRT;
		}
	}
}

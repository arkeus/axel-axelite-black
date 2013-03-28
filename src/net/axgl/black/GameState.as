package net.axgl.black {
	import net.axgl.black.assets.Resource;
	import net.axgl.black.entity.Player;
	import net.axgl.black.world.Tile;
	import net.axgl.black.world.WorldBuilder;
	
	import org.axgl.Ax;
	import org.axgl.AxState;
	import org.axgl.input.AxKey;
	import org.axgl.input.AxMouseButton;
	import org.axgl.tilemap.AxTilemap;

	public class GameState extends AxState {
		private static const CAMERA_SPEED:Number = 20;
		private static const COPIES:Number = 1;
		
		private var map:AxTilemap;
		private var player:Player;
		
		override public function create():void {
			var builder:WorldBuilder = new WorldBuilder(Resource.MAP_TINY).build();
			//var builder:WorldBuilder = new WorldBuilder(Resource.MAP).build();
			for (var i:uint = 0; i < COPIES; i++) {
				this.add(map = builder.map);
			}
			this.add(player = new Player(70, 20));
		}
		
		override public function update():void {
			if (Ax.keys.down(AxKey.RIGHT)) {
				Ax.camera.x += CAMERA_SPEED;
			} else if (Ax.keys.down(AxKey.LEFT)) {
				Ax.camera.x -= CAMERA_SPEED;
			}
			if (Ax.keys.down(AxKey.DOWN)) {
				Ax.camera.y += CAMERA_SPEED;
			} else if (Ax.keys.down(AxKey.UP)) {
				Ax.camera.y -= CAMERA_SPEED;
			}
			
			var ox:uint = 90;
			var oy:uint = 5;
			
			if (Ax.keys.pressed(AxKey.SPACE)) {
				map.removeTileAt(ox + 0, oy + 0);
				map.removeTileAt(ox + 1, oy + 0);
				map.removeTileAt(ox + 2, oy + 0);
				map.removeTileAt(ox + 0, oy + 2);
				map.removeTileAt(ox + 1, oy + 2);
				map.removeTileAt(ox + 2, oy + 2);
			}
			
			if (Ax.keys.pressed(AxKey.Z)) {
				map.setTileAt(ox + 0, oy + 0, 16);
			}
			
			if (Ax.mouse.pressed(AxMouseButton.LEFT)) {
				var tx:int = Ax.mouse.x / Tile.SIZE;
				var ty:int = Ax.mouse.y / Tile.SIZE;
				if (map.getTileAt(tx, ty) != null) {
					map.removeTileAt(tx, ty);
				} else {
					map.setTileAt(tx, ty, 16);
				}
			}
			
			super.update();
			
			Ax.collide(player, map);
		}
	}
}

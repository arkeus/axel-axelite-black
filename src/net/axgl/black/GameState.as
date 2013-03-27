package net.axgl.black {
	import net.axgl.black.assets.Resource;
	import net.axgl.black.world.WorldBuilder;
	
	import org.axgl.Ax;
	import org.axgl.AxState;
	import org.axgl.input.AxKey;
	import org.axgl.tilemap.AxTilemap;

	public class GameState extends AxState {
		private var map:AxTilemap;
		
		override public function create():void {
			var builder:WorldBuilder = new WorldBuilder(Resource.MAP_GIANT).build();
			this.add(map = builder.map);
		}
		
		private static const CAMERA_SPEED:Number = 20;
		override public function update():void {
			if (Ax.keys.down(AxKey.D)) {
				Ax.camera.x += CAMERA_SPEED;
			} else if (Ax.keys.down(AxKey.A)) {
				Ax.camera.x -= CAMERA_SPEED;
			}
			if (Ax.keys.down(AxKey.S)) {
				Ax.camera.y += CAMERA_SPEED;
			} else if (Ax.keys.down(AxKey.W)) {
				Ax.camera.y -= CAMERA_SPEED;
			}
		}
	}
}

package {
	import net.axgl.black.GameState;

	import org.axgl.Ax;

	public class AxeliteBlack extends Ax {
		public function AxeliteBlack() {
			super(GameState);
		}

		override public function create():void {
			Ax.background.hex = 0xff000000;
		}
	}
}

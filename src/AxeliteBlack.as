package {
	import net.axgl.black.GameState;

	import org.axgl.Ax;
	
	[SWF(width = "800", height = "600", backgroundColor = "#000000")]

	public class AxeliteBlack extends Ax {
		public function AxeliteBlack() {
			super(GameState);
		}

		override public function create():void {
			Ax.background.hex = 0xff000000;
			Ax.debuggerEnabled = true;
		}
	}
}

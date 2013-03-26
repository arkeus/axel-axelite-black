package net.axgl.black {
	import org.axgl.Ax;
	import org.axgl.AxState;
	import org.axgl.resource.AxResource;
	import org.axgl.text.AxText;

	public class GameState extends AxState {
		override public function create():void {
			Ax.background.hex = 0xff666666;
			this.add(new AxText(10, 50, AxResource.FONT, "Empty Project... So Far!"));
		}
	}
}

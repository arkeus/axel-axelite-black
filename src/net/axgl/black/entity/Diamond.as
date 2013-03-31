package net.axgl.black.entity {
	import net.axgl.black.assets.Resource;
	
	import org.axgl.AxSprite;
	import org.axgl.AxU;

	public class Diamond extends AxSprite {
		public var collected:Boolean = false;
		
		public function Diamond(x:uint, y:uint) {
			super(x, y, Resource.DIAMOND, 11, 11);
			origin.x = origin.y = width / 2;
			show(AxU.rand(0, 4));
		}
	}
}

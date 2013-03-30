package net.axgl.black.entity {
	import net.axgl.black.assets.Resource;
	
	import org.axgl.Ax;
	import org.axgl.AxSprite;
	import org.axgl.input.AxKey;
	
	public class Player extends AxSprite {
		private var JUMP_TIME:Array = [0.2, 0.03, 0.03];
		private var jumpTimers:Array = [0, 0, 0];
		private var jumping:Boolean = false;
		
		public function Player(x:uint, y:uint) {
			super(x, y, Resource.PLAYER, 16, 24);
			
			offset.y = 8;
			height = 14;
			offset.x = 4;
			width = 8;
			
			addAnimation("walk", [0, 1, 2, 3, 4], 7, true);
			addAnimation("stand", [6, 7], 4, true);
			addAnimation("jump", [5]);
			animate("stand");
			
			acceleration.y = 700;
		}
		
		override public function update():void {
			handleInput();
			handleFacing();
			super.update();
		}
		
		private function handleInput():void {
			// Movement
			if (Ax.keys.down(AxKey.D)) {
				velocity.x = speed;
			} else if (Ax.keys.down(AxKey.A)) {
				velocity.x = -speed;
			} else {
				velocity.x = 0;
			}
			
			// Jump
			var jumpAbility:Array = [true, true, false];
			for (var i:uint = 0; i < jumpTimers.length; i++) {
				if (!jumpAbility[i] || jumpTimers[i] <= 0) {
					continue;
				}
				
				if (Ax.keys.pressed(AxKey.W)) {
					jumping = true;
				}
				
				if (Ax.keys.down(AxKey.W) && jumping) {
					jumpTimers[i] -= Ax.dt;
					if (jumpTimers[i] <= 0 || isTouching(UP)) {
						jumping = false;
					}
					velocity.y = -200;
				} else if (jumping) {
					jumping = false;
					var ratio:Number = 1 - jumpTimers[i] / (JUMP_TIME[i] + 2 * 0.015);
					var limit:Number = ratio * -100;
					if (limit > -50)
						limit = -50;
					if (velocity.y < limit) {
						velocity.y = limit;
					}
					jumpTimers[i] = 0;
				} else if (jumpTimers[i] != JUMP_TIME[i] + 2 * 0.01) {
					jumpTimers[i] = 0;
				}
				
				break;
			}
			
			if (!isTouching(DOWN) && !Ax.keys.down(AxKey.W)) {
				jumpTimers[0] = 0;
			}
			
			if (isTouching(DOWN)) {
				for (i = 0; i < jumpTimers.length; i++) {
					jumpTimers[i] = JUMP_TIME[i] + 2 * 0.01;
				}
			}
		}
		
		private function handleFacing():void {
			if (center.x < Ax.mouse.x) {
				facing = RIGHT;
			} else {
				facing = LEFT;
			}
		}
		
		public function get speed():Number {
			return 120;
		}
	}
}
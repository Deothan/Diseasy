package Common{
	import Main.View;
	
	import Platforms.Platform;
	
	import Player.Player;
	
	public class Physicus{
		/* constant variables */
		private static var Entities:Array = new Array();
		private static var instance:Physicus;
		private static const GRAVITY:Number = 0.8;
		private static const KENETIC:Number = 0.5;
		private static const HITFORCE:Number = 15;
		/* variable variables */
		private static var _verticalVelocity:Number;
		private static var _disableGravity:Boolean;
		
		/**
		 * constructor method
		 */
		public function Physicus(){
			_verticalVelocity = 0;
			_disableGravity = false;
		}
		
		/**
		 * Singleton
		 */
		public static function usePhysics():Physicus{
			if (instance == null){
					instance = new Physicus();
			}
			return instance;
		}
		
		/**
		 * method to crosscheck player with entities borders
		 * single for loop, growth: O(n)
		 */
		public function Collision():void{
			var playerLeft:int = View.GetInstance().GetPlayer().getX() - (View.GetInstance().GetPlayer().getWidth() / 2);
			var playerRight:int = View.GetInstance().GetPlayer().getX() + (View.GetInstance().GetPlayer().getWidth() / 2);
			var playerBottom:int = View.GetInstance().GetPlayer().getY() + (View.GetInstance().GetPlayer().getHeight() / 2);
			var playerTop:int = View.GetInstance().GetPlayer().getY() - (View.GetInstance().GetPlayer().getHeight() / 2);
			for each(var entity:Object in Entities){
				var entityLeft:int = entity.x - (entity.getWidth() / 2);
				var entityRight:int = entity.x + (entity.getWidth() / 2);
				var entityBottom:int = entity.y + (entity.getHeight() / 2);
				var entityTop:int = (entity.y - (entity.getHeight() / 2) -35);
				
				if(entity is Platform){
					if(playerLeft >= entityLeft && playerLeft <= entityRight && playerTop <= entityTop && playerBottom >= entityTop){
						trace("[Physicus] Collide with platform object");
						_disableGravity = true;
						View.GetInstance().GetPlayer().y = entityTop;
						_verticalVelocity *= 0;
					}
					else{
						_disableGravity = false;
						//do nothing
					}
				}
				else if(playerBottom >= entityTop && playerRight >= entityLeft && playerRight <= entityRight){
					trace("[Physicus] Collide with none platform object");
					if(entity is Item){
						//View.GetInstance().GetPlayer().addItem(entity);
						entity.Destroy();
					}
				}
				
			}
		}
		
		/**
		 * method to see if player is landed, referenced by level
		 * @return Boolean true = grounded, false = not grounded
		 */
		public function isGrounded():Boolean{
			if(View.GetInstance().GetPlayer().y >= 205 || _disableGravity){
				return true;
			}
			else{
				return false;
			}
		}
		
		/**
		 * method to apply gravity to player (falling)
		 * if player is not grounded (stage.y = 205)
		 */
		public function Gravity():void{
			if(_disableGravity){
				//do nothing	
			}
			else{
				View.GetInstance().GetPlayer().y += _verticalVelocity;
				if(View.GetInstance().GetPlayer().y >= 205){
					//trace("[Physicus] Gravity-> grounded");
					_verticalVelocity *= 0;
					View.GetInstance().GetPlayer().y = 205;
				}
				else{
					//trace("[Physicus] Gravity-> air");
					_verticalVelocity += GRAVITY;
				}
			}
		}
		
		/**
		 * method to apply vertical velocity to player (jumping)
		 */
		public function Kinetics():void{
			trace("[Physicus] Kinetics");
			_verticalVelocity -= HITFORCE;
		}
		
		/**
		 * method to add entities to array
		 */
		public function addEntity(_entity:Object):void{
			Entities.push(_entity);
		}
	}
}
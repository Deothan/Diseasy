/**
 * Product owner: Hanze University of Applied Sciences
 * This class is not allowed to be copied or sold except with explicit permission from Hanze: University of Applied Sciences
 * @author:    Kevin Stoffers
 * @version: 1 (29/11/2015)
 * @version: 2 (02/12/2015)
 * UNLOCK (find in map) , SWITCHANIMATION, life (has to be reflected in lvl1:shownLife),  
 */
package Player
{
    /**
     * Load external libraries
     */
    import flash.filesystem.File;
    
    import starling.core.Starling;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.utils.AssetManager;
    
    /**
     * This class contains an instance of the player class. By calling the constructor a new instance is initiated
     */
    public class Player extends Sprite {
       /* parameters 
		* @param life, nr of hearts
        */       
		private var life:int = 5;
		private var currentAnimation:String;
		private var animations:Array;
		private var assetManager:AssetManager;
		private var unlock1:Boolean = true;
		private var unlock2:Boolean = false;
		private var unlock3:Boolean = false;
		private var unlock4:Boolean = false;
        
       /**
         * Class constructor sets stage, desired position x and desired position y
         */    
        public function Player() {  
			animations = new Array();
        	addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function loadAnimations():void{
			var run_animation:MovieClip = new MovieClip(assetManager.getTextures("Mole"), 24);
			animations["run"] = run_animation;
		}
				
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Player/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			loadAnimations();
			switchAnimations("run");
		}

		public function getLife():int{
			return this.life;
		}
		
		public function getUnlock():Array{
			var unlock:Array = new Array();
			unlock[0] = unlock1;
			unlock[1] = unlock2;
			unlock[2] = unlock3;
			unlock[3] = unlock4;
			return unlock;
		}
		
		public function setUnlock(level:int):void{
			if (level == 2){
				unlock2 = true;
			}
			else if(level == 3){
				unlock3 = true;
			}
			else if(level == 4){
				unlock4 = true;
			}
		}
		
		public function setLife(_life:int):void{
			this.life = _life; 
		}
		
		//before monday
		public function jump(name:String):void{
			
		}
		
		/**
		 * Method that changes animation
		 * @param: _animation possibilities: run - jump - hit
		 */
		public function switchAnimations(_animation:String):void{
			if(currentAnimation == null){
				addChild(animations[_animation]);
				Starling.juggler.add(animations[_animation]);
				currentAnimation = _animation;
			}
			else if(_animation.localeCompare(currentAnimation)==0){
				//animation is already playing, do nothing
			}
			else{
				var currentX:int = animations[currentAnimation].x;
				var currentY:int = animations[currentAnimation].y; 
				animations[currentAnimation].stop();
				removeChild(animations[currentAnimation]);
				Starling.juggler.add(animations[_animation]);
				animations[_animation].x = currentX;
				animations[_animation].y = currentY;
				currentAnimation = _animation;
			}
		}
		
		public function destroy():void{
			removeEventListener(Event.ADDED_TO_STAGE, Initialize);
			assetManager.dispose();
		}
		
    }
}
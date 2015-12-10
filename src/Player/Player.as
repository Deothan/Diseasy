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
    
    import Common.Item;
    
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
		private var coins:int = 0;
		private var currentAnimation:String;
		private var animations:Array;
		private var assetManager:AssetManager;
		private var unlock:Array = new Array;
		private var unlock1:Boolean = true;
		private var unlock2:Boolean = false;
		private var unlock3:Boolean = false;
		private var unlock4:Boolean = false;
		private var unlock5:Boolean = false;
		private var looks:Array = new Array();
		public var items:Array = new Array();
		private var name:String;
		private var spawned:Boolean = false;
		private var checkedViruses:Array = new Array();
        
       /**
         * Class constructor sets stage, desired position x and desired position y
         */    
        public function Player() {  
			animations = new Array();
			unlock[1] = true;
        	addEventListener(Event.ADDED_TO_STAGE, Initialize);
			
			//Should be loaded not set.
			looks[0] = 0;
			looks[1] = 1;
			looks[2] = 2;
			
			name = "Agina";
			
			checkedViruses[0] = true;
			checkedViruses[1] = false;
			checkedViruses[2] = false;
			checkedViruses[3] = false;
			checkedViruses[4] = false;
		}
		
		private function loadAnimations():void{
			var run_animation:MovieClip = new MovieClip(assetManager.getTextures("Mole"), 24);
			run_animation.width = 40; // to be removed
			run_animation.height = 50; // to be removed
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
			this.spawned = true;
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
			unlock[4] = unlock5;
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
		
		public function loseLife():void{
			this.life -= 1; 
		}
		
		//before monday
		public function jump(_name:String):void{
			
		}
		
		public function SetName(_name:String):void{
			this.name = _name;
		}
		
		public function GetName():String{
			return name;
		}
		
		public function SetLooks(_looks:Array):void{
			this.looks = _looks;
		}
		
		public function GetLooks():Array{
			return looks;
		}
		
		public function GetCheckedViruses():Array{
			return checkedViruses;
		}
		
		public function SetCheckedViruses(checkedViruses:Array):void{
			this.checkedViruses = new checkedViruses;
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
				currentAnimation = _animation;
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
		
		public function getWidth():int{
			//return animations[currentAnimation].width;
			return this.width;
		}
		
		public function getHeight():int{
			return this.height;
		}
		
		public function getX():int{
			return this.x;
		}
		
		public function getY():int{
			return this.y;
		}
		
		public function getSpawned():Boolean{
			return this.spawned;
		}
		

		public function addCoin():void{
			this.coins++;
		}
		
		public function addLife():void{
			this.life ++;
		}
		
		/**
		 * method to decrement the number of coins only and only if there is a coin to be removed
		 * @return Boolean returns true if coin was removed (i.e.: player has atleast one coin)
		 */
		public function removeCoin():Boolean{
			if(this.coins < 1){
				return false;
			}
			else{
				this.coins --;
				return true;
			}
		}
		
		public function getCoins():int{
			return this.coins;
		}
		
		public function setCoin(param:int):void{
			this.coins = param;
		}
		
		/**
		 * method to set a level to a current state. !!IMPORTANT!! ignore [0]
		 * @param level: the level to set
		 * @param state: the state to set the level to (i.e.: true or false)
		 */
		public function setLevel(level:int, state:Boolean):void{
			this.unlock[int] = state;
		}
		
		/**
		 * method to get an Array of level states. !!IMPORTANT!! ignore [0]
		 * @return Array: an array with the level states (i.e.: true,true,false,false,false)
		 */
		public function getLevels():Array{
			return this.unlock;
		}
		
		public function addItem(_item:Item):void{
			items.push(_item);

		}
    }
}
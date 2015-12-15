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
    
    import Items.Blanket;
    import Items.Medicine;
    import Items.Towel;
    import Items.WaterBottle;
    
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
		private var looks:int = 0;
		private var items:Array = new Array();
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
			
			name = "Enter Name";
			
			checkedViruses[0] = false;
			checkedViruses[1] = false;
			checkedViruses[2] = false;
			checkedViruses[3] = false;
			checkedViruses[4] = false;
			
			unlock[0] = true;
			unlock[1] = false;
			unlock[2] = false;
			unlock[3] = false;
			unlock[4] = false;
		}
		
		private function loadAnimations():void{
			var run_animation:MovieClip = new MovieClip(assetManager.getTextures("body instance"), 24);
			run_animation.width = 40; // to be removed
			run_animation.height = 50; // to be removed
			animations["run"] = run_animation;
			
			/** NEEDS TO BE UNMARKED WHEN IMAGES ARE READY
			var jump_animation:MovieClip = new MovieClip(assetManager.getTextures("jump instance"), 24);
			jump_animation.width = 40; // to be removed
			jump_animation.height = 50; // to be removed
			animations["jump"] = jump_animation;
			**/
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
			return unlock;
		}
		
		public function setLife(_life:int):void{
			this.life = _life; 
		}
		
		public function loseLife():void{
			this.life -= 1; 
		}
		
		public function jump():void{
			switchAnimations("jump");
		}
		
		public function SetName(_name:String):void{
			this.name = _name;
		}
		
		public function GetName():String{
			return name;
		}
		
		public function SetLooks(_looks:int):void{
			this.looks = _looks;
		}
		
		public function GetLooks():int{
			return looks;
		}
		
		public function GetCheckedViruses():Array{
			return checkedViruses;
		}
		
		public function SetCheckedViruses(checkedViruses:Array):void{
			this.checkedViruses = checkedViruses;
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
		 * method to set a level to a current state. 
		 * @param level: the level to set (1-5)
		 * @param state: the locked state true or false
		 */
		public function setLevel(level:int, state:Boolean):void{
			this.unlock[level-1] = state;
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
		
		/**
		 * method to get array of items.
		 * @return: Array, array holding medicine,towel,waterbottle
		 */
		public function getItems():Array{
			var foo:Array = new Array();
			foo[0] = 0;
			foo[1] = 0;
			foo[2] = 0;
			foo[3] = 0;
			for (var i:int = 0; i < items.length; i++){
				if(items[i] is Medicine){
					foo[0]++;
				}
				if(items[i] is Towel){
					foo[1]++;
				}
				if(items[i] is WaterBottle){
					foo[2]++;
				}
				if(items[i] is Blanket){
					foo[3]++;
				}
			}
			return foo;
		}
		
		public function GetItemsArray():Array{
			return items;
		}
		
		public function RemoveItem(element:Item):void{
			for(var i:int = items.indexOf(element); i < items.length-1; i++){                                                                                      
				items[i] = items[i+1];                                  
			}
			
			items.pop()
		}
		
		public function Stop():void{
			Starling.juggler.remove(animations[currentAnimation])
		}
		
		public function Run():void{
			if(!(Starling.juggler.contains(animations[currentAnimation]))){
				Starling.juggler.add(animations[currentAnimation])
			}
		}
		
		public function setItems(param:Array):void{
			for(var j:int = 1; j< param[0]; j++){
				addItem(new Medicine());
			}
			for(var k:int = 1; k< param[1]; k++){
				addItem(new Towel());
			}
			for(var l:int = 1; l < param[2]; l++){
				addItem(new WaterBottle());
			}
		}
    }
}
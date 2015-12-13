/**
 * Product owner: Hanze University of Applied Sciences
 * This class is not allowed to be copied or sold except with explicit permission from Hanze: University of Applied Sciences
 * @author:	Kevin Stoffers
 * @version: 1 (25/11/2015)
 */
package Items
{
	import flash.filesystem.File;
	
	import Common.Entity;
	import Common.Item;
	
	import Main.View;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	

	/**
	 * Load external libraries
	 */

	/**
	 * This class contains an instance of the coin item. By calling the constructor a new instance is initiated
	 * To add the item to stage a stage instance needs to be called in the constructor of the class.
	 */
	public class Coin extends Sprite implements Entity, Item{
		/* parameters 
		* @param PositionX the desired x location (absolute to stage) position to spawn the item
		* @param PositionY the desired y location (absolute to stage) position to spawn the item
		*/
		private var assetManager:AssetManager;
		private var coin:Image;
		private var destroyed:Boolean = false;
		/**
		 * Class constructor sets desired position x and desired position y
		 * @param _positionx the desired x location (absolute to stage) position to spawn the item
		 * @param _positiony the desired y loaction (absolute to stage) position to spawn the item
		 */
		public function Coin(){
			trace("[Coin] Adding coin to scence");
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Items/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			coin = new Image(assetManager.getTexture("coin"));
			addChild(coin);
		}
		
		public function Destroy():void{
			removeEventListener(Event.ADDED_TO_STAGE, Initialize);
			assetManager.dispose();
			destroyed = true;
		}
		
		public function getWidth():int{
			return this.width;
		}
		
		public function getHeight():int{
			return this.height;
		}
		
		public function Destroyed():Boolean{
			return destroyed;
		}
		
		public function triggerEffect():void{
			
		}
		
		public function Use():void{
			trace("[Coin] using coin");
			View.GetInstance().GetPlayer().addCoin();
			Destroy();
		}
	}
}
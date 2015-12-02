package Items
{
	import flash.filesystem.File;
	
	import Common.Entity;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class Blanket extends Sprite implements Entity{
		
		private var assetManager:AssetManager;
		private var blanketImage:Image;
		
		public function Blanket(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		//If added to the stage load the assetmanager and call function progress
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Items/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		//Functions that checks whether the assetmanager is done loading, if so continue
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		//If assetmanager is loaded, get the texture set its size and add it to the stage
		private function Start():void{
			blanketImage = new Image(assetManager.getTexture("blanket"));
			addChild(blanketImage);
		}
		
		//Function to remove the listener and assetmanager of this object, 
		public function Destroy():void{
			removeEventListener(Event.ADDED_TO_STAGE, Initialize);
			removeChild(blanketImage);
			assetManager.dispose();
		}
	}
}
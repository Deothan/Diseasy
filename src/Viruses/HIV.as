/**
 * Product owner: Hanze University of Applied Sciences
 * This class is not allowed to be copied or sold except with explicit permission from Hanze: University of Applied Sciences
 * @author:    Werner Mulder
 * @version: 1 (29/11/2015)
 */
package Viruses{

		import flash.filesystem.File;
		
		import Common.Entity;
		
		import starling.display.Image;
		import starling.display.Sprite;
		import starling.events.Event;
		import starling.utils.AssetManager;
		
		public class HIV extends Sprite implements Entity{
			
			private var assetManager:AssetManager;
			private var bacteriaImage:Image;
			 
			public function HIV() {
				addEventListener(Event.ADDED_TO_STAGE, Initialize);
			}
			
			private function Initialize():void{
				assetManager = new AssetManager();
				var folder:File = File.applicationDirectory.resolvePath("Viruses/assets");
				assetManager.enqueue(folder);
				assetManager.loadQueue(Progress);
			}
			
			private function Progress(ratio:Number):void{
				if(ratio == 1){
					Start();
				}
			}
			
			private function Start():void{
				bacteriaImage = new Image(assetManager.getTexture("hiv"));
				bacteriaImage.width = 40; // to be removed later
				bacteriaImage.height = 40; // to be removed later
				addChild(bacteriaImage);
			}
			
			public function Destroy():void{
				removeEventListener(Event.ADDED_TO_STAGE, Initialize);
				assetManager.dispose();
			}
		}
	}

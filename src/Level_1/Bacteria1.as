/**
 * Product owner: Hanze University of Applied Sciences
 * This class is not allowed to be copied or sold except with explicit permission from Hanze: University of Applied Sciences
 * @author:    Werner Mulder
 * @version: 1 (29/11/2015)
 */
package Level_1{

		import flash.filesystem.File;
		import flash.geom.Point;
		
		import starling.display.Image;
		import starling.display.Sprite;
		import starling.display.Stage;
		import starling.events.Event;
		import starling.utils.AssetManager;
		
		public class Bacteria1 extends Sprite{
			
			private var StageInstance:Stage;
			private var assetManager:AssetManager;
			private var bacteriaImage:Image;
			 
			public function Bacteria1(_stage:Stage, _desiredX:int, _desiredY:int) {
				this.StageInstance = _stage;
				this.x = _desiredX;
				this.y = _desiredY;
				addEventListener(Event.ADDED_TO_STAGE, Initialize);
			}
			
			private function Initialize():void{
				assetManager = new AssetManager();
				var folder:File = File.applicationDirectory.resolvePath("Level_1/assets");
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
				bacteriaImage.width = 40;
				bacteriaImage.height = 40;
				addChild(bacteriaImage);
				
			}

			public function getPosition():Point{
				return new Point(this.x, this.y);
			}
			
			public function setPosition(_position:Point):void{
				this.x = _position.x;
				this.y = _position.y;
			}
			
			public function destroy():void{
				removeEventListener(Event.ADDED_TO_STAGE, Initialize);
				assetManager.dispose();
			}
			
		}
	}

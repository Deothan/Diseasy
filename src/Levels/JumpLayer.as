package Levels{
	import flash.filesystem.File;
	
	import Common.Physicus;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;

	public class JumpLayer	extends Sprite{
		private var assetManager:AssetManager = new AssetManager();
		private var jumpScreen:Image;
		
		public function JumpLayer(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Levels/assets/general");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			jumpScreen = new Image(assetManager.getTexture("transparent"));
			jumpScreen.addEventListener(TouchEvent.TOUCH, Jump);
			jumpScreen.x = 0;
			jumpScreen.y = 30;
			addChild(jumpScreen);
		}
		
		/**
		 * Will be called when the transparentScreen is clicked.
		 */
		private function Jump(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				//trace("[Level_1] Jump trigger");
				if(Physicus.GetInstance().isGrounded()){
					//trace("[Level_1] Grounded");
					Physicus.GetInstance().Kinetics();
				}
			}
		}
		
		public function Destroy():void{
			jumpScreen.removeEventListener(TouchEvent.TOUCH, Jump);
			removeEventListener(Event.ADDED_TO_STAGE, Initialize);

		}
	}
}

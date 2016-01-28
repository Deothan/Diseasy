package InformationScreen
{
	import flash.filesystem.File;
	
	import Main.View;
		
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;

	public class Tutorial extends Sprite{
		private var assetManager:AssetManager;
		private var tutorial0:Image;
		private var tutorial1:Image;
		private var tutorial2:Image;
		private var tutorial3:Image;

		
		public function Tutorial(){
			View.GetInstance().getSoundControl().removeBackground();
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("InformationScreen/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		public function Start():void{	
			tutorial0 = new Image(assetManager.getTexture("gradient"));
			addChild(tutorial0);
			tutorial1 = new Image(assetManager.getTexture("cutscene_virusinformation1"));
			tutorial1.addEventListener(TouchEvent.TOUCH, TutorialTouch);
			addChild(tutorial1);
		}
		
		private function TutorialTouch(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				View.GetInstance().getSoundControl().playButton();
				if(event.target == tutorial1){
					tutorial1.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial1);
					tutorial2 = new Image(assetManager.getTexture("cutscene_virusinformation2"));
					tutorial2.addEventListener(TouchEvent.TOUCH, TutorialTouch);
					addChild(tutorial2);
				}
				else if(event.target == tutorial2){
					tutorial2.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial2);
					tutorial3 = new Image(assetManager.getTexture("cutscene_virusinformation3"));
					tutorial3.addEventListener(TouchEvent.TOUCH, TutorialTouch);
					addChild(tutorial3);
				}
				else if(event.target == tutorial3){
					tutorial3.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial3);
					removeChild(tutorial0);
					
					View.GetInstance().GetPlayer().setTutorials(5, true);
					
					assetManager.dispose();
					removeEventListeners(null);
				}
			}				
		}
	}
}
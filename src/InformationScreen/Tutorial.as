package InformationScreen
{
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Levels.Level_1;
	
	import Main.View;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import VirusScreen.VirusScreen;

	public class Tutorial extends Sprite implements Screen{
		private var assetManager:AssetManager;
		private var tutorial0:Image;
		private var tutorial1:Image;
		private var tutorial2:Image;
		
		public function Tutorial(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("InformationScreen/tutorial");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		public function Start():void{	
			tutorial0 = new Image(assetManager.getTexture("cutscene_virusinformation"));
			tutorial0.addEventListener(TouchEvent.TOUCH, TutorialTouch);
			addChild(tutorial0);
		}
		
		private function TutorialTouch(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				View.GetInstance().getSoundControl().playButton();
				if(event.target == tutorial0){
					tutorial0.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					//removeChild(tutorial0);
					tutorial1 = new Image(assetManager.getTexture("cutscene_virusinformation1"));
					tutorial1.addEventListener(TouchEvent.TOUCH, TutorialTouch);
					addChild(tutorial1);
				}
				else if(event.target == tutorial1){
					tutorial1.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial1);
					tutorial2 = new Image(assetManager.getTexture("cutscene_virusinformation2"));
					tutorial2.addEventListener(TouchEvent.TOUCH, TutorialTouch);
					addChild(tutorial2);
				}
				else if(event.target == tutorial2){
					tutorial2.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial2);
					removeChild(tutorial0);
					//what screen should be called??
					//
				}
			}				
		}
		
		public function Update():void{
			
		}
		
		public function Destroy():void{
			
		}
	}
}
package Levels{
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Cutscene.Cutscene;
	
	import Main.View;
	
	import Map.Map;

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class SpeedScreen extends Sprite implements Screen{
		private var assetManager:AssetManager;
		private var background:Image;
		private var backButton:Button;
		private var easyButton:Button;
		private var mediumButton:Button;
		private var hardButton:Button;
		
		public function SpeedScreen(){
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
			background = new Image(assetManager.getTexture("background"));
			addChild(background);
			
			backButton = new Button(assetManager.getTexture("button_back"));
			backButton.addEventListener(starling.events.Event.TRIGGERED, BackButtonTriggered);
			backButton.x = 365;
			backButton.y = 265;
			addChild(backButton);
			
			easyButton = new Button(assetManager.getTexture("button_easy"));
			easyButton.addEventListener(starling.events.Event.TRIGGERED, SpeedButtonTriggered);
			easyButton.x = stage.stageWidth/2-easyButton.width/2;
			easyButton.y = 30;
			addChild(easyButton);
			
			mediumButton = new Button(assetManager.getTexture("button_medium"));
			mediumButton.addEventListener(starling.events.Event.TRIGGERED, SpeedButtonTriggered);
			mediumButton.x = stage.stageWidth/2-mediumButton.width/2;
			mediumButton.y = 100;
			addChild(mediumButton);
			
			hardButton = new Button(assetManager.getTexture("button_hard"));
			hardButton.addEventListener(starling.events.Event.TRIGGERED, SpeedButtonTriggered);
			hardButton.x = stage.stageWidth/2-hardButton.width/2;
			hardButton.y = 170;
			addChild(hardButton);

		}
		
		private function BackButtonTriggered():void{
			View.GetInstance().LoadScreen(Map);
		}
		
		private function SpeedButtonTriggered(event:Event):void{
			if(event.target == easyButton) View.GetInstance().setSpeed(1);
			if(event.target == mediumButton) View.GetInstance().setSpeed(2);
			if(event.target == hardButton) View.GetInstance().setSpeed(3);
			
			View.GetInstance().LoadScreen(View.GetInstance().GetLevel());
		}
		
		public function Update():void{
			
		}
		
		public function Destroy():void{
			removeEventListeners(null);
			assetManager.dispose();
		}
	}
}
package InfantScreen{
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Main.View;
	
	import Map.Map;

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class FeedbackScreen extends Sprite implements Screen{
		private var assetManager:AssetManager;
		private var background:Image;
		private var finishButton:Button;
		
		public function FeedbackScreen(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("InfantScreen/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			if(View.GetInstance().GetInfant().getHealth() > 99 && View.GetInstance().GetInfant().getHydration() > 99 && View.GetInstance().GetInfant().getHygiene() > 99 && View.GetInstance().GetInfant().getTemperature() > 99){
				background = new Image(assetManager.getTexture("feedbackscene_good"));
				addChild(background);

				finishButton = new Button(assetManager.getTexture("button_finish"));
				finishButton.addEventListener(Event.TRIGGERED, FinishButtonTriggered);
				finishButton.x = 320;
				finishButton.y = 265;
				addChild(finishButton);
			}
			else{
				background = new Image(assetManager.getTexture("feedbackscene_bad"));
				addChild(background);		
				
				var continueButton:Button = new Button(assetManager.getTexture("button_continue"));
				continueButton.addEventListener(Event.TRIGGERED, ContinueButtonTriggered);
				continueButton.x = 320;
				continueButton.y = 215;
				addChild(continueButton);
				
				finishButton = new Button(assetManager.getTexture("button_finish"));
				finishButton.addEventListener(Event.TRIGGERED, FinishButtonTriggered);
				finishButton.x = 320;
				finishButton.y = 265;
				addChild(finishButton);
			}
		}
		
		private function FinishButtonTriggered():void{
			View.GetInstance().LoadScreen(Map);
		}
		
		private function ContinueButtonTriggered():void{
			View.GetInstance().LoadScreen(InfantScreen);
		}
		
		public function Update():void{}
		
		public function Destroy():void{
			removeEventListeners(null);
			assetManager.dispose();
		}
	}
}
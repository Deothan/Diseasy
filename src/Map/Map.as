package Map{
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Customize.Customize;
	
	import Cutscene.Cutscene;
	
	import Levels.Level_2;
	import Levels.Level_3;
	import Levels.Level_4;
	import Levels.Level_5;
	import Levels.SpeedScreen;
	
	import Main.View;
	
	import Menu.Menu;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;

	public class Map extends Sprite implements Screen{
		private var assetManager:AssetManager = new AssetManager();
		private var background:Image;
		private var backButton:Button;
		private var customizeButton:Button;
		private var level1Button:Button;
		private var level2Button:Button;
		private var level3Button:Button;
		private var level4Button:Button;
		private var level5Button:Button;
		private var loaded:Boolean = false;
		private var unlocks:Array;
		private var tutorial0:Image;
		private var tutorial1:Image;
		private var tutorial2:Image;
		private var tutorial3:Image;
		private var tutorial4:Image;
		
		public function Map(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Map/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			View.GetInstance().getSoundControl().playDefault();
			View.GetInstance().SetLastScreen("Map");
			
			background = new Image(assetManager.getTexture("map"));
			addChild(background);		
			
			unlocks = View.GetInstance().GetPlayer().getUnlock();
			
			if(unlocks[0] == true)
				level1Button = new Button(assetManager.getTexture("button_stage1"));
			else
				level1Button = new Button(assetManager.getTexture("button_key"));
			
			level1Button.addEventListener(Event.TRIGGERED, LevelButtonTriggered);
			level1Button.x = 55;
			level1Button.y = 30;
			addChild(level1Button);
			
			if(unlocks[1] == true)
				level2Button = new Button(assetManager.getTexture("button_stage2"));
			else
				level2Button = new Button(assetManager.getTexture("button_key"));			

			level2Button.addEventListener(Event.TRIGGERED, LevelButtonTriggered);
			level2Button.x = 160;
			level2Button.y = 135;
			addChild(level2Button);
			
			if(unlocks[2] == true)
				level3Button = new Button(assetManager.getTexture("button_stage3"));
			else
				level3Button = new Button(assetManager.getTexture("button_key"));	
			
			level3Button.addEventListener(Event.TRIGGERED, LevelButtonTriggered);
			level3Button.x = 235;
			level3Button.y = 50;
			addChild(level3Button);
			
			if(unlocks[3] == true)
				level4Button = new Button(assetManager.getTexture("button_stage4"));
			else
				level4Button = new Button(assetManager.getTexture("button_key"));	
			
			level4Button.addEventListener(Event.TRIGGERED, LevelButtonTriggered);
			level4Button.x = 295;
			level4Button.y = 130;
			addChild(level4Button);
			
			if(unlocks[4] == true)
				level5Button = new Button(assetManager.getTexture("button_stage5"));
			else
				level5Button = new Button(assetManager.getTexture("button_key"));	
			
			level5Button.addEventListener(Event.TRIGGERED, LevelButtonTriggered);
			level5Button.x = 384;
			level5Button.y = 22;
			addChild(level5Button);
			
			backButton = new Button(assetManager.getTexture("button_back"));
			backButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			backButton.x = 370;
			backButton.y = 260;
			addChild(backButton);
 		
			customizeButton = new Button(assetManager.getTexture("button_customize"));
			customizeButton.addEventListener(Event.TRIGGERED, CustomizeButtonTriggered);
			customizeButton.x = 200;
			customizeButton.y = 265;
			addChild(customizeButton);
			
			if(!View.GetInstance().GetPlayer().GetTutorials()[1]){
				tutorial0 = new Image(assetManager.getTexture("gradient"));
				addChild(tutorial0);
				
				tutorial1 = new Image(assetManager.getTexture("cutscene_map1"));
				tutorial1.addEventListener(TouchEvent.TOUCH, TutorialTouch);
				addChild(tutorial1);
			}
		}
		
		private function TutorialTouch(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				View.GetInstance().getSoundControl().playButton();
				if(event.target == tutorial1){
					tutorial1.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial1);
					tutorial2 = new Image(assetManager.getTexture("cutscene_map3"));
					tutorial2.addEventListener(TouchEvent.TOUCH, TutorialTouch);
					addChild(tutorial2);
				}
				else if(event.target == tutorial2){
					tutorial2.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial2);
					tutorial3 = new Image(assetManager.getTexture("cutscene_map4"));
					tutorial3.addEventListener(TouchEvent.TOUCH, TutorialTouch);
					addChild(tutorial3);
				}
				else if(event.target == tutorial3){
					tutorial3.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial3);
					removeChild(tutorial0);
					
					View.GetInstance().GetPlayer().setTutorials(1, true);
				}
			}				
		}
		
		private function LevelButtonTriggered(event:Event):void{
			View.GetInstance().getSoundControl().playButton();
			View.GetInstance().getSoundControl().playLevel();
			if(event.target == level1Button && unlocks[0]){
				View.GetInstance().SetLevel(Cutscene);
				View.GetInstance().LoadScreen(SpeedScreen);
			}
			else if(event.target == level2Button && unlocks[1]){
				View.GetInstance().SetLevel(Level_2);
				View.GetInstance().LoadScreen(SpeedScreen);
			}
			else if(event.target == level3Button && unlocks[2]){
				View.GetInstance().SetLevel(Level_3);
				View.GetInstance().LoadScreen(SpeedScreen);
			}
			else if(event.target == level4Button && unlocks[3]){
				View.GetInstance().SetLevel(Level_4);
				View.GetInstance().LoadScreen(SpeedScreen);
			}
			else if(event.target == level5Button && unlocks[4]){
				View.GetInstance().SetLevel(Level_5);
				View.GetInstance().LoadScreen(SpeedScreen);
			}
		}
		
		private function CustomizeButtonTriggered():void{
			View.GetInstance().getSoundControl().playButton();
			View.GetInstance().LoadScreen(Customize);
		}
		
		private function BackButtonTriggered():void{
			View.GetInstance().getSoundControl().playButton();
			View.GetInstance().LoadScreen(Menu);
		}
		
		public function Update():void{	
		}
		
		public function Destroy():void{
			removeEventListeners(null);
			assetManager.dispose();
		}
	}
}
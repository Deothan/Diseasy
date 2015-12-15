package Map{
	import flash.filesystem.File;
	
	import Common.IO;
	import Common.Screen;
	
	import Customize.Customize;
	
	import Levels.Level_1;
	import Levels.Level_2;
	import Levels.Level_3;
	import Levels.Level_4;
	import Levels.Level_5;
	
	import Main.View;
	
	import Menu.Menu;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class Map extends Sprite implements Screen{
		private var assetManager:AssetManager = new AssetManager();
		private var background:Image;
		private var backButton:Button;
		private var saveButton:Button;
		private var customizeButton:Button;
		private var level1Button:Button;
		private var level2Button:Button;
		private var level3Button:Button;
		private var level4Button:Button;
		private var level5Button:Button;
		private var loaded:Boolean = false;
		private var unlocks:Array;
		
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
				level4Button = new Button(assetManager.getTexture("button_stage1"));
			else
				level4Button = new Button(assetManager.getTexture("button_key"));	
			
			level4Button.addEventListener(Event.TRIGGERED, LevelButtonTriggered);
			level4Button.x = 295;
			level4Button.y = 130;
			addChild(level4Button);
			
			if(unlocks[3] == true)
				level5Button = new Button(assetManager.getTexture("button_stage1"));
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
	
			saveButton = new Button(assetManager.getTexture("button_save"));
			saveButton.addEventListener(Event.TRIGGERED, SaveButtonTriggered);
			saveButton.x = 370;
			saveButton.y = 215;
			addChild(saveButton);
 		
			customizeButton = new Button(assetManager.getTexture("button_customize"));
			customizeButton.addEventListener(Event.TRIGGERED, CustomizeButtonTriggered);
			customizeButton.x = 200;
			customizeButton.y = 265;
			addChild(customizeButton);
		}
		
		private function LevelButtonTriggered(event:Event):void{
			if(event.target == level1Button && unlocks[0]){
				View.GetInstance().LoadScreen(Level_1);
			}
			else if(event.target == level1Button && unlocks[1]){
				View.GetInstance().LoadScreen(Level_2);
			}
			else if(event.target == level1Button && unlocks[2]){
				View.GetInstance().LoadScreen(Level_3);
			}
			else if(event.target == level1Button && unlocks[3]){
				View.GetInstance().LoadScreen(Level_4);
			}
			else if(event.target == level1Button && unlocks[4]){
				View.GetInstance().LoadScreen(Level_5);
			}
		}
		
		private function CustomizeButtonTriggered():void{
			View.GetInstance().LoadScreen(Customize);
		}
		
		private function BackButtonTriggered():void{
			View.GetInstance().LoadScreen(Menu);
		}
		
		private function SaveButtonTriggered():void{
			IO.GetInstance().Save();
		}
		
		public function Update():void{	
		}
		
		public function Destroy():void{
			level1Button.removeEventListener(Event.TRIGGERED, LevelButtonTriggered);
			backButton.removeEventListener(Event.TRIGGERED, BackButtonTriggered);
			saveButton.removeEventListener(Event.TRIGGERED, SaveButtonTriggered);
			customizeButton.removeEventListener(Event.TRIGGERED, CustomizeButtonTriggered);
			assetManager.dispose();
		}
	}
}
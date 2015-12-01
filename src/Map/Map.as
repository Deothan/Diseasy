package Map{
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Customize.Customize;
	
	import Level_1.Level_1;
	
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
		private var loaded:Boolean = false;
		//These unlocks should be saved in player.
		private var unlock1:Boolean = true;
		private var unlock2:Boolean = false;
		private var unlock3:Boolean = false;
		private var unlock4:Boolean = false;

		
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
			
			level1Button = new Button(assetManager.getTexture("button_stage1"));
			level1Button.addEventListener(Event.TRIGGERED, Level1ButtonTriggered);
			level1Button.x = 55;
			level1Button.y = 30;
			addChild(level1Button);
			
			level2Button = new Button(assetManager.getTexture("button_key"));
			level2Button.addEventListener(Event.TRIGGERED, Level1ButtonTriggered);
			level2Button.x = 160;
			level2Button.y = 135;
			addChild(level2Button);
			
			level3Button = new Button(assetManager.getTexture("button_key"));
			level3Button.addEventListener(Event.TRIGGERED, Level1ButtonTriggered);
			level3Button.x = 235;
			level3Button.y = 50;
			addChild(level3Button);
			
			level4Button = new Button(assetManager.getTexture("button_key"));
			level4Button.addEventListener(Event.TRIGGERED, Level1ButtonTriggered);
			level4Button.x = 295;
			level4Button.y = 130;
			addChild(level4Button);
			
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
			
			loaded = true;
		}
		
		private function Level1ButtonTriggered(event:Event):void{
			if(event.target == level1Button && unlock1){
				View.GetInstance().LoadScreen(Level_1);
			}
			if(event.target == level1Button && unlock2){
				//View.GetInstance().LoadScreen(Level_2);
			}
			if(event.target == level1Button && unlock3){
				//View.GetInstance().LoadScreen(Level_3);
			}
			if(event.target == level1Button && unlock4){
				//View.GetInstance().LoadScreen(Level_4);
			}
		}
		
		public function UnlockLevels():void{
			//Insert check in player.
		}
		
		private function CustomizeButtonTriggered():void{
			View.GetInstance().LoadScreen(Customize);
		}
		
		private function BackButtonTriggered():void{
			View.GetInstance().LoadScreen(Menu);
		}
		
		private function SaveButtonTriggered():void{
			//Add save code here.
		}
		
		public function Update():void{
			if(loaded){
				UnlockLevels();
			}			
		}
		
		public function Destroy():void{
			level1Button.removeEventListener(Event.TRIGGERED, Level1ButtonTriggered);
			backButton.removeEventListener(Event.TRIGGERED, BackButtonTriggered);
			saveButton.removeEventListener(Event.TRIGGERED, SaveButtonTriggered);
			customizeButton.removeEventListener(Event.TRIGGERED, CustomizeButtonTriggered);
			assetManager.dispose();
		}
	}
}
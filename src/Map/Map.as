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
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;

	public class Map extends Sprite implements Screen{
		private var assetManager:AssetManager = new AssetManager();
		private var background:Image;
		private var backButton:Button;
		private var saveButton:Button;
		private var customizeButton:Button;
		private var level1Image:Image;
		
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
			background = new Image(assetManager.getTexture("test"));
			addChild(background);		
			
			level1Image = new Image(assetManager.getTexture("transparent"));
			level1Image.addEventListener(TouchEvent.TOUCH, Level1Touch);
			level1Image.x = 78;
			level1Image.y = 58;
			addChild(level1Image);
			
			backButton = new Button(assetManager.getTexture("backButton"), "Back");
			backButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			backButton.x = 412;
			backButton.y = 292;
			addChild(backButton);
			
			saveButton = new Button(assetManager.getTexture("saveButton"), "Save");
			saveButton.addEventListener(Event.TRIGGERED, SaveButtonTriggered);
			saveButton.x = 412;
			saveButton.y = 262;
			addChild(saveButton);
			
			customizeButton = new Button(assetManager.getTexture("customizeButton"), "Customize");
			customizeButton.addEventListener(Event.TRIGGERED, CustomizeButtonTriggered);
			customizeButton.x = 320;
			customizeButton.y = 292;
			addChild(customizeButton);
		}
		
		private function Level1Touch(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				View.GetInstance().LoadScreen(Level_1);
			}
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
		}
		
		public function Destroy():void{
		}
	}
}
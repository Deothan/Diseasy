package Customize{
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Main.View;
	
	import Map.Map;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.AssetManager;

	public class Customize extends Sprite implements Screen{
		private var assetManager:AssetManager = new AssetManager();
		private var background:Image;
		private var topImage:Image;
		private var middleImage:Image;
		private var bottomImage:Image;
		private var backButton:Button;
		private var okButton:Button;
		private var nameText:TextField;
		
		public function Customize(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Customize/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		public function Start():void{
			background = new Image(assetManager.getTexture("background"));
			addChild(background);
			
			topImage = new Image(assetManager.getTexture("button_hair"));
			topImage.x = 170;
			topImage.y = 175;
			addChild(topImage);
			
			middleImage = new Image(assetManager.getTexture("button_baby"));
			middleImage.x = 300;
			middleImage.y = 65;
			addChild(middleImage);
			
			bottomImage = new Image(assetManager.getTexture("button_clothes"));
			bottomImage.x = 170;
			bottomImage.y = 65;
			addChild(bottomImage);
			
			backButton = new Button(assetManager.getTexture("button_back"));
			backButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			backButton.x = 365;
			backButton.y = 265;
			addChild(backButton);
			
			okButton = new Button(assetManager.getTexture("button_ok"));
			okButton.addEventListener(Event.TRIGGERED, OkButtonTriggered);
			okButton.x = 300;
			okButton.y = 180;
			addChild(okButton);
			
			nameText = new TextField(80, 40, "Name");
			nameText.fontSize = 20;
			nameText.addEventListener(TouchEvent.TOUCH, NameTouched);
			nameText.color = 0xFFFFFF;
			nameText.x = 175;
			nameText.y = 20;
			addChild(nameText);
		}
		
		//Add save functionality
		private function OkButtonTriggered():void{
			View.GetInstance().LoadScreen(Map);
		}
		
		private function BackButtonTriggered():void{
			View.GetInstance().LoadScreen(Map);
		}
		
		//Has to get keyboard input, and use it to change the name
		private function NameTouched(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				nameText.text = "Test";
			}
		}
		
		public function Update():void{
			
		}
		
		public function Destroy():void{
			backButton.removeEventListener(Event.TRIGGERED, BackButtonTriggered);
			okButton.removeEventListener(Event.TRIGGERED, OkButtonTriggered);
			nameText.removeEventListener(TouchEvent.TOUCH, NameTouched);
			assetManager.dispose();
		}
	}
}
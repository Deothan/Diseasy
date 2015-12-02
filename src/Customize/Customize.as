package Customize{
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Main.View;
	
	import Map.Map;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.AssetManager;

	public class Customize extends Sprite implements Screen{
		private var assetManager:AssetManager = new AssetManager();
		private var background:Image;
		private var hairButton:Button;
		private var babbyButton:Button;
		private var clothesButton:Button;
		private var backButton:Button;
		private var okButton:Button;
		private var nameText:TextField;
		private var input:String;
		
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
			
			hairButton = new Button(assetManager.getTexture("button_hair"));
			hairButton.addEventListener(Event.TRIGGERED, HairButtonTriggered);
			hairButton.x = 170;
			hairButton.y = 175;
			addChild(hairButton);
			
			babbyButton = new Button(assetManager.getTexture("button_baby"));
			babbyButton.addEventListener(Event.TRIGGERED, BabbyButtonTriggered);
			babbyButton.x = 300;
			babbyButton.y = 65;
			addChild(babbyButton);
			
			clothesButton = new Button(assetManager.getTexture("button_clothes"));
			clothesButton.addEventListener(Event.TRIGGERED, ClothesButtonTriggered);
			clothesButton.x = 170;
			clothesButton.y = 65;
			addChild(clothesButton);
			
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
			
			nameText = new TextField(300, 40, "Name");
			nameText.addEventListener(TouchEvent.TOUCH, NameTouched);
			nameText.fontSize = 20;
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
		
		private function HairButtonTriggered():void{
			
		}
		
		private function BabbyButtonTriggered():void{
			
		}
		
		private function ClothesButtonTriggered():void{
			
		}
		
		/**
		 * If "Enter" is hit then the keyboard listener is removed. Untill it is removed it changes the nameText variable.
		 */
		private function ReadKey(event:KeyboardEvent):void{
			if(event.keyCode == 13){
				removeEventListener(KeyboardEvent.KEY_DOWN, ReadKey);
			}		
				
			var read:String = String.fromCharCode(event.charCode);
			input += read;
			nameText.text = input;
		}
		
		/**
		 * Adds a keyboard listener when the name is clicked, and empties the current input.
		 */
		private function NameTouched(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				addEventListener(KeyboardEvent.KEY_DOWN, ReadKey);
				
				input = new String();
				nameText.text = input;
			}
		}
		
		public function Update():void{
			
		}
		
		public function Destroy():void{
			backButton.removeEventListener(Event.TRIGGERED, BackButtonTriggered);
			okButton.removeEventListener(Event.TRIGGERED, OkButtonTriggered);
			nameText.removeEventListener(TouchEvent.TOUCH, NameTouched);
			hairButton.removeEventListener(Event.TRIGGERED, HairButtonTriggered);
			babbyButton.removeEventListener(Event.TRIGGERED, BabbyButtonTriggered);
			clothesButton.removeEventListener(Event.TRIGGERED, ClothesButtonTriggered);
			assetManager.dispose();
		}
	}
}
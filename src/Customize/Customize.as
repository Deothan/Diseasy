package Customize{
	import flash.filesystem.File;
	
	import Common.IO;
	import Common.Physicus;
	import Common.Screen;
	
	import Main.View;
	
	import Map.Map;
	
	import Menu.Menu;
	
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
		private var tutorial1:Image;
		private var tutorial2:Image;
		private var tutorial3:Image;
		private var look:Image;
		private var currentLook:int;
		private var backButton:Button;
		private var lookButton:Button;
		private var okButton:Button;
		private var nameText:TextField;
		private var input:String;
		private var looks:Array = new Array();
		
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
			background = new Image(assetManager.getTexture("customize_screen1"));
			addChild(background);

			backButton = new Button(assetManager.getTexture("button_back"));
			backButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			backButton.x = 365;
			backButton.y = 265;
			addChild(backButton);
			
			okButton = new Button(assetManager.getTexture("button_ok"));
			okButton.addEventListener(Event.TRIGGERED, OkButtonTriggered);
			okButton.x = 230;
			okButton.y = 248;
			addChild(okButton);
			
			lookButton = new Button(assetManager.getTexture("button_hair"));
			lookButton.addEventListener(Event.TRIGGERED, LookButtonTriggered);
			lookButton.x = 280;
			lookButton.y = 110;
			addChild(lookButton);
			
			nameText = new TextField(172, 40, View.GetInstance().GetPlayer().GetName());
			nameText.addEventListener(TouchEvent.TOUCH, NameTouched);
			nameText.fontSize = 20;
			nameText.color = 0x000000;
			nameText.x = 285;
			nameText.y = 20;
			addChild(nameText);
			
			looks[0] = new Image(assetManager.getTexture("customize_women_1"));
			looks[1] = new Image(assetManager.getTexture("customize_women_2"));
			looks[2] = new Image(assetManager.getTexture("customize_women_3"));
			looks[3] = new Image(assetManager.getTexture("customize_women_4"));
		
			currentLook = View.GetInstance().GetPlayer().GetLooks();
			look = looks[currentLook];
			look.x = 10;
			look.y = 10;
			addChild(look);
			
			if(!View.GetInstance().GetPlayer().GetTutorials()[0]){
				tutorial1 = new Image(assetManager.getTexture("tutorial1"));
				tutorial1.addEventListener(TouchEvent.TOUCH, TutorialTouch);
				addChild(tutorial1);
			}
		}
		
		private function TutorialTouch(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				if(event.target == tutorial1){
					tutorial1.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial1);
					tutorial2 = new Image(assetManager.getTexture("tutorial2"));
					tutorial2.addEventListener(TouchEvent.TOUCH, TutorialTouch);
					addChild(tutorial2);
				}
				else if(event.target == tutorial2){
					tutorial2.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial2);
					tutorial3 = new Image(assetManager.getTexture("tutorial3"));
					tutorial3.addEventListener(TouchEvent.TOUCH, TutorialTouch);
					addChild(tutorial3);
				}
				else if(event.target == tutorial3){
					tutorial3.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial3);
					
					View.GetInstance().GetPlayer().setTutorials(0, true);
				}
			}				
		}
		
		private function LookButtonTriggered():void{
			currentLook++;
			
			if(currentLook > 3){
				currentLook = 0;
			}			
			
			removeChild(look);
			
			look = looks[currentLook];
			look.x = 10;
			look.y = 10;
			addChild(look);
		}
		
		private function OkButtonTriggered():void{
			View.GetInstance().GetPlayer().SetName(nameText.text);
			View.GetInstance().GetPlayer().SetLooks(currentLook);
			IO.GetInstance().Save();
			View.GetInstance().LoadScreen(Map);
		}
		
		private function BackButtonTriggered():void{
			if(View.GetInstance().GetLastScreen() == "Menu"){
				View.GetInstance().LoadScreen(Menu);
			}
			else{
				View.GetInstance().LoadScreen(Map);
			}	
		}
		
		/**
		 * If "Enter" is hit then the keyboard listener is removed. Untill it is removed it changes the nameText variable.
		 * 65-90 are the letters
		 * 32 is space
		 * 13 is the maximum length of the field
		 */
		private function ReadKey(event:KeyboardEvent):void{
			if(event.keyCode == 13){
				removeEventListener(KeyboardEvent.KEY_DOWN, ReadKey);
				View.GetInstance().GetPlayer().SetName(nameText.text);
			}
			else if(event.keyCode >= 65 && event.keyCode <= 90){
				var letter:String = String.fromCharCode(event.charCode);
				
				if(input.length <= 13)
					input += letter;
				
				nameText.text = input;
			}
			else if(event.keyCode == 32){
				var space:String = String.fromCharCode(event.charCode);
				
				if(input.length <= 13)
					input += space;
				
				nameText.text = input;
			}
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
		
		public function Update():void{}
		
		public function Destroy():void{
			removeEventListeners(null);
			assetManager.dispose();
		}
	}
}
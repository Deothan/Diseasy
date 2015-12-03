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
		private var hairImage:Image;
		private var bodyImage:Image;
		private var babyImage:Image;
		private var strapImage:Image;
		private var hairButton:Button;
		private var babbyButton:Button;
		private var clothesButton:Button;
		private var backButton:Button;
		private var okButton:Button;
		private var nameText:TextField;
		private var input:String;
		private var hair:Array = new Array();
		private var body:Array = new Array();
		private var baby:Array = new Array();
		private var strap:Array = new Array();
		private var currentHair:int;
		private var currentBody:int;
		private var currentBaby:int;
		
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
			LoadChangeArrays();

			currentHair = View.GetInstance().GetPlayer().GetLooks()[0];
			currentBody = View.GetInstance().GetPlayer().GetLooks()[1];
			currentBaby = View.GetInstance().GetPlayer().GetLooks()[2];
			
			background = new Image(assetManager.getTexture("background"));
			addChild(background);
			
			babyImage = baby[currentBaby];
			babyImage.x = 10;
			babyImage.y = 7;
			addChild(babyImage);
			
			hairImage = hair[currentHair];
			hairImage.x = 10;
			hairImage.y = 7;
			addChild(hairImage);

			bodyImage = body[currentBody];
			bodyImage.x = 10;
			bodyImage.y = 7;
			addChild(bodyImage);
			
			strapImage = strap[currentBaby];
			strapImage.x = 10;
			strapImage.y = 7;
			addChild(strapImage);
			
			hairButton = new Button(assetManager.getTexture("button_hair"));
			hairButton.addEventListener(Event.TRIGGERED, HairButtonTriggered);
			hairButton.x = 180;
			hairButton.y = 175;
			addChild(hairButton);
			
			babbyButton = new Button(assetManager.getTexture("button_baby"));
			babbyButton.addEventListener(Event.TRIGGERED, BabyButtonTriggered);
			babbyButton.x = 310;
			babbyButton.y = 65;
			addChild(babbyButton);
			
			clothesButton = new Button(assetManager.getTexture("button_clothes"));
			clothesButton.addEventListener(Event.TRIGGERED, ClothesButtonTriggered);
			clothesButton.x = 180;
			clothesButton.y = 65;
			addChild(clothesButton);
			
			backButton = new Button(assetManager.getTexture("button_back"));
			backButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			backButton.x = 365;
			backButton.y = 265;
			addChild(backButton);
			
			okButton = new Button(assetManager.getTexture("button_ok"));
			okButton.addEventListener(Event.TRIGGERED, OkButtonTriggered);
			okButton.x = 310;
			okButton.y = 180;
			addChild(okButton);
			
			nameText = new TextField(172, 40, View.GetInstance().GetPlayer().GetName());
			nameText.addEventListener(TouchEvent.TOUCH, NameTouched);
			nameText.fontSize = 20;
			nameText.color = 0x000000;
			nameText.x = 290;
			nameText.y = 20;
			addChild(nameText);
		}
		
		//Add save functionality
		private function OkButtonTriggered():void{
			var looks:Array = new Array();
			looks[0] = currentHair;
			looks[1] = currentBody;
			looks[2] = currentBaby;
			
			View.GetInstance().GetPlayer().SetLooks(looks);
			View.GetInstance().LoadScreen(Map);
		}
		
		private function BackButtonTriggered():void{
			View.GetInstance().LoadScreen(Map);
		}
		
		private function HairButtonTriggered():void{
			if(currentHair == hair.length-1)
				currentHair = 0;
			else
				currentHair++;
			
			removeChild(hairImage);
			hairImage = hair[currentHair];	
			hairImage.x = 10;
			hairImage.y = 7;
			addChildAt(hairImage, 2);
		}
		
		private function BabyButtonTriggered():void{
			if(currentBaby == baby.length-1)
				currentBaby = 0;
			else
				currentBaby++;
			
			removeChild(babyImage);
			babyImage = baby[currentBaby];
			babyImage.x = 10;
			babyImage.y = 7;
			addChildAt(babyImage, 1);
			
			removeChild(strapImage);
			strapImage = strap[currentBaby];
			strapImage.x = 10;
			strapImage.y = 7;
			addChildAt(strapImage, 4);	
		}
		
		private function ClothesButtonTriggered():void{
			if(currentBody == body.length-1)
				currentBody = 0;
			else
				currentBody++;
			
			removeChild(bodyImage);
			bodyImage = body[currentBody];	
			bodyImage.x = 10;
			bodyImage.y = 7;
			addChildAt(bodyImage, 3);
		}
		
		private function LoadChangeArrays():void{
			body[0] = new Image(assetManager.getTexture("women_longskirt"));
			body[1] = new Image(assetManager.getTexture("women_orangedress"));
			body[2] = new Image(assetManager.getTexture("women_pants"));
			body[3] = new Image(assetManager.getTexture("women_tshirt"));
			
			hair[0] = new Image(assetManager.getTexture("women_one"));
			hair[1] = new Image(assetManager.getTexture("women_orange"));
			hair[2] = new Image(assetManager.getTexture("women_twin"));
			hair[3] = new Image(assetManager.getTexture("women_short"));
			
			baby[0] = new Image(assetManager.getTexture("baby_blue"));
			baby[1] = new Image(assetManager.getTexture("baby_green"));
			baby[2] = new Image(assetManager.getTexture("baby_purple"));
			baby[3] = new Image(assetManager.getTexture("baby_red"));
			
			strap[0] = new Image(assetManager.getTexture("babycloth_blue"));
			strap[1] = new Image(assetManager.getTexture("babycloth_green"));
			strap[2] = new Image(assetManager.getTexture("babycloth_purple"));
			strap[3] = new Image(assetManager.getTexture("babycloth_red"));
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
		
		public function Update():void{
			
		}
		
		public function Destroy():void{
			backButton.removeEventListener(Event.TRIGGERED, BackButtonTriggered);
			okButton.removeEventListener(Event.TRIGGERED, OkButtonTriggered);
			nameText.removeEventListener(TouchEvent.TOUCH, NameTouched);
			hairButton.removeEventListener(Event.TRIGGERED, HairButtonTriggered);
			babbyButton.removeEventListener(Event.TRIGGERED, BabyButtonTriggered);
			clothesButton.removeEventListener(Event.TRIGGERED, ClothesButtonTriggered);
			assetManager.dispose();
		}
	}
}
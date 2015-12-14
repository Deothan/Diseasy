package Load
{
	
	import flash.filesystem.File;
	
	import Common.IO;
	import Common.Screen;
	
	import Main.View;
	
	import Map.Map;
	
	import Menu.Menu;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.AssetManager;

	public class Load extends Sprite implements Screen{
		private var assetManager:AssetManager = new AssetManager();
		private var backButton:Button;
		private var loadButton:Button;
		private var player1Button:Button;
		private var player2Button:Button;
		private var player3Button:Button;
		private var background:Image;
		private var currentHair:int;
		private var currentBody:int;
		private var currentBaby:int;
		private var currentStrap:int;
		private var baby:Image;
		private var body:Image;
		private var hair:Image;
		private var strap:Image;
		private var looks:Array = new Array();
		private var names:Array = Common.IO.GetInstance().getNames();
		
		
		public function Load(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Load/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			background = new Image(assetManager.getTexture("customize_screen3"));
			addChild(background);
						
			setPlayerImage();
			spawnPlayerImage();
			
			backButton = new Button(assetManager.getTexture("button_back"));
			backButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			backButton.x = 370;
			backButton.y = 263;
			addChild(backButton);
			
			loadButton = new Button(assetManager.getTexture("button_load"));
			loadButton.addEventListener(Event.TRIGGERED, LoadButtonTriggered);
			loadButton.x = 339;
			loadButton.y = 196;
			addChild(loadButton);
			
			for(var i:int; i<Common.IO.GetInstance().getNames().length; i++){
				var textField:TextField = new TextField(172,40, names[i],"Verdana", 20, 0x0);
					textField.addEventListener(TouchEvent.TOUCH, NameTouched);
					textField.x = 20;
					textField.y = (20 * (i+1));
					addChild(textField);
			}
			
		}
		
		private function NameTouched(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				
			}
		}
		
		private function setPlayerImage():void{
			if(baby != null){
				removeChild(baby);
			}
			if(hair != null){
				removeChild(hair);
			}
			if(body != null){
				removeChild(body);
			}
			if(strap != null){
				removeChild(strap);
			}
			
			currentHair = View.GetInstance().GetPlayer().GetLooks()[0];
			currentBody = View.GetInstance().GetPlayer().GetLooks()[1];
			currentBaby = View.GetInstance().GetPlayer().GetLooks()[2];
			
			switch(currentBaby){
				case 0:
					baby = new Image(assetManager.getTexture("baby_blue"));
					break;
				case 1:
					baby = new Image(assetManager.getTexture("baby_green"));
					break;
				case 2:
					baby = new Image(assetManager.getTexture("baby_purple"));
					break;
				case 3:
					baby = new Image(assetManager.getTexture("baby_red"));
					break;
			}
			
			switch(currentHair){
				case 0:
					hair = new Image(assetManager.getTexture("women_one"));
					break;
				case 1:
					hair = new Image(assetManager.getTexture("women_orange"));
					break;
				case 2:
					hair = new Image(assetManager.getTexture("women_twin"));
					break;
				case 3:
					hair = new Image(assetManager.getTexture("women_short"));
					break;
			}
			
			switch(currentBody){
				case 0:
					body = new Image(assetManager.getTexture("women_longskirt"));
					break;
				case 1:
					body = new Image(assetManager.getTexture("women_orangedress"));
					break;
				case 2:
					body = new Image(assetManager.getTexture("women_pants"));
					break;
				case 3:
					body = new Image(assetManager.getTexture("women_tshirt"));
					break;
			}
			
			switch(currentBaby){
				case 0:
					strap = new Image(assetManager.getTexture("babycloth_blue"));
					break;
				case 1:
					strap = new Image(assetManager.getTexture("babycloth_green"));
					break;
				case 2:
					strap = new Image(assetManager.getTexture("babycloth_purple"));
					break;
				case 3:
					strap = new Image(assetManager.getTexture("babycloth_red"));
					break;
			}
			
			
		}
		
		private function spawnPlayerImage():void{
			baby.x = 200;
			hair.x = 200;
			body.x = 200;
			strap.x = 200;
			addChildAt(baby,1);
			addChildAt(hair,2);
			addChildAt(body,3);
			addChildAt(strap,4);
		}
		
		
		private function LoadPlayer(i:int):void{
			switch(i){
				case 1:
					looks[0] = 0;
					looks[1] = 1;
					looks[2] = 2;
					break;
				case 2:
					looks[0] = 1;
					looks[1] = 2;
					looks[2] = 3;
					break;
				case 3:
					looks[0] = 2;
					looks[1] = 3;
					looks[2] = 4;
					break;
			}
			View.GetInstance().GetPlayer().SetLooks(looks);
			setPlayerImage();
			spawnPlayerImage();
				
		}
		
		private function Player1Loaded(name:String):void{
			LoadPlayer(1);
		}
		
		private function Player2Loaded():void{
			LoadPlayer(2);
		}
		
		private function Player3Loaded():void{
			LoadPlayer(3);
		}
		
		public function Update():void{
		}
		
		private function LoadButtonTriggered():void{
			View.GetInstance().LoadScreen(Map);
		}
		
		private function BackButtonTriggered():void{
			View.GetInstance().LoadScreen(Menu);
		}
		
		public function Destroy():void{
			backButton.removeEventListener(Event.TRIGGERED, BackButtonTriggered);
			loadButton.removeEventListener(Event.TRIGGERED, LoadButtonTriggered);
			//player1Button.addEventListener(Event.TRIGGERED, Player1Loaded);
			//player2Button.addEventListener(Event.TRIGGERED, Player2Loaded);
			//player3Button.addEventListener(Event.TRIGGERED, Player3Loaded);
			assetManager.dispose();
		}
	}
}
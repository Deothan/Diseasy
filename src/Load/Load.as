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
	import starling.utils.AssetManager;

	public class Load extends Sprite implements Screen{
		private var assetManager:AssetManager = new AssetManager();
		private var backButton:Button;
		private var loadButton:Button;
		private var playerButton1:Button;
		private var playerButton2:Button;
		private var playerButton3:Button;
		private var playerButton4:Button;
		private var playerButton5:Button;
		private var nextButton:Button;
		private var previousButton:Button;
		private var background:Image;
		private var playerImage:Image;
		private var names:Array = Common.IO.GetInstance().getNames();
		private var looks:Array = new Array();
		private var player1:String = new String(" ");
		private var player2:String = new String(" ");
		private var player3:String = new String(" ");
		private var player4:String = new String(" ");
		private var player5:String = new String(" ");
		private var arrayPart:int = 0;
		
		
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
			background = new Image(assetManager.getTexture("background"));
			addChild(background);
			
			looks[0] = new Image(assetManager.getTexture("customize_women_1"));
			looks[1] = new Image(assetManager.getTexture("customize_women_2"));
			looks[2] = new Image(assetManager.getTexture("customize_women_3"));
			looks[3] = new Image(assetManager.getTexture("customize_women_4"));
			
			playerImage = looks[0];
			playerImage.x = 175;
			addChild(playerImage);
			
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
			
			SetPlayerNames(arrayPart);
			
			LoadPlayerButtons(arrayPart);
			
			nextButton = new Button(assetManager.getTexture("next_button"));
			nextButton.addEventListener(Event.TRIGGERED, NextListOfPlayers);
			nextButton.x = 50;
			nextButton.y = 275;
			addChild(nextButton);
			
			previousButton = new Button(assetManager.getTexture("previous_button"));
			previousButton.addEventListener(Event.TRIGGERED, PreviousListOfPlayers);
			previousButton.x = 10;
			previousButton.y = 275;
			addChild(previousButton);
			
			trace(names);
		}
		
		private function LoadPlayerButtons(_param:int):void{
			
			if(playerButton1 != null){
				removeChild(playerButton1);
			}
			
			if(playerButton2 != null){
				removeChild(playerButton2);
			}
			
			if(playerButton3 != null){
				removeChild(playerButton3);
			}
			
			if(playerButton4 != null){
				removeChild(playerButton4);
			}
			
			if(playerButton5 != null){
				removeChild(playerButton5);
			}
			
			if(Common.IO.GetInstance().getNames()[0 + (_param * 5)] != null){
				playerButton1 = new Button(assetManager.getTexture("button_player"),player1);
				playerButton1.addEventListener(Event.TRIGGERED, LoadPlayer1);
				playerButton1.x = 10;
				playerButton1.y = 20;
				addChild(playerButton1);
			}
			if(Common.IO.GetInstance().getNames()[1 + (_param * 5)] != null){
				playerButton2 = new Button(assetManager.getTexture("button_player"),player2);
				playerButton2.addEventListener(Event.TRIGGERED, LoadPlayer2);
				playerButton2.x = 10;
				playerButton2.y = 70;
				addChild(playerButton2);
			}
			
			if(Common.IO.GetInstance().getNames()[2 + (_param * 5)] != null){
				playerButton3 = new Button(assetManager.getTexture("button_player"),Common.IO.GetInstance().getNames()[2]);
				playerButton3.addEventListener(Event.TRIGGERED, LoadPlayer3);
				playerButton3.x = 10;
				playerButton3.y = 120;
				addChild(playerButton3);
			}
			
			if(Common.IO.GetInstance().getNames()[3 + (_param * 5)] != null){
				playerButton4 = new Button(assetManager.getTexture("button_player"),player4);
				playerButton4.addEventListener(Event.TRIGGERED, LoadPlayer4);
				playerButton4.x = 10;
				playerButton4.y = 170;
				addChild(playerButton4);
			}
			
			if(Common.IO.GetInstance().getNames()[4 + (_param * 5)] != null){
				playerButton5 = new Button(assetManager.getTexture("button_player"),player5);
				playerButton5.addEventListener(Event.TRIGGERED, LoadPlayer5);
				playerButton5.x = 10;
				playerButton5.y = 220;
				addChild(playerButton5);
			}
		}
		
		private function SetPlayerNames(_param:int):void{
			if(Common.IO.GetInstance().getNames()[0 + (_param * 5)] != null){
				player1 = Common.IO.GetInstance().getNames()[0 + (_param * 5)];
			}else{
				player1 = " ";
			}
			if(Common.IO.GetInstance().getNames()[1 + (_param * 5)] != null){
				player2 = Common.IO.GetInstance().getNames()[1 + (_param * 5)];
			}else{
				player2 = " ";
			}
			if(Common.IO.GetInstance().getNames()[2 + (_param * 5)] != null){
				player3 = Common.IO.GetInstance().getNames()[2 + (_param * 5)];
			}else{
				player3 = " ";
			}
			if(Common.IO.GetInstance().getNames()[3 + (_param * 5)] != null){
				player4 = Common.IO.GetInstance().getNames()[3 + (_param * 5)];
			}else{
				player4 = " ";
			}
			if(Common.IO.GetInstance().getNames()[4 + (_param * 5)] != null){
				player5 = Common.IO.GetInstance().getNames()[4 + (_param * 5)];
			}else{
				player5 = " ";
			}
		}
		
		
		private function LoadPlayer1(event:Event):void{
			removeChild(playerImage);
			if(player1 != " "){
				Common.IO.GetInstance().loadUserProfile(player1);
				playerImage = looks[View.GetInstance().GetPlayer().GetLooks()];
				playerImage.x = 175;
				addChild(playerImage);
			}
		}
		
		private function LoadPlayer2(event:Event):void{
			if(player2 != " "){
				Common.IO.GetInstance().loadUserProfile(player2);
				playerImage = looks[View.GetInstance().GetPlayer().GetLooks()];
				playerImage.x = 175;
				addChild(playerImage);
			}
		}
		
		private function LoadPlayer3(event:Event):void{
			if(player3 != " "){
				Common.IO.GetInstance().loadUserProfile(player3);
				playerImage = looks[View.GetInstance().GetPlayer().GetLooks()];
				playerImage.x = 175;
				addChild(playerImage);
			}
		}
		
		private function LoadPlayer4(event:Event):void{
			if(player4 != " "){
				Common.IO.GetInstance().loadUserProfile(player4);
				playerImage = looks[View.GetInstance().GetPlayer().GetLooks()];
				playerImage.x = 175;
				addChild(playerImage);
			}
		}
		
		private function LoadPlayer5(event:Event):void{
			if(player5 != " "){
				Common.IO.GetInstance().loadUserProfile(player5);
				playerImage = looks[View.GetInstance().GetPlayer().GetLooks()];
				playerImage.x = 175;
				addChild(playerImage);
			}
		}
		
		
		private function NextListOfPlayers(event:Event):void{
			arrayPart++;
			if((arrayPart * 5) <= Common.IO.GetInstance().getNames().length){
				SetPlayerNames(arrayPart);
				LoadPlayerButtons(arrayPart);
			}else{
				arrayPart--;
			}
		}
		
		private function PreviousListOfPlayers(event:Event):void{
			if(arrayPart > 0){
				arrayPart--;
				SetPlayerNames(arrayPart);
				LoadPlayerButtons(arrayPart);
			}
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
			removeEventListeners(null);
			assetManager.dispose();
		}
	}
}
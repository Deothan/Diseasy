package Menu
{
	import flash.desktop.NativeApplication;
	import flash.filesystem.File;
	
	import Common.Highscore;
	import Common.IO;
	import Common.Screen;
	
	import Customize.Customize;
	
	import Load.Load;
	
	import Main.View;
	
	import Settings.Settings;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class Menu extends Sprite implements Screen{
		private var assetManager:AssetManager = new AssetManager();
		private var mapButton:Button;
		private var settingsButton:Button;
		private var loadButton:Button;
		private var exitButton:Button;
		private var highscoreButton:Button;
		private var background:Image;
		
		public function Menu(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Menu/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			IO.GetInstance().reset();
			View.GetInstance().getSoundControl();
			View.GetInstance().SetLastScreen("Menu");
			
			background = new Image(assetManager.getTexture("background"));
			addChild(background);
			
			mapButton = new Button(assetManager.getTexture("menu_play"));
			mapButton.addEventListener(Event.TRIGGERED, MapButtonTriggered);
			mapButton.x = 50;
			mapButton.y = 30;
			addChild(mapButton);
			
			loadButton = new Button(assetManager.getTexture("menu_load"));
			loadButton.addEventListener(Event.TRIGGERED, LoadButtonTriggered);
			loadButton.x = 250;
			loadButton.y = 30;
			addChild(loadButton);
			
			exitButton = new Button(assetManager.getTexture("menu_exit"));
			exitButton.addEventListener(Event.TRIGGERED, ExitButtonTriggered);
			exitButton.x = 50;
			exitButton.y = 220;
			addChild(exitButton);
			
			highscoreButton = new Button(assetManager.getTexture("button_highscore"));
			highscoreButton.addEventListener(Event.TRIGGERED, highscoreTriggered);
			highscoreButton.x = 280;
			highscoreButton.y = 220;
			addChild(highscoreButton);
			
		}
		
		/**
		 * Closes the application.
		 */
		private function ExitButtonTriggered():void{
			View.GetInstance().getSoundControl().playButton();
			NativeApplication.nativeApplication.exit();
		}
		
		/**
		 * Opens the Highscore screen
		 */
		private function highscoreTriggered():void{
			View.GetInstance().getSoundControl().playButton();
			View.GetInstance().setCurrentLevel(-1);
			View.GetInstance().LoadScreen(Highscore);
		}
		
		/**
		 * Opens the Load screen.
		 */
		private function LoadButtonTriggered():void{
			View.GetInstance().getSoundControl().playButton();	
			/** set back before commit **/
			View.GetInstance().LoadScreen(Load);
		}
		
		/**
		 * Opens the map screen.
		 */
		private function MapButtonTriggered():void{
			View.GetInstance().getSoundControl().playButton();
			
			//set player to default
			View.GetInstance().GetPlayer().SetName('Enter Name');
			View.GetInstance().GetPlayer().setCoin(0);
			View.GetInstance().GetPlayer().setLife(5);
			View.GetInstance().GetPlayer().SetLooks(0);
			View.GetInstance().GetPlayer().RemoveItem(null);
			View.GetInstance().GetPlayer().overWriteSetHighscore(null);
			
			View.GetInstance().LoadScreen(Customize);
		}
		
		/**
		 * Opens the settings screen.
		 */
		private function SettingsButtonTriggered():void{
			View.GetInstance().getSoundControl().playButton();	
			View.GetInstance().LoadScreen(Settings);
		}
		
		public function Update():void{

		}
		
		public function Destroy():void{
			removeEventListeners(null);
			assetManager.dispose();
		}
	}
}
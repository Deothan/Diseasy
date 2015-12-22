package Menu
{
	import flash.desktop.NativeApplication;
	import flash.filesystem.File;
	
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
		}
		
		/**
		 * Closes the application.
		 */
		private function ExitButtonTriggered():void{
			View.GetInstance().getSoundControl().playButton();
			NativeApplication.nativeApplication.exit();
		}
		
		/**
		 * Opens the Load screen.
		 */
		private function LoadButtonTriggered():void{
			View.GetInstance().getSoundControl().playButton();	
			View.GetInstance().LoadScreen(Load);
		}
		
		/**
		 * Opens the map screen.
		 */
		private function MapButtonTriggered():void{
			View.GetInstance().getSoundControl().playButton();	
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
package Menu
{
	import flash.desktop.NativeApplication;
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Level_1.Level_1;
	
	import Main.View;
	
	import Map.Map;
	
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
			background = new Image(assetManager.getTexture("test"));
			addChild(background);
			
			mapButton = new Button(assetManager.getTexture("mapButton"), "Map");
			mapButton.addEventListener(Event.TRIGGERED, MapButtonTriggered);
			mapButton.x = 100;
			mapButton.y = 100;
			addChild(mapButton);
			
			settingsButton = new Button(assetManager.getTexture("settingsButton"), "Settings");
			settingsButton.addEventListener(Event.TRIGGERED, SettingsButtonTriggered);
			settingsButton.x = 320;
			settingsButton.y = 100;
			addChild(settingsButton);
			
			loadButton = new Button(assetManager.getTexture("loadButton"), "Load");
			loadButton.addEventListener(Event.TRIGGERED, LoadButtonTriggered);
			loadButton.x = 100;
			loadButton.y = 200;
			addChild(loadButton);
			
			exitButton = new Button(assetManager.getTexture("exitButton"), "Exit");
			exitButton.addEventListener(Event.TRIGGERED, ExitButtonTriggered);
			exitButton.x = 320;
			exitButton.y = 200;
			addChild(exitButton);
		}
		
		/**
		 * Closes the application.
		 */
		private function ExitButtonTriggered():void{
			NativeApplication.nativeApplication.exit();
		}
		
		/**
		 * Opens the Load screen.
		 */
		private function LoadButtonTriggered():void{
			//View.GetInstance().LoadScreen(Load);
		}
		
		/**
		 * Opens the map screen.
		 */
		private function MapButtonTriggered():void{
			View.GetInstance().LoadScreen(Map);
		}
		
		/**
		 * Opens the settings screen.
		 */
		private function SettingsButtonTriggered():void{
			View.GetInstance().LoadScreen(Settings);
		}
		
		public function Update():void{
			
		}
		
		public function Destroy():void{
			
		}
	}
}
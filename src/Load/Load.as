package Load
{
	
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Main.View;
	
	import Menu.Menu;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class Load extends Sprite implements Screen{
		private var assetManager:AssetManager = new AssetManager();
		private var backButton:Button;
		private var background:Image;
		
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
			
			backButton = new Button(assetManager.getTexture("button_back"));
			backButton.addEventListener(Event.TRIGGERED, ExitButtonTriggered);
			backButton.x = 370;
			backButton.y = 260;
			addChild(backButton);
		}
		
		public function Update():void{
		}
		
		private function LoadButtonTriggered():void{
			View.GetInstance().LoadScreen(Menu);
		}
		
		private function ExitButtonTriggered():void{
			View.GetInstance().LoadScreen(Menu);
		}
		
		public function Destroy():void{
			backButton.removeEventListener(Event.TRIGGERED, ExitButtonTriggered);
			assetManager.dispose();
		}
	}
}
package Customize{
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Main.View;
	
	import Map.Map;
	
	import Menu.Menu;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.AssetManager;

	public class Customize extends Sprite implements Screen{
		private var assetManager:AssetManager = new AssetManager();
		private var background:Image;
		private var topImage:Image;
		private var middleImage:Image;
		private var bottomImage:Image;
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
			background = new Image(assetManager.getTexture("test"));
			addChild(background);
			
			topImage = new Image(assetManager.getTexture("face"));
			topImage.x = 185;
			topImage.y = 60;
			addChild(topImage);
			
			middleImage = new Image(assetManager.getTexture("middle"));
			middleImage.x = 185;
			middleImage.y = 125;
			addChild(middleImage);
			
			bottomImage = new Image(assetManager.getTexture("bottom"));
			bottomImage.x = 185;
			bottomImage.y = 174;
			addChild(bottomImage);
			
			okButton = new Button(assetManager.getTexture("okButton"), "OK");
			okButton.addEventListener(Event.TRIGGERED, OkButtonTriggered);
			okButton.x = 412;
			okButton.y = 292;
			addChild(okButton);
			
			nameText = new TextField(50, 20, "Name");
			nameText.color = 0xFFFFFF;
			nameText.x = 200;
			nameText.y = 20;
			addChild(nameText);
		}
		
		private function OkButtonTriggered():void{
			View.GetInstance().LoadScreen(Map);
		}
		
		public function Update():void{
			
		}
		
		public function Destroy():void{

		}
	}
}
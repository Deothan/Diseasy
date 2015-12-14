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
		private var background:Image;
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
			assetManager.dispose();
		}
	}
}
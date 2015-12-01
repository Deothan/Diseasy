package Settings{
	import flash.filesystem.File;
	import flash.media.SoundTransform;
	
	import Common.Screen;
	
	import Main.View;
	
	import Menu.Menu;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.AssetManager;

	public class Settings extends Sprite implements Screen{
		private var assetManager:AssetManager = new AssetManager();
		private var background:Image;
		private var backButton:Button;
		private var soundOn:Boolean;
		private var soundText:TextField;
		private var soundOnOffText:TextField;
		private var sound:SoundTransform = new SoundTransform;
		
		public function Settings(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Settings/assets");
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
			
			backButton = new Button(assetManager.getTexture("backButton"), "Back");
			backButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			backButton.x = 412;
			backButton.y = 292;
			addChild(backButton);
			
			soundText = new TextField(50, 30, "Sound:");
			soundText.color = 0xFFFFFF;
			soundText.x = 50;
			soundText.y = 50;
			addChild(soundText);
			
			if(View.GetInstance().GetVolume() == 1){
				soundOnOffText = new TextField(30, 30, "ON");
				soundOn = true;
			}
			else{
				soundOnOffText = new TextField(30, 30, "OFF");
				soundOn = false;
			}
					
			soundOnOffText.color = 0xFFFFFF;
			soundOnOffText.x = 150;
			soundOnOffText.y = 50;
			soundOnOffText.addEventListener(TouchEvent.TOUCH, SoundTouch);
			addChild(soundOnOffText);
		}
		
		private function SoundTouch(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				if(soundOn){
					soundOnOffText.text = "OFF";
					soundOn = false;
					sound.volume = 0;
				}
				else{
					soundOnOffText.text = "ON";
					soundOn = true;
					sound.volume = 1;
				}
				View.GetInstance().SetVolume(sound.volume);
			}
		}
		
		private function BackButtonTriggered():void{
			View.GetInstance().LoadScreen(Menu);
		}
		
		public function Update():void{
			
		}
		
		public function Destroy():void{
			
		}
	}
}
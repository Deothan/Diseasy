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
	import starling.utils.AssetManager;

	public class Settings extends Sprite implements Screen{
		private var assetManager:AssetManager = new AssetManager();
		private var background:Image;
		private var backButton:Button;
		private var soundOn:Boolean;
		private var soundOnButton:Button;
		private var soundOffButton:Button;
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
			background = new Image(assetManager.getTexture("background"));
			addChild(background);
			
			backButton = new Button(assetManager.getTexture("button_back"));
			backButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			backButton.x = 370;
			backButton.y = 260;
			addChild(backButton);
			
			soundOnButton = new Button(assetManager.getTexture("sound_off"));
			soundOnButton.alpha = 0.5;
			soundOnButton.addEventListener(Event.TRIGGERED, SoundTouch);
			soundOnButton.x = 350;
			soundOnButton.y = 50;
			addChild(soundOnButton);
			
			soundOffButton = new Button(assetManager.getTexture("sound_on"));
			soundOffButton.addEventListener(Event.TRIGGERED, SoundTouch);
			soundOffButton.x = 250;
			soundOffButton.y = 50;
			addChild(soundOffButton);
			
			if(View.GetInstance().GetVolume() == 1){
				soundOnButton.alpha = 0.5;
				soundOffButton.alpha = 1;
				soundOn = true;
			}
			else{
				soundOnButton.alpha = 0.5;
				soundOffButton.alpha = 1;
				soundOn = false;
			}
		}
		
		private function SoundTouch():void{
			if(soundOn){
				soundOnButton.alpha = 0.5;
				soundOffButton.alpha = 1;
				soundOn = false;
				sound.volume = 0;
			}
			else{
				soundOnButton.alpha = 1;
				soundOffButton.alpha = 0.5;
				soundOn = true;
				sound.volume = 1;
			}
			View.GetInstance().SetVolume(sound.volume);
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
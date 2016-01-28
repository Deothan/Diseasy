package Hospital{
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import Common.Screen;
	
	import InfantScreen.InfantScreen;
	
	import Main.View;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class Hospital extends Sprite implements Screen{
		private var assetManager:AssetManager;
		private var background:Image;
		private var timer:Timer;
		private var delayDone:Boolean = false;
		private var player:MovieClip;
		
		public function Hospital(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Hospital/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			timer = new flash.utils.Timer(3500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, Timed);
			
			background = new Image(assetManager.getTexture("hospital_animation"));
			addChild(background);
			player = new MovieClip(assetManager.getTextures("body instance"), 34);
			Starling.juggler.add(player);
			player.x = -10;
			player.y = 205;
			addChild(player);
		}
		
		private function Timed(event:TimerEvent):void{
			View.GetInstance().LoadScreen(InfantScreen);
		}
		
		private function movePlayer():void{
			if(player.x < 300){
				player.x += 2;
			}
			else{
				Starling.juggler.remove(player);
				removeChild(player);
				timer.start();
			}
		}
		
		public function Update():void{
				if(player != null) movePlayer();
		}
		
		public function Destroy():void{
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, Timed);
			removeEventListeners(null);
		}
	}
}
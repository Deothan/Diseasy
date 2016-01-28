package Main
{
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class Loader extends Sprite{
		private var assetManager:AssetManager;
		private var load:Image;
		private var timer:Timer;
		
		public function Loader(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Main/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			load = new Image(assetManager.getTexture("title"));
			addChild(load);
			
			timer = new Timer(2500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, Continue);
			timer.start();
			
			View.GetInstance().getSoundControl();
		}
		
		
		private function Continue(e:TimerEvent):void{
			removeChild(load);			
			
			assetManager.dispose();
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, Continue);
			
			addChild(View.GetInstance());
		}
	}
}
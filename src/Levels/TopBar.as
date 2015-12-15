package Levels{
	import flash.filesystem.File;
	
	import Main.View;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.AssetManager;

	public class TopBar extends Sprite{
		private var destroyed:Boolean = false;
		private var assetManager:AssetManager = new AssetManager();
		private var coinIcon:Image;
		private var coinText:TextField;
		private var timeText:TextField;
		private var timeCounterText:TextField;
		private var loaded:Boolean = false;
		
		public function TopBar(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Levels/assets/general");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			coinIcon = new Image(assetManager.getTexture("coin"));
			coinIcon.x = 460;
			coinIcon.y = 7;
			addChild(coinIcon);
			
			coinText = new TextField(35, 25, View.GetInstance().GetPlayer().getCoins() + "x");
			coinText.color = 0xFFFFFF;
			coinText.x = 428;
			coinText.y = 4;
			addChild(coinText);
			
			timeText = new TextField(45, 25, "Time:");
			timeText.color = 0xFFFFFF;
			timeText.x = 5;
			timeText.y = 5;
			addChild(timeText);
			
			timeCounterText = new TextField(30, 20, View.GetInstance().GetTime().toString(10));
			timeCounterText.color = 0xFFFFFF;
			timeCounterText.x = 42;
			timeCounterText.y = 7;
			addChild(timeCounterText);
			
			loaded = true;
		}
		
		public function Loaded():Boolean{
			return loaded;
		}
		
		public function Update():void{
			UpdateCoins();
			Timer();
		}
		
		private function Timer():void{
			var time:int = View.GetInstance().GetTime() + 1;
			View.GetInstance().SetTime(time);
			var timeString:int = time/24;
			timeCounterText.text = timeString.toString(10);
		}
		
		public function GetTime():int{
			return View.GetInstance().GetTime();
		}
		
		public function DecreaseTime(reduction:int):void{
			View.GetInstance().DecreaseTime();
		}
		
		private function UpdateCoins():void{
			this.coinText.text = ""+View.GetInstance().GetPlayer().getCoins() + " x";
		}
		
		public function Destroy():void{
			removeEventListeners(null);
			assetManager.dispose();
		}
	}
}
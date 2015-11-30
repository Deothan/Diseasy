package Level_1
{
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Main.View;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.Color;

	public class Level_1 extends Sprite implements Screen{
		private var assetManager:AssetManager;
		private var background:Image;
		private var coinIcon:Image;
		private var shownLife:int = 5;
		private var time:int;
		private var coinText:TextField;
		private var lifeText:TextField;
		private var timeText:TextField;
		private var timeCounterText:TextField;
		private var loaded:Boolean = false;
		private var progress:Quad;
		private var middle:Quad;
		private var left:Quad;
		private var right:Quad;
		private var exitButton:Button;
		private var entities:Array = new Array();
		private var hearts:Array = new Array();
		private var speed:int;
		
		public function Level_1(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Level_1/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			loaded = true;
			
			background = new Image(assetManager.getTexture("test"));
			addChild(background);
			
			coinIcon = new Image(assetManager.getTexture("coinIcon"));
			coinIcon.x = 460;
			coinIcon.y = 12;
			addChild(coinIcon);
			
			exitButton = new Button(assetManager.getTexture("exitButton"), "Exit");
			exitButton.addEventListener(Event.TRIGGERED, ExitButtonTriggered);
			exitButton.x = 412;
			exitButton.y = 292;
			addChild(exitButton);	
			
			coinText = new TextField(35, 25, "0 x");
			coinText.color = 0xFFFFFF;
			coinText.x = 425;
			coinText.y = 4;
			addChild(coinText);
			
			lifeText = new TextField(35, 25, "Life:");
			lifeText.color = 0xFFFFFF;
			lifeText.x = 5;
			lifeText.y = 292;
			addChild(lifeText);
			
			timeText = new TextField(45, 25, "Time:");
			timeText.color = 0xFFFFFF;
			timeText.x = 5;
			timeText.y = 5;
			addChild(timeText);
			
			timeCounterText = new TextField(30, 20, time.toString(10));
			timeCounterText.color = 0xFFFFFF;
			timeCounterText.x = 42;
			timeCounterText.y = 7;
			addChild(timeCounterText);

			middle = new Quad(100 ,2 ,Color.WHITE);
			middle.x = 290;
			middle.y = 302;
			addChild(middle);
			
			left = new Quad(2 ,9 ,Color.WHITE);
			left.x = 290;
			left.y = 298;
			addChild(left);
			
			right = new Quad(2 ,9 ,Color.WHITE);
			right.x = 390;
			right.y = 298;
			addChild(right);
			
			progress = new Quad(2 ,9 ,Color.WHITE);
			progress.x = 290;
			progress.y = 298;
			addChild(progress);
			
			AddEntities();
		}
		
		/**
		 * This is where all the entites specific for the level is added.
		 */
		private function AddEntities():void{
			
		}
		
		private function UpdateHearts():void{
			while(shownLife > hearts.length){
				var heart:Image = new Image(assetManager.getTexture("heartIcon"));
				heart.x = 45 + (hearts.length*17);
				heart.y = 298;
				hearts.push(heart);
				addChild(heart);
			}
			while(shownLife < hearts.length){
				removeChild(hearts.pop());
			}
		}
		
		private function ExitButtonTriggered():void{
			View.GetInstance().LoadScreen(Level_1);
		}
		
		private function Timer():void{
			time++;
			var timeString:int = time/24;
			timeCounterText.text = timeString.toString(10);
		}
		
		private function ProgressBar():void{
			if(progress.x < 390){
				progress.x += 1;
			}
		}
		
		private function MoveEntities():void{
			for(var e:Sprite in entities){
				e.x += speed;
			}
		}
		
		public function Update():void{
			if(loaded){
				Timer();
				ProgressBar();
				MoveEntities();
				UpdateHearts();
			}
		}

		public function Destroy():void{
		}
	}
}
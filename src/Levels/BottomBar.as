package Levels{
	import flash.filesystem.File;
	
	import Main.View;
	
	import Map.Map;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.Color;

	public class BottomBar extends Sprite{
		private var assetManager:AssetManager = new AssetManager();
		private var lifeText:TextField;
		private var loaded:Boolean = false;
		private var progress:Quad;
		private var middle:Quad;
		private var left:Quad;
		private var right:Quad;
		private var backButton:Button;
		private var hearts:Array = new Array();
		private var speed:int;
		private var widthOfLevelInPixels:int;
	
		public function BottomBar()		{
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
			backButton = new Button(assetManager.getTexture("button_back"));
			backButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			backButton.x = 370;
			backButton.y = 265;
			addChild(backButton);	
			
			lifeText = new TextField(35, 25, "Life:");
			lifeText.color = 0xFFFFFF;
			lifeText.x = 5;
			lifeText.y = 283;
			addChild(lifeText);
			
			middle = new Quad(100 ,2 ,Color.WHITE);
			middle.x = 250;
			middle.y = 292;
			addChild(middle);
			
			left = new Quad(2 ,9 ,Color.WHITE);
			left.x = 250;
			left.y = 288;
			addChild(left);
			
			right = new Quad(2 ,9 ,Color.WHITE);
			right.x = 350;
			right.y = 288;
			addChild(right);
			
			progress = new Quad(2 ,9 ,Color.WHITE);
			progress.x = 250;
			progress.y = 288;
			addChild(progress);
			
			loaded = true;
		}
		
		public function SetWidthOfLevelInPixels(width:int):void{
			widthOfLevelInPixels = width;
		}
		
		public function SetSpeed(speed:int):void{
			this.speed = speed;
		}
		
		private function UpdateHearts():void{
			while(View.GetInstance().GetPlayer().getLife() > hearts.length){
				var heart:Image = new Image(assetManager.getTexture("heart"));
				heart.x = 45 + (hearts.length*22);
				heart.y = 285;
				hearts.push(heart);
				addChild(heart);
			}
			while(View.GetInstance().GetPlayer().getLife() < hearts.length && View.GetInstance().GetPlayer().getLife() >= 0){
				removeChild(hearts.pop());
			}
			if(View.GetInstance().GetPlayer().getLife() <= 0){
				//Player dies.
			}
		}
		
		private function ProgressBar():void{
			if(progress.x < 350){
				progress.x += (speed/((widthOfLevelInPixels-480)/100));
			}
		}
		
		public function GetProgress():int{
			return progress.x - 250;
		}
		
		private function BackButtonTriggered():void{
			View.GetInstance().LoadScreen(Map);
		}
		
		public function Loaded():Boolean{
			return loaded;
		}
		
		public function Update():void{
			UpdateHearts();
			ProgressBar();
		}
		
		public function Destroy():void{
			removeEventListeners(null);
			assetManager.dispose();
		}
	}
}
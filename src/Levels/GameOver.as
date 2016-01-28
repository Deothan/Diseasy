package Levels{
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Main.View;
	
	import Map.Map;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;

	public class GameOver extends Sprite implements Screen{
		private var assetManager:AssetManager;
		private var gameOverImage:Image;
		private var gradient:Image;
		
		public function GameOver(){
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
			gradient = new Image(assetManager.getTexture("gradient"));
			gradient.addEventListener(TouchEvent.TOUCH, GameOverTouch);
			addChild(gradient)
			
			gameOverImage = new Image(assetManager.getTexture("GameOver"));
			gameOverImage.addEventListener(TouchEvent.TOUCH, GameOverTouch);
			addChild(gameOverImage);
		}		
		
		private function GameOverTouch(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				View.GetInstance().LoadScreen(Map);
			}
		}
		
		public function Update():void{
			
		}
		
		public function Destroy():void{
			
		}
	}
}
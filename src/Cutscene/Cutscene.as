package Cutscene{
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import Common.Screen;
	
	import Levels.Level_1;
	
	import Main.View;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class Cutscene extends Sprite implements Screen{
		private var assetManager:AssetManager;
		private var timer:Timer;
		private var scenes:Array = new Array();
		private var currentScene:int = 0;
		
		public function Cutscene(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Cutscene/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			timer = new Timer(3000, 6);
			timer.addEventListener(TimerEvent.TIMER, NextScene);
			
			scenes[0] = new Image(assetManager.getTexture("storyscene1"));
			scenes[1] = new Image(assetManager.getTexture("storyscene2"));
			scenes[2] = new Image(assetManager.getTexture("storyscene3"));
			scenes[3] = new Image(assetManager.getTexture("storyscene4"));
			scenes[4] = new Image(assetManager.getTexture("storyscene5"));
			scenes[5] = new Image(assetManager.getTexture("storyscene6"));
			
			addChild(scenes[currentScene]);
			
			timer.start();
		}
		
		private function NextScene(event:TimerEvent):void{
			removeChild(scenes[currentScene]);
			currentScene++;
			
			if(currentScene > 5)
				View.GetInstance().LoadScreen(Level_1);
			else
				addChild(scenes[currentScene]);
			
			
		}
		
		public function Update():void{			
		}
		
		public function Destroy():void{
			assetManager.dispose();
			removeEventListeners(null);
		}
	}
}
package Obstacles
{
	
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	
	import Common.Entity;
	import Common.Obstacle;
	
	import Main.View;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class Branch extends Sprite implements Entity, Obstacle		
	{
		private var assetManager:AssetManager;
		private var branchObstacle:Image;
		private var hit:Boolean=false;
		private var debugCode:int;
		
		public function Branch()
		{
			debugCode = randomRange(1000, 2000);
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function randomRange(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		private function Initialize():void
		{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Obstacles/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		public function getID():Number{
			return debugCode;
		}
		
		private function Progress(ratio:Number):void
		{
			if(ratio == 1)
			{
				Start();
			}
		}
		
		private function Start():void
		{
			branchObstacle = new Image(assetManager.getTexture("obstacle_branch"));
			branchObstacle.width = 40; 
			branchObstacle.height = 40; 
			addChild(branchObstacle);
		}
		
		public function Destroy():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Initialize);
			
			removeEventListeners(null);
			assetManager.dispose();
		}
		
		public function Destroyed():Boolean
		{
			return false;
		}
		
		public function isHit():Boolean
		{
			return hit;
		}
		
		public function getWidth():int
		{
			return this.width;
		}
		
		public function getHeight():int
		{
			return this.height;
		}
		
		public function Encounter():void
		{
			View.GetInstance().GetPlayer().loseLife();
			hit = true;
		}
	}
}
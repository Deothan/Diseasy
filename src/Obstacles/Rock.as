package Obstacles
{
	import flash.filesystem.File;
	
	import Common.Entity;
	import Common.Obstacle;
	
	import Main.View;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class Rock extends Sprite implements Entity, Obstacle
	{
		private var assetManager:AssetManager;
		private var rockObstacle:Image;
		private var hit:Boolean=false;
		
		public function Rock()
		{
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
			
		private function Initialize():void
		{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Obstacles/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
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
			rockObstacle = new Image(assetManager.getTexture("obstacle_stone"));
			rockObstacle.width = 40; 
			rockObstacle.height = 40; 
			addChild(rockObstacle);
		}
		
		public function Destroy():void
		{
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
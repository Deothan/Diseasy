package Main
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.geom.Rectangle;
	import Common.IO;
	import starling.core.Starling;
	
	public class Diseasy extends Sprite{
		public function Diseasy(){
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			
			var screenWidth:int = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			var viewPort:Rectangle = new Rectangle(0, 0, screenWidth, screenHeight);
			
			//loads save games to memory
			IO.GetInstance();
			
			var starlingInstance:Starling = new Starling(Loader, stage, viewPort);
			starlingInstance.stage.stageWidth = 480;
			starlingInstance.stage.stageHeight = 320;
			starlingInstance.start();
		}
	}
}
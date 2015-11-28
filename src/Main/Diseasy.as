package Main
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	public class Diseasy extends Sprite{
		public function Diseasy(){
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			
			var screenWidth:int = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			var viewPort:Rectangle = new Rectangle(0, 0, screenWidth, screenHeight);
			
			var starlingInstance:Starling = new Starling(View, stage, viewPort);
			starlingInstance.stage.stageWidth = 480;
			starlingInstance.stage.stageHeight = 320;
			starlingInstance.start();
		}
	}
}
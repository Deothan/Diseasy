package Level_1
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.AssetManager;

	public class Level_1 extends Sprite implements Screen{
		private var assetManager:AssetManager;
		private var background:Image;
		private var test:int;
		private var testText:TextField;
		private var loaded:Boolean = false;
		
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
			
			testText= new TextField(50, 100, test.toString(10));
			addChild(testText);
			
		}
		
		public function Update():void{
			if(loaded){
				test++;
				testText.text = test.toString(10);
			}
		}
	}
}
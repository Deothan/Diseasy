package Shop
{
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Main.View;
	
	import Menu.Menu;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class Shop extends Sprite implements Screen{
		private var assetManager:AssetManager = new AssetManager();
		private var background:Image;
		private var backButton:Button;
		private var buyMedicineButton:Button;
		private var buyTowelButton:Button;
		private var buyBlanketButton:Button;
		private var buyWaterBottleButton:Button;
		
		public function Shop(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Load/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			background = new Image(assetManager.getTexture("shop_screen_example"));
			addChild(background);

			
			backButton = new Button(assetManager.getTexture("button_back"));
			backButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			backButton.x = 370;
			backButton.y = 263;
			addChild(backButton);
			
			buyMedicineButton = new Button(assetManager.getTexture("button_buy"));
			buyMedicineButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			buyMedicineButton.x = 270;
			buyMedicineButton.y = 103;
			addChild(buyMedicineButton);
			
			buyTowelButton = new Button(assetManager.getTexture("button_buy"));
			buyTowelButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			buyTowelButton.x = 270;
			buyTowelButton.y = 163;
			addChild(buyTowelButton);

			buyBlanketButton = new Button(assetManager.getTexture("button_buy"));
			buyBlanketButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			buyBlanketButton.x = 270;
			buyBlanketButton.y = 203;
			addChild(buyBlanketButton);
			
			buyWaterBottleButton = new Button(assetManager.getTexture("button_buy"));
			buyWaterBottleButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			buyWaterBottleButton.x = 270;
			buyWaterBottleButton.y = 263;
			addChild(buyWaterBottleButton);
			
		}
		
		private function BackButtonTriggered():void{
			View.GetInstance().LoadScreen(Menu);//Should be infant care screen
		}
		
		public function Update():void{
			
		}
		
		public function Destroy():void{
			removeEventListener(Event.ADDED_TO_STAGE, Initialize);
			assetManager.dispose();
		}
	}
}
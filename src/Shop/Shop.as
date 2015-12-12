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
		private var medicineImage:Image;
		private var towelImage:Image;
		private var blanketImage:Image;
		private var waterBottleImage:Image;
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
			var folder:File = File.applicationDirectory.resolvePath("Shop/assets");
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
			
			medicineImage = new Image(assetManager.getTexture("shop_medicine"));
			medicineImage.x = 35;
			medicineImage.y = 20;
			addChild(medicineImage);
			
			towelImage = new Image(assetManager.getTexture("shop_towel"));
			towelImage.x = 26;
			towelImage.y = 91;
			addChild(towelImage);
			
			blanketImage = new Image(assetManager.getTexture("shop_blanket"));
			blanketImage.x = 30;
			blanketImage.y = 155;
			addChild(blanketImage);
			
			waterBottleImage = new Image(assetManager.getTexture("shop_water"));
			waterBottleImage.x = 33;
			waterBottleImage.y = 220;
			addChild(waterBottleImage);
			
			var coinText1:Image = new Image(assetManager.getTexture("coin_text"));
			coinText1.x = 105;
			coinText1.y = 40;
			addChild(coinText1);
			
			backButton = new Button(assetManager.getTexture("button_back"));
			backButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			backButton.x = 370;
			backButton.y = 263;
			addChild(backButton);
			
			buyMedicineButton = new Button(assetManager.getTexture("button_buy"));
			buyMedicineButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			buyMedicineButton.x = 200;
			buyMedicineButton.y = 27;
			addChild(buyMedicineButton);
			
			buyTowelButton = new Button(assetManager.getTexture("button_buy"));
			buyTowelButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			buyTowelButton.x = 200;
			buyTowelButton.y = 94;
			addChild(buyTowelButton);

			buyBlanketButton = new Button(assetManager.getTexture("button_buy"));
			buyBlanketButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			buyBlanketButton.x = 200;
			buyBlanketButton.y = 162;
			addChild(buyBlanketButton);
			
			buyWaterBottleButton = new Button(assetManager.getTexture("button_buy"));
			buyWaterBottleButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			buyWaterBottleButton.x = 200;
			buyWaterBottleButton.y = 234;
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
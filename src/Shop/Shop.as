package Shop
{
	import flash.filesystem.File;
	
	import Common.IO;
	import Common.Screen;

	import InfantScreen.InfantScreen;
	
	import Items.Blanket;
	import Items.Medicine;
	import Items.Towel;
	import Items.WaterBottle;
	
	import Main.View;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
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
		private var coins:int;
		private var medicinePrice:int = 1;
		private var towelPrice:int =2;
		private var blanketPrice:int = 3;
		private var waterPrice:int =4
		private var textField1:TextField;
		private var tutorial0:Image;
		private var tutorial1:Image;
		private var tutorial2:Image;
		private var notEnoughCoins:Image;
		private var notEnoughCoinsGradient:Image;
			
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
			coins = View.GetInstance().GetPlayer().getCoins();
			
			background = new Image(assetManager.getTexture("shop_screen"));
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
			
			var coinText2:Image = new Image(assetManager.getTexture("coin_text"));
			coinText2.x = 105;
			coinText2.y = 103;
			addChild(coinText2);
			
			var coinText3:Image = new Image(assetManager.getTexture("coin_text"));
			coinText3.x = 105;
			coinText3.y = 170;
			addChild(coinText3);
			
			var coinText4:Image = new Image(assetManager.getTexture("coin_text"));
			coinText4.x = 105;
			coinText4.y = 247;
			addChild(coinText4);
			
			var coinText5:Image = new Image(assetManager.getTexture("coin_text"));
			coinText5.x = 352;
			coinText5.y = 25;
			addChild(coinText5);
			
			textField1 = new TextField(50,25,coins.toString(),"Arial",18,0x0,true);
			textField1.x = 410;
			textField1.y = 25;
			addChild(textField1);
			
			var textField2:TextField = new TextField(50,25,medicinePrice.toString(),"Arial",18,0x0,true);
			textField2.x = 153;
			textField2.y = 40;
			addChild(textField2);
			
			var textField3:TextField = new TextField(50,25,towelPrice.toString(),"Arial",18,0x0,true);
			textField3.x = 153;
			textField3.y = 103;
			addChild(textField3);
			
			var textField4:TextField = new TextField(50,25,blanketPrice.toString(),"Arial",18,0x0,true);
			textField4.x = 153;
			textField4.y = 170;
			addChild(textField4);
			
			var textField5:TextField = new TextField(50,25,waterPrice.toString(),"Arial",18,0x0,true);
			textField5.x = 153;
			textField5.y = 247;
			addChild(textField5);
			
			backButton = new Button(assetManager.getTexture("button_back"));
			backButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			backButton.x = 370;
			backButton.y = 263;
			addChild(backButton);
			
			buyMedicineButton = new Button(assetManager.getTexture("button_buy"));
			buyMedicineButton.addEventListener(Event.TRIGGERED, BuyMedicineButtonTriggered);
			buyMedicineButton.x = 200;
			buyMedicineButton.y = 27;
			addChild(buyMedicineButton);
			
			buyTowelButton = new Button(assetManager.getTexture("button_buy"));
			buyTowelButton.addEventListener(Event.TRIGGERED, BuyTowelButtonTriggered);
			buyTowelButton.x = 200;
			buyTowelButton.y = 94;
			addChild(buyTowelButton);

			buyBlanketButton = new Button(assetManager.getTexture("button_buy"));
			buyBlanketButton.addEventListener(Event.TRIGGERED, BuyBlanketButtonTriggered);
			buyBlanketButton.x = 200;
			buyBlanketButton.y = 162;
			addChild(buyBlanketButton);
			
			buyWaterBottleButton = new Button(assetManager.getTexture("button_buy"));
			buyWaterBottleButton.addEventListener(Event.TRIGGERED, BuyWaterBottleButtonTriggered);
			buyWaterBottleButton.x = 200;
			buyWaterBottleButton.y = 234;
			addChild(buyWaterBottleButton);
			
			if(!View.GetInstance().GetPlayer().GetTutorials()[3]){
				tutorial0 = new Image(assetManager.getTexture("gradient"));
				addChild(tutorial0);

				tutorial1 = new Image(assetManager.getTexture("cutscene_shop1"));
				tutorial1.addEventListener(TouchEvent.TOUCH, TutorialTouch);
				addChild(tutorial1);
			}			
		}
		
		private function NotEnoughCoins():void{
			notEnoughCoinsGradient = new Image(assetManager.getTexture("gradient"));
			addChild(notEnoughCoinsGradient)
			
			notEnoughCoins = new Image(assetManager.getTexture("not_enough_coins"));
			notEnoughCoins.addEventListener(TouchEvent.TOUCH, NotEnoughCoinsTouch);
			addChild(notEnoughCoins);
		}
		
		private function NotEnoughCoinsTouch(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				removeChild(notEnoughCoins);
				removeChild(notEnoughCoinsGradient)
			}
		}
		
		private function TutorialTouch(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				View.GetInstance().getSoundControl().playButton();
				if(event.target == tutorial1){
					tutorial1.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial1);
					tutorial2 = new Image(assetManager.getTexture("cutscene_shop2"));
					tutorial2.addEventListener(TouchEvent.TOUCH, TutorialTouch);
					addChild(tutorial2);
				}
				else if(event.target == tutorial2){
					tutorial2.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial2);
					removeChild(tutorial0);
					
					View.GetInstance().GetPlayer().setTutorials(3, true);
				}
			}				
		}
		
		private function BuyMedicineButtonTriggered():void{
			View.GetInstance().getSoundControl().playButton();
			if(coins >= medicinePrice){
				coins -= medicinePrice;
				View.GetInstance().GetPlayer().setCoin(coins);
				View.GetInstance().GetPlayer().addItem(new Medicine());
				textField1.text = coins.toString();
			}
			else
				NotEnoughCoins();
		}
		
		private function BuyTowelButtonTriggered():void{
			View.GetInstance().getSoundControl().playButton();
			if(coins >= towelPrice){
				coins -= towelPrice;
				View.GetInstance().GetPlayer().setCoin(coins);
				View.GetInstance().GetPlayer().addItem(new Towel());
				textField1.text = coins.toString();
			}
			else
				NotEnoughCoins();
		}
		
		private function BuyBlanketButtonTriggered():void{
			View.GetInstance().getSoundControl().playButton();
			if(coins >= blanketPrice){
				coins -= blanketPrice;
				View.GetInstance().GetPlayer().setCoin(coins);
				View.GetInstance().GetPlayer().addItem(new Blanket());
				textField1.text = coins.toString();
			}
			else
				NotEnoughCoins();
		}
		
		private function BuyWaterBottleButtonTriggered():void{
			View.GetInstance().getSoundControl().playButton();
			if(coins >= waterPrice){
				coins -= waterPrice;
				View.GetInstance().GetPlayer().setCoin(coins);
				View.GetInstance().GetPlayer().addItem(new WaterBottle());
				textField1.text = coins.toString();
			}
			else
				NotEnoughCoins();
		}
		
		private function BackButtonTriggered():void{
			View.GetInstance().getSoundControl().playButton();
			View.GetInstance().LoadScreen(InfantScreen);
		}
		
		public function Update():void{
			
		}
		
		public function Destroy():void{
			removeEventListeners(null);
			assetManager.dispose();
			IO.GetInstance().Save();
		}
	}
}
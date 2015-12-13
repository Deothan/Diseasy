package InfantScreen
{	
	import flash.filesystem.File;
	import flash.utils.getQualifiedClassName;
	
	import Common.Entity;
	import Common.Item;
	import Common.Screen;
	
	import Items.Blanket;
	import Items.Medicine;
	import Items.Towel;
	import Items.WaterBottle;
	
	import Main.View;
	
	import Menu.Menu;
	
	import Shop.Shop;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.Color;
	
	public class InfantScreen extends Sprite implements Screen{
		private var assetManager:AssetManager;
		private var background:Image;
		private var continueButton:Button;
		private var hospitalButton:Button;
		private var medicineButton:Button;
		private var shopButton:Button;
		private var towelButton:Button;
		private var waterButton:Button;
		private var coinText:TextField;
		private var blanketText:TextField;
		private var medicineText:TextField;
		private var towelText:TextField;
		private var waterbottleText:TextField;
		private var Health:Quad;
		private var HealthRED:Quad;
		private var Hygiene:Quad;
		private var HygieneRED:Quad;
		private var Hydration:Quad;
		private var HydrationRED:Quad;
		private var Temperature:Quad;
		private var TemperatureRED:Quad;
		private var Infant:Image;
		private var ready:Boolean = false;
		
		
		public function InfantScreen(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("InfantScreen/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			View.GetInstance().setInfantScreen(this);
			var items:Array = View.GetInstance().GetPlayer().getItems();
			background = new Image(assetManager.getTexture("infantcare_background"));
			View.GetInstance().AddEntity(background);
			addChild(background);
			
			continueButton = new Button(assetManager.getTexture("button_continue"));
			continueButton.addEventListener(Event.TRIGGERED, continueButtonTriggered);
			continueButton.x = 320;
			continueButton.y = 265;
			addChild(continueButton);	

			shopButton = new Button(assetManager.getTexture("button_shop"));
			shopButton.addEventListener(Event.TRIGGERED, shopButtonTriggered);
			shopButton.width = (shopButton.width * 1.3);
			shopButton.height = (shopButton.height * 1.3);
			shopButton.x = 360;
			shopButton.y = 155;
			addChild(shopButton);
			
			hospitalButton = new Button(assetManager.getTexture("button_hospital"));
			hospitalButton.addEventListener(Event.TRIGGERED, hospitalButtonTriggered);
			hospitalButton.x = 220;
			hospitalButton.y = 230;
			addChild(hospitalButton);
			
			towelButton = new Button(assetManager.getTexture("button_towel"));
			towelButton.addEventListener(Event.TRIGGERED, towelButtonTriggered);
			towelButton.x = 150;
			towelButton.y = 230;
			addChild(towelButton);
			
			towelText = new TextField(40, 40, items[1], "Verdana", 20, Color.BLACK, true);
			towelText.x = towelButton.x + 2;
			towelText.y = towelButton.y - 27;
			addChild(towelText);
			
			medicineButton = new Button(assetManager.getTexture("button_medicine"));
			medicineButton.addEventListener(Event.TRIGGERED, medicineButtonTriggered);
			medicineButton.x = 80;
			medicineButton.y = 230;
			addChild(medicineButton);
			
			medicineText = new TextField(40, 40, items[0], "Verdana", 20, Color.BLACK, true);
			medicineText.x = medicineButton.x + 2;
			medicineText.y = medicineButton.y - 27;
			addChild(medicineText);
			
			waterButton = new Button(assetManager.getTexture("button_water"));
			waterButton.addEventListener(Event.TRIGGERED, waterButtonTriggered);
			waterButton.x = 10;
			waterButton.y = 230;
			addChild(waterButton);
			
			waterbottleText = new TextField(40, 40, items[2], "Verdana", 20, Color.BLACK, true);
			waterbottleText.x = waterButton.x + 2;
			waterbottleText.y = waterButton.y - 27;
			addChild(waterbottleText);
			
			HealthRED = new Quad(100 ,13 ,Color.RED);
			HealthRED.x = 90;
			HealthRED.y = 7;
			addChild(HealthRED);
			
			Health = new Quad(50 ,13 ,Color.GREEN);
			Health.x = 90;
			Health.y = 7;
			addChild(Health);
			
			HygieneRED = new Quad(100 ,13 ,Color.RED);
			HygieneRED.x = 90;
			HygieneRED.y = 25;
			addChild(HygieneRED);
			
			Hygiene = new Quad(75 ,13 ,Color.GREEN);
			Hygiene.x = 90;
			Hygiene.y = 25;
			addChild(Hygiene);
			
			HydrationRED = new Quad(100 ,13 ,Color.RED);
			HydrationRED.x = 365;
			HydrationRED.y = 7;
			addChild(HydrationRED);
			
			Hydration = new Quad(83 ,13 ,Color.GREEN);
			Hydration.x = 365;
			Hydration.y = 7;
			addChild(Hydration);
			
			TemperatureRED = new Quad(100 ,13 ,Color.RED);
			TemperatureRED.x = 365;
			TemperatureRED.y = 25;
			addChild(TemperatureRED);
			
			Temperature = new Quad(17 ,13 ,Color.GREEN);
			Temperature.x = 365;
			Temperature.y = 25;
			addChild(Temperature);
			
			this.ready = true;
			
			Infant = new Image(assetManager.getTexture("babyface1_normal"));
			Infant.x = 150;
			Infant.y = 50;
			addChild(Infant);
		}
		
		private function waterButtonTriggered():void{
			var item:Item;
			var i:int = 0;

			while(item != WaterBottle && i < View.GetInstance().GetPlayer().GetItemsArray().length){
				item = View.GetInstance().GetPlayer().GetItemsArray()[i];
				i++;
				
				if(item is WaterBottle){
					item.triggerEffect();
				}
			}
		}
		
		private function towelButtonTriggered():void{
			var item:Item;
			var i:int = 0;
			
			while(item != Towel && i < View.GetInstance().GetPlayer().GetItemsArray().length){
				item = View.GetInstance().GetPlayer().GetItemsArray()[i];
				i++;
				
				if(item is Towel){
					item.triggerEffect();
				}
			}
		}
		
		private function shopButtonTriggered():void
		{
			View.GetInstance().LoadScreen(Shop);
		}
		
		private function medicineButtonTriggered():void{
			var item:Item;
			var i:int = 0;
			
			while(item != Medicine && i < View.GetInstance().GetPlayer().GetItemsArray().length){
				item = View.GetInstance().GetPlayer().GetItemsArray()[i];
				i++;
			
				if(item is Medicine){
					item.triggerEffect();
				}
			}
		}
		
		private function blanketButtonTriggered():void{
			var item:Item;
			var i:int = 0;
			
			while(item != Blanket && i < View.GetInstance().GetPlayer().GetItemsArray().length){
				item = View.GetInstance().GetPlayer().GetItemsArray()[i];
				i++;
				
				if(item is Blanket){
					item.triggerEffect();
				}
			}
		}
		
		private function hospitalButtonTriggered():void
		{
			// TODO Auto Generated method stub
		}
		
		private function continueButtonTriggered():void
		{
			View.GetInstance().LoadScreen(Menu);
		}
		
		
		/**
		 * Updates the screen.
		 */
		public function Update():void{
			if(ready){
				Health.width = View.GetInstance().GetInfant().getHealth();
				Hygiene.width = View.GetInstance().GetInfant().getHygiene();
				Hydration.width = View.GetInstance().GetInfant().getHydration();
				Temperature.width = View.GetInstance().GetInfant().getTemperature();
				var items:Array = View.GetInstance().GetPlayer().getItems();
				medicineText.text = items[0];
				towelText.text = items[1];
				waterbottleText.text = items[2];
			}
			
		}
		
		/**
		 * method to switch infant state (i.e.: healthy, fever, hunger, normal, cold, diarrhea, neonatalsepsis)
		 */
		public function switchInfant(state:String):void{
			if(state.search("healthy") >= 0){
				Infant.texture = assetManager.getTexture("babyface1_healthy");
			}
			if(state.search("fever") >= 0){
				Infant.texture = assetManager.getTexture("babyface1_fever");
			}
			if(state.search("hunger") >= 0){
				Infant.texture = assetManager.getTexture("babyface1_hunger");
			}
			if(state.search("normal") >= 0){
				Infant.texture = assetManager.getTexture("babyface1_normal");	
			}
			if(state.search("cold") >= 0){
				Infant.texture = assetManager.getTexture("babyface1_cold");
			}
			if(state.search("diarrhea") >= 0){
				Infant.texture = assetManager.getTexture("babyface1_diarrhea");
			}
			if(state.search("neonatalsepsis") >= 0){
				Infant.texture = assetManager.getTexture("babyface1_neonatalsepsis");
			}
		}
		
		public function Destroy():void{
			ready = false;
			continueButton.removeEventListener(Event.TRIGGERED, continueButtonTriggered);
			hospitalButton.removeEventListener(Event.TRIGGERED, hospitalButtonTriggered);
			medicineButton.removeEventListener(Event.TRIGGERED, medicineButtonTriggered);
			shopButton.removeEventListener(Event.TRIGGERED, shopButtonTriggered);
			towelButton.removeEventListener(Event.TRIGGERED, towelButtonTriggered);
			waterButton.removeEventListener(Event.TRIGGERED, waterButtonTriggered);
			removeEventListener(Event.ADDED_TO_STAGE, Initialize);
			assetManager.dispose();
			
		}
	}
}
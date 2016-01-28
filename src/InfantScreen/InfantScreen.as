package InfantScreen
{	
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;
	
	import Common.IO;
	import Common.Item;
	import Common.Screen;
	
	import Hospital.Hospital;
	
	import Items.Blanket;
	import Items.Medicine;
	import Items.Towel;
	import Items.WaterBottle;
	
	import Main.View;
	
	import Shop.Shop;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
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
		private var blanketButton:Button;
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
		private var hospitalPrice:int = 15;
		private var timer:Timer;
		private var scenes:Array = new Array();
		private var currentScene:int = 0;
		private var currentState:String = "normal";
		private var tutorial0:Image;
		private var tutorial1:Image;
		private var tutorial2:Image;
		private var tutorial3:Image;
		private var tutorial4:Image;
		private var noMoney:Image;
		
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
			View.GetInstance().getSoundControl().playInfant();
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
			
			blanketButton = new Button(assetManager.getTexture("button_blanket"));
			blanketButton.addEventListener(Event.TRIGGERED, blanketButtonTriggered);
			blanketButton.x = 10;
			blanketButton.y = 135;
			addChild(blanketButton);
			
			blanketText = new TextField(40, 40, items[3], "Verdana", 20, Color.BLACK, true);
			blanketText.x = blanketButton.x + 2;
			blanketText.y = blanketButton.y - 27;
			addChild(blanketText);
			
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
			
			if(!View.GetInstance().GetPlayer().GetTutorials()[6]){
				tutorial0 = new Image(assetManager.getTexture("gradient"));
				addChild(tutorial0);
				
				tutorial1 = new Image(assetManager.getTexture("cutscene_infantcare1"));
				tutorial1.addEventListener(TouchEvent.TOUCH, TutorialTouch);
				addChild(tutorial1);
			}
		}
		
		private function TutorialTouch(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				View.GetInstance().getSoundControl().playButton();
				if(event.target == tutorial1){
					tutorial1.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial1);
					tutorial2 = new Image(assetManager.getTexture("cutscene_infantcare2"));
					tutorial2.addEventListener(TouchEvent.TOUCH, TutorialTouch);
					addChild(tutorial2);
				}
				else if(event.target == tutorial2){
					tutorial2.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial2);
					tutorial3 = new Image(assetManager.getTexture("cutscene_infantcare3"));
					tutorial3.addEventListener(TouchEvent.TOUCH, TutorialTouch);
					addChild(tutorial3);
				}
				else if(event.target == tutorial3){
					tutorial3.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial3);
					tutorial4 = new Image(assetManager.getTexture("cutscene_infantcare4"));
					tutorial4.addEventListener(TouchEvent.TOUCH, TutorialTouch);
					addChild(tutorial4);
				}
				else if(event.target == tutorial4){
					tutorial4.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial4);
					removeChild(tutorial0);
					
					View.GetInstance().GetPlayer().setTutorials(6, true);
				}
			}				
		}
		
		private function waterButtonTriggered():void{
			var item:Item;
			var i:int = 0;

			while(!(item is WaterBottle) && i < View.GetInstance().GetPlayer().GetItemsArray().length){
				item = View.GetInstance().GetPlayer().GetItemsArray()[i];
				i++;
				
				if(item is WaterBottle && View.GetInstance().GetInfant().getHydration() < 100){
					item.triggerEffect();
				}
			}
		}
		
		private function towelButtonTriggered():void{
			var item:Item;
			var i:int = 0;
			
			while(!(item is Towel) && i < View.GetInstance().GetPlayer().GetItemsArray().length){
				item = View.GetInstance().GetPlayer().GetItemsArray()[i];
				i++;
				
				if(item is Towel && View.GetInstance().GetInfant().getHygiene() < 100){
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
			
			while(!(item is Medicine) && i < View.GetInstance().GetPlayer().GetItemsArray().length){
				item = View.GetInstance().GetPlayer().GetItemsArray()[i];
				i++;
			
				if(item is Medicine && View.GetInstance().GetInfant().getHealth() < 100){
					item.triggerEffect();
				}
			}
		}
		
		private function blanketButtonTriggered():void{
			var item:Item;
			var i:int = 0;
			
			while(!(item is Blanket) && i < View.GetInstance().GetPlayer().GetItemsArray().length){
				trace(View.GetInstance().GetPlayer().GetItemsArray()[i]);
				item = View.GetInstance().GetPlayer().GetItemsArray()[i];
				i++;
				
				if(item is Blanket && View.GetInstance().GetInfant().getTemperature() < 100){
					item.triggerEffect();
				}
			}
		}
		
		private function hospitalButtonTriggered():void
		{
			View.GetInstance().GetPlayer().setCoin(100);
			if(View.GetInstance().GetPlayer().getCoins() > hospitalPrice){
				View.GetInstance().GetPlayer().changeCoins(-hospitalPrice);
				
				View.GetInstance().GetInfant().setHealth(100);
				View.GetInstance().GetInfant().setHydration(100);
				View.GetInstance().GetInfant().setHygiene(100);
				View.GetInstance().GetInfant().setTemperature(100);
				
				View.GetInstance().LoadScreen(Hospital);
			}
			else{
				noMoney = new Image(assetManager.getTexture("no_money_hospital"));
				noMoney.addEventListener(TouchEvent.TOUCH, NoMoneyTouch);
				addChild(noMoney);
			}
		}
		
		private function NoMoneyTouch(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				removeChild(noMoney);
			}
		}
		
		private function NextScene(event:TimerEvent):void{
			removeChild(scenes[currentScene]);
			currentScene++;
			
			if(currentScene > 5)
				View.GetInstance().LoadScreen(InfantScreen);
			else
				addChild(scenes[currentScene]);
		}
		
		private function continueButtonTriggered():void
		{
			View.GetInstance().LoadScreen(FeedbackScreen);
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
				blanketText.text = items[3];
				if(View.GetInstance().GetInfant().getHealth() > 99 && View.GetInstance().GetInfant().getHydration() > 99 && View.GetInstance().GetInfant().getHygiene() > 99 && View.GetInstance().GetInfant().getTemperature() > 99){
					View.GetInstance().GetInfant().setState("healthy");
				}
				if(View.GetInstance().GetInfant().getHealth() < 99 && View.GetInstance().GetInfant().getHydration() > 99 && View.GetInstance().GetInfant().getHygiene() > 99 && View.GetInstance().GetInfant().getTemperature() > 99){
					View.GetInstance().GetInfant().setState("normal");
				}
				if(View.GetInstance().GetInfant().getHealth() > 99 && View.GetInstance().GetInfant().getHydration() > 99 && View.GetInstance().GetInfant().getHygiene() > 99 && View.GetInstance().GetInfant().getTemperature() < 99){
					View.GetInstance().GetInfant().setState("cold");
				}
				if(currentState != View.GetInstance().GetInfant().getState()){
					switchInfant(View.GetInstance().GetInfant().getState());
				}
			}
		}
		
		/**
		 * method to switch infant state (i.e.: healthy, fever, hunger, normal, cold, diarrhea, neonatalsepsis)
		 */
		public function switchInfant(state:String):void{
			if(state.search("healthy") >= 0){
				Infant.texture = assetManager.getTexture("babyface1_healthy");
				currentState = "healthy";
			}
			if(state.search("fever") >= 0){
				Infant.texture = assetManager.getTexture("babyface1_fever");
				currentState = "fever";
			}
			if(state.search("hunger") >= 0){
				Infant.texture = assetManager.getTexture("babyface1_hunger");
				currentState = "hunger";
			}
			if(state.search("normal") >= 0){
				Infant.texture = assetManager.getTexture("babyface1_normal");
				currentState = "normal";
			}
			if(state.search("cold") >= 0){
				Infant.texture = assetManager.getTexture("babyface1_cold");
				currentState = "cold";
			}
			if(state.search("diarrhea") >= 0){
				Infant.texture = assetManager.getTexture("babyface1_diarrhea");
				currentState = "diarrhea";
			}
			if(state.search("neonatalsepsis") >= 0){
				Infant.texture = assetManager.getTexture("babyface1_neonatalsepsis");
				currentState = "neonatalsepsis";
			}
			if(state.search("hiv") >= 0){
				Infant.texture = assetManager.getTexture("babyface1_hiv");
				currentState = "hiv";
			}
		}
		
		public function Destroy():void{
			ready = false;
			removeEventListeners(null);
			assetManager.dispose();
			IO.GetInstance().Save();
		}
	}
}
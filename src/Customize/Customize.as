package Customize{
	import flash.filesystem.File;
	
	import Common.IO;
	import Common.Screen;
	
	import Main.View;
	
	import Map.Map;
	
	import Menu.Menu;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class Customize extends Sprite implements Screen{
		private var assetManager:AssetManager = new AssetManager();
		private var background:Image;
		private var tutorial1:Image;
		private var tutorial2:Image;
		private var tutorial3:Image;
		private var look:Image;
		private var currentLook:int;
		private var backButton:Button;
		private var lookButton:Button;
		private var okButton:Button;
		private var looks:Array = new Array();
		private var nameText:TextField;
		
		/** keyboard **/
		private var AButton:Button;
		private var BButton:Button;
		private var CButton:Button;
		private var DButton:Button;
		private var EButton:Button;
		private var FButton:Button;
		private var GButton:Button;
		private var HButton:Button;
		private var IButton:Button;
		private var JButton:Button;
		private var KButton:Button;
		private var LButton:Button;
		private var MButton:Button;
		private var NButton:Button;
		private var OButton:Button;
		private var PButton:Button;
		private var QButton:Button;
		private var RButton:Button;
		private var SButton:Button;
		private var TButton:Button;
		private var UButton:Button;
		private var VButton:Button;
		private var WButton:Button;
		private var XButton:Button;
		private var YButton:Button;
		private var ZButton:Button;
		private var BACKButton:Button;
		private var showKeyboard:Boolean = true;
		private var keyboardButton:Array = new Array();
		
		public function Customize(){
			addEventListener(starling.events.Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Customize/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		public function Start():void{	
			background = new Image(assetManager.getTexture("customize_screen1"));
			addChild(background);

			backButton = new Button(assetManager.getTexture("button_back"));
			backButton.addEventListener(starling.events.Event.TRIGGERED, BackButtonTriggered);
			backButton.x = 365;
			backButton.y = 265;
			addChild(backButton);
			
			okButton = new Button(assetManager.getTexture("button_ok"));
			okButton.addEventListener(starling.events.Event.TRIGGERED, OkButtonTriggered);
			okButton.x = 230;
			okButton.y = 248;
			addChild(okButton);
			
			lookButton = new Button(assetManager.getTexture("button_hair"));
			lookButton.addEventListener(starling.events.Event.TRIGGERED, LookButtonTriggered);
			lookButton.x = 280;
			lookButton.y = 140;
			addChild(lookButton);
			
			looks[0] = new Image(assetManager.getTexture("customize_women_1"));
			looks[1] = new Image(assetManager.getTexture("customize_women_2"));
			looks[2] = new Image(assetManager.getTexture("customize_women_3"));
			looks[3] = new Image(assetManager.getTexture("customize_women_4"));
		
			currentLook = View.GetInstance().GetPlayer().GetLooks();
			look = looks[currentLook];
			look.x = 10;
			look.y = 10;
			addChild(look);
			
			if(View.GetInstance().GetPlayer().name != 'Mother') nameText = new TextField(200,25,View.GetInstance().GetPlayer().GetName()); 
			else nameText = new TextField(200,25, '');
			nameText.fontSize = nameText.fontSize * 1.5; 
			nameText.x = 275;
			nameText.y = 26;
			nameText.autoScale = true;
			nameText.addEventListener(TouchEvent.TOUCH, onTouch);
			addChild(nameText);
			
			initializeKeyboard();
			generateKeyboard(0,185,60);
			for each(var currentButton:Button in keyboardButton){
				addChild(currentButton);
			}

			if(!View.GetInstance().GetPlayer().GetTutorials()[0]){
				tutorial1 = new Image(assetManager.getTexture("tutorial1"));
				tutorial1.addEventListener(TouchEvent.TOUCH, TutorialTouch);
				addChild(tutorial1);
			}
			
			
		}
		
		private function onTouch(event:TouchEvent):void{			
			if(event.getTouch(this, TouchPhase.BEGAN)){
				if(showKeyboard){
					for each(var currentButton:Button in keyboardButton){
						currentButton.alpha = 0;
					}
					showKeyboard = false;
				}
				else{
					for each(var currentButton2:Button in keyboardButton){
						currentButton2.alpha = 1;
					}
					if(nameText.text.match('Enter Name') || nameText.text.match('name taken')) nameText.text = '';
					showKeyboard = true;
				}
			}
		}
		
		/** 
		 * simple algerithm to generate keyboard 
		 */
		private function generateKeyboard(_index:int, _x:int, _y:int):void{
			if(_index >= keyboardButton.length) return;
			if(_index == 10) {
				_x = 205;
				_y = 90;
			}
			if(_index == 19){
				_x = 215;
				_y = 120;
			}
			keyboardButton[_index].fontBold = true;
			keyboardButton[_index].fontSize = 800;
			keyboardButton[_index].textHAlign = HAlign.CENTER;
			keyboardButton[_index].textVAlign = VAlign.CENTER;
			keyboardButton[_index].x = _x;
			keyboardButton[_index].y = _y;
			keyboardButton[_index].useHandCursor = true;
			generateKeyboard((_index + 1), (_x + 30), _y);
		}
		
		/**
		 * method to initialize keyboard buttons
		 */
		private function initializeKeyboard():void{
			AButton = new Button(assetManager.getTexture("button_keyboard"), 'A');
			AButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			AButton.width = 25;
			AButton.height = 25;
			keyboardButton.push(AButton);
			
			BButton = new Button(assetManager.getTexture("button_keyboard") , 'B');
			BButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			BButton.width = 25;
			BButton.height = 25;
			keyboardButton.push(BButton);
			
			CButton = new Button(assetManager.getTexture("button_keyboard") , 'C');
			CButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			CButton.width = 25;
			CButton.height = 25;
			keyboardButton.push(CButton);
			
			DButton = new Button(assetManager.getTexture("button_keyboard"), 'D');
			DButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			DButton.width = 25;
			DButton.height = 25;
			keyboardButton.push(DButton);
			
			EButton = new Button(assetManager.getTexture("button_keyboard"), 'E');
			EButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			EButton.width = 25;
			EButton.height = 25;
			keyboardButton.push(EButton);
			
			FButton = new Button(assetManager.getTexture("button_keyboard") , 'F');
			FButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			FButton.width = 25;
			FButton.height = 25;
			keyboardButton.push(FButton);
			
			GButton = new Button(assetManager.getTexture("button_keyboard"), 'G');
			GButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			GButton.width = 25;
			GButton.height = 25;
			keyboardButton.push(GButton);
			
			HButton = new Button(assetManager.getTexture("button_keyboard"), 'H');
			HButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			HButton.width = 25;
			HButton.height = 25;
			keyboardButton.push(HButton);
			
			IButton = new Button(assetManager.getTexture("button_keyboard"), 'I');
			IButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			IButton.width = 25;
			IButton.height = 25;
			keyboardButton.push(IButton);
			
			JButton = new Button(assetManager.getTexture("button_keyboard"), 'J');
			JButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			JButton.width = 25;
			JButton.height = 25;
			keyboardButton.push(JButton);
			
			KButton = new Button(assetManager.getTexture("button_keyboard"), 'K');
			KButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			KButton.width = 25;
			KButton.height = 25;
			keyboardButton.push(KButton);
			
			LButton = new Button(assetManager.getTexture("button_keyboard"), 'L');
			LButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			LButton.width = 25;
			LButton.height = 25;
			keyboardButton.push(LButton);
			
			MButton = new Button(assetManager.getTexture("button_keyboard"), 'M');
			MButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			MButton.width = 25;
			MButton.height = 25;
			keyboardButton.push(MButton);
			
			NButton = new Button(assetManager.getTexture("button_keyboard"), 'N');
			NButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			NButton.width = 25;
			NButton.height = 25;
			keyboardButton.push(NButton);
			
			OButton = new Button(assetManager.getTexture("button_keyboard"), 'O');
			OButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			OButton.width = 25;
			OButton.height = 25;
			keyboardButton.push(OButton);
			
			PButton = new Button(assetManager.getTexture("button_keyboard"), 'P');
			PButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			PButton.width = 25;
			PButton.height = 25;
			keyboardButton.push(PButton);
			
			QButton = new Button(assetManager.getTexture("button_keyboard"), 'Q');
			QButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			QButton.width = 25;
			QButton.height = 25;
			keyboardButton.push(QButton);
			
			RButton = new Button(assetManager.getTexture("button_keyboard"), 'R');
			RButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			RButton.width = 25;
			RButton.height = 25;
			keyboardButton.push(RButton);
			
			SButton = new Button(assetManager.getTexture("button_keyboard"), 'S');
			SButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			SButton.width = 25;
			SButton.height = 25;
			keyboardButton.push(SButton);
			
			TButton = new Button(assetManager.getTexture("button_keyboard"), 'T');
			TButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			TButton.width = 25;
			TButton.height = 25;
			keyboardButton.push(TButton);
			
			UButton = new Button(assetManager.getTexture("button_keyboard"), 'U');
			UButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			UButton.width = 25;
			UButton.height = 25;
			keyboardButton.push(UButton);
			
			VButton = new Button(assetManager.getTexture("button_keyboard"), 'V');
			VButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			VButton.width = 25;
			VButton.height = 25;
			keyboardButton.push(VButton);
			
			WButton = new Button(assetManager.getTexture("button_keyboard"), 'W');
			WButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			WButton.width = 25;
			WButton.height = 25;
			keyboardButton.push(WButton);
			
			XButton = new Button(assetManager.getTexture("button_keyboard"), 'X');
			XButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			XButton.width = 25;
			XButton.height = 25;
			keyboardButton.push(XButton);
			
			YButton= new Button(assetManager.getTexture("button_keyboard"), 'Y');
			YButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			YButton.width = 25;
			YButton.height = 25;
			keyboardButton.push(YButton);
			
			ZButton = new Button(assetManager.getTexture("button_keyboard"), 'Z');
			ZButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			ZButton.width = 25;
			ZButton.height = 25;
			keyboardButton.push(ZButton);
			
			BACKButton = new Button(assetManager.getTexture("arrow_left"), '');
			BACKButton.addEventListener(starling.events.Event.TRIGGERED, KeyboardButton);
			BACKButton.width = 25;
			BACKButton.height = 25;
			keyboardButton.push(BACKButton);
		}
		
		/** method to handle simpulated keyboard input **/
		private function KeyboardButton(event:starling.events.Event):void{
			if(nameText.text.length >= 13) return;
			if(event.target == BACKButton) if(nameText.text.length != 0) nameText.text = nameText.text.substr(0, nameText.text.length - 1);
			if(event.target == AButton) nameText.text = nameText.text + 'A';
			if(event.target == BButton) nameText.text = nameText.text + 'B';
			if(event.target == CButton) nameText.text = nameText.text + 'C';
			if(event.target == DButton) nameText.text = nameText.text + 'D';
			if(event.target == EButton) nameText.text = nameText.text + 'E';
			if(event.target == FButton) nameText.text = nameText.text + 'F';
			if(event.target == GButton) nameText.text = nameText.text + 'G';
			if(event.target == HButton) nameText.text = nameText.text + 'H';
			if(event.target == IButton) nameText.text = nameText.text + 'I';
			if(event.target == JButton) nameText.text = nameText.text + 'J';
			if(event.target == KButton) nameText.text = nameText.text + 'K';
			if(event.target == LButton) nameText.text = nameText.text + 'L';
			if(event.target == MButton) nameText.text = nameText.text + 'M';
			if(event.target == NButton) nameText.text = nameText.text + 'N';
			if(event.target == OButton) nameText.text = nameText.text + 'O';
			if(event.target == PButton) nameText.text = nameText.text + 'P';
			if(event.target == QButton) nameText.text = nameText.text + 'Q';
			if(event.target == RButton) nameText.text = nameText.text + 'R';
			if(event.target == SButton) nameText.text = nameText.text + 'S';
			if(event.target == TButton) nameText.text = nameText.text + 'T';
			if(event.target == UButton) nameText.text = nameText.text + 'U';
			if(event.target == VButton) nameText.text = nameText.text + 'V';
			if(event.target == WButton) nameText.text = nameText.text + 'W';
			if(event.target == XButton) nameText.text = nameText.text + 'X';
			if(event.target == YButton) nameText.text = nameText.text + 'Y';
			if(event.target == ZButton) nameText.text = nameText.text + 'Z';
			nameText.redraw();
		}		
		
		private function TutorialTouch(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				View.GetInstance().getSoundControl().playButton();
				if(event.target == tutorial1){
					tutorial1.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial1);
					tutorial2 = new Image(assetManager.getTexture("tutorial2"));
					tutorial2.addEventListener(TouchEvent.TOUCH, TutorialTouch);
					addChild(tutorial2);
				}
				else if(event.target == tutorial2){
					tutorial2.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial2);
					tutorial3 = new Image(assetManager.getTexture("tutorial3"));
					tutorial3.addEventListener(TouchEvent.TOUCH, TutorialTouch);
					addChild(tutorial3);
				}
				else if(event.target == tutorial3){
					tutorial3.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial3);
					
					View.GetInstance().GetPlayer().setTutorials(0, true);
				}
			}				
		}
		
		private function LookButtonTriggered():void{
			currentLook++;
			View.GetInstance().getSoundControl().playButton();
			
			if(currentLook > 3){
				currentLook = 0;
			}			
			
			removeChild(look);
			
			look = looks[currentLook];
			View.GetInstance().GetPlayer().SetLooks(currentLook);
			look.x = 10;
			look.y = 10;
			addChild(look);
		}
		
		private function OkButtonTriggered():void{
			if(View.GetInstance().GetLastScreen() == "Map"){
				View.GetInstance().getSoundControl().playButton();
				IO.GetInstance().Save();
				View.GetInstance().LoadScreen(Map);
				return;
			}
			if(nameText.text.length == 0 || nameText.text.match('Enter Name')) return;
			var namesAlreadyUsed:Array = IO.GetInstance().getNames();
			for each(var currentName:String in namesAlreadyUsed){
				if(nameText.text.match(currentName)){
					nameText.text = 'name taken'
					return;
				}
			}
			
			View.GetInstance().getSoundControl().playButton();
			View.GetInstance().GetPlayer().SetName(nameText.text);
			View.GetInstance().GetPlayer().SetLooks(currentLook);
			IO.GetInstance().Save();

			View.GetInstance().LoadScreen(Map);
		}
		
		private function BackButtonTriggered():void{
			if(View.GetInstance().GetLastScreen() == "Menu"){
				View.GetInstance().getSoundControl().playButton();
				View.GetInstance().LoadScreen(Menu);
			}
			else{
				View.GetInstance().LoadScreen(Map);
			}	
		}
		
		public function Update():void{}
		
		public function Destroy():void{
			removeEventListeners(null);

			assetManager.dispose();
		}
	}
}
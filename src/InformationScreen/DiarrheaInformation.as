package InformationScreen
{
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Main.View;
	
	import Menu.Menu;
	
	import VirusScreen.VirusScreen;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class DiarrheaInformation extends Sprite implements Screen
	{
		private var assetManager:AssetManager;
		private var background:Image;
		private var okButton:Button;
		private var diarrheaInformation:Image;
		private var englishButton:Button;
		private var luoButton:Button;
		
		public function DiarrheaInformation()
		{
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize() :void
		{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("InformationScreen/assets");
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
			background = new Image(assetManager.getTexture("screen_doctor"));
			addChild(background); 
			
			diarrheaInformation = new Image(assetManager.getTexture("Info_Screen_Diarrhea"));
			diarrheaInformation.x = 15;
			diarrheaInformation.y = 20;
			addChild(diarrheaInformation);
			
			okButton = new Button(assetManager.getTexture("button_ok"));
			okButton.addEventListener(Event.TRIGGERED, OkButtonTriggered);
			okButton.x = 339;
			okButton.y= 248;
			addChild(okButton);
			
			englishButton = new Button(assetManager.getTexture("button_english"));
			englishButton.addEventListener(Event.TRIGGERED, EnglishLanguage);
			englishButton.x = 356;
			englishButton.y = 11;
			addChild(englishButton);
			
			luoButton = new Button(assetManager.getTexture("button_luo"));
			luoButton.addEventListener(Event.TRIGGERED, LuoLanguage);
			luoButton.x = 356;
			luoButton.y = 11;
			addChild(luoButton);
		}
		
		public function OkButtonTriggered():void
		{
			View.GetInstance().LoadScreen(VirusScreen);
		}
		
		public function EnglishLanguage():void
		{
			removeChild(englishButton);
			addChild(luoButton);
			removeChild(diarrheaInformation);
			diarrheaInformation = new Image(assetManager.getTexture("Info_Screen_Diarrhea"));
			diarrheaInformation.x = 15;
			diarrheaInformation.y = 20;
			addChild(diarrheaInformation);
			
			//View.GetInstance().LoadScreen(LangaugeScreen);
		}	
		
		public function LuoLanguage():void
		{
			removeChild(luoButton);
			addChild(englishButton);
			removeChild(diarrheaInformation);
			diarrheaInformation = new Image(assetManager.getTexture("InfoLuo_Screen_Diarrhea"));
			diarrheaInformation.x = 15;
			diarrheaInformation.y = 20;
			addChild(diarrheaInformation); 
			
			//View.GetInstance().LoadScreen(LanguageScreen);
		}
		
		public function Update():void
		{			
		}
		
		public function Destroy() :void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Initialize);
			okButton.removeEventListener(Event.TRIGGERED, OkButtonTriggered);
			englishButton.removeEventListener(Event.TRIGGERED, EnglishLanguage);
			luoButton.removeEventListener(Event.TRIGGERED, LuoLanguage);
			assetManager.dispose();
		}
	}
}
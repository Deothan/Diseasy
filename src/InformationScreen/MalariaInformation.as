package InformationScreen
{
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Main.View;
	
	import VirusScreen.VirusScreen;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class MalariaInformation extends Sprite implements Screen
	{
		private var assetManager:AssetManager;
		private var background:Image;
		private var malariaInformation:Image;
		private var okButton:Button;
		private var englishButton:Button;
		private var luoButton:Button;
		
		public function MalariaInformation()
		{
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
			
		private function Initialize():void
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
			
			malariaInformation = new Image(assetManager.getTexture("Info_Screen_Malaria"));
			malariaInformation.x = 15;
			malariaInformation.y = 20;
			addChild(malariaInformation);
			
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
			removeChild(malariaInformation);
			malariaInformation = new Image(assetManager.getTexture("Info_Screen_Malaria"));
			malariaInformation.x = 15;
			malariaInformation.y = 20;
			addChild(malariaInformation);
		}	
		
		public function LuoLanguage():void
		{
			removeChild(luoButton);
			addChild(englishButton);
			removeChild(malariaInformation);
			malariaInformation = new Image(assetManager.getTexture("InfoLuo_Screen_Malaria"));
			malariaInformation.x = 15;
			malariaInformation.y = 20;
			addChild(malariaInformation);
		}
		
		public function Update():void
		{			
		}
		
		public function Destroy() :void
		{
			removeEventListeners(null);
			assetManager.dispose();
		}
	}
}
	
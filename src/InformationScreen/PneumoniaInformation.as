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

	public class PneumoniaInformation extends Sprite implements Screen
	{
		private var assetManager:AssetManager;
		private var background:Image;
		private var pneumoniaInformation:Image;
		private var okButton:Button;
		private var englishButton:Button;
		private var luoButton:Button;
		private var speakerButton:Button;
		
		public function PneumoniaInformation()
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
			
			pneumoniaInformation = new Image(assetManager.getTexture("Info_Screen_Pneumonia"));
			pneumoniaInformation.x = 15;
			pneumoniaInformation.y = 20;
			addChild(pneumoniaInformation);
			
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
			
			speakerButton = new Button(assetManager.getTexture("button_speakloud"));
			speakerButton.addEventListener(Event.TRIGGERED, Speaker);
			speakerButton.x = 380;
			speakerButton.y = 45;
			addChild(speakerButton);
		}
		
		public function OkButtonTriggered():void
		{
			View.GetInstance().LoadScreen(VirusScreen);
		}
		
		public function EnglishLanguage():void
		{
			removeChild(englishButton);
			addChild(luoButton);
			removeChild(pneumoniaInformation);
			pneumoniaInformation = new Image(assetManager.getTexture("Info_Screen_Pneumonia"));
			pneumoniaInformation.x = 15;
			pneumoniaInformation.y = 20;
			addChild(pneumoniaInformation);
		}	
		
		public function LuoLanguage():void
		{
			removeChild(luoButton);
			addChild(englishButton);
			removeChild(pneumoniaInformation);
			pneumoniaInformation = new Image(assetManager.getTexture("InfoLuo_Screen_Pneumonia"));
			pneumoniaInformation.x = 15;
			pneumoniaInformation.y = 20;
			addChild(pneumoniaInformation);
		}
		
		public function Speaker():void
		{
			View.GetInstance().getSoundControl().playPnuemonia();
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
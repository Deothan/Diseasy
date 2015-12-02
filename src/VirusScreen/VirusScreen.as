package VirusScreen
{
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import Main.View;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class VirusScreen extends Sprite implements Screen
	{
		private var assetManager:AssetManager;
		private var background:Image;
		private var continueButton:Button;
		private var diarrhea:Button; 
		private var hiv:Button;
		private var malaria:Button;
		private var pneumonia:Button;
		private var neonatalsepsis:Button;
		private var diarrheaClicked:Boolean = false;
		private var hivClicked:Boolean = false;
		private var malariaClicked:Boolean = false;
		private var pneumoniaClicked:Boolean = false;
		private var neonatalsepsisClicked:Boolean = false;
		
		public function VirusScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
			
		}
		
		private function Initialize() :void
		{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("VirusScreen/assets");
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
			background = new Image(assetManager.getTexture("Background"));
			addChild(background); 
			
			continueButton = new Button(assetManager.getTexture("Button"));
			continueButton.addEventListener(Event.TRIGGERED, ContinueButtonTriggered);
			continueButton.x = 312;
			continueButton.y = 262;
			addChild(continueButton);
			
			diarrhea = new Button(assetManager.getTexture("virusscreen_diarrhea"));
			diarrhea.addEventListener(Event.TRIGGERED, DiarrheaTriggered);
			diarrhea.x = 10;
			diarrhea.y = 10;
			addChild(diarrhea);
			
			hiv = new Button(assetManager.getTexture("virusscreen_hiv"));
			hiv.addEventListener(Event.TRIGGERED, HivTriggered);
			hiv.x = 70;
			hiv.y = 140;
			addChild(hiv);
			
			malaria = new Button(assetManager.getTexture("virusscreen_malaria"));
			malaria.addEventListener(Event.TRIGGERED, MalariaTriggered);
			malaria.x = 130;
			malaria.y = 10;
			addChild(malaria);
			
			pneumonia = new Button(assetManager.getTexture("virusscreen_pneumonia"));
			pneumonia.addEventListener(Event.TRIGGERED, PneumoniaTriggered);
			pneumonia.x = 190;
			pneumonia.y = 140;
			addChild(pneumonia);
			
			neonatalsepsis = new Button(assetManager.getTexture("virusscreen_neonatalsepsis"));
			neonatalsepsis.addEventListener(Event.TRIGGERED, NeonatalsepsisTriggered);
			neonatalsepsis.x = 250;
			neonatalsepsis.y = 10;
			addChild(neonatalsepsis);			
		}
		
		public function ContinueButtonTriggered():void
		{
			//View.GetInstance().LoadScreen(Infant);
		}
		
		public function DiarrheaTriggered():void
		{
			if (diarrheaClicked == false)
			{
				removeChild(diarrhea);
				diarrhea = new Button(assetManager.getTexture("virusscreen_diarrhea_check"));
				diarrhea.addEventListener(Event.TRIGGERED, DiarrheaTriggered);
				diarrhea.x = 10;
				diarrhea.y = 10;
				addChild(diarrhea);
				diarrheaClicked = true;
			}
			//View.GetInstance().LoadScreen(DiarrheaInformation);
		}
		
		public function HivTriggered():void
		{
			if (hivClicked == false)
			{
				removeChild(hiv);
				hiv = new Button(assetManager.getTexture("virusscreen_hiv_check"));
				hiv.addEventListener(Event.TRIGGERED, HivTriggered);
				hiv.x = 70;
				hiv.y = 140;
				addChild(hiv);
				hivClicked = true;
			}
			//View.GetInstance().LoadScreen(HivInformation);
		}
		
		public function MalariaTriggered():void
		{
			if (malariaClicked == false)
			{
				removeChild(malaria);
				malaria = new Button(assetManager.getTexture("virusscreen_malaria_check"));
				malaria.addEventListener(Event.TRIGGERED, MalariaTriggered);
				malaria.x = 130;
				malaria.y = 10;
				addChild(malaria);
				malariaClicked = true;
			}
			//View.GetInstance().LoadScreen(MalariaInformation);
		}
		
		public function PneumoniaTriggered():void
		{
			if (pneumoniaClicked == false)
			{
				removeChild(pneumonia);
				pneumonia = new Button(assetManager.getTexture("virusscreen_pneumonia_check"));
				pneumonia.addEventListener(Event.TRIGGERED, PneumoniaTriggered);
				pneumonia.x = 190;
				pneumonia.y = 140;
				addChild(pneumonia);
				pneumoniaClicked = true;
			}
			//View.GetInstance().LoadScreen(PneumoniaInformation);
		}
		
		public function NeonatalsepsisTriggered():void
		{
			if (neonatalsepsis == false);
			{
				removeChild(neonatalsepsis);
				neonatalsepsis = new Button(assetManager.getTexture("virusscreen_neonatalsepsis_check"));
				neonatalsepsis.addEventListener(Event.TRIGGERED, NeonatalsepsisTriggered);
				neonatalsepsis.x = 250;
				neonatalsepsis.y = 10;
				addChild(neonatalsepsis);
				neonatalsepsisClicked = true; 
			}
			//View.GetInstance().LoadScreen(NeonatalsepsisInformation);
		}
		
		public function Update():void
		{			
		}
		
		public function Destroy() :void
		{
		}
	}
}
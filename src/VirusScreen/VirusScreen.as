package VirusScreen
{
	import flash.filesystem.File;
	
	import Common.Screen;
	
	import InformationScreen.DiarrheaInformation;
	import InformationScreen.HivInformation;
	import InformationScreen.MalariaInformation;
	import InformationScreen.NeonatalSepsisInformation;
	import InformationScreen.PneumoniaInformation;
	
	import Main.View;
	
	import Menu.Menu;
	
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
		private var checkedArray:Array = View.GetInstance().GetPlayer().GetCheckedViruses();
		
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
			
			if (checkedArray[0])
			{
				removeChild(diarrhea);
				diarrhea = new Button(assetManager.getTexture("virusscreen_diarrhea_check"));
				diarrhea.addEventListener(Event.TRIGGERED, DiarrheaTriggered);
				diarrhea.x = 10;
				diarrhea.y = 10;
				addChild(diarrhea);
			}
			else
			{
				removeChild(diarrhea);
				diarrhea = new Button(assetManager.getTexture("virusscreen_diarrhea"));
				diarrhea.addEventListener(Event.TRIGGERED, DiarrheaTriggered);
				diarrhea.x = 10;
				diarrhea.y = 10;
				addChild(diarrhea);
			}
			
			if (checkedArray[1])
			{
				removeChild(hiv);
				hiv = new Button(assetManager.getTexture("virusscreen_hiv_check"));
				hiv.addEventListener(Event.TRIGGERED, HivTriggered);
				hiv.x = 70;
				hiv.y = 140;
				addChild(hiv);
			}
			else
			{
				removeChild(hiv);
				hiv = new Button(assetManager.getTexture("virusscreen_hiv"));
				hiv.addEventListener(Event.TRIGGERED, HivTriggered);
				hiv.x = 70;
				hiv.y = 140;
				addChild(hiv);
			}
			
			if (checkedArray[2])
			{
				removeChild(malaria);
				malaria = new Button(assetManager.getTexture("virusscreen_malaria_check"));
				malaria.addEventListener(Event.TRIGGERED, MalariaTriggered);
				malaria.x = 130;
				malaria.y = 10;
				addChild(malaria);
			}
			else
			{
				removeChild(malaria);
				malaria = new Button(assetManager.getTexture("virusscreen_malaria"));
				malaria.addEventListener(Event.TRIGGERED, MalariaTriggered);
				malaria.x = 130;
				malaria.y = 10;
				addChild(malaria);
			}
			
			if (checkedArray[3])
			{
				removeChild(pneumonia);
				pneumonia = new Button(assetManager.getTexture("virusscreen_pneumonia_check"));
				pneumonia.addEventListener(Event.TRIGGERED, PneumoniaTriggered);
				pneumonia.x = 190;
				pneumonia.y = 140;
				addChild(pneumonia);
			}
			else
			{
				removeChild(pneumonia);
				pneumonia = new Button(assetManager.getTexture("virusscreen_pneumonia"));
				pneumonia.addEventListener(Event.TRIGGERED, PneumoniaTriggered);
				pneumonia.x = 190;
				pneumonia.y = 140;
				addChild(pneumonia);
			}
			
			if (checkedArray[4])
			{
				removeChild(neonatalsepsis);
				neonatalsepsis = new Button(assetManager.getTexture("virusscreen_neonatalsepsis_check"));
				neonatalsepsis.addEventListener(Event.TRIGGERED, NeonatalsepsisTriggered);
				neonatalsepsis.x = 250;
				neonatalsepsis.y = 10;
				addChild(neonatalsepsis);		
			}
			else
			{
				removeChild(neonatalsepsis);
				neonatalsepsis = new Button(assetManager.getTexture("virusscreen_neonatalsepsis"));
				neonatalsepsis.addEventListener(Event.TRIGGERED, NeonatalsepsisTriggered);
				neonatalsepsis.x = 250;
				neonatalsepsis.y = 10;
				addChild(neonatalsepsis);
			}
		}
		
		public function ContinueButtonTriggered():void
		{
			View.GetInstance().LoadScreen(Menu);
		}
		
		public function DiarrheaTriggered():void
		{
			if (!checkedArray[0])
			{
				checkedArray[0] = true;
			}
			View.GetInstance().LoadScreen(DiarrheaInformation);
		}
		
		public function HivTriggered():void
		{
			if (!checkedArray[1])
			{
				checkedArray[1] = true;	
			}
			View.GetInstance().LoadScreen(HivInformation);
		}
		
		public function MalariaTriggered():void
		{
			if (!checkedArray[2])
			{
				checkedArray[2] = true;
			}
			View.GetInstance().LoadScreen(MalariaInformation);
		}
		
		public function PneumoniaTriggered():void
		{
			if (!checkedArray[3])
			{
				checkedArray[3] = true;
			}
			View.GetInstance().LoadScreen(PneumoniaInformation);
		}
		
		public function NeonatalsepsisTriggered():void
		{
			if (!checkedArray[4])
			{
				checkedArray[4] = true;
			}
			View.GetInstance().LoadScreen(NeonatalSepsisInformation);
		}
		
		public function Update():void
		{			
		}
		
		public function Destroy() :void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Initialize);
			continueButton.removeEventListener(Event.TRIGGERED, ContinueButtonTriggered);
			diarrhea.removeEventListener(Event.TRIGGERED, DiarrheaTriggered);
			hiv.removeEventListener(Event.TRIGGERED, HivTriggered);
			malaria.removeEventListener(Event.TRIGGERED, MalariaTriggered);
			pneumonia.removeEventListener(Event.TRIGGERED, PneumoniaTriggered);
			neonatalsepsis.removeEventListener(Event.TRIGGERED, NeonatalsepsisTriggered);
			assetManager.dispose();
			
			View.GetInstance().GetPlayer().SetCheckedViruses(checkedArray);
		}
	}
}
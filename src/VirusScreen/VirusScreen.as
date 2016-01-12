package VirusScreen
{
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import Common.IO;
	import Common.Screen;
	
	import InfantScreen.InfantScreen;
	import InfantScreen.Tutorial;
	
	import InformationScreen.NeonatalSepsisInformation;
	import InformationScreen.HivInformation;
	import InformationScreen.DiarrheaInformation;
	import InformationScreen.MalariaInformation;
	import InformationScreen.PneumoniaInformation;
	
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
		private var checkedArray:Array = View.GetInstance().GetPlayer().GetCheckedViruses();
		private var loaded:Boolean = false;
		
		public function VirusScreen()
		{
			if(!View.GetInstance().gettutorialVirusScreen()){
				View.GetInstance().settutorialVirusScreen(true);
				// !BUG! null pointer when VirusScreen gets loaded again. Tutorial working fine
				View.GetInstance().LoadScreen(VirusScreen.Tutorial);
			}
			else{
				addEventListener(Event.ADDED_TO_STAGE, Initialize);
			}
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
				diarrhea = new Button(assetManager.getTexture("virusscreen_neonatalsepsis_check"));
				diarrhea.addEventListener(Event.TRIGGERED, NeonatalsepsisTriggered);
				diarrhea.x = 65;
				diarrhea.y = 10;
				addChild(diarrhea);
			}
			else
			{
				diarrhea = new Button(assetManager.getTexture("virusscreen_neonatalsepsis"));
				diarrhea.addEventListener(Event.TRIGGERED, NeonatalsepsisTriggered);
				diarrhea.x = 65;
				diarrhea.y = 10;
				addChild(diarrhea);
			}
			
			if (checkedArray[1])
			{
				hiv = new Button(assetManager.getTexture("virusscreen_hiv_check"));
				hiv.addEventListener(Event.TRIGGERED, HivTriggered);
				hiv.x = 125;
				hiv.y = 140;
				addChild(hiv);
			}
			else
			{
				hiv = new Button(assetManager.getTexture("virusscreen_hiv"));
				hiv.addEventListener(Event.TRIGGERED, HivTriggered);
				hiv.x = 125;
				hiv.y = 140;
				addChild(hiv);
			}
			
			if (checkedArray[2])
			{
				malaria = new Button(assetManager.getTexture("virusscreen_diarrhea_check"));
				malaria.addEventListener(Event.TRIGGERED, DiarrheaTriggered);
				malaria.x = 185;
				malaria.y = 10;
				addChild(malaria);
			}
			else
			{
				malaria = new Button(assetManager.getTexture("virusscreen_diarrhea"));
				malaria.addEventListener(Event.TRIGGERED, DiarrheaTriggered);
				malaria.x = 185;
				malaria.y = 10;
				addChild(malaria);
			}
			
			if (checkedArray[3])
			{
				pneumonia = new Button(assetManager.getTexture("virusscreen_malaria_check"));
				pneumonia.addEventListener(Event.TRIGGERED, MalariaTriggered);
				pneumonia.x = 245;
				pneumonia.y = 140;
				addChild(pneumonia);
			}
			else
			{
				pneumonia = new Button(assetManager.getTexture("virusscreen_malaria"));
				pneumonia.addEventListener(Event.TRIGGERED, MalariaTriggered);
				pneumonia.x = 245;
				pneumonia.y = 140;
				addChild(pneumonia);
			}
			
			if (checkedArray[4])
			{
				neonatalsepsis = new Button(assetManager.getTexture("virusscreen_pneumonia_check"));
				neonatalsepsis.addEventListener(Event.TRIGGERED, PneumoniaTriggered);
				neonatalsepsis.x = 305;
				neonatalsepsis.y = 10;
				addChild(neonatalsepsis);		
			}
			else
			{
				neonatalsepsis = new Button(assetManager.getTexture("virusscreen_pneumonia"));
				neonatalsepsis.addEventListener(Event.TRIGGERED, PneumoniaTriggered);
				neonatalsepsis.x = 305;
				neonatalsepsis.y = 10;
				addChild(neonatalsepsis);
			}
			
			View.GetInstance().startVirusScreenUnlockTimer();
			
			loaded = true;
		}
		
		public function ContinueButtonTriggered():void
		{
			if(!View.GetInstance().getLockInformationScreen()){
				View.GetInstance().getSoundControl().playButton();
				var firstTime:Array = View.GetInstance().GetPlayer().getLevels();
				if(firstTime[2] == false) View.GetInstance().LoadScreen(InfantScreen.Tutorial);
				else View.GetInstance().LoadScreen(InfantScreen);	
			}
		}
		
		public function NeonatalsepsisTriggered():void
		{
			View.GetInstance().getSoundControl().playButton();
			if (!checkedArray[0])
			{
				checkedArray[0] = true;
			}
			View.GetInstance().LoadScreen(NeonatalSepsisInformation);
		}
		
		public function HivTriggered():void
		{
			View.GetInstance().getSoundControl().playButton();
			if (!checkedArray[1])
			{
				checkedArray[1] = true;	
			}
			View.GetInstance().LoadScreen(HivInformation);
		}
		
		public function DiarrheaTriggered():void
		{
			View.GetInstance().getSoundControl().playButton();
			if (!checkedArray[2])
			{
				checkedArray[2] = true;
			}
			View.GetInstance().LoadScreen(DiarrheaInformation);
		}
		
		public function MalariaTriggered():void
		{
			View.GetInstance().getSoundControl().playButton();
			if (!checkedArray[3])
			{
				checkedArray[3] = true;
			}
			View.GetInstance().LoadScreen(MalariaInformation);
		}
		
		public function PneumoniaTriggered():void
		{
			View.GetInstance().getSoundControl().playButton();
			if (!checkedArray[4])
			{
				checkedArray[4] = true;
			}
			View.GetInstance().LoadScreen(PneumoniaInformation);
		}
		
		public function Update():void
		{
			if(loaded){
				if(View.GetInstance().getLockInformationScreen())
					continueButton.alpha = 0.5;
				else
					continueButton.alpha = 1;
			}
		}
		
		public function Destroy() :void
		{
			removeEventListeners(null);
			if(assetManager != null)assetManager.dispose();
			View.GetInstance().GetPlayer().SetCheckedViruses(checkedArray);
			IO.GetInstance().Save();
		}
	}
}
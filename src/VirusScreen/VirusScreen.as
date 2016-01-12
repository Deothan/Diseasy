package VirusScreen
{
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import Common.IO;
	import Common.Screen;
	
	import InfantScreen.InfantScreen;
	import InfantScreen.Tutorial;
	
	import InformationScreen.DiarrheaInformation;
	import InformationScreen.HivInformation;
	import InformationScreen.MalariaInformation;
	import InformationScreen.NeonatalSepsisInformation;
	import InformationScreen.PneumoniaInformation;
	
	import Levels.Level_1;
	
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
				neonatalsepsis = new Button(assetManager.getTexture("virusscreen_neonatalsepsis_check"));
				neonatalsepsis.addEventListener(Event.TRIGGERED, NeonatalsepsisTriggered);
				neonatalsepsis.x = 65;
				neonatalsepsis.y = 10;
				addChild(neonatalsepsis);
			}
			else
			{
				neonatalsepsis = new Button(assetManager.getTexture("virusscreen_neonatalsepsis"));
				neonatalsepsis.addEventListener(Event.TRIGGERED, NeonatalsepsisTriggered);
				neonatalsepsis.x = 65;
				neonatalsepsis.y = 10;
				addChild(neonatalsepsis);
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
				diarrhea = new Button(assetManager.getTexture("virusscreen_diarrhea_check"));
				diarrhea.addEventListener(Event.TRIGGERED, DiarrheaTriggered);
				diarrhea.x = 185;
				diarrhea.y = 10;
				addChild(diarrhea);
			}
			else
			{
				diarrhea = new Button(assetManager.getTexture("virusscreen_diarrhea"));
				diarrhea.addEventListener(Event.TRIGGERED, DiarrheaTriggered);
				diarrhea.x = 185;
				diarrhea.y = 10;
				addChild(diarrhea);
			}
			
			if (checkedArray[3])
			{
				malaria = new Button(assetManager.getTexture("virusscreen_malaria_check"));
				malaria.addEventListener(Event.TRIGGERED, MalariaTriggered);
				malaria.x = 245;
				malaria.y = 140;
				addChild(malaria);
			}
			else
			{
				malaria = new Button(assetManager.getTexture("virusscreen_malaria"));
				malaria.addEventListener(Event.TRIGGERED, MalariaTriggered);
				malaria.x = 245;
				malaria.y = 140;
				addChild(malaria);
			}
			
			if (checkedArray[4])
			{
				pneumonia = new Button(assetManager.getTexture("virusscreen_pneumonia_check"));
				pneumonia.addEventListener(Event.TRIGGERED, PneumoniaTriggered);
				pneumonia.x = 305;
				pneumonia.y = 10;
				addChild(pneumonia);		
			}
			else
			{
				pneumonia = new Button(assetManager.getTexture("virusscreen_pneumonia"));
				pneumonia.addEventListener(Event.TRIGGERED, PneumoniaTriggered);
				pneumonia.x = 305;
				pneumonia.y = 10;
				addChild(pneumonia);
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
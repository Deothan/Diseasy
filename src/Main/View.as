package Main{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import Common.EntityPlaceholder;
	import Common.Screen;
	import Common.SoundControl;
	
	import InfantScreen.Infant;

	import Menu.Menu;
	
	import Player.Player;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class View extends Sprite{
		private static var instance:View = new View();
		private var screen:Sprite;
		private var volume:int;
		private var player:Player = new Player();
		private var infant:Infant = new Infant();
		private var entities:Array = new Array();
		private var soundtrack:SoundControl;
		private var time:int = 0;
		private var lastScreen:String = "Menu";
		private var lockInformationScreen:Boolean = true;
		private var timerStarted:Boolean = false;
		private var timer:Timer;
		//Delay before the player can go to next screen in seconds.
		private var delay:int = 10;		
		/** speed in which the level progresses **/
		private var currentSpeed:int = 2;
		private var defaultSpeed:int = 2;
		private var Tutorial:Boolean = false;
		private var tutorialVirusScreen:Boolean = false;
		private var currentLevel:int = 0;
		//The first Screen to load
		private var firstScreen:Class = Menu;
		private var level:Class;
		
		public function View(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
			addEventListener(Event.ENTER_FRAME, Update);
		}
		
		/**
		 * Singleton instance.
		 */
		public static function GetInstance():View{
			return instance;
		}
		
		private function Initialize(event:Event):void{
			LoadScreen(firstScreen);
			
			timer = new Timer((delay*1000), 1);
			timer.addEventListener(TimerEvent.TIMER, Unlock);
		}
		
		private function Update(event:Event):void{
			(screen as Screen).Update();
		}
		
		public function GetLevel():Class{
			return level;
		}
		
		public function SetLevel(level:Class):void{
			this.level = level;
		}
		
		public function setCurrentLevel(_level:int):void{
			currentLevel = _level;
		}
		
		public function getCurrentLevel():int{
			return currentLevel;
		}
		
		public function setSpeed(_speed:int):void{
			this.currentSpeed = _speed;
		}
		
		private function Unlock(event:TimerEvent):void{
			lockInformationScreen = false;
		}
		
		public function startVirusScreenUnlockTimer():void{
			if(!timerStarted)
				timer.start();
		}
		
		public function getLockInformationScreen():Boolean{
			return lockInformationScreen;
		}
		
		public function setLockInformationScreen(value:Boolean):void{
			lockInformationScreen = value;
		}
		
		public function getSpeed():int{
			return this.currentSpeed;
		}
		
		public function setDefaultSpeed(_speed:int):void{
			this.defaultSpeed = _speed;
		}
		
		public function setSpeedBackToDefault():void{
			this.currentSpeed = this.defaultSpeed;
		}
		
		public function GetTime():int{
			return time;
		}
		
		public function SetTime(time:int):void{
			this.time = time;
		}
		
		public function DecreaseTime():void{
			time -= 120;
		}
		
		public function GetLastScreen():String{
			return lastScreen;
		}
		
		public function SetLastScreen(lastScreen:String):void{
			this.lastScreen = lastScreen;
		}
		
		public function SetVolume(volume:int):void{
			this.volume = volume;
		}
		
		public function GetVolume():int{
			return volume;
		}
		
		public function GetPlayer():Player{
			return player;
		}
		
		public function GetInfant():Infant{
			return infant;
		}

		public function GetEntities():Array{
			return entities;
		}
		
		public function AddEntity(element:Object):void{
			entities.push(element);
		}
		
		public function RemoveEntity(element:Object):void{
			entities[entities.indexOf(element)] = new EntityPlaceholder();
		}
		
		public function LoadScreen(newScreen:Class):void{
			if(screen != null && contains(screen)){		
				(screen as Screen).Destroy();
				entities = new Array();
				removeChild(screen, true);
			}
			
			screen = new newScreen();
			addChild(screen);
		}
		
		public function getSoundControl():SoundControl{
			if(soundtrack == null){
				soundtrack = new SoundControl();
			}
			return soundtrack;
		}

		public function settutorialVirusScreen(value:Boolean):void{
			tutorialVirusScreen = value;
		}
		
		public function gettutorialVirusScreen():Boolean{
			return tutorialVirusScreen;
		}
	}
}
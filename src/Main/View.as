package Main{
	import Common.EntityPlaceholder;
	import Common.Level;
	import Common.Screen;
	
	import InfantScreen.Infant;
	import InfantScreen.InfantScreen;
	
	import Menu.Menu;
	
	import Platforms.Platform;
	
	import Player.Player;
	
	import VirusScreen.VirusScreen;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class View extends Sprite{
		private static var instance:View = new View();
		private var screen:Sprite;
		private var volume:int;
		private var player:Player = new Player();
		private var infant:Infant = new Infant();
		private var level:Level;
		private var entities:Array = new Array();
		private var infantScreen:InfantScreen;
		
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
			LoadScreen(InfantScreen);
		}
		
		private function Update(event:Event):void{
			(screen as Screen).Update();
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
		
		public function setLevel(currentLevel):void{
			level = currentLevel;
		}
		
		public function getLevel():Level{
			return level;
		}
		
		public function GetEntities():Array{
			return entities;
		}
		
		public function AddEntity(element:Object):void{
			entities.push(element);
		}
		
		public function setInfantScreen(InfantScreen):void{
			infantScreen = InfantScreen;
		}
		
		public function getInfantScreen():InfantScreen{
			return infantScreen;
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
	}
}
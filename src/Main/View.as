package Main{
	import Common.Level;
	import Common.Screen;
	
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
		private var level:Level;
		private var entities:Array = new Array();
		
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
			LoadScreen(Menu);
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
		
		public function RemoveEntity(element:Object):void{
			for(var i:int = entities.indexOf(element); i < entities.length-1; i++){				
				entities[i] = entities[i+1];					
			}
			
			entities.pop();
		}
		
		public function LoadScreen(newScreen:Class):void{
			if(screen != null && contains(screen)){		
				(screen as Screen).Destroy();
				removeChild(screen, true);
			}
			
			screen = new newScreen();
			addChild(screen);
		}
	}
}
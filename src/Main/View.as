package Main{
	import Common.Screen;
	
	import Level_1.Level_1;
	
	import Menu.Menu;
	
	import Settings.Settings;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class View extends Sprite{
		private static var instance:View = new View();
		private var screen:Sprite;
		
		
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
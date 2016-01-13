package InfantScreen{
	
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	public class Infant extends Sprite{
		private var assetManager:AssetManager;
		private var Health:int;
		private var Hygiene:int;
		private var Hydration:int;
		private var Temperature:int;
		private var animations:Array;
		private var state:String;
		private var loaded:Boolean;
		
		/**
		 * Infant object called by View. Object can be set by loading a profile
		 */
		public function Infant(){
			/** should be loaded **/
			
			/** default **/
			this.Health = 80;
			this.Hygiene = 80;
			this.Hydration = 80;
			this.Temperature = 80;
			
			state = "normal";
		}
		
		public function setState(newState:String):void{
			state = newState;
		}
		
		public function getState():String{
			return this.state;
		}
		
		public function getHealth():int{
			if(Health > 100) Health = 100;
			return this.Health;
		}
		
		public function getHygiene():int{
			if(Hygiene > 100) Hygiene = 100;
			return this.Hygiene;
		}
		
		public function getHydration():int{
			if(Hydration > 100) Hydration = 100;
			return this.Hydration;
		}
		
		public function getTemperature():int{
			if(Temperature > 100) Temperature = 100;
			return this.Temperature;
		}
		
		/**
		 * methods to set the parameters of the infant object
		 * @param the modyfier (either - or + value)
		 */
		public function setHealth(param:int):void{
			if((this.Health += param) > 100){
				this.Health = 100;
			}
			else if((this.Health += param) < 0){
				this.Health = 0;
			}
			else{
				this.Health += param;	
			}
		}
		
		public function setHygiene(param:int):void{
			if((this.Hygiene += param) > 100){
				this.Hygiene = 100;
			}
			else if((this.Hygiene += param) < 0){
				this.Hygiene = 0;
			}
			else{
				this.Hygiene += param;	
			}
		}
		
		public function setHydration(param:int):void{
			if((this.Hydration += param) > 100){
				this.Hydration = 100;
			}
			else if((this.Hydration += param) < 0){
				this.Hydration = 0;
			}
			else{
				this.Hydration += param;	
			}
		}
		
		public function setTemperature(param:int):void{
			if((this.Temperature += param) > 100){
				this.Temperature = 100;
			}
			else if((this.Temperature += param) < 0){
				this.Temperature = 0;
			}
			else{
				this.Temperature += param;	
			}
		}
		
	}
}
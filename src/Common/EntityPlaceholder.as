package Common{
	import starling.display.Sprite;

	public class EntityPlaceholder extends Sprite implements Entity{
		public function EntityPlaceholder(){}
		
		public function Destroy():void{}
		public function Destroyed():Boolean{return true}
		public function getWidth():int{return 0;};
		public function getHeight():int{return 0;};
	}
}
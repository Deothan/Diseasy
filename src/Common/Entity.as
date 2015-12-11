package Common{
	public interface Entity	{
		function Destroy():void;
		function Destroyed():Boolean;
		function getWidth():int;
		function getHeight():int;
	}
}
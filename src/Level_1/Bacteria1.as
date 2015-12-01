/**
 * Product owner: Hanze University of Applied Sciences
 * This class is not allowed to be copied or sold except with explicit permission from Hanze: University of Applied Sciences
 * @author:    Kevin Stoffers
 * @version: 1 (29/11/2015)
 */
 
package  {
	
	/**
     * Load external libraries
     */
    import flash.display.Stage;
    import flash.display.Sprite;
    import flash.geom.Point;
	
	/**
     * This class contains an instance of a bacteria1 class. By calling the constructor a new instance is initiated
     * To add the bacteria1 to the stage, the stage instance needs to be called in the constructor of the class.
     */
	public class Bacteria1 extends Sprite{
		
		/* parameters 
        * @param currentAnimationState the string representation of the animation state the bacteria1 is currently in
        * @param animations Array holding animations object
        * @param StageInstance the stage instance to add bacteria1 instance to
        * @param PositionX the desired x location (absolute to stage) position to spawn the item
        * @param PositionY the desired y location (absolute to stage) position to spawn the item
        */
		private var currentAnimationState:String;
        private var animations:Array;
        private var StageInstance:Stage;        
        private var PositionX:int;
        private var PositionY:int;
        
       /**
         * Class constructor sets stage, desired position x and desired position y
         * @param _stage stage instance to add the bacteria1 to
         * @param _positionx the desired x location (absolute to stage) position to spawn the item
         * @param _positiony the desired y loaction (absolute to stage) position to spawn the item
         */    
		public function Bacteria1(_stage:Stage, _desiredX:int, _desiredY:int) {
			this.StageInstance = _stage;
            this.PositionX = _desiredX;
            this.PositionY = _desiredY;
            loadAnimations();
            Spawn();
        }

        /**
         * Class public method to get x and y coordination of bacteria1 instance wrapped as Point
         * @return Point a point representation of objects x and y coordination
         */
        public function getPosition():Point{
            return new Point(this.animations[this.currentAnimationState].x, this.animations[this.currentAnimationState].y);
        }
        
        /**
        * Class public method to set x and y coordination of bacteria1 instance wrappes as Point
        * @param _position the desired position (absolute to stage) wrapped as Point
        */
        public function setPosition(_position:Point):void{
            this.PositionX = _position.x;
            this.PositionY = _position.y;
        }
        
        /**
         * Class private method that adds bacteria1 to the stage and places it on desired X/Y position
         */
        private function Spawn():void{
            switchAnimations(null);            
            this.StageInstance.addChild(animations[currentAnimationState]);
            animations[currentAnimationState].x = this.PositionX;
            animations[currentAnimationState].y = this.PositionY;
        }
        
       /**
         * Class private method that loads bacteria1 animations to memory
         * animations array holds reference to object
         */
         private function loadAnimations():void{
            var _idle:bacteria1Idle = new bacteria1Idle();
            var _hit:bacteria1Hit = new bacteria1Hit();
            
            this.animations = new Array();
            this.animations["idle"] = _idle;
            this.animations["hit"] = _hit;
        }
        
        /**
         * Class public method that switches bacteria1 animations in memory
         * if the currentAnimationState = null switches to idle (i.e.: before spawn)
         * if the currentAnimationState = param _animation do nothing
         * else save the current X and Y position, switch animation and set X and Y position
         * @param _animation the desired animation to switch to
         */
        public function switchAnimations(_animation:String):void{
            if(this.currentAnimationState == null){
                this.currentAnimationState = "idle";
            }
            else if(this.currentAnimationState == _animation){
                // do nothing
            }
            else{
                var positionX = this.animations[this.currentAnimationState].x;
                var positionY = this.animations[this.currentAnimationState].y;
                this.currentAnimationState = _animation;
                this.StageInstance.addChild(this.animations[this.currentAnimationState]);
                this.animations[this.currentAnimationState].x = positionX;
                this.animations[this.currentAnimationState].y = positionY;
            }
        }
		
		/**
		* Destroy this instance, to be called from player class
		* Destroy this instance and switches screen to virus 1 information screen
		*/
		public function onHit():void{
			this.parent.removeChild(this);
			StageInstance.screenSwitcher(virus1InformationScreen);
		}

    }
}
package Levels{
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import Common.Entity;
	import Common.Highscore;
	import Common.IO;
	import Common.Physicus;
	import Common.Screen;
	import Common.Virus;
	
	import Items.Blanket;
	import Items.Coin;
	import Items.Heart;
	import Items.Medicine;
	import Items.Towel;
	import Items.Watch;
	import Items.WaterBottle;
	
	import Main.View;
	
	import Obstacles.Rock;
	
	import Platforms.Platform;
	
	import Viruses.HIV;
	import Viruses.NeonatalSepsis;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class Level_2 extends Sprite implements Screen{
		private var assetManager:AssetManager;
		private var top:TopBar = new TopBar();
		private var bottom:BottomBar = new BottomBar;
		private var jumpLayer:JumpLayer = new JumpLayer();
		private var background1:Image;
		private var background2:Image;
		private var background3:Image;
		private var jumpScreen:Image;
		private var winImage:Image;
		private var loaded:Boolean = false;
		private var playerLoaded:Boolean = false;
		private var timer:flash.utils.Timer;
		private var spawned76:Boolean = false;
		private var spawned57:Boolean = false;
		private var spawned38:Boolean = false;
		private var spawned19:Boolean = false;
		private var spawned0:Boolean = false;
		private var pulseTracker:int = 0;
		private var pulseGoingUp:Boolean = true;
		
		//Changeable variables
		private var pulseSize:int = 15;
		private var widthOfLevelInPixels:int = 6150;
		private var speed:int = View.GetInstance().getSpeed();
		private var spawnTimeInSeconds:int = 13;
		
		public function Level_2(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Levels/assets/level2");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			View.GetInstance().GetPlayer().setLife(5);
			View.GetInstance().SetTime(0);
			
			View.GetInstance().GetInfant().setHealth(100);
			View.GetInstance().GetInfant().setHydration(100);
			View.GetInstance().GetInfant().setHygiene(100);
			View.GetInstance().GetInfant().setTemperature(100);

			timer = new flash.utils.Timer(3500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, Continue);
			
			background1 = new Image(assetManager.getTexture("background"));
			View.GetInstance().AddEntity(background1);
			addChild(background1);
			
			addChild(top);
			
			bottom.SetSpeed(speed);
			bottom.SetWidthOfLevelInPixels(widthOfLevelInPixels);
			addChild(bottom);
			
			AddEntities();
			
			addChild(jumpLayer);
			View.GetInstance().GetPlayer().setIdleFlag(false);
			View.GetInstance().GetPlayer().Run();
			
			loaded = true;
		}
		
		/**
		 * This is where all the entites specific for the level is added.
		 */
		private function AddEntities():void{
			/* CHANGING PLAYER SPAWN POSITION ALSO NEEDS TO BE CHANGED IN PHYSICUS -> GRAVITY */
			View.GetInstance().GetPlayer().x = 100;
			View.GetInstance().GetPlayer().y = 205;
			addChild(View.GetInstance().GetPlayer());
			
			for(var i:int = 0; i < 10; i++){
				if(((widthOfLevelInPixels/ 10) * i) < widthOfLevelInPixels-300 && (widthOfLevelInPixels/ 10) * i > 150){
					var enemy:Sprite = new HIV();
					enemy.x = ((widthOfLevelInPixels/ 10) * i);
					enemy.y = 215;
					View.GetInstance().AddEntity(enemy);
					addChildAt(enemy, 3);
				}	
			}
			
			for(i = 0; i < 29; i++){
				if(((widthOfLevelInPixels/ 29) * i) < widthOfLevelInPixels-300 && (widthOfLevelInPixels/ 29) * i > 150){
					var random:Number = Math.random();
					var item:Sprite;
					if(random < 0.15) item = new Coin();
					if(random > 0.15 && random < 0.3) item = new Heart();
					if(random > 0.3 && random < 0.45) item= new Towel();
					if(random > 0.45 && random < 0.6) item = new Blanket();
					if(random > 0.6 && random < 0.75) item= new Watch();
					if(random > 0.75 && random < 0.9) item = new WaterBottle();
					if(random > 0.9) item= new Medicine();
					
					item.x = ((widthOfLevelInPixels/ 29) * i);
					if(random < 0.3 || random > 0.75) item.y = 215;
					else item.y = 130;
					
					View.GetInstance().AddEntity(item);
					addChildAt(item, 3);
				}	
			}
			
			for(i = 0; i < 14; i++){
				if(((widthOfLevelInPixels/ 14) * i) < widthOfLevelInPixels-300 && (widthOfLevelInPixels/ 14) * i > 150){
					var platform:Sprite = new Platform();
					platform.x = ((widthOfLevelInPixels/ 14) * i);
					platform.y = 175;
					View.GetInstance().AddEntity(platform);
					addChildAt(platform, 3);
				}
			}
			
			for(i = 0; i < 6; i++){
				if(((widthOfLevelInPixels/ 6) * i) < widthOfLevelInPixels-300 && (widthOfLevelInPixels/ 6) * i > 150){
					var obstacle:Sprite = new Rock();
					obstacle.x = ((widthOfLevelInPixels/ 6) * i);
					obstacle.y = 215;
					View.GetInstance().AddEntity(obstacle);
					addChildAt(obstacle, 3);
				}
			}
		}
		
		public function ScreenProgression():void{
			if(bottom.GetProgress() >= 25 && background2 == null){
				background2 = new Image(assetManager.getTexture("background"));
				background2.x = 480;
				background2.y = 0;
				View.GetInstance().AddEntity(background2);
				addChildAt(background2, 1);
			}
			if(bottom.GetProgress() >= 58 && background3 == null){
				background3 = new Image(assetManager.getTexture("background"));
				background3.x = 480;
				background3.y = 0;
				View.GetInstance().AddEntity(background3);
				addChildAt(background3, 1);
			}
			
			if(bottom.GetProgress() >= 94 && winImage == null){
				winImage = new Image(assetManager.getTexture("Level2FinalStage"));
				winImage.x = 480;
				winImage.y = 0;
				View.GetInstance().AddEntity(winImage);
				addChildAt(winImage, 1);
			}
			if(bottom.GetProgress() >= 100){
				timer.start();	
				View.GetInstance().setLockInformationScreen(true);
				View.GetInstance().GetPlayer().Stop();
				View.GetInstance().GetPlayer().setLevel(3, true);
			}
		}
		
		/**
		 * Changes the x coordinate of the entites so they all move, it uses the variable speed decide how many pixels to move.
		 * To change the speed of the level change the speed variable in the top.
		 */
		private function MoveEntities():void{
			if(bottom.GetProgress() < 100){
				for(var i:int = 0; i < View.GetInstance().GetEntities().length; i++){
					View.GetInstance().GetEntities()[i].x -= speed;
				}
			}
		}
		
		/**
		 * This function decides how much the virus pulses in this level.
		 * By changing the pulseSize integer in the top, the level of the pulse can be changed for this level.
		 */
		private function VirusPulse():void{
			for(var i:int = 0; i < View.GetInstance().GetEntities().length; i++){
				if(View.GetInstance().GetEntities()[i] is Virus){
					if(pulseTracker < pulseSize && pulseGoingUp){
						(View.GetInstance().GetEntities()[i] as Virus).Pulse(pulseTracker);
						pulseTracker++;
					}
					else if(pulseTracker == pulseSize && pulseGoingUp){
						(View.GetInstance().GetEntities()[i] as Virus).Pulse(pulseTracker);
						pulseGoingUp = false;
						pulseTracker--;
					}
					else if(pulseTracker > 0 && !pulseGoingUp){
						(View.GetInstance().GetEntities()[i] as Virus).Pulse(pulseTracker);
						pulseTracker--;
					}
					else if(pulseTracker == 0 && !pulseGoingUp){
						(View.GetInstance().GetEntities()[i] as Virus).Pulse(pulseTracker);
						pulseGoingUp = true;
						pulseTracker++;
					}
				}
			}
		}		
			
		/**
		 * Updates the screen.
		 */
		public function Update():void{
			if(loaded && top.Loaded() && bottom.Loaded()){
				speed = View.GetInstance().getSpeed();
				MoveEntities();
				RemoveOutOfStageEntities();
				top.Update();
				ScreenProgression();
				bottom.Update();
				VirusPulse();
			}
			if(View.GetInstance().GetPlayer().getSpawned()){
				Common.Physicus.GetInstance().Collision();
				Common.Physicus.GetInstance().Gravity();
			}
		}
		
		/**
		 * Deleting the Entites when it leaves the screen.
		 * If it is an Entity call Destroy().
		 */
		private function RemoveOutOfStageEntities():void{
			for(var i:int = 0; i < View.GetInstance().GetEntities().length; i++){
				if(View.GetInstance().GetEntities()[i].x < (0 - View.GetInstance().GetEntities()[i].width)){	
					removeChild(View.GetInstance().GetEntities()[i]);
					
					if(View.GetInstance().GetEntities()[i] is Entity){
						View.GetInstance().GetEntities()[i].Destroy();
						View.GetInstance().RemoveEntity(View.GetInstance().GetEntities()[i]);
					}
				}
			}
		}
		
		/**
		 * Continues to next screen.
		 */
		private function Continue(event:TimerEvent):void{
			View.GetInstance().GetPlayer().setHighscore(2, View.GetInstance().GetTime());
			View.GetInstance().setCurrentLevel(2);
			View.GetInstance().LoadScreen(Highscore);
		}

		/**
		 * Called when the screen is changed.
		 */
		public function Destroy():void{
			bottom.Destroy();
			top.Destroy();
			jumpLayer.Destroy();
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, Continue);
			removeEventListeners(null);
			assetManager.dispose();
			IO.GetInstance().Save();
		}
	}
}
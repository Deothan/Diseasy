package Levels{
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import Common.Entity;
	import Common.IO;
	import Common.Physicus;
	import Common.Screen;
	
	import Items.Coin;
	import Items.Heart;
	import Items.Medicine;
	import Items.Towel;
	import Items.Watch;
	
	import Main.View;
	
	import Platforms.Platform;
	
	import VirusScreen.VirusScreen;
	
	import Viruses.HIV;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class Level_1 extends Sprite implements Screen{
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
		
		//Changeable variables
		private var widthOfLevelInPixels:int = 6150;
		private var speed:int = View.GetInstance().getSpeed();
		private var enemySpawnTimeInSeconds:int = 8;
		private var platformSpawnTimeInSeconds:int = 12;
		private var itemSpawnTimeInSeconds:int = 16;
		private var masterSpawnTimeInSeconds:int = 13;
		
		public function Level_1(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Levels/assets/level1");
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
			View.GetInstance().getSoundControl().playStartGame();
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
			
			if(bottom.GetProgress() >= 92 && winImage == null){
				winImage = new Image(assetManager.getTexture("Level1FinalStage"));
				winImage.x = 480;
				winImage.y = 0;
				View.GetInstance().AddEntity(winImage);
				addChildAt(winImage, 1);
			}
			if(bottom.GetProgress() >= 100){
				timer.start();
				View.GetInstance().setLockInformationScreen(true);
				View.GetInstance().GetPlayer().Stop();
				View.GetInstance().GetPlayer().setLevel(2, true);
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
		
		private function SpawnAll(interval:int):void{
			if( (top.GetTime()/24)%interval == 0 && bottom.GetProgress() < 80){
				var hiv:Sprite = new HIV();
				var xLocation:int = Math.floor(Math.random()*50);
				hiv.x = 500+xLocation;
				hiv.y = 215;
				View.GetInstance().AddEntity(hiv);
				addChildAt(hiv, 3 );
				
				var platform:Platform = new Platform();
				xLocation = Math.floor(Math.random()*75);
				platform.x = 550+xLocation;
				platform.y = 175;
				View.GetInstance().AddEntity(platform);
				addChildAt(platform, 3);
				
				var nextPowerUpX:int = 630+xLocation;
				var nextPowerUpY:int = 100;
				var nextPowerUp:int = Math.floor(Math.random()*6);
				SpawnPowerUp(nextPowerUp, nextPowerUpX, nextPowerUpY);
				
				xLocation = Math.floor(Math.random()*25);
				nextPowerUpX = 600+xLocation;
				nextPowerUpY = 155;
				nextPowerUp = Math.floor(Math.random()*6);
				SpawnPowerUp(nextPowerUp, nextPowerUpX, nextPowerUpY);
				
				var hiv2:Sprite = new HIV();
				xLocation = Math.floor(Math.random()*50);
				hiv2.x = 725+xLocation;
				hiv2.y = 215;
				View.GetInstance().AddEntity(hiv2);
				addChildAt(hiv2, 3);
				
				xLocation = Math.floor(Math.random()*50);
				nextPowerUpX = 800+xLocation;
				nextPowerUpY = 215;
				nextPowerUp = Math.floor(Math.random()*6);
				SpawnPowerUp(nextPowerUp, nextPowerUpX, nextPowerUpY);
				
				var hiv3:Sprite = new HIV();
				xLocation = Math.floor(Math.random()*50);
				hiv3.x = 900+xLocation;
				hiv3.y = 215;
				View.GetInstance().AddEntity(hiv3);
				addChildAt(hiv3, 3);
				
				xLocation = Math.floor(Math.random()*50);
				nextPowerUpX = 1000+xLocation;
				nextPowerUpY = 215;
				nextPowerUp = Math.floor(Math.random()*6);
				SpawnPowerUp(nextPowerUp, nextPowerUpX, nextPowerUpY);
				
				
			}
		}
		
		private function SpawnPowerUp(type:int, xLocation:int, yLocation:int):void{
			switch (type){
				case 0:
					//do nothing
					break;
				
				case 1:
					var coin:Coin = new Coin();
					coin.x = xLocation;
					coin.y = yLocation;
					View.GetInstance().AddEntity(coin);
					addChildAt(coin, 3);
					break;
				
				case 2:
					var watch:Watch = new Watch();
					watch.x = xLocation;
					watch.y = yLocation;
					View.GetInstance().AddEntity(watch);
					addChildAt(watch, 3);	
					break;
				
				case 3:
					var heart:Heart = new Heart();
					heart.x = xLocation;
					heart.y = yLocation;
					View.GetInstance().AddEntity(heart);
					addChildAt(heart, 3);
					break;
				
				case 4:
					var medicine:Medicine = new Medicine();
					medicine.x = xLocation;
					medicine.y = yLocation;
					View.GetInstance().AddEntity(medicine);
					addChildAt(medicine, 3);					
					break;
				
				case 5:
					var towel:Towel = new Towel();
					towel.x = xLocation;
					towel.y = yLocation;
					View.GetInstance().AddEntity(towel);
					addChildAt(towel, 3);					
					break;
			}
		}
		
		/**
		 * Spawns enemies at a given interval, but not in the end zone.
		 * @param interval:int - interval in seconds between spawn.
		 */
		/*private function SpawnEnemies(interval:int):void{
			if( (top.GetTime()/24)%interval == 0 && bottom.GetProgress() < 70){
				var hiv:Sprite  = new HIV();
				hiv.x = 500;
				hiv.y = 215;
				View.GetInstance().AddEntity(hiv);
				addChildAt(hiv, 3);
			}
		}*/
		
		/**
		 * Spawns items at a given interval, but not in the end zone.
		 * @param interval:int - interval in seconds between spawn.
		 */
		/*
		private function SpawnItems(interval:int):void{
			if( (top.GetTime()/24)%interval == 0 && bottom.GetProgress() < 70){
				var coin:Coin = new Coin();
				coin.x = 550;
				coin.y = 215;
				View.GetInstance().AddEntity(coin);
				addChildAt(coin, 3);
				
				var watch:Watch = new Watch();
				watch.x = 630;
				watch.y = 100;
				View.GetInstance().AddEntity(watch);
				addChildAt(watch, 3);
				
				var heart:Heart = new Heart();
				heart.x = 730;
				heart.y = 215;
				View.GetInstance().AddEntity(heart);
				addChildAt(heart, 3);
				
				var medicine:Medicine = new Medicine();
				medicine.x = 815;
				medicine.y = 215;
				View.GetInstance().AddEntity(medicine);
				addChildAt(medicine, 3);
				
				var towel:Towel = new Towel();
				towel.x = 935;
				towel.y = 215;
				View.GetInstance().AddEntity(towel);
				addChildAt(towel, 3);
			}
		}*/
		
		/**
		 * Spawns platforms at a given interval, but not in the end zone.
		 * @param interval:int - interval in seconds between spawn.
		 */
		/*
		private function SpawnPlatforms(interval:int):void{
			if (((top.GetTime())/24)%interval == 0 && bottom.GetProgress() < 70){
				var platform:Platform = new Platform();
				platform.x = 550;
				platform.y = 175;
				View.GetInstance().AddEntity(platform);
				addChildAt(platform, 3);
			}
		}
		*/
		
		/**
		 * Updates the screen.
		 */
		public function Update():void{
			if(loaded && top.Loaded() && bottom.Loaded()){
				speed = View.GetInstance().getSpeed();
				MoveEntities();
				RemoveOutOfStageEntities();
				/*
				SpawnEnemies(enemySpawnTimeInSeconds);
				SpawnPlatforms(platformSpawnTimeInSeconds);
				SpawnItems(itemSpawnTimeInSeconds);
				*/
				SpawnAll(masterSpawnTimeInSeconds);
				top.Update();
				ScreenProgression();
				bottom.Update();
				
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
			View.GetInstance().LoadScreen(VirusScreen);
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
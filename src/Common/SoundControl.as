package Common{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import starling.utils.AssetManager;
	import Main.View;
	
	public class SoundControl
	{
		private var assetManager:AssetManager;
		private var Channel:SoundChannel = new SoundChannel;
		private var BackgroundChannel:SoundChannel = new SoundChannel;
		private var sound:Sound;
		private var Backgroundsound:Sound;
		private var playing:Boolean = false;
		
		public function SoundControl(){
			Initialize();
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Common/sounds");
			assetManager.enqueue(folder);
			assetManager.verbose = true;
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				trace("[AssetManager] MUSIC LOADED");
			}
		}

		public function playSad():void{
			sound = assetManager.getSound('sadtheme');
			Channel.stop();
			BackgroundChannel.stop();
			Channel = sound.play();
		}
		
		public function playClock():void{
			sound = assetManager.getSound('sound_ticking');
			Channel.stop();
			Channel = sound.play();
		}
		
		public function playButton():void{
			sound = assetManager.getSound('button');
			Channel.stop();
			Channel = sound.play();
		}
		
		public function playCoin():void{
			sound = assetManager.getSound('coin');
			Channel.stop();
			Channel = sound.play();
		}
		
		public function playcollide():void{
			sound = assetManager.getSound('collide');
			Channel.stop();
			Channel = sound.play();
		}
		
		public function playjump():void{
			sound = assetManager.getSound('jump');
			Channel.stop();
			Channel = sound.play();
		}
		
		public function playStartGame():void{
			sound = assetManager.getSound('startgame');
			Channel.stop();
			Channel = sound.play();			
		}
		
		public function playHiv():void{
			sound = assetManager.getSound('hiv');
			Channel.stop();
			Channel = sound.play();
		}
		
		public function playHiv_En():void{
			sound = assetManager.getSound('hiv_En');
			Channel.stop();
			Channel = sound.play();
		}
		
		public function playDiarrhea():void{
			sound = assetManager.getSound('diarrhea');
			Channel.stop();
			Channel = sound.play();
		}
		
		public function playDiarrhea_En():void{
			sound = assetManager.getSound('diarrhea_En');
			Channel.stop();
			Channel = sound.play();
		}
		
		public function playMalaria():void{
			sound = assetManager.getSound('malaria');
			Channel.stop();
			Channel = sound.play();
		}
		
		public function playMalaria_En():void{
			sound = assetManager.getSound('malaria_En');
			Channel.stop();
			Channel = sound.play();
		}
		
		public function playPnuemonia():void{
			sound = assetManager.getSound('pnuemonia');
			Channel.stop();
			Channel = sound.play();
		}
		
		public function playPnuemonia_En():void{
			sound = assetManager.getSound('pnuemonia_En');
			Channel.stop();
			Channel = sound.play();
		}
		
		public function playSepsis():void{
			sound = assetManager.getSound('sepsis');
			Channel.stop();
			Channel = sound.play();
		}
		
		public function playSepsis_En():void{
			sound = assetManager.getSound('sepsis_En');
			Channel.stop();
			Channel = sound.play();
		}
		
		public function playLevel():void{
			Backgroundsound = assetManager.getSound('levels');
			BackgroundChannel.stop();
			BackgroundChannel = Backgroundsound.play();
		}
		
		public function playInfant():void{
			Backgroundsound = assetManager.getSound('infantscreen');
			BackgroundChannel.stop();
			BackgroundChannel = Backgroundsound.play();
		}
		
		public function playDefault():void{
			if(Backgroundsound != null){
				if(Backgroundsound.length == assetManager.getSound('highscore').length) return;
			}
			Backgroundsound = assetManager.getSound('highscore');
			BackgroundChannel.stop();
			BackgroundChannel = Backgroundsound.play();
		}
		
		public function removeBackground():void{
			BackgroundChannel.stop();
		}
	}
}
package Common{
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import starling.utils.AssetManager;
	
	public class SoundControl
	{
		private var assetManager:AssetManager;
		private var Channel:SoundChannel =  new SoundChannel();
		private var sound:Sound;
		
		public function SoundControl(){
			Initialize();
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Common/assets");
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
			if (Channel != null) Channel.stop();
			sound = assetManager.getSound('sadtheme');
			Channel = sound.play();
		}
		
		public function playClock():void{
			if (Channel != null) Channel.stop();
			sound = assetManager.getSound('sound_ticking');
			Channel = sound.play();
		}
		
		public function playButton():void{
			assetManager.getSound('button').play();
		}
		
		public function playCoin():void{
			assetManager.getSound('coin').play();
		}
		
		public function playcollide():void{
			assetManager.getSound('collide').play();
		}
		
		public function playjump():void{
			Channel.stop()
			assetManager.getSound('jump').play();
		}
		
		public function playStartGame():void{
			if (Channel != null) Channel.stop();
			sound = assetManager.getSound('startgame');
			Channel = sound.play();
		}
		
		public function playHiv():void{
			assetManager.getSound('hiv').play();
		}
		
		public function playHiv_En():void{
			assetManager.getSound('hiv_En').play();
		}
		
		public function playDiarrhea():void{
			assetManager.getSound('diarrhea').play();
		}
		
		public function playDiarrhea_En():void{
			assetManager.getSound('diarrhea_En').play();
		}
		
		public function playMalaria():void{
			assetManager.getSound('malaria').play();
		}
		
		public function playMalaria_En():void{
			assetManager.getSound('malaria_En').play();
		}
		
		public function playPnuemonia():void{
			assetManager.getSound('pnuemonia').play();
		}
		
		public function playPnuemonia_En():void{
			assetManager.getSound('pnuemonia_En').play();
		}
		
		public function playSepsis():void{
			assetManager.getSound('sepsis').play();
		}
		
		public function playSepsis_En():void{
			assetManager.getSound('sepsis_En').play();
		}
	}
}
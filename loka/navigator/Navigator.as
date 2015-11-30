package utils.loka.navigator {
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author loka
	 */
	public class Navigator extends Sprite	{
		public static const PLAY:String = "PLAY";
		public static const PAUSE:String = "PAUSE";
		public static const VOLUME:String = "VOLUME";
		public static const VOLUME_STOPED:String = "VOLUME_STOPED";
		public static const PLAY_PREV:String = "PLAY_PREV";
		public static const PLAY_NEXT:String = "PLAY_NEXT";
		private var _play:Play;// = new Play();
		private var _vol:Volume;// = new Play();
		private var _volStoped:Volstoped;// = new Play();
		private var _arrowLeft:Arrows;// = new Play();
		private var _arrowRight:Arrows;// = new Play();
		private var _volume:Number = 1;//volume count
		private var _volumeStatus:Boolean= true;//volume status
		public function Navigator() {
			
		}
		public function createNavigator(plays:Boolean = false, next:Boolean = false, prev:Boolean = false, volume:Boolean = false ):void {
			if(plays){
				this._play = new Play();
				this._play.addEventListener(Play.PLAY, play);
				this._play.addEventListener(Play.PAUSE, pause);
				this.addChild(this._play);
			}
			if(next){
				this._arrowLeft = new Arrows("Image/vol/arrows2.png",Arrows.PREV);
				this._arrowLeft.x = this._play.x + this._play.width + 20;
				this._arrowLeft.y = this._play.y;
				//this._arrowLeft.height = this._play.height;
				this._arrowLeft.addEventListener(Arrows.PREV, playPrev);
				this.addChild(this._arrowLeft);
			}
			if(prev){
				this._arrowRight = new Arrows("Image/vol/arrows1.png",Arrows.NEXT);
				this._arrowRight.x = this._arrowLeft.x + this._arrowLeft.width + 30;
				this._arrowRight.y = this._play.y;
				//this._arrowRight.height = this._play.height;
				this._arrowRight.addEventListener(Arrows.NEXT, playNext);
				this.addChild(this._arrowRight);
			}
			if(volume){
				this._volStoped = new Volstoped("Image/vol/vol.png","Image/vol/volStopped.png");
				//this._volStoped.create();
				//this._volStoped.x = this._arrowRight.x + this._arrowRight.width+35;
				this._volStoped.x = this.width + 35;
				this._volStoped.addEventListener(Volstoped.VOLUME_STATUS, destroyVolume);
				//this._vol.addEventListener(Play.PAUSE, pause);
				this.addChild(this._volStoped);
			
				this._vol = new Volume();
				this._vol.create();
				this._vol.x = this._volStoped.x + this._volStoped.width + 10;
			
				this._vol.addEventListener(Volume.REVOLUME, revolume);
				this._vol.y = -5;//Math.abs(this._vol.height - this._play.height);
				this.addChild(this._vol);
			}
			//this._volStoped.y = Math.abs(this._vol.height - this._volStoped.height);
			//this._vol.addEventListener(Play.PAUSE, pause);
			//this._vol.width = 40;
			//this._vol.height = this._play.height+this._play.height/4;
			
		}
		private function playNext(e:Event):void {
			this.dispatchEvent(new Event(Navigator.PLAY_NEXT));
		}
		private function playPrev(e:Event):void {
			this.dispatchEvent(new Event(Navigator.PLAY_PREV));
		}
		private function play(e:Event):void {
			this.dispatchEvent(new Event(Navigator.PLAY));
		}
		private function pause(e:Event):void {
			this.dispatchEvent(new Event(Navigator.PAUSE));
		}
		private function revolume(e:Event):void {
			this._volume = this._vol.volumes;
			this.dispatchEvent(new Event(Navigator.VOLUME));
			
		}
		private function destroyVolume(e:Event):void {
			this._volumeStatus = this._volStoped.status;
			if (!this._volumeStatus) {
				this._vol.alpha = 0.5;
				this._vol.removeEventListener(Volume.REVOLUME, revolume);
				this._vol.useHandCursor = false;
				this._volume = 0;
				//this._vol
				//var mc:MovieClip = new MovieClip();
				//mc.so
			}else {
				this._vol.alpha = 1;
				this._vol.addEventListener(Volume.REVOLUME, revolume);
				this._vol.useHandCursor = true;
				this._volume = this._vol.volumes;
			}
			this.dispatchEvent(new Event(Navigator.VOLUME_STOPED));
		}
		
		public function get volumeStatus():Boolean {
			return this._volumeStatus;
		}
		public function get volume():Number {
			return this._volume;
		}
		public function set volume(val:Number):void {
			this._vol.volumes=val;
		}
		public function get volElement():Volume {
			return this._vol;
		}
		public function get volStopElement():Volstoped {
			return this._volStoped;
		}
		public function set plays(val:Boolean):void {
			this._play.status=val;
		}
		public function get plays():Boolean {
			return this._play.status;
		}
		public function set volumeStatus(val:Boolean):void {
			this._volumeStatus = val;
			this._volStoped.status = val;
			if (!this._volumeStatus) {
				
				this._vol.alpha = 0.5;
				this._vol.removeEventListener(Volume.REVOLUME, revolume);
				this._vol.useHandCursor = false;
				this._volume = 0;
			}else {
				
				this._vol.alpha = 1;
				this._vol.addEventListener(Volume.REVOLUME, revolume);
				this._vol.useHandCursor = true;
				this._volume = this._vol.volumes;
			}
			//this.dispatchEvent(new Event(Navigator.VOLUME_STOPED));
		}
		
	}

}
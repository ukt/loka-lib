package utils.loka.dataBase.mp3Player {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import utils.loka.button.btnEffect.BtnEffect;
	import utils.loka.dataBase.Data;
	
	/**
	 * ...
	 * @author loka
	 */
	public class Player extends Data{
		private var _url:String = "";
		private var _sound:Sound;
		private var _song:SoundChannel;
		private var _request:URLRequest;
		private var _statusPlay:Boolean;
		private var _pos:Number = 0;
		private var _btnPlay:Play = new Play(true);
		private var _ready:Boolean = false;
		public function Player() {
			this.init();
			//this._prefix = this.getDataByName("Prefix").data;
		}
		public function create():void {
			if (this._url != "") {
				this.buffer(); 
				this._ready = true;
			}else {
				trace("* Please set url *");
				this._ready = false;
			}
		}
		private function eventPlay(e:Event):void {
			this.play();
		}
		private function eventPause(e:Event):void {
			this.pause(); //this.
		}
		
		public function pause():void {
			this._pos = this._song.position;
			this._song.stop();
			this._statusPlay = false;
			//this._btnPlay.status = false;
		}
		public function stop():void {
			this._song.stop();
			this._statusPlay = false;
			//this._btnPlay.status = false;
			this._pos = 0;
		}
		public function play():void {
			this._song.stop();
			this._song = this._sound.play(this._pos);
			this._statusPlay = true;
			//this._btnPlay.status = true;
		}
		private function buffer():void {
			this._btnPlay.create();
			//this._btnPlay.status = false;
			this.addChild(this._btnPlay);
			this._btnPlay.addEventListener(Play.PAUSE, this.eventPlay);
			this._btnPlay.addEventListener(Play.PLAY, this.eventPause);
			new BtnEffect(this._btnPlay);
			
			//this._url = this.getDataByName("Song").data;
			this._request = new URLRequest(this._url);
			this._sound = new Sound();
			this._sound.load(this._request);
			this._song = this._sound.play();
			this.stop();
			this._song.addEventListener(Event.SOUND_COMPLETE, completeHandler);
		}
		private function completeHandler(e:Event):void {
			
		}
		public function set btnPlay(value:DisplayObject):void{ this._btnPlay.btnPlay=value;}
		public function set btnPause(value:DisplayObject):void{ this._btnPlay.btnPause=value;}
		public function set url(value:String):void{ this._url=value;}
		//public function set url(value:String):void{ this._url=value;}
		public function get ready():Boolean{ return this._ready;}
		public function get totalTime():Number{ return this._sound.length;}
		public function get position():Number{ return this._song.position;}
		public function set position(value:Number):void { this._pos = value; this.play(); }
		public function get statusPlay():Boolean{ return this._statusPlay;}
		public function set statusPlay(val:Boolean):void { 
			this._statusPlay = val;
			if (this._statusPlay) {
				this.play();
			}else {
				this.stop();
				//this.play(this._pos);
			}
		}
	}

}
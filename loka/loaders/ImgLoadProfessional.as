package loka.loaders {
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.LoaderContext;
	/**
	 * ...
	 * @author loka
	 */
	public class ImgLoadProfessional extends Sprite {
		private var i:uint = 0;
		private var _arr_img:Array = new Array;
		private var _url:String = "";
		private var _properties:Array = new Array();
		private var _loader:Loader;// = new Loader();
		private var _previosLoadSize:Number = 0;;// = new Loader();
		
		private var _statusOpen:Boolean = false;
		private var _DO:DisplayObjectContainer;
		//public static const LOAD_IMG_COMPLETED:String = "LOAD_IMG_COMPLETED";
		public function ImgLoadProfessional(Link:String,DO:DisplayObjectContainer = null){
			this._url = Link
			if (DO!=null) this._DO = DO;
		}
		public function LoadImg(local:Boolean = true):void {
			var context:LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;
			try{
				this._loader = new Loader();
				var kesh:String;
				if (!local) {
					kesh = "?d=" + Math.random() * 1000;
				}else {
					kesh = "";
				}
				this._loader.contentLoaderInfo.addEventListener(Event.INIT, comlete);
				this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, openLoad);
				this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
				this._loader.load(new URLRequest(this._url+kesh),new LoaderContext(true));
				
			}catch (e:Error) {
				trace("Don't load img :(");
				
			}
		}
		private function openLoad(e:Event):void {
			if (this.totalSize != 0 && !this._statusOpen) {
				this._statusOpen = true;
				e.currentTarget.removeEventListener(ProgressEvent.PROGRESS, progress);
				this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
				
				this._loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
				dispatchEvent(new Event(LoaderConstans.OPEN_LOAD, true));
			}
		}
		private function progress(e:Event):void {
			dispatchEvent(new Event(LoaderConstans.PROGRESS, true));
			
		}
		private function comlete(e:Event):void {
			this._arr_img["img"] = e.target.content;
			e.currentTarget.removeEventListener(Event.INIT, comlete);
			e.currentTarget.removeEventListener(ProgressEvent.PROGRESS, progress);
			
			if (_DO) this._DO.addChild(e.target.content);
			dispatchEvent(new Event(LoaderConstans.LOAD_IMG_COMPLETED, true));
			
		}
		private function httpStatusHandler(e:HTTPStatusEvent):void {
			//trace("httpStatusHandler");
		}
		private function ioError(e:IOErrorEvent):void {
			trace("IO ERROR");
			dispatchEvent(new Event(LoaderConstans.IO_ERROR, true));
		}
		public function setProperties(name:String, data:Object):void {
			this._properties[name] = data;
		}
		public function getProperties(name:String):Object {
			return this._properties[name];
		}
		public function get img():Object {
			return this._arr_img["img"];
		}
		public function get totalSize():uint {
			return this._loader.contentLoaderInfo.bytesTotal;
		}
		public function get peviosLoadSize():Number {
			var tmp:Number = this._previosLoadSize;
			this._previosLoadSize = this.loadSize;
			return tmp;
		}
		public function get loadSize():uint {
			return this._loader.contentLoaderInfo.bytesLoaded;
		}
	}

}
package loka.loaders.loaderList {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	
	import loka.console.Console;
	import loka.loaders.LoaderConstans;
	
	/**
	 * ...
	 * @author loka
	 */
	public class LoaderData extends EventDispatcher {
		private var _url:String;
		private var _data:Object;
		private var _properties:Dictionary = new Dictionary();
		private var _loader:Loader;
		private var _urlLoader:URLLoader;
		private var _local:Boolean;
		private var _urlLoaderStatus:Boolean;
		private var _isStartLoad:Boolean = false;
//		private var _isLoad:Boolean = false;
		private var _isLoadComlete:Boolean = false;
		
		public function LoaderData(url:String) {
			this._url = url;
		}
		public function Load(urlLoader:Boolean, local:Boolean = true, method:String = URLRequestMethod.GET):void 
		{
			this._local = local;
			this._urlLoaderStatus = urlLoader;
			_urlRequest = new URLRequest(_url + kesh);
			_urlRequest.method = method;
			_urlRequest.contentType 
			if (this._urlLoaderStatus) 
			{
				this.urlLoaderLoad();
			}
			else 
			{
				this.loaderLoad();
			}
			
			_isStartLoad = true;
		}
		
		private var _urlRequest:URLRequest;
		
		private function urlLoaderLoad():void 
		{
			try 
			{
				this._urlLoader = new URLLoader();
				
				_urlLoader.addEventListener(Event.COMPLETE, comlete);
				_urlLoader.load(_urlRequest);
			}
			catch (e:Error) 
			{
				trace("Don't load TXT :("+e.message);
			}
		}
		private function loaderLoad():void {
			var context:LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;
//			context.applicationDomain = ApplicationDomain.currentDomain;
			try{
				_loader = new Loader();
				//_loader.contentLoaderInfo.addEventListener(Event.INIT, comlete);
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, comlete);
				_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
//				_loader.contentLoaderInfo.addEventListener(Event., progress);
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
				_loader.load(new URLRequest(this._url + kesh), context);
				
				Console.write("LOAD: ", Console.GREEN, false);
				Console.write(_url, Console.YELLOW);
			}catch (e:Error) {
				trace("Don't load img :(");
			}
		}
		private function get kesh():String {
			if (!this._local) {
				var arr:Array = this._url.split("?");
				if (arr.length > 0) {
					return "?d=" + Math.random() * 1000;
				}else {
					return "&d=" + Math.random() * 1000;
				}
			}
			return  "";
			
		}
		private function progress(e:Event):void {
			dispatchEvent(new Event(LoaderConstans.PROGRESS, true));
//            if(_loader)
//            Console.write(this._url + kesh + "PROGRESS:     " + (_loader.contentLoaderInfo.bytesTotal / _loader.contentLoaderInfo.bytesLoaded));
		}
		private function comlete(e:Event):void {
			if (this._urlLoaderStatus) {
				this.urlLoaderComplete();
			}else {
				this.loaderComplete();
			}
			
		}
		private function loaderComplete():void {
			if(!_isLoadComlete){
				_loader.contentLoaderInfo.removeEventListener(Event.INIT, comlete);
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, comlete);
				_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
				try{
					this._data = this._loader.contentLoaderInfo.content;
				}catch (e:Error){
					this._data = this._loader;
				}
				this.dispatchEvent(new Event(LoaderConstans.LOAD_DATA_COMPLETED, false));
				_isLoadComlete = true;
			}
		}
		private function urlLoaderComplete():void {
			if(!_isLoadComlete){
				_urlLoader.removeEventListener(Event.COMPLETE, comlete);
				this._data = this._urlLoader.data;
				this.dispatchEvent(new Event(LoaderConstans.LOAD_DATA_COMPLETED, false));
				_isLoadComlete = true;
			}
		}
		
		public function get bytesLoaded():Number
		{
			return _loader.contentLoaderInfo.bytesLoaded;
		}
		
		public function get bytesTotal():Number
		{
			return _loader.contentLoaderInfo.bytesTotal;
			
		}
		
		public function setProperties(name:String, data:Object):void { 
			this._properties[name] = data;
		}
		
		public function getProperties(name:String):Object {
			return this._properties[name];
		}
		
		public function get data():Object {
			return this._data;
		}
		
		public function get isLoadComlete():Boolean
		{
			return this._isLoadComlete;
		}
		public function get isStartLoad():Boolean 
		{
			return this._isStartLoad;
		}
		private function ioError(e:IOErrorEvent):void {
			Console.write("IO ERROR", Console.RED);
			Console.write(e.text, Console.RED);
			Console.write("SRC not found: "  , Console.RED, false);
			Console.write(this._url, Console.GREEN);
			Console.write("  "  , Console.RED);
			dispatchEvent(new Event(LoaderConstans.IO_ERROR, true));
		}
	}

}
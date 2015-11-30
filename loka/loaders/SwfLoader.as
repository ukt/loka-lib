package loka.loaders {
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	/**
	 * ...
	 * @author loka
	 */
	public class SwfLoader extends Sprite{
		
		private var _url:String = "";
		private var _properties:Array = new Array();
		
		public function SwfLoader(link:String) {
			this._url = link
		}
		
		public function Load(local:Boolean=true):void {
			try{
				var loader:Loader = new Loader();
				var kesh:String;
				if (!local) {
					kesh="?d="+Math.random()*1000
				}else {
					kesh = "";
				}
				loader.load(new URLRequest(this._url+kesh));
				loader.contentLoaderInfo.addEventListener(Event.INIT, comlete);
			}catch (e:Error) {
				trace("Don't load swf :("+e.message);
				
			}
		}
		
		private function comlete(e:Event):void {
			//this.arr = this.unite_complete(e.target);
			this.setProperties(LoaderConstans.SWF, e.target.content);
			this.dispatchEvent(new Event(LoaderConstans.LOAD_SWF_COMPLETED, true));
			
		}
		
		public function setProperties(name:String, data:*):void {
			this._properties[name] = data;
		}
		
		public function getProperties(name:String):* {
			return this._properties[name];
		}
		
		public function get swf():* {
			return this.getProperties(LoaderConstans.SWF);
		}
	}

}
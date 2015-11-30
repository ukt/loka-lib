package loka.loaders {
	import flash.display.*;
	import flash.events.Event;
	import flash.net.*;
	
	import loka.console.Console;
	/**
	 * ...
	 * @author loka
	 */
	public class TxtLoader extends Sprite{
		private var _arr:Array = new Array;
		private var _url:String = "";
		private var _properties:Array = new Array();
		public function TxtLoader(link:String) {
			this._url = link;
		}
		public function Load(local:Boolean = true):void {
			Console.instance.write("TxtLoader.Load: "+local);
			try {
				Console.instance.write("TxtLoader.Load.try: "+local);
				var loader:URLLoader = new URLLoader();
				var kesh:String;
				
				if (!local) {
					var arr:Array = this._url.split("?");
					if (arr.length == 2) {
						kesh = "&d=" + Math.random() * 1000
					}else{
						kesh = "?d=" + Math.random() * 1000
					}
					//trace("length="+arr.length);
				}else {
					kesh = "";
				}
				loader.load(new URLRequest(this._url+kesh));
				loader.addEventListener(Event.COMPLETE, comlete);
			}catch (e:Error) {
				Console.instance.write(("Don't load TXT :("+e.message));
				trace("Don't load TXT :("+e.message);
				
			}
		}
		private function comlete(e:Event):void {
			Console.instance.write("TxtLoader.comlete: ");
			//this.arr = this.unite_complete(e.target);
			this.setProperties(LoaderConstans.TXT, e.target.data);
			this.dispatchEvent(new Event(LoaderConstans.LOAD_TXT_COMPLETED, true));
			
		}
		public function setProperties(name:String, data:Object):void {
			this._properties[name] = data;
		}
		public function getProperties(name:String):Object {
			return this._properties[name];
		}
		public function get txt():Object{
			return this.getProperties(LoaderConstans.TXT);
		}
	}

}
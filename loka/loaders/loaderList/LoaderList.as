package utils.loka.loaders.loaderList {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequestMethod;
	import flash.utils.Dictionary;
	
	import utils.loka.loaders.LoaderConstans;
	
	/**
	 * ...
	 * @author loka
	 * this class has been loaded any files from one operations
	 * before load we must add any files and here proportions to load and start progress
	 * after we has event Complete Command: LoaderConstans.LOAD_DATA_ITTER_COMPLETED = "LOAD_DATA_ITTER_COMPLETED"
	 * to get data need call: getAssetsByName("[name]") as LoaderData
	 */
	public class LoaderList extends EventDispatcher {
		private var _dict:Dictionary;
		private var _count:uint = 0;
		private var _countLoad:uint = 0;
		public function LoaderList() {
			this._dict = new Dictionary();
		}
		
		public function addAssets(name:String, url:String, urlLoader:Boolean, obj:Object = null):void {
			var loader:LoaderData = new LoaderData(url);
			if(obj!=null){
				for (var c:String in obj) {
					loader.setProperties(c, obj[c]);
				}
			}
			loader.setProperties("urlLoader", urlLoader);
			loader.setProperties("name", name);
			this._dict[name] = loader;
			this._count++;
		}
		
		public var name:String; 
		public function load(isLocal:Boolean, name:String = "", method:String = URLRequestMethod.GET):void {
			for each(var item:LoaderData in this._dict) {
				if(!item.isStartLoad)
				{
					item.addEventListener(LoaderConstans.LOAD_DATA_COMPLETED, endLoad);
					item.addEventListener(LoaderConstans.PROGRESS, progressLoad);
					item.Load(item.getProperties("urlLoader"), isLocal, method);
					item.setProperties("name", name);
				}
			}
			this.name = name;
		}
		
		protected function progressLoad(event:Event):void
		{
			// TODO Auto-generated method stub
//			trace("he he");
			this.dispatchEvent(new EventLoader(LoaderConstans.PROGRESS, this, false, false));
		}
		
		private function endLoad(e:Event):void {
			this._countLoad++;
			this.dispatchEvent(new EventLoader(LoaderConstans.LOAD_DATA_ITTER_COMPLETED, this, false, false));
			if (this._count - this._countLoad  <= 0) {
				for each(var item:LoaderData in this._dict) {
					item.removeEventListener(LoaderConstans.LOAD_DATA_COMPLETED, endLoad);
				}
				this.dispatchEvent(new EventLoader(LoaderConstans.LOAD_DATA_COMPLETED, this, false, false));
			}
		}
		
		public function getAssetsByName(name:String):LoaderData {
			return this._dict[name] as LoaderData;
		}
		
		public function getAllAssets():Object {
			return this._dict;
		}
		
		public function get bytesLoaded():Number
		{
			var result:Number = 0;
			for each(var loaderData:LoaderData in _dict)
			{
				result += loaderData.bytesLoaded;
			}
			
			return result; 
		}
		
		public function get bytesTotal():Number
		{
			var result:Number = 0;
			for each(var loaderData:LoaderData in _dict)
			{
				result += loaderData.bytesTotal;
			}
			
			return result;
		}
		/**
		 *	Return loading percent for nameGroup   
		 * 	@return Number [0...1]
		 * 
		 */
		public function get percent():Number
		{
			var percent:Number = 0;
			var max:Number = 0;
			var count:int = 1;
			for each(var loaderData:LoaderData in _dict)
			{
				max++;
				if(loaderData.isLoadComlete)
				{
					count++;
				}
			}
			percent = (1 / max) * count;
			return percent;
		}
		
	}

}
package utils.loka.loaders {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequestMethod;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import utils.loka.bitmap.BitmapEdit;
	import utils.loka.loaders.loaderList.EventLoader;
	import utils.loka.loaders.loaderList.LoaderList;
	
	public class GlobaLoaderData extends EventDispatcher {
		
		private static const PROGRESS:String = "PROGRESS";
		private static const ITTER:String = "ITTER";
		private static const COMPLETE:String = "COMPLETE";
		private static const JS_FUNC:String = "JS_FUNC";
		
		private var loaderDataDict:Dictionary = new Dictionary();
		
		public function GlobaLoaderData(key:Blocker) {
			super();
		}
		
		public function init():void {
			instance;
		}
		
		private static function dispatchProgressCompleteEvent(e:EventLoader):void {
			var GD:GlobaLoaderData = instance;
			var nameGroup:String = (e.currentTarget as LoaderList).name;
			
			var event:Event = new Event(GET_PROGRESS_EVENT(nameGroup));
			GD.dispatchEvent(event);
		}
		
		private static function dispatchItterCompleteEvent(e:EventLoader):void {
			var GD:GlobaLoaderData = instance;
			var nameGroup:String = (e.currentTarget as LoaderList).name;
			
			var event:Event = new Event(GET_ITTER_EVENT(nameGroup));
			GD.dispatchEvent(event);
		}
		
		private static function getLoader(nameGroup:String):LoaderList
		{
			var GD:GlobaLoaderData = instance;
			var loader:LoaderList;
			if(GD.loaderDataDict.hasOwnProperty(nameGroup)){
				loader = (GD.loaderDataDict[nameGroup] as LoaderList);
			}else {
				
			}
			
			return loader;
		}
		/**
		 * 
		 * @param e
		 * dispatchEvent GlobalLoaderData.COMPLETE + (e.currentTarget as LoaderList).name
		 * need listenner GlobalLoaderData.COMPLETE + name;
		 */
		private static function dispatchCompleteEvent(e:EventLoader):void 
		{
			
			var GD:GlobaLoaderData = instance;
			var nameGroup:String = (e.currentTarget as LoaderList).name;
			var loader:LoaderList;
			if(GD.loaderDataDict.hasOwnProperty(nameGroup)){
				loader = (GD.loaderDataDict[nameGroup] as LoaderList);
			}else {
				
			}

			var event:Event = new Event(GET_COMPLETE_EVENT(nameGroup));
//			event.da
			GD.dispatchEvent(event);
			var data:Dictionary = getListDataByNameGroup(nameGroup);
            var func:Function;
            var list:Array = getListCallBackFunctionByNameGroup(nameGroup);
			for each(func in list)
			{
				if(func != null)
				{
					if(func.length > 0)
					{
						func(data);
						func = null;
					}
					else
					{
						func();
						func = null;
					}
				}
			}
				
			for each(func in list)
			{
				(GD.loaderDataDict[nameGroup + JS_FUNC] as Vector.<Function>).splice((GD.loaderDataDict[nameGroup + JS_FUNC] as Vector.<Function>).indexOf(func), 1);
			}
		}
		
        /**
         * 
         * @param nameGroup
         * @return js func list 
         * 
         */
		private static function getListCallBackFunctionByNameGroup(nameGroup:String):Array
        {
            var GD:GlobaLoaderData = instance;
            var arrResult:Array = new Array();
//            var list:Object = (GD.loaderDataDict[nameGroup + JS_FUNC] as Function);
            
            for each(var func:Function in GD.loaderDataDict[nameGroup + JS_FUNC] as Vector.<Function>)
            {
                arrResult.push(func);
            }
            
            return arrResult;
        }
        
		private static function getListDataByNameGroup(nameGroup:String):Dictionary{
			var GD:GlobaLoaderData = instance;
			var arrResult:Dictionary = new Dictionary();
			var list:Object = (GD.loaderDataDict[nameGroup] as LoaderList).getAllAssets(); 
			for(var c:String in list){
				arrResult[c] = (list[c]);
			}
			return arrResult;
		}
		/**
		 * 
		 * @param nameGroupLoad - 
		 * @param nameAssets
		 * @param url
		 * @param urlLoader
		 * @param obj
		 * @return 
		 *  
		 */
		public static function addAsset(nameGroup:String, nameAssets:String,  url:String, urlLoader:Boolean = false, obj:Object = null):void{
			var GD:GlobaLoaderData = instance;
			var loader:LoaderList;
			if (GD.loaderDataDict.hasOwnProperty(nameGroup)) {
				loader = (GD.loaderDataDict[nameGroup] as LoaderList);
			} else {
				loader = new LoaderList();
				GD.loaderDataDict[nameGroup] = loader;
				
			}
			loader.addAssets(nameAssets, url, urlLoader, obj);
		}
		
		
		/**
		 * 
		 * @param nameAsset
		 * @param type
		 * @return 
		 * 
		 */
		public static function getDefinition(nameAsset:String, type:Class): Class
		{
			if(type === Sprite || type === MovieClip ){
				return ApplicationDomain.currentDomain.getDefinition(nameAsset) as Class;
			}
			return null;
		}
		
		/**
		 * 
		 * @param nameGroup
		 * @param nameAsset
		 * @return DisplayObject or any data) 
		 * 
		 */
		public static function getAsset(nameGroup:String, nameAsset:String, classDefinition:String = ""):Object
		{
			var GD:GlobaLoaderData = instance;
			if(GD.loaderDataDict[nameGroup]){
				return getResource((GD.loaderDataDict[nameGroup] as LoaderList).getAssetsByName(nameAsset).data, classDefinition);
			} else { 
				throw new Error("fail: assetGroup not isset [" + nameAsset + "]");
			}
//			return _instance._loader.getAssetsByName(name).data;
		}
		
        private static function getResource(data:Object, classDefinition:String = ""):Object{
            var result:Object;
            if(data is MovieClip && classDefinition != "")
            {
				result = new ((data as MovieClip).loaderInfo.applicationDomain.getDefinition(classDefinition) as Class)();
            } 
            else if(data is Bitmap)
            {
				result = BitmapEdit.drawImg(data as DisplayObject);
            }
			else if(classDefinition != "")
			{
				try
				{
//					result = new ((data as MovieClip).loaderInfo.applicationDomain.getDefinition(classDefinition) as Class)();
					result = new ((data)[classDefinition] as Class)();
				}catch (e:Error) 
				{
					
				}
			}
			else
			{
				result = data;
			}
            
            return result;
        }
		
		/**
		 * 
		 * @param nameGroup
		 * @return Number [0...1]
		 * 
		 */
		public static function getBytesPercent(nameGroup:String):Number
		{
			var GD:GlobaLoaderData = instance;
			var loader:LoaderList = getLoader(nameGroup);
			return (1 / loader.bytesTotal) * loader.bytesLoaded;
		}
		
		/**
		 *	Return loading ITTER percent for nameGroup   
		 * @param nameGroup
		 * @return Number [0...1]
		 * 
		 */
		public static function getPercent(nameGroup:String):Number
		{
			var GD:GlobaLoaderData = instance;
			var loader:LoaderList = getLoader(nameGroup);
			return loader.percent;
		}
        /**
         * 
         * @param nameGroup
         * @param calbackFunctiom
         * 
         */
		public static function load(nameGroup:String, calbackFunction:Function, kesh:Boolean = false, method:String = URLRequestMethod.GET):void{
			var GD:GlobaLoaderData = instance;
			var loader:LoaderList;
			if(GD.loaderDataDict.hasOwnProperty(nameGroup)){
				loader = (GD.loaderDataDict[nameGroup] as LoaderList);
			}else{
				calbackFunction();
				return;
//				throw new Error("fail: nameGroup not isset [" + nameGroup + "]");
			}
			if (loader.hasEventListener(LoaderConstans.LOAD_DATA_COMPLETED)) {
				loader.removeEventListener(LoaderConstans.LOAD_DATA_COMPLETED, dispatchCompleteEvent)
			}
			if(!GD.loaderDataDict.hasOwnProperty(nameGroup + JS_FUNC))
			{
				GD.loaderDataDict[nameGroup + JS_FUNC] = new Vector.<Function>();
			}
			(GD.loaderDataDict[nameGroup + JS_FUNC] as Vector.<Function>).push(calbackFunction);
			loader.addEventListener(LoaderConstans.LOAD_DATA_COMPLETED, dispatchCompleteEvent);	
			loader.addEventListener(LoaderConstans.LOAD_DATA_ITTER_COMPLETED, dispatchItterCompleteEvent);	
			loader.addEventListener(LoaderConstans.PROGRESS, dispatchProgressCompleteEvent);	
			loader.load(!kesh, nameGroup, method);
			loader.name = nameGroup;
		}
		
		public static function GET_PROGRESS_EVENT(nameGroup:String):String
		{
			return PROGRESS + nameGroup;
		}
		
		public static function GET_ITTER_EVENT(nameGroup:String):String
		{
			return ITTER + nameGroup;
		}
		
		public static function GET_COMPLETE_EVENT(nameGroup:String):String
		{
			return COMPLETE + nameGroup;
		}
		
		
		
		
		
		
		//		private static var _instanceKey:String = Date.UTC();s
		private static var _instance:GlobaLoaderData;
		public static function get instance():GlobaLoaderData{
			if(_instance == null){
				_instance = new GlobaLoaderData(new Blocker())
			}
			return _instance;
		}
	}
	
}
internal final class Blocker
{
	public function Blocker():void
	{
	}
}
package loka.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import loka.bitmap.RectVO;
	import loka.loaders.GlobaLoaderData;
	
	public class ImgBoxAutoLoad extends Sprite
	{
		private static var NAME:String = "ImgBoxAutoLoad";
		private static var itter:uint = 0;
		private var uid:uint = 0;

		private var _rect:RectVO;
		
		public function ImgBoxAutoLoad(url:String, autoload:Boolean = true)
		{
			super();
			uid = itter++;
			GlobaLoaderData.addAsset(NAME + uid, uid.toString(), url);
			if(autoload)
			{
				load();
			}
		}
		
		public function load():void
		{
			GlobaLoaderData.load(NAME + uid, onLoaded);
		}
		
		private function onLoaded(data:*):void
		{
			var child:DisplayObject = GlobaLoaderData.getAsset(NAME + uid, uid.toString()) as DisplayObject 
			addChild(child);
			if(_rect)
			{
				child.width = _rect.width;
				child.height = _rect.height;
				child.x = _rect.x;
				child.y = _rect.y;
			}
		}
		
		public function setSizeAfterLoad(rect:RectVO):void
		{
			_rect = rect;
		}
	}
}
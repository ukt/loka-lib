package loka.loaders {
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.LoaderContext;
	/**
	 * ...
	 * @author loka
	 */
	public class ImgLoaderTrue extends Sprite {
		private var i:uint = 0;
		private var _arr_img:Array = new Array;
		private var _url:String = "";
		private var _properties:Array = new Array();
		//public static const LOAD_IMG_COMPLETED:String = "LOAD_IMG_COMPLETED";
		public function ImgLoaderTrue(Link:String){
			this._url = Link
		}
		public function LoadImg(local:Boolean = true):void {
			var context:LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;
			//context.
			try{
				var loader:Loader = new Loader();
				var kesh:String;
				if (!local) {
					kesh = "?d=" + Math.random() * 1000;
				}else {
					kesh = "";
				}
				loader.contentLoaderInfo.addEventListener(Event.INIT, comlete);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
				loader.load(new URLRequest(this._url+kesh),new LoaderContext(true));
				
			}catch (e:Error) {
				trace("Don't load img :(");
				
			}
		}
		private function progress(e:Event):void {
			dispatchEvent(new Event(LoaderConstans.PROGRESS, true));
		}
		private function comlete(e:Event):void {
			//var bitmap:BitmapData; 
			//var loader_img:Bitmap = Bitmap(e.target.content);
			//bitmap = new BitmapData(loader_img.width, loader_img.height, true , 0X00000000);
			//bitmap.lock();
			//var matr:Matrix = new Matrix();
			//matr.translate(0,0);
			//bitmap.draw(loader_img, matr);
			//var image:Bitmap = new  Bitmap(bitmap);
			//this._arr_img["img"] = image;
			//trace("ImageLoaderComplite");
			this._arr_img["img"] = e.target.content;
			dispatchEvent(new Event(LoaderConstans.LOAD_IMG_COMPLETED, true));
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
	}

}
package  utils.loka.loaders{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix;
	import flash.net.*;
	public class ImgLoaderBox extends Sprite{
		private var arr_img:Array = new Array;
		private var i:uint = 0;
		private var _url:String = "";
		public static const LOAD_IMG_COMPLETED:String = "LOAD_IMG_COMPLETED";
		public const N:uint = 1;
		
		public function ImgLoaderBox(img:String, autoload:Boolean = true) {
			this._url = img
			autoload ? load() : null;
		}
		
		public function load():void {
			try{
				var loader:Loader = new Loader();
				loader.load(new URLRequest(this._url));
				loader.contentLoaderInfo.addEventListener(Event.INIT, comlete);
			}catch (e:Error) {
				trace("fuck load img :(");
				
			}
		}
		private function comlete(e:Event):void {
			this.arr_img["img"] = this.unite_complete(e.target);
			this.teller();
			
		}
		private function unite_complete(target:Object ):DisplayObject {
			var bitmap:BitmapData;
			var loader_img:Bitmap;
			var matr:Matrix;
			var image:Bitmap;
			try{
				loader_img = Bitmap(target.content);
				bitmap = new BitmapData(loader_img.width+0, loader_img.height+0, true , 0X00000000/*header.bitmapData*/);
				bitmap.lock();
				matr = new Matrix();
				matr.translate(0,0);
				bitmap.draw(loader_img, matr );
				
				image = new  Bitmap(bitmap);
			}catch (e:Error) {
				return target.loader;
			}
			
			loader_img = Bitmap(target.content);
			bitmap = new BitmapData(loader_img.width+0, loader_img.height+0, true , 0X00000000/*header.bitmapData*/);
			bitmap.lock();
			matr = new Matrix();
			matr.translate(0,0);
			bitmap.draw(loader_img, matr );
			
			image = new  Bitmap(bitmap);
			
			//image.filters = [new  ConvolutionFilter(12, 12, [0, 1, 1, 0,1, -3, -3, 1,1, -3, -3, 1,0, 1, 1, 0])]
			
			
			return image;
		}
		private function teller():void {
			
			this.i++;
			//trace("выполненно загрузка номер:" + this.i /*+ target.url*/ );
			if(this.i>=this.N){
				dispatchEvent(new Event(ImgLoaderBox.LOAD_IMG_COMPLETED, true));
			}
		}
		public function get arr_imges():Array {
			return this.arr_img;
		}
	}
	
}
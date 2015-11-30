package loka.dataBase {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import loka.loaders.*;
	/**
	 * ...
	 * @author loka
	 */
	public class ImgDBLoader extends Data{
		private var _loader:ImgLoadProfessional;
		public static const END:String = "END";
		public static const ADD:String = "ADD";
		private var _i:uint = 0;
		private var _length:uint;
		private var _prefix:String = "IMG_";
		private var _type:String = "img";
		private var _nameLink:String = "url";
		public function ImgDBLoader(base:Array) {
			this.updateData(base);
			
			
		}
		public function get currentCount():uint { return this._i; }
		public function get totalCount():uint { return this._length; }
		public function set prefix(value:String):void { this._prefix = value; }
		public function set type(value:String):void { this._type = value; }
		public function set nameLink(value:String):void { this._nameLink = value; }
		public function load(cash:Boolean = true):void {
			var arr:Array = this.getDataByType(this._type);
			this._length = arr.length;
			for (var c:String in arr) {
				trace("link="+arr[c].data[this._nameLink])
				this._loader = new ImgLoadProfessional((arr[c].data[this._nameLink]).toString());
				this._loader.addEventListener(LoaderConstans.LOAD_IMG_COMPLETED, addImg);
				this._loader.setProperties("name", arr[c].name);
				//this._loader.setProperties("data", arr[c].data);
				this._loader.LoadImg(cash);
				//trace("link="+arr[c].data.data);
				//trace("name="+arr[c].name);
				
			}
		}
		private function addImg(e:Event):void {
			//this._loader.'
			var mc:Sprite = new Sprite();
			mc.addChild(DisplayObject((e.currentTarget as ImgLoadProfessional).img));
			this.addNewData(this._prefix+(e.currentTarget as ImgLoadProfessional).getProperties("name"),mc);
			//trace("load");
			this._i++;
			//this.getDataByName("preloader").data.set_fon_size(this._i, this._length);
			//trace(this._i, this._length)
			this.dispatchEvent(new Event(ImgDBLoader.ADD, true));
			if (this._i >= this._length) {
				//trace("END");
				this.dispatchEvent(new Event(ImgDBLoader.END, true));
			}
		}
		
		
	}

}
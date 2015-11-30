package loka.navigator {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import loka.loaders.ImgLoaderBox;
	
	/**
	 * ...
	 * @author loka
	 */
	public class Volstoped extends Sprite {
		public static const VOLUME_STATUS:String = "VOLUME_STATUS";
		private var vol:Sprite = new Sprite();
		private var stop:Sprite = new Sprite();
		private var loader1: ImgLoaderBox;
		private var loader2: ImgLoaderBox;
		private var _status:Boolean = true;
		/**
		 * 
		 * @param	volTrue:UrlReques-link to image volStoped if true
		 * @param	volFalse:UrlReques-link to image volStoped if fasle
		 */
		public function Volstoped(volTrue:String,volFalse:String) {
			this.useHandCursor = true;
			this.buttonMode = true;
			this.loader1 = new ImgLoaderBox(volTrue);
			this.loader1.load();
			this.loader1.addEventListener(ImgLoaderBox.LOAD_IMG_COMPLETED, addVol);
			
			this.loader2 = new ImgLoaderBox(volFalse);
			this.loader2.load();
			this.loader2.addEventListener(ImgLoaderBox.LOAD_IMG_COMPLETED, addVolStoped);
			
			this.addEventListener(MouseEvent.CLICK, volumeDestroy);
		}
		private function addVol(e:Event):void {
			//trace("load");
			this.vol.addChild(this.loader1.arr_imges['img']);
			
			this.addChild(vol);
		}
		private function addVolStoped(e:Event):void {
			//trace("load");
			this.stop.addChild(this.loader2.arr_imges['img']);
			this.addChild(stop);
			this.stop.visible = false;
		}
		private function volumeDestroy(e:Event):void {
			if (this._status) {
				this._status = false;
				this.stop.visible = true;
				this.vol.visible = false;
			}else {
				this._status = true;
				this.stop.visible = false;
				this.vol.visible = true;
			}
			this.dispatchEvent(new Event(Volstoped.VOLUME_STATUS,true));
		}
		public  function get status():Boolean {
			return this._status
		}
		public  function set status(val:Boolean):void {
			this._status = val;
			if (!this._status) {
				//this._status = false;
				this.stop.visible = true;
				this.vol.visible = false;
			}else {
				//this._status = true;
				this.stop.visible = false;
				this.vol.visible = true;
			}
			
		}
	}

}
package loka.navigator {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import loka.loaders.ImgLoaderBox;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Arrows extends Sprite {
		public static const NEXT:String = "NEXT";
		public static const PREV:String = "PREV";
		private var _status:String = "NEXT";
		private var _arrow:Sprite;
		private var loader:ImgLoaderBox;
		/**
		 * 
		 * @default NEXT
		 * @param	status=NEXT||PREV:String
		 * @param	arrowLink:String=link to image;
		 */
		public function Arrows(arrowLink:String, arrowstatus:String = "NEXT") {
			this._status = arrowstatus;
			this._arrow = new Sprite();
			this.useHandCursor = true;
			this.buttonMode = true;
			/*if (this._status==Arrows.NEXT ) {
				this._arrow.rotation = 0;
			}else {
				this._arrow.rotation = 180;
			}*/
			this.addChild(this._arrow);
			this._arrow.addEventListener(MouseEvent.CLICK, arrowClick);
			this._arrow.addEventListener(MouseEvent.MOUSE_OVER, arrowOver);
			this._arrow.addEventListener(MouseEvent.MOUSE_OUT, arrowOut);
			//this.createArrow();
			this.loader = new ImgLoaderBox(arrowLink);
			this.loader.load();
			this.loader.addEventListener(ImgLoaderBox.LOAD_IMG_COMPLETED, addArrow);
		}
		private function addArrow(e:Event):void {
			this._arrow.addChild(this.loader.arr_imges['img']);
			/*this.loader.arr_imges['img'].y -= this.loader.arr_imges['img'].height/2;
			this.loader.arr_imges['img'].x -= this.loader.arr_imges['img'].width / 2;
			this._arrow.x+= this.loader.arr_imges['img'].width / 2;
			this._arrow.y+= this.loader.arr_imges['img'].height / 2;*/
			//this.addChild(vol);
		}
		private function arrowOver(e:Event):void {
			
			if (this._status==Arrows.NEXT ) {
				this._arrow.x += 1;
			}else {
				this._arrow.x -= .5;
			}
		}
		private function arrowOut(e:Event):void {
			if (this._status==Arrows.NEXT ) {
				this._arrow.x -= 1;
			}else {
				this._arrow.x += .5;
			}
		}
		private function arrowClick(e:Event):void {
			if(this._status==Arrows.NEXT){
				this.dispatchEvent(new Event(Arrows.NEXT, true));
			}else {
				this.dispatchEvent(new Event(Arrows.PREV, true));
			}
		}
		private function createArrow(num:int = 2):void {
			var tmp:Sprite;
			for (var i:int; i <= num; i++ ) {
				//tmp; = new Sprite();
				tmp = this.arrow;
				tmp.x = this.width;
				this._arrow.addChild(tmp);
			}
		}
		private function get arrow():Sprite {
			var tmpSpr:Sprite = new Sprite();
			with(tmpSpr.graphics){
				beginFill(0xffffff, .5);
				lineStyle(0, 0xcecece, 1, true, LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER, 10);
				moveTo(0, 0);
				lineTo(w,0);
				lineTo(w,1);
				lineTo(0, 1);
				lineTo(0, 0);
				endFill();
				
			}
			return tmpSpr;
		}
		
	}

}
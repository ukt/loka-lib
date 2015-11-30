package loka.dataBase.scroll {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class Scroll extends ScrollBase {
		
		
		private var _percent:Number=0;
		
		private var _mc_scroll:Btnscroll;
		private var _mc_up:Btnup;
		private var _mc_down:Btndown;
		private var _mc_body:loka.dataBase.scroll.Body;
		
		public static const SCROLLS:String = "SCROLLS";
		public function Scroll(w:Number = 10, h:Number = 100, x:Number = 0, y:Number = 0) {
			this._h = h;
			this._w = w;
			this._x = x;
			this._y = y;
			this.init();
			this.addNewData("h",h);
			this.addNewData("w",w);
			this.addNewData("x",x);
			this.addNewData("y",y);
			this.addNewData("bckgColor",0x0000ff);
			this.addNewData("lineColor", 0X0000ff);
			this.addNewData("root", this);
			
			this.createBody();
		}
		private function createBody():void {
			//this._mc.gr
			
			var rect:Rectangle = this.createRect();
			this._mc_scroll = new Btnscroll(this.data);
			this._mc_scroll.create( rect, this._w, this._w, this._x, this._y+this._rect.y);
			this._mc_up = new Btnup(this.data);
			this._mc_up.create(this._w, this._w, this._x, this._y);
			this._mc_down = new Btndown(this.data);
			this._mc_down.create(this._w, this._w, this._x, this._h - this._w);
			this._mc_body = new Body(this.data);
			//trace("this.y="+this._y)
			this._mc_body.create(this._w, this._h , this._x, this._y);
			//
			
			this._mc_up.addEventListener(MyscrollEvent.BTN_UP_CLICKED, scroll_up);
			this._mc_down.addEventListener(MyscrollEvent.BTN_DOWN_CLICKED, scroll_down);
			this._mc_scroll.addEventListener(MyscrollEvent.MOVED, scroll_Move);
			addChild(this._mc_body);
			addChild(this._mc_up);
			addChild(this._mc_down);
			addChild(this._mc_scroll);
			//trace("body.y=" + _mc_body.y);
		}
		private function scroll_up(e:Event):void {
			this._mc_scroll.moveUp();
		}
		private function scroll_down(e:Event):void {
			this._mc_scroll.moveDown();
		}
		private function scroll_Move(e:Event):void {
			var dispatch:Boolean = true;
			//if (Math.round(this._percent) == Math.round(this._mc_scroll.Percent)) dispatch = false;
			this._percent = this._mc_scroll.Percent;
			//if (dispatch)
			dispatchEvent(new Event(Scroll.SCROLLS, true));
			//trace("move");
		}
		public function get Percent():Number {
			return this._percent;
		}
		public function set Percent(val:Number):void {
			//return this._percent;
			this._percent = val;
			this._mc_scroll.Percent = this._percent;
			//dispatchEvent(new Event(Scroll.SCROLLS, true));
		}
		override public function get width():Number { return super.width; }
		
		override public function set width(value:Number):void {
			this._w = value;
			this.addNewData("w", value,true);
			this.reCreate();
		}
		override public function get height():Number { return super.height; }
		
		override public function set height(value:Number):void {
			this._h = value;
			this.addNewData("h", value,true);
			this.reCreate();
		}
		public function set bckgColor(value:uint):void {
			this.addNewData("bckgColor", value,true);
			this._bckgColor = value;
			this.reCreate();
		}
		public function set lineColor(value:uint):void {
			this.addNewData("lineColor", value,true);
			this._lineColor = value;
			this.reCreate();
		}
		
		public function set btnUpImage(val:DisplayObject):void { this.addNewData("btnUp", val, true);this.reCreate();} 
		public function set btnDownImage(val:DisplayObject):void { this.addNewData("btnDown", val, true);this.reCreate();} 
		public function set btnScrollImage(val:DisplayObject):void { this.addNewData("btnScroll", val, true);this.reCreate();} 
		public function set scrollBodyImage(val:DisplayObject):void { this.addNewData("scrollBody", val, true); this.reCreate(); } 
		
		private function reCreate():void {
			this._mc_up.removeEventListener(MyscrollEvent.BTN_UP_CLICKED, scroll_up);
			this._mc_down.removeEventListener(MyscrollEvent.BTN_DOWN_CLICKED, scroll_down);
			this._mc_scroll.removeEventListener(MyscrollEvent.MOVED, scroll_Move);
			removeChild(this._mc_body);
			removeChild(this._mc_up);
			removeChild(this._mc_down);
			removeChild(this._mc_scroll);
			
			this.createBody();
		}
		private function createRect():Rectangle {
			this._rect.x = this._x;
			this._rect.y = this._y + this._w;
			this._rect.width = 0;
			this._rect.height = this._h - 3 * this._w;
			if (issetData("btnUp")) {
				this._rect.y = this.y + this.getDataByName("btnUp").data.height;
				this._rect.height += this._w - this.getDataByName("btnUp").data.height;
			}
			//if (issetData("btnDown")) {
				//this._rect.height += this._w - this.getDataByName("btnDown").data.height;
			//}
			if (issetData("btnScroll")) {
				this._rect.height += this._w - this.getDataByName("btnScroll").data.height;
			}
			return this._rect;
		}
	}
	
}
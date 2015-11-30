package loka.dataBase.scroll  {
	import flash.events.*;
	import flash.geom.Rectangle;
	
	import loka.bitmap.BitmapEdit;
	import loka.button.btnEffect.BtnEffect;
	public class Btnscroll extends ScrollBase{
		//private var _rect:Rectangle = new Rectangle(0, 10, 10, 90);
		//private var _w:Number = 10;
		private var _percent:Number = 10;
		private var _mouseYClick:Number = 0;
		
		public function Btnscroll(data:Array) {
			this.updateData(data);
			this._h = parseFloat(this.getDataByName("h").data);
			this._w = parseFloat(this.getDataByName("w").data);
			this._x = parseFloat(this.getDataByName("x").data);
			this._y = parseFloat(this.getDataByName("y").data);
			this._bckgColor = this.getDataByName("bckgColor").data;
			this._lineColor = this.getDataByName("lineColor").data;		
		}
		public function create(rect:Rectangle, w:Number = 10, h:Number = 10, x:Number = 0, y:Number = 90 ):void {
			this._w = w;
			this._rect = rect;
			if (this.issetData("btnScroll")) {
				this.addChild(BitmapEdit.drawImg(this.getDataByName("btnScroll").data));
				//this._rect = new Rectangle(this.x,this.y,this.width,)
			}else{
				this.graphics.beginFill(this._bckgColor,0.2);
					this.graphics.lineStyle(2, this._lineColor,0.5);
					//this.graphics.drawRect(0, 0, w, h);
					this.graphics.drawCircle(w / 2, h / 2, w / 2 - w / 10);
					this.graphics.lineStyle(1, this._lineColor,0.5);
					this.graphics.moveTo(w / 4, h / 2);
					this.graphics.lineTo(w - w / 4, h / 2);
					this.graphics.moveTo(w / 3, h / 2.5);
					this.graphics.lineTo(w - w / 3, h / 2.5);
					this.graphics.moveTo(w / 3, h / 1.65);
					this.graphics.lineTo(w - w / 3, h / 1.65);
					
				this.graphics.endFill();
			}	
			this.x = x;
			this.y = y;
			//return this;
			this.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			this._btnEffect = new BtnEffect(this);
		}
		private function clicked(e:Event):void {
			this.startDrag();
			//e.updateAfterEvent();
		}
		private function onDown(e:Event):void {
			//this.startDrag(false, this._rect);
			this._mouseYClick = this.mouseY;
			this.getDataByName("root").data.stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
			//this.addEventListener(MouseEvent.MOUSE_UP, onUp);
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			this.addEventListener(Event.ENTER_FRAME, onMove);
		}
		private function onUp(e:Event):void {
			//this.stopDrag();
			//this.removeEventListener(MouseEvent.MOUSE_UP, onUp);
			this.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
			this.removeEventListener(Event.ENTER_FRAME, onMove);
		}
		private function onMove(e:Event):void {
			//var e_y=((this.mc_scroll_list_h+2+e.target.height)/(this.scroll_bar.height-scroll_bar_btn.height))*((-1)*(e.target.y ))
			//this.mc_scroll_list.y = e_y;
			//trace(this.y);
			var newY:Number = this.parent.mouseY - this._mouseYClick;
			if (newY > this._rect.y-1 && newY < this._rect.height+this._rect.y+1)
			this.y = newY;
			if (newY < this._rect.y - 1) this.y = this._rect.y;
			if (newY > this._rect.height+this._rect.y+1) this.y = this._rect.height+this._rect.y;
			//trace(this.parent.mouseY);
			this._percent=(100 / this._rect.height ) * (this.y - this.height - 2 * this._w / 10 + 2);
			dispatchEvent(new Event(MyscrollEvent.MOVED,true));
		}
		public function moveUp():void {
			var move:Number = this.y;
			if(this.y - (this._rect.height / 100) * 10>this._rect.y){
				move -= (this._rect.height / 100) * 10;
			}else {
				move = this._rect.y;
			}
			//this._percent = (100 / this._rect.height ) * (this.y - this.height - 2 * this._w / 10 + 2);
			statusThis = true;
			this.Percent = (100 / this._rect.height ) * (move - this.height - 2 * this._w / 10 + 2);
			//dispatchEvent(new Event(MyscrollEvent.MOVED,true));
		}
		public function moveDown():void {
			var move:Number = this.y;
			if(this.y + (this._rect.height / 100) * 10<this._rect.height+this._rect.y/*+this.height*/){
				move += (this._rect.height / 100) * 10;
			}else {
				move = this._rect.height + this._rect.y;
			}
			//this._percent = (100 / this._rect.height ) * (this.y - this.height - 2 * this._w / 10 + 2);
			statusThis = true;
			this.Percent = (100 / this._rect.height ) * (move - this.height - 2 * this._w / 10 + 2);
			//dispatchEvent(new Event(MyscrollEvent.MOVED,true));
		}
		
		private function valideMove():Boolean {
			var result:Boolean = true;
			
			return result;
		}
		public function get Percent():Number {
			//
			return this._percent;
		}
		private var statusThis:Boolean = false;
		public function set Percent(val:Number):void {
			if(val < 100&& val>0){
				this._percent = val;
				
			}else if (val > 100) {
				this._percent = 100;
			}else if (val < 100) {
				this._percent = 0;
			}
			this.y = (this._rect.height / 100) * this._percent + this._rect.y;
			//if(statusThis)
			dispatchEvent(new Event(MyscrollEvent.MOVED, true));
			//trace(val);
			statusThis = false;
			
		}
		
	}
	
}
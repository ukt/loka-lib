package utils.loka.graph {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.*;
	
	import utils.loka.drags.Drags;
	
	/**
	 * ...
	 * @author loka
	 */
	public class LineMoved extends Sprite{
		private var _line:Sprite = new Sprite();
		private var _lineColor:uint =0x000000;
		private var _lineSize:uint =1;
		private var _lineAlpha:Number =1;
		private var _lineVisible:Boolean = false;
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _w:Number = 0;
		private var _h:Number = 0;
		private var _Obj:DisplayObject;
		private var _drags:Drags;
		public function LineMoved(obj:DisplayObject, x:Number = 0, y:Number = 0, w:Number = 0, h:Number = 0) {
			this._Obj = obj;
			this._x = x;
			this._y = y;
			this._w = w;
			this._h = h;
				this._drags = new Drags();
				this._drags.addEventListener(Drags.DRAGED, Moved);
				this._drags.dragElement(this._Obj);
				
				//this.addChild(this._Obj);
			/*this._line.graphics.lineStyle(0, 0x000000, 1, true);
			this._line.graphics.moveTo(this._x, this._y);
			this._line.graphics.lineTo(this._Obj.x, this._Obj.y);*/
			//this.addChild(this._line);
			//this._Obj.addEventListener(DRAGE
		}
		public function Moved(e:Event):void {
			//this.getChildAt
			//trace("ЫЫЫ"+this._Obj.y);
			//this._line = new Sprite();
			this.render();
		}
		private function render():void {
			this._line.graphics.clear();
			this._line.graphics.lineStyle(this._lineSize, this._lineColor, this._lineAlpha, true);
			this._line.graphics.moveTo(this._x, this._y);
			var xs:Number=0;
			if (this._Obj.x + this._Obj.width+this._Obj.width/2 > this._x && this._Obj.x-this._Obj.width/2 < this._x) {
				//xs = (this._Obj.x + this._Obj.width/2);
				xs =(this._Obj.x + this._Obj.width/2)+(this._x-(this._Obj.x + this._Obj.width/2))/2;
			}else if(this._Obj.x + this._Obj.width <= this._x){
				xs = (this._Obj.x + this._Obj.width);
			}else if(this._Obj.x>= this._x){
				xs = this._Obj.x;
			}
			var ys:Number = 0;
			if (this._Obj.y + this._Obj.height+this._Obj.height/2 > this._y && this._Obj.y-this._Obj.height/2 < this._y) {
				//ys= (this._Obj.y + this._Obj.height/2) ;
				//ys=(2*this._Obj.height)/100  (this._Obj.y + this._Obj.height)-this._y ;
				ys =(this._Obj.y + this._Obj.height/2)+(this._y-(this._Obj.y + this._Obj.height/2))/2;
				//ys = this._y;
			}else if(this._Obj.y + this._Obj.height <= this._y){
				ys= (this._Obj.y + this._Obj.height);
			}else if(this._Obj.y>= this._y){
				ys = this._Obj.y;
			}
			this._line.graphics.lineTo(xs, ys);
		}
		public function set Visible(value:Boolean):void{
			if (!value&&this._lineVisible) {
				this.removeChild(this._line);
			}else if (value && !this._lineVisible) {
				this.render();
				this.addChild(this._line);
			}
			this._lineVisible = value;
		}
		public function set _X(value:Number):void{
			this._x = value;
		}
		public function set _Y(value:Number):void{
			this._y = value;
		}
		public function set _color(value:Number):void{
			this._lineColor = value;
		}
		public function set _alpha(value:Number):void{
			this._lineAlpha = value;
		}
		public function set _size(value:Number):void{
			this._lineSize = value;
		}
		public function set _Move(value:Boolean):void {
			if(value){
				this._drags._Move = true;
			}else {
				this._drags._Move = false;
			}
		}
		
		
	}
	
}
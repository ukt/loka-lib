package utils.loka.graph {
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author loka
	 */
	public class Canvas extends Sprite{
		private var _color:uint=0x000000;
		private var _colorStatus:Boolean=true;
		private var _bckColorStatus:Boolean=true;
		private var _bckColor:uint=0xffffff;
		private var _line:uint=1;
		private var _lineAlpha:Number=1;
		private var _bckAlpha:Number=1;
		private var _Rad:Number=0;
		private var _mc:Sprite;
		public function Canvas() {
			
		}
		public function circleTo(x:Number, y:Number, r:Number, start:Number=1, stop:Number=1):Sprite{
			this.proporties();
			this.graphics.moveTo(x, y);
			start =  start*2*Math.PI;
			stop = stop*2*Math.PI;
			this.graphics.lineTo(x + r * -Math.cos(start+Math.PI+this._Rad), y + (r) * Math.sin(start+Math.PI+this._Rad));
			while(start<stop){
				
				this.graphics.lineTo(x + r * -Math.cos(start +Math.PI+this._Rad), y + (r) * Math.sin(start + Math.PI+this._Rad));
				start+=0.1;
			}
			this.graphics.lineTo(x + r * -Math.cos(start +Math.PI+this._Rad), y + (r) * Math.sin(start+Math.PI+this._Rad));
			this.graphics.lineTo(x, y);
			this.graphics.endFill();
			return this;
		}
		public function RectfromCirc(x:Number, y:Number, r1:Number, r2:Number, start:Number = 1, stop:Number = 1 ):Sprite {
			
			this.proporties();
			r1 -= r2 / 2;//*/
			start =  start*2*Math.PI;
			stop = stop*2*Math.PI;
			var tmp:Number = start;
			this.graphics.moveTo(x + r1 * -Math.cos(start+Math.PI+this._Rad), y + (r1) * Math.sin(start+Math.PI+this._Rad));
			while(start<stop){
				start+=0.1;
				this.graphics.lineTo(x + r1 * -Math.cos(start +Math.PI+this._Rad), y + (r1) * Math.sin(start+Math.PI+this._Rad));
			}
			this.graphics.lineTo(x /*- r2*/ + r1 * -Math.cos(start + Math.PI+this._Rad), y + r2 + (r1) * Math.sin(start + Math.PI+this._Rad));
			while(start>tmp){
				start-=0.1;
				this.graphics.lineTo(x/*-r2*/ + r1 * -Math.cos(start +Math.PI+this._Rad), y+r2 + (r1) * Math.sin(start+Math.PI+this._Rad));
			}
			this.graphics.endFill(); 
			this.lineStatus = true;
			this.proporties();
			if (Math.abs(r1 * -Math.cos(start +Math.PI+this._Rad) + r1 * -Math.cos(stop +Math.PI+this._Rad)) <=r1 * -Math.cos(3*Math.PI+this._Rad) ) {
				
				
			}
			this.graphics.endFill();
			return this;
		}
		
		public function Rectangles(x:Number, y:Number, r:Number, h:Number, start:Number = 1, stop:Number = 1 ):Sprite {
			this._mc = new Sprite();
			this.McProporties();
			
			start =  start*2*Math.PI;
			stop = stop*2*Math.PI;
			var tmp:Number = start;
			
			this._mc.graphics.moveTo(x + r * -Math.cos(start+Math.PI+this._Rad), y-h/2);
			var tmpX:Number = x + r * -Math.cos(start +Math.PI+this._Rad);
			var p:Number = 1;
			tmpX -= x + r * -Math.cos(start+0.1 +Math.PI+this._Rad);
			if (tmpX >= 0) { 
				p = 1;
			}else {
				p = -1;
			}
			this._mc.graphics.moveTo(x + r * -Math.cos(start +Math.PI+this._Rad), y - h / 2);
			while (start < stop) {
				
				
				
				start+=0.1;
				this._mc.graphics.lineTo(x + r * -Math.cos(start +Math.PI+this._Rad), y - h / 2);
				
				tmpX -= x + r * -Math.cos(start +Math.PI);
				if (tmpX >= 0 && p == -1) {
					this._mc.graphics.lineTo(x  + r * -Math.cos(start + Math.PI+this._Rad), y + h / 2);
					this._mc.graphics.lineTo(x  + r * -Math.cos(tmp+ Math.PI+this._Rad), y + h / 2);
					this._mc.graphics.moveTo(x  + r * -Math.cos(tmp+ Math.PI+this._Rad), y - h / 2);
					this.McProportiesEnd();
					this.McProporties();
				}else if (tmpX < 0 && p == 1){
					this._mc.graphics.lineTo(x  + r * -Math.cos(start + Math.PI+this._Rad), y + h / 2);
					this._mc.graphics.lineTo(x  + r * -Math.cos(tmp + Math.PI+this._Rad), y + h / 2);
					this._mc.graphics.moveTo(x  + r * -Math.cos(tmp+ Math.PI+this._Rad), y - h / 2);
					this.McProportiesEnd();
					this.McProporties();
				}
				tmpX = x + r * -Math.cos(start + Math.PI);
			}
					this._mc.graphics.lineTo(x  + r * -Math.cos(stop + Math.PI+this._Rad), y + h / 2);
					this._mc.graphics.lineTo(x  + r * -Math.cos(tmp + Math.PI+this._Rad), y + h / 2);
			this.McProportiesEnd();
			return this._mc;
		}
		public function set bckColor(color:uint):void {
			this._bckColor = color;
		}
		/**
		 *  default =true;
		 */
		public function set bckStatus(stat:Boolean):void {
			this._bckColorStatus = stat;
		}
		public function set lineColor(color:uint):void {
			this._color = color;
		}
		public function set lineStatus(stat:Boolean):void {
			this._colorStatus = stat;
		}
		public function set line(n:uint):void {
			this._line = n;
		}
		public function set lineAlpha(n:uint):void {
			this._lineAlpha = n;
		}
		public function set backGAlpha(n:uint):void {
			this._bckAlpha = n;
		}
		public function set _Radian(n:Number):void {
			this._Rad = n;
		}
		private function McProporties():void {
			if (this._colorStatus) {
				this._mc.graphics.lineStyle(this._line, this._color, this._lineAlpha);
			}
			if (this._bckColorStatus) {
				this._mc.graphics.beginFill(this._bckColor,this._bckAlpha);
			}
		}
		
		private function McProportiesEnd():void {
			this._mc.graphics.endFill();
		}
		
		private function proporties():void {
			if (this._colorStatus) {
				this.graphics.lineStyle(this._line, this._color, this._lineAlpha);
			}
			if (this._bckColorStatus) {
				this.graphics.beginFill(this._bckColor,this._bckAlpha);
			}
		}
		
	}
	
}
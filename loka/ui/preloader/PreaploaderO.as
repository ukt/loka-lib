package loka.ui.preloader {
//	import classes.Base;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author loka
	 */
	public class PreaploaderO extends Sprite{
		private var _O:Sprite= new Sprite();
		private var _OBackground:Sprite= new Sprite();
		private var _start:Number = 0.25;
		private var _stop:Number = 0;
		private var _currentStop:Number = 0;
		private var _maxSize:Number = 100;
		private var _speed:Number = 10;
		private var _r1:Number = 80;
		private var _r2:Number = 100;
		private var _color:uint = 0x00ff00;
		private var _strokeColor:uint = 0xffff00;
		private var _times:Boolean= true;
		public static const FULL_POSITION:String = "FULL_POSITION";
		
		
		public function PreaploaderO() {
/*var gradientBevel:GradientBevelFilter = new GradientBevelFilter();
gradientBevel.distance = 8;
gradientBevel.angle = 225; // opposite of 45 degrees
gradientBevel.colors = [0xFFFFCC, 0xFEFE78, 0x8F8E01];
gradientBevel.alphas = [1, 0, 1];
gradientBevel.ratios = [0, 128, 255];
gradientBevel.blurX = 8;
gradientBevel.blurY = 8;
gradientBevel.quality = BitmapFilterQuality.HIGH;
this._O.filters=[gradientBevel]*/
			this.addChild(this._O);
			this.addChild(this._OBackground);
			this._OBackground.graphics.beginFill(this._color);
			this._OBackground.graphics.drawRect(0, 0, 10, 10);
			this._OBackground.graphics.endFill();
			this._OBackground.alpha = 0.01;
		}
		private function createO(start:Number = 0, stop:Number = 0):void {
			var vector:int = 1;
			this.removeChild(this._O);
			//this._O.alpha = 0.01;
			this._O = new Sprite();
			
			var r1:Number = this._r1;
			var r2:Number = this._r2;
			var start:Number = this._start * 2 * Math.PI;
			var stop:Number = this._stop * 2 * Math.PI+start;
			var x:Number = r2;
			var y:Number = r2;
			var tmp:Number = start;
			if (this._times) {
				start = -1*this._start * 2 * Math.PI+Math.PI;
				stop = -1 * this._stop * 2 * Math.PI - start + Math.PI;
				
				this._O.graphics.beginFill(this._color);
				this._O.graphics.lineStyle(1, this._color,1,false,LineScaleMode.NONE);
				this._O.graphics.moveTo(x + r1 * -Math.cos(start + Math.PI), y + r1 * Math.sin(start + Math.PI));
				this._O.graphics.lineStyle(1, this._strokeColor,1,false,LineScaleMode.NONE);
				while(start>stop){
					start-=0.001;
					this._O.graphics.lineTo(x + r1 * -Math.cos(start +Math.PI), y + r1 * Math.sin(start+Math.PI));
				}
				this._O.graphics.lineStyle(1, this._color,1,false,LineScaleMode.NONE);
				this._O.graphics.lineTo(x + r2 * -Math.cos(start + Math.PI), y + r2  * Math.sin(start + Math.PI));
				this._O.graphics.lineStyle(1, this._strokeColor,1,false,LineScaleMode.NONE);
				while(start<=tmp){
					start+=0.001;
					this._O.graphics.lineTo(x + r2 * -Math.cos(start +Math.PI), y + r2  * Math.sin(start + Math.PI));
				}
			}else{
				//var tmp = start;
				this._O.graphics.beginFill(this._color);
				this._O.graphics.lineStyle(1, this._color,1,false,LineScaleMode.NONE);
				this._O.graphics.moveTo(x + r1 * -Math.cos(start + Math.PI), y + r1 * Math.sin(start + Math.PI));
				this._O.graphics.lineStyle(1, this._strokeColor,1,false,LineScaleMode.NONE);
				while(start<stop){
					start+=0.001;
					this._O.graphics.lineTo(x + r1 * -Math.cos(start +Math.PI), y + r1 * Math.sin(start+Math.PI));
				}
				this._O.graphics.lineStyle(1, this._color,1,false,LineScaleMode.NONE);
				this._O.graphics.lineTo(x + r2 * -Math.cos(start + Math.PI), y + r2  * Math.sin(start + Math.PI));
				this._O.graphics.lineStyle(1, this._strokeColor,1,false,LineScaleMode.NONE);
				while(start>=tmp){
					start-=0.001;
					this._O.graphics.lineTo(x + r2 * -Math.cos(start +Math.PI), y + r2  * Math.sin(start + Math.PI));
				}
			}
			this._O.graphics.lineStyle(1, this._color, 1, false,LineScaleMode.NONE);
			this._O.graphics.endFill(); 
			this.addChild(this._O);
			
			
			
			this._OBackground.width = this._r2*2;
			this._OBackground.x = this._O.x;
			this._OBackground.y = this._O.y;
			this._OBackground.height = this._r2 * 2;
			
		}
		
		public function setFonSize(value:Number, max_size:Number = 100):void {
			//trace(this.width+"_"+this._stop);
			this._maxSize = max_size;
			this._currentStop = value;	
			if (!this.hasEventListener(Event.ENTER_FRAME)) {
				this.addEventListener(Event.ENTER_FRAME, moveLoader);
			}
			
			//this.addEventListener(Event.ENTER_FRAME,moveLoader);
		}
		
		private function moveLoader(e:Event):void {
			this._stop += (this._currentStop / this._maxSize - this._stop) / (this._speed);
			if ((this._currentStop / this._maxSize - this._stop) / (this._speed) < 0.01) {
				//this._stop += .01;
			}
			//trace(((this._currentStop / this._maxSize - this._stop) / (this._speed)))
			//trace(this._stop +"==="+ 1 / this._maxSize);
			if (this._stop >= 0.9999) {
				//trace("Good");
				dispatchEvent(new Event(PreaploaderO.FULL_POSITION, true))
				this.removeEventListener(Event.ENTER_FRAME, moveLoader);
			}
			//if()
			//trace(this._stop );
			this.createO();
		}
		
		public function set times(val:Boolean):void {this._times = val;}
		public function set speedEffect(val:Number):void {this._speed = val;}
		public function set color(val:uint):void {this._color= val;}
		public function set storkeColor(val:uint):void {this._strokeColor = val;}
		public function get radiusIn():Number {return this._r1;}
		public function set radiusIn(val:Number):void {this._r1 = val;}
		public function set radiusOut(val:Number):void {this._r2 = val;}
		public function set start(val:Number):void { this._start = val; }
		public function set stop(val:Number):void {this._currentStop = val;}
		
	}

}
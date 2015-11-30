package loka.tween {
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author loka
	 */
	public class Tweener {
		private var _el:Object;
		private var _property:String="NULL";
		private var _start:Number=666.666;
		private var _stop:Number=100;
		private var _speed:Number = 10;
		private var _precision:Number = .1;
		private var _shape:Shape = new Shape();
		private var _functionEnd:Function;// = this.end();
		private var _functionMove:Function;// = this.end();
		private var _functionMethod:Function;// = this.end();
		private var _completeNow:Boolean = true;
		private var _timer:Timer;
		private var _timerStaus:Boolean = false;
		private var _delay:Number= 100;
		public static const END:String = "END";
		public static const ERROR:String = "ERROR";
		public static const TWEEN_OUT:String = "tweenOut";
		public static const TWEEN_IN:String = "tweenIn";
		
		private var _method:String = Tweener.TWEEN_OUT;
		public function Tweener(timer:Boolean=false) {
			this._functionEnd = this.end;
			this._functionMove = this.move;
			this._timerStaus = timer;
		}
		public function go():void {
			switch(this._method) {
				case Tweener.TWEEN_IN :
					this._functionMethod = this.tweenIn;
					break;
				case Tweener.TWEEN_OUT :
					this._functionMethod = this.tweenOut;
					break;
				default : 
					trace("Tweener ERROR"+"\nSorry, this method: " +this._method+"- not good"); 
					break; 
			}
			if (this._el != null || this._property != "NULL") {
				if(this._property in this._el)
				if (this._start == 666.666) this.start = this._el[this._property] else this._el[this._property] = this._start;
				
				if (this._timerStaus) {
					this._timer = new Timer(this._delay);
					
					this._timer.addEventListener(TimerEvent.TIMER, this._functionMethod);
					this._timer.start();
				}else{
					this._shape.addEventListener(Event.ENTER_FRAME, this._functionMethod);
				}
			}else {
				//this._shape.dispatchEvent(new Event(Tweener.ERROR, true));
				this._functionEnd();
				trace(Tweener.ERROR);
			}
		}
		private var _precisionIn:Number = .2;
		private function tweenIn(e:Event):void {
			this._precisionIn += this._precision;
			var tmpMove:Number = Math.pow(this._precisionIn, 2);
			if ((this._start >this._stop)) tmpMove= -Math.pow(this._precisionIn, 2);
			if (Math.abs(this._stop - (this._el[this._property])) < Math.abs(tmpMove)) {
				this._el[this._property] = this._stop;
				this.completeNow();
			}else {
				this._el[this._property] += tmpMove;
				this._functionMove(this._el);
			}
		}
		private function tweenOut(e:Event):void {
			var tmpMove:Number = (this._el[this._property] - this._stop) / this._speed;
			if (Math.abs(tmpMove) < this._precision) {
				this.completeNow();
			}else {
				this._el[this._property] -= tmpMove;
				this._functionMove(this._el);
			}
			//trace("timer"+tmpMove)
		}
		private function end():void { }
		private function move(o:Object):void { }
		/**
		 * object from which to work
		 */
		public function set element(el:Object):void { this._el = el; }
		/**
		 * start property
		 */
		public function set start(value:Number):void { this._start = value; }
		/**
		 * stop property
		 */
		public function set stop(value:Number):void { this._stop = value; }
		/**
		 * current property witch we must worked
		 */
		public function set property(value:String):void { this._property = value; }
		/**
		 * speed property. Default = 10
		 */
		public function set speed(value:Number):void { this._speed = value; }
		/**
		 * minimum movingProperty
		 */
		public function set precision(value:Number):void { this._precision = value; }
		/**
		 * function call after the completion of robots.
		 */
		public function set functionEND(value:Function):void { this._functionEnd = value; }
		/**
		 * function call if Object has been tweener.
		 */
		public function set functionMove(value:Function):void { this._functionMove = value; }
		/**
		 * stoped Move status? if true then completeNow has been call;
		 */
		public function set completeNowStatus(value:Boolean):void { this._completeNow = value; }
		/**
		 * if use timer set delay
		 */
		public function set delay(value:Number):void { this._delay = value; }
		/**
		 * if use timer set timerStatus - true
		 */
		public function set timerStatus(value:Boolean):void { this._timerStaus = value; }
		/**
		 * set the method of move 
		 */
		public function set method(value:String):void { if(value==(Tweener.TWEEN_IN||Tweener.TWEEN_OUT)) this._method = value; }
		/**
		 * compulsory completion
		 */
		public function completeNow():void {
			if(this._shape.hasEventListener(Event.ENTER_FRAME)&&this._completeNow){
				this._shape.removeEventListener(Event.ENTER_FRAME, this._functionMethod);
				this._functionEnd();
			}else if (this._timerStaus&&this._completeNow) {
				this._timer.stop();
				this._functionEnd();
			}
		}
	}

}
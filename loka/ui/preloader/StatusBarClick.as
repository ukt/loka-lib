package utils.loka.ui.preloader {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	
	import utils.loka.bitmap.BitmapEdit;
	import utils.loka.tween.Tweener;
	
	/**
	 * ...
	 * @author loka
	 */
	public class StatusBarClick extends Sprite
	{
		public var _fon:MovieClip;
		
		public var _width:Number;
		public var _widthMax:Number;
		private var _splah:MovieClip ;
		private var _load:Boolean = false;
		private var _reposition:Boolean = true;
		private var _mc:MovieClip;
		private var _percent:Number;
		private var _flashCount:uint = 10;
		private var _currentWidth:Number;
		
		private var _speedEffect:Number = 10;
		
		private var _bufferColor:uint = 0xcecece;
		//private var _mc:MovieClip;
		
		private var _buffer:Sprite;
		private var _twener:Tweener = new Tweener();
		private var _currentBufferWidth:Number =1;
		
		public static const REPOSITION:String = "REPOSITION";
		public static const FULL_POSITION:String = "FULL_POSITION";
		//private var _TF:Mymemo = new Mymemo();
		public function StatusBarClick() 
		{
			super();	
			this.name = "StatusBarClick";
//			
		}
		
		public function createBar(x:Number,y:Number,w:Number,h:Number,color:uint=0x88CBD9,color_back:uint=0x00cc00):void 
		{
			this._mc = new MovieClip();
			var pr:MovieClip = new MovieClip();
			this._width = 0;
			this._widthMax = w;
			pr.graphics.beginFill(color);
			pr.graphics.drawRect(0, 0, w, h);
			pr.graphics.endFill();
			
			this._buffer = new Sprite();
			this._buffer.graphics.beginFill(this._bufferColor);
			this._buffer.graphics.drawRect(0, 0, 1, h);
			this._buffer.graphics.endFill();
			
			
			this._fon = new MovieClip();
			this._fon.graphics.beginFill(color_back);
			this._fon.graphics.drawRect(0, 0, 1, h);
			this._fon.graphics.endFill();
			this._fon.name = "fon";
			_mc.addChild(pr);
			_mc.addChild(this._buffer);
			_mc.addChild(this._fon);
			
			this.x = x;
			this.y = y;
			var masks:Sprite = this.rect(0, 0, w, h);
			mask = masks;
			
			_mc.addChild(masks);
			_mc.name = "mc";
			_mc.addEventListener(MouseEvent.MOUSE_OVER, goOver);
			_mc.addEventListener(MouseEvent.MOUSE_OUT, goOut);
			if (this._reposition) _mc.addEventListener(MouseEvent.CLICK, goClick);
			
			addChild(_mc);
			this._twener.completeNowStatus = false;
			
		}
		
		private function goClick(e:Event):void 
		{
			//this._fon.width = this.mouseX;
			if (!this._fon.hasEventListener(Event.ENTER_FRAME)) {
				this._fon.addEventListener(Event.ENTER_FRAME, setCurrentWidth);
			}
			this._currentWidth = this.mouseX;
			dispatchEvent(new Event(StatusBarClick.REPOSITION, true));
		}
		
		private function goOver(e:Event):void 
		{
			var _mc1:MovieClip = new MovieClip();
			_mc1.addChild(this.createFlash(e.target.height));
			_mc1.addEventListener(Event.ENTER_FRAME, go);
			_mc1.name = "_mc1";
			_mc1.mouseEnabled = false;
			this._mc.addChild(_mc1);
		}
		
		private function goOut(e:Event):void 
		{
			
		}
		
		private function go(e:Event):void 
		{
			this._load == true;
			
			e.currentTarget.x += 2;
			
			if (e.currentTarget.x - (e.currentTarget.width / 2) > this._widthMax) 
			{
				e.target.removeEventListener(Event.ENTER_FRAME, go);
				this._mc.removeChild(DisplayObject(e.currentTarget));
			}	
		}
		
		private function createFlash(h:Number):Bitmap 
		{ 
			this._splah = new MovieClip(); 
			for (var i:uint = 0; i < this._flashCount; i++ ) 
			{
				var _mc1:Sprite = this.rect( -i*4, 0, 8 * i, h);
				_mc1.alpha = 0.051;
				this._splah.addChild(_mc1);
			}
			
			return BitmapEdit.drawImgNew(this._splah, true, -4 * this._flashCount);
			
		}
		
		private function rect(x:Number, y:Number, w:Number, h:Number):Sprite 
		{ 
			var _mc1:Sprite = new Sprite();
			_mc1.graphics.beginFill(0Xffffff);
			_mc1.graphics.drawRect(x, y, w, h);
			_mc1.graphics.endFill();
			return _mc1;
		}
		
		public function setFonSize(value:Number, max_size:Number = 100):void 
		{
			this.percent(value, max_size);
		}
		
		/**
		 *	Use to set fon in progress bar 
		 *	@param value
		 *	@param max_size
		 * 
		 */
		public function percent(value:Number, max_size:Number=100, useSpeedEffect:Boolean = true):void 
		{
			this._currentWidth = value * (this._widthMax / max_size);
			
			if (!this._fon.hasEventListener(Event.ENTER_FRAME)) 
			{
				this._fon.addEventListener(Event.ENTER_FRAME, setCurrentWidth);
			}
			
			if(!useSpeedEffect)
			{
				this._fon.width = this._currentWidth;
			}
		}
		
		public function setBuffersize(value:Number, max_size:Number = 100):void 
		{
			this._currentBufferWidth = value * (this._widthMax / max_size);
			this._twener.completeNow();
			this._twener.element = this._buffer;
			
			this._twener.start = this._buffer.width;
			this._twener.stop = this._currentBufferWidth;
			this._twener.property = "width";
			this._twener.go();
			
		}
		
		private function setCurrentWidth(e:Event):void 
		{
			this._fon.width += (this._currentWidth - this._fon.width) / this._speedEffect;
			
			if ((this._currentWidth - this._fon.width) / this._speedEffect < 0.5)
			{
				this._fon.width += 0.5;
			}
			
			if (this._currentWidth - this._fon.width >=-.5 && this._currentWidth - this._fon.width <= .5) 
			{
				this.removeEventListener(Event.ENTER_FRAME, setCurrentWidth);
			}
			
			if (this._fon.width >= this._widthMax) 
			{
				dispatchEvent(new Event(StatusBarClick.FULL_POSITION, true));
				this._fon.removeEventListener(Event.ENTER_FRAME, setCurrentWidth)
			}
		}
		
		public function getFonSize(max_size:Number = 100):Number 
		{
			return Math.round(this._fon.width / (this._widthMax / max_size));	
		}

		public function get _w():Number 
		{
			return this._widthMax;
		}
		
		public function set position(value:Number):void 
		{
			if (this._fon.width < this._widthMax)
			{
				this._fon.width = value * (this._widthMax/100);
			}
		}
		
		public function get position():Number 
		{
			return this._currentWidth * (100 / this._widthMax);
		}
		
		/**
		 * Use reposition on mouse click
		 * @param val
		 * 
		 */
		public function set reposition(val:Boolean):void 
		{
			this._reposition = val;
			if (!this._reposition) 
			{
				if (_mc.hasEventListener(MouseEvent.CLICK)) 
				{
					_mc.removeEventListener(MouseEvent.CLICK, goClick);
				}
				_mc.mouseChildren = false;
			}
			else 
			{
				if (!_mc.hasEventListener(MouseEvent.CLICK)) 
				{
					_mc.addEventListener(MouseEvent.CLICK, goClick);
				}
				_mc.mouseChildren = true;
			}
		}
		
		public function set bufferColor(value:uint):void 
		{
			this._bufferColor = value;
			if (this._buffer != null) 
			{
				if (this._mc.contains(this._buffer)) 
				{
					var index:int = this._mc.getChildIndex(this._buffer);
					this._mc.removeChild(this._buffer);
					this._buffer = new Sprite();
					this._buffer.graphics.beginFill(this._bufferColor);
					this._buffer.graphics.drawRect(0, 0, 1, this.height);
					this._buffer.graphics.endFill();
					this._buffer.width = this._currentBufferWidth;
					this._mc.addChildAt(this._buffer,index);
					//this.setChildIndex(this._buffer, index);
				}
			}
		}
		
		public function set flashCount(num:uint):void 
		{
			this._flashCount = num;
		}
		
		public function set speedEffect(num:uint):void 
		{
			this._speedEffect = num;
		}
		
		override public function set width(value:Number):void
		{
			if(this.mask)
			{
				this.mask.width = value; 
			}
			else
			{
				super.width = value;
			}
		}
		
		override public function get width():Number
		{
			if(this.mask)
			{
				return this.mask.width; 
			}
			else
			{
				return super.width;
			}
		}
		
		override public function set height(value:Number):void
		{
			if(this.mask)
			{
				this.mask.height = value; 
			}
			else
			{
				super.height = value;
			}
		}
		
		override public function get height():Number
		{
			if(this.mask)
			{
				return this.mask.height; 
			}
			else
			{
				return super.height;
			}
		}
	}
	
}
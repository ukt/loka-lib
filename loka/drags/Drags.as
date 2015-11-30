package loka.drags {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import loka.button.btnEffect.BtnEffect;


	/**
	 * ...
	 * @author loka
	 */
	
	public class Drags extends EventDispatcher
	{
        protected static var dictionaryUseEl:Dictionary = new Dictionary();
        protected static var MAP_INSTANCE:String = "mapInstance";
        
        public static var instance:DisplayObjectContainer;
		protected var _timmer:Timer;// = new Timer(1000 / 30);
		protected var _x:Number = 0;
		protected var _y:Number = 0;
		protected var _el:DisplayObject;
		protected var _duration:Number = 2;
		private var _drags:Boolean = false;
		public static var DRAGED:String = "DRAGED";
		public static var DRAGED_STOP:String = "dragedStop";
		public static var DRAGED_START:String = "dragedStart";
		
		public function Drags(el:DisplayObject, btnEffect:Boolean = false, duration:Number = 2, fps:uint = 0) 
		{
			dragElement(el, btnEffect, duration, fps);
			super();
		}


		private function dragElement(el:DisplayObject, btnEffect:Boolean = false, duration:Number = 2, fps:uint = 0):DisplayObject 
		{
            if(dictionaryUseEl[el.name] == el)
            {
                return null;
            }
			if(el.stage)
			{
				instance = el.stage as DisplayObjectContainer;  
			}
            dictionaryUseEl[el.name] = el;
            dictionaryUseEl[el.name + MAP_INSTANCE] = this;
			if (this._el == null && el != null) 
			{
                if(duration >= 1)
                {
                    _duration = duration;
                }
				_timmer = new Timer(Math.round(1000 / (fps ? fps : (el.stage?el.stage.frameRate : 30))));
				this._timmer.addEventListener(TimerEvent.TIMER, times);
				this._el = el;
				
				this._x = this._el.x;
				this._y = this._el.y;
				
				if (!(this._el is Sprite)) 
				{
					var mc:Sprite = new Sprite();
					
					var parentMC:DisplayObjectContainer;
					if (this._el.parent) 
					{
						parentMC = this._el.parent; 
						mc.x = this._el.x;
						mc.y = this._el.y;
						
						this._el.x = 0;
						this._el.y = 0;
						if(!(parentMC is Loader)){
							if (parentMC.contains(this._el)) {
								parentMC.removeChild(this._el);
							}else{
								
							}
							parentMC.addChild(mc);							
						}
					}
					
					mc.addChild(this._el);
					this._el = mc;
				}
				
				if (btnEffect)
				{
					new BtnEffect(this._el as Sprite);
				}
                if(!_hide)
                {
                    this._el.addEventListener(MouseEvent.MOUSE_DOWN, go);
                }
				
				
				this.dispatchEvent(new Event(Drags.DRAGED, true, true));
			}
			else 
			{
				trace("not good");
			}
			
			return this._el;
		}
		
		private var _mousePaddingX:Number = 0;
		private var _mousePaddingY:Number = 0;
		
        
		private function go(event:Event):void {
            stop(null);
			if(!_el){
				return;
			}
            _statusMove = true;
			
            if(this._el.parent)
            {
	            if(_zOrdered)
	            {
				    this._el.parent.setChildIndex(this._el, this._el.parent.numChildren - 1 );
	            }
    			this._mousePaddingX = this._el.parent.mouseX - this._el.x; 
    			this._mousePaddingY = this._el.parent.mouseY - this._el.y;
            }else{
                this._mousePaddingX = 0; 
                this._mousePaddingY = 0;
            }

			this._x = this._el.x;
			this._y = this._el.y;
			this._timmer.start();
			this.dispatchEvent(new Event(Drags.DRAGED_START, true));
			
			
//			this._el.removeEventListener(MouseEvent.MOUSE_DOWN, go);
            
            var dispatcher:DisplayObjectContainer = this._el.parent; 
            if(instance){
                dispatcher = instance; 
            }
            dispatcher.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
            dispatcher.addEventListener(MouseEvent.MOUSE_MOVE, updatePoint);
            
		}
		
        private var _statusMove:Boolean = true;
		private function updatePoint(event:Event):void
        {
            if(this._el && this._el.parent)
            {
                _pointMove.x = this._el.parent.mouseX;
                _pointMove.y = this._el.parent.mouseY;
            }
        }
        
		private function mouseUp(event:Event):void
        {
            _statusMove = false;
            var dispatcher:DisplayObjectContainer = this._el.parent; 
            if(instance)
            {
                dispatcher = instance; 
            }
            dispatcher.removeEventListener(MouseEvent.MOUSE_MOVE, updatePoint);
        }
        
        private var _zOrdered:Boolean = true;
		public function zOrdered(value:Boolean = true):Drags {
            _zOrdered = value;
			return this;
        }
        
        private var _hide:Boolean = false;
		public function hide(value:Boolean = true):void
        {
            _hide = value;
            if(this._el){
                if(_hide)
                {
                    this._el.removeEventListener(MouseEvent.MOUSE_DOWN, go);
                }else{
                    this._el.addEventListener(MouseEvent.MOUSE_DOWN, go);
                }
            }
            stop();
        }
        
		public function start():void {
            this.go(null);
        }
        
		public function stop(event:Event = null):void 
		{
            if(!this._el)
            {
                return;
            }
            updatePoint(null);
			this._timmer.stop();
			this._x = this._el.x;
			this._y = this._el.y;
            var dispatcher:DisplayObjectContainer = this._el.parent; 
            
            if(instance){
                dispatcher = instance; 
            }
            
            dispatcher.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
            dispatcher.removeEventListener(MouseEvent.MOUSE_MOVE, updatePoint);
            
            this.dispatchEvent(new Event(Drags.DRAGED_STOP, true));
            
            if(!_hide)
            {
                this._el.addEventListener(MouseEvent.MOUSE_DOWN, go);
            }

		}
		
        private var _pointMove:Point = new Point();
		private function times(event:TimerEvent):void 
		{
            var tmpMoveX:Number = (((this._pointMove.x - this._mousePaddingX - this._el.x)) / _duration); 
            var tmpMoveY:Number = (((this._pointMove.y - this._mousePaddingY - this._el.y)) / _duration); 
			this._el.x += tmpMoveX;
			this._el.y += tmpMoveY;
            
			this._x = this._el.x;
			this._y = this._el.y;
				
            if(Math.abs(tmpMoveX) < .1 && Math.abs(tmpMoveX) < .1)
            {
                if(!_statusMove)
                {
                    stop(null);
                }
            }
            
			if(hasEventListener(Drags.DRAGED))
			{
				this.dispatchEvent(new Event(Drags.DRAGED, true));
			}
            
            if(event as TimerEvent)
            {
                (event as TimerEvent).updateAfterEvent();
            }
		}
		
		public function set duration(value:Number):void
        {
            if(value >= 1){
                this._duration = value;
            }
        }
		public function set _Move(value:Boolean):void 
		{
			if(value)
			{
				this._el.addEventListener(MouseEvent.MOUSE_DOWN, go);
			}
			else 
			{
				this._el.removeEventListener(MouseEvent.MOUSE_DOWN, go);
			}
		}
        public static function dieDrag(el:DisplayObject):Boolean
        {
            if(dictionaryUseEl[el.name])
            {
				delete dictionaryUseEl[el.name];
                (dictionaryUseEl[el.name + MAP_INSTANCE] as Drags).dispose();
                delete dictionaryUseEl[el.name + MAP_INSTANCE];
                return true;
            }
            return false;
        }
        public function get isDrags():Boolean
        {
            return _timmer.running;
        }
		
        public function dispose():void
        {
            stop();
            this._timmer.removeEventListener(TimerEvent.TIMER, times);
            _timmer = null;
            
            this._el.removeEventListener(MouseEvent.MOUSE_DOWN, go);
			dieDrag(this._el);
				
            this._el = null;
        }
		
	}
	
}
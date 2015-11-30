package utils.loka.ui
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	
	
	/**
	 * ...
	 *
	 * @history create Mar 28, 2012 10:04:08 AM
	 * @author g.savenko
	 */    
	public class UIMouse
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
		private static var _padX:Number = 0;
		private static var _padY:Number = 0;
		private static var _DO:DisplayObject;
		private static var _STAGE:Stage;
		private static var init:UIMouse;// = new UIMouse();
		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------
		public function UIMouse(stage:Stage)
		{
			if(_STAGE)
			{
				throw new Error("this OBJEC is single static Class");
			}
			_STAGE = stage;
			
		}
		
		//---------------------------------------------------------------
		//
		//      PRIVATE & PROTECTED METHODS
		//
		//---------------------------------------------------------------
		
		private static function removeMouseListeners():void
		{
//			_STAGE.removeEventListener(Event.ENTER_FRAME, onMoved)
			_STAGE.removeEventListener(MouseEvent.MOUSE_MOVE, onMoved)
			_STAGE.removeEventListener(Event.MOUSE_LEAVE, onMouseLeave);
		}
		
		private static function initMouseListeners():void
		{
			_STAGE.addEventListener(MouseEvent.MOUSE_MOVE, onMoved)
			_STAGE.addEventListener(Event.MOUSE_LEAVE, onMouseLeave);
		}
		
		//---------------------------------------------------------------
		//
		//      EVENT HANDLERS
		//
		//---------------------------------------------------------------
		
		private static var _speedDrag:Number = 2; 
		protected static function onMoved(event:MouseEvent):void
		{
			var rect:Rectangle = _STAGE.getRect(_STAGE);
			
			if (rect.contains(_STAGE.mouseX, _STAGE.mouseY) && !_DO.visible)
			{
				_DO.visible = true;
			}
			
			_DO.x += ((_STAGE.mouseX + _padX) - _DO.x) / _speedDrag;
			_DO.y += ((_STAGE.mouseY + _padY) - _DO.y) / _speedDrag;
			_STAGE.addChild(_DO);
//			event.updateAfterEvent();
		}
		
		protected static function onMouseLeave(event:Event):void
		{
			_DO.visible = false;
		}
		
		//---------------------------------------------------------------
		//
		//      PUBLIC METHODS
		//
		//---------------------------------------------------------------
		public static function INIT(stage:Stage):void
		{
			init = new UIMouse(stage);
		}
		
		public static function HIDE():void
		{
			removeMouseListeners();
			Mouse.show();
			if(_DO && _STAGE && _STAGE.contains(_DO))
			{
				_STAGE.removeChild(_DO);
			}
		}
		
		public static function SHOW(DO:DisplayObject = null, padX:Number = 0, padY:Number = 0, showNativeCursor:Boolean = false, speedRatio:Number = 2):void
		{
			_speedDrag = speedRatio;
			
			if(_DO)
			{
				if(_STAGE.contains(_DO))
				{
					_STAGE.removeChild(_DO);
				}
			}
			
			if(DO)
			{
				_padX = padX;
				_padY = padY;
				_DO = DO;
				if(_DO is DisplayObjectContainer)
				{
					DisplayObjectContainer(_DO).mouseChildren = false;
					DisplayObjectContainer(_DO).mouseEnabled = false;
					DisplayObjectContainer(_DO).cacheAsBitmap = true;
				}
			}
			
			if(_DO)
			{
				if (!showNativeCursor)
				{
					Mouse.hide();
				}
				
				/*if(_DO is MovieClip)
				{
					MovieClip(_DO).mouseEnabled = false;
					MovieClip(_DO).mouseChildren = false;
				}*/
				initMouseListeners();
				_STAGE.addChild(_DO);
				
				_DO.x = _STAGE.mouseX + _padX;
				_DO.y = _STAGE.mouseY + _padY;
			}
		}
		
		
		//---------------------------------------------------------------
		//
		//      ACCESSORS
		//
		//---------------------------------------------------------------
	}
}
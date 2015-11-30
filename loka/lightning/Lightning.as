package loka.lightning
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	
	/**
	 * ...
	 *
	 * @history create Sep 26, 2012 3:37:32 PM
	 * @author g.savenko
	 */    
	public class Lightning extends Sprite
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
		private var _ptStart:Point;
		private var _ptFinish:Point;
		private var _lightElement:LightElementVer2;
		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------
		/**
		 *TO DO:
		 * Настроить правильное расположение от точки к точке
		 * Нужно добавить риалтаймовое обновление точек
		 * @param ptStart
		 * @param ptFinish
		 * 
		 */
		public function Lightning(ptStart:Point, ptFinish:Point)
		{
			super();
			
			_ptStart	= ptStart;
			_ptFinish	= ptFinish;
			
			init();
		}
		
		//---------------------------------------------------------------
		//
		//      PRIVATE & PROTECTED METHODS
		//
		//---------------------------------------------------------------
		
		
		//---------------------------------------------------------------
		//
		//      EVENT HANDLERS
		//
		//---------------------------------------------------------------
		
		protected function onEnter(event:Event):void
		{
			_lightElement.update();
//			var dt:Number = 45;
//			_lightElement.rotation += Math.random() * dt - dt * .5;
		}
		
		//---------------------------------------------------------------
		//
		//      PUBLIC METHODS
		//
		//---------------------------------------------------------------
		public function init():void
		{
			_lightElement = new LightElementVer2(_ptStart, _ptFinish, 1);
			var dis:Number = Point.distance(_ptStart, _ptFinish);//Получаем расстояние между точками
//			var angl:Number = Math.round(Math.acos((_ptFinish.x - _ptStart.x) / dis) / Math.PI * 180);
//			_lightElement.rotation = angl;
//			_lightElement.y = _ptStart.y;
//			_lightElement.x = _ptStart.x;
			addChild(_lightElement);
			addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		
		//---------------------------------------------------------------
		//
		//      ACCESSORS
		//
		//---------------------------------------------------------------
	}
}
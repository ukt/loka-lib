package utils.loka.asUtils.updater
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	
	import utils.loka.globalInterface.IDispose;
	import utils.loka.ui.uiI.IAlive;
	import utils.loka.ui.uiI.ITicker;
	import utils.loka.ui.vo.TickVO;
	
	public class Updater implements IUpdater
	{
		protected var _list:Vector.<ITicker>;
		protected var DO:DisplayObject;
		public function Updater(DO:DisplayObject)
		{
			_list = new Vector.<ITicker>();
			this.DO = DO;
			DO.addEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		private var _lastTime:Number;
		private var _currentTime:Number;
		
		private function onUpdate(event:Event = null):void
		{
			
			var dt:Number = (_currentTime - _lastTime);
			_lastTime = _currentTime;
			_currentTime = getTimer();
			
			var updateVO:TickVO	= new TickVO();
			updateVO.dt 		= dt;
//			updateVO.rect 		= new RectVO(0,0, instance.stage.stageWidth, instance.stage.stageHeight);
			var arrIsAlivable:Array = []
			for each(var c:ITicker in _list) 
			{
//				if((c is IDispose && !IDispose(c).isDispose) && c.isTick && DisplayObject(c).stage)
				if(
					(
						c is IDispose 
						&& 
						!IDispose(c).isDispose
					) 
					&& 
					c.isTick
				)
				{
					c.tick(updateVO);
				}
				
				if(
					c is IAlive
					&&
					!IAlive(c).isAlive
				)
				{
					arrIsAlivable.push(c);
				}
			}
			
			for each(var needDisposeItem:IDispose in arrIsAlivable)
			{
				needDisposeItem.dispose();
			}
			
			if(event is TimerEvent)
			{
				(event as TimerEvent).updateAfterEvent();
			}
		}
		
		public function addUpdater(value:ITicker):void
		{
			if(_list.indexOf(value) == -1)
			{
				_list.push(value);
			}
		}
		
		public function removeUpdater(value:ITicker):void
		{
			var index:uint = _list.indexOf(value);
			if(index != -1)
			{
				_list.splice(index, 1);
			}
		}
		
		public function dispose():void
		{
			_isDispose = true;
			DO.removeEventListener(Event.ENTER_FRAME, onUpdate);
		}
		
		protected var _isDispose:Boolean = false;
		public function get isDispose():Boolean
		{
			return _isDispose;
		}
	}
}
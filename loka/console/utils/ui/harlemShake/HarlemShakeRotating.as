package utils.loka.console.utils.ui.harlemShake
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.setTimeout;

	public class HarlemShakeRotating
	{
		private var _DO:DisplayObject;
		private var _duration:Number;
		private var _DOrotation:Number;
		private var _DOrotationTo:Number;
		private var _DOrotationNow:Number;
		
		public function HarlemShakeRotating(DO:DisplayObject)
		{
			this._DO = DO;			
			_DOrotation = DO.rotation;
			setTimeout(start, 5000);
			start();
		}
		
		private function start():void
		{
			_duration = .2 + Math.random();
			_DOrotationNow = _DOrotation;
			_DOrotationTo = _DOrotation + 360
			_DO.addEventListener(Event.ENTER_FRAME, rotate);
			
		}
		
		protected function rotate(event:Event):void
		{
			if((_DOrotationTo - _DOrotationNow) * _duration < .1 ) {
				_DO.removeEventListener(Event.ENTER_FRAME, rotate);
				setTimeout(start, 5000);
				_DO.rotation = _DOrotation;
				return;
			}
			_DOrotationNow += (_DOrotationTo - _DOrotationNow) * _duration;
			_DO.rotation = _DOrotationNow; 
		} 
	}
}
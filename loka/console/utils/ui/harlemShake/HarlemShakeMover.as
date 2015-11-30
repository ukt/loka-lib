package utils.loka.console.utils.ui.harlemShake
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	public class HarlemShakeMover
	{
		private var _DO:DisplayObject;
		private var _duration:Number;
		public function HarlemShakeMover(DO:DisplayObject)
		{
			this._DO = DO;
			_duration = Math.random()*.5;
			start();
		}
		
		private function start():void
		{
			_DO.addEventListener(Event.ENTER_FRAME, scaleX);
			
		}
		
		protected function scaleX(event:Event):void
		{
			_DO.scaleX += (2 - _DO.scaleX) * _duration;
			_DO.scaleY += (.5 - _DO.scaleY) * _duration;
			if(_DO.scaleX > 1.8){
				_DO.removeEventListener(Event.ENTER_FRAME, scaleX);
				_DO.addEventListener(Event.ENTER_FRAME, scaleY);
			}
			
		}
		
		protected function scaleY(event:Event):void
		{
			_DO.scaleX += (.5 - _DO.scaleX) * _duration;
			_DO.scaleY += (2 - _DO.scaleY) * _duration;
			if(_DO.scaleY > 1.8){
				_DO.removeEventListener(Event.ENTER_FRAME, scaleY);
				_DO.addEventListener(Event.ENTER_FRAME, scaleX);
			}
			
		}
	}
}
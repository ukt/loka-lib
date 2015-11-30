package loka.ui.uiManager.aniController
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 *
	 * @history create Jun 27, 2012 3:50:26 PM
	 * @author g.savenko
	 */    
	public class AniOncePlayAnimation
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
		private var _ani:MovieClip;

		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------
		public function AniOncePlayAnimation(ani:MovieClip)
		{
			_ani = ani;
			_ani.addEventListener(Event.ENTER_FRAME, onEnter);
			_ani.mouseChildren = false;
			_ani.mouseEnabled = false;
		}
		
		protected function onEnter(event:Event):void
		{
			// TODO Auto-generated method stub
			if(_ani.currentFrame == _ani.totalFrames)
			{
				_ani.removeEventListener(Event.ENTER_FRAME, onEnter);
				if(_ani.parent)
				{
					_ani.parent.removeChild(_ani);
					if(_ani.hasOwnProperty("dispose"))
					{
						_ani["dispose"]();
					}
					_ani = null;
				}
			}
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
		
		
		//---------------------------------------------------------------
		//
		//      PUBLIC METHODS
		//
		//---------------------------------------------------------------
		
		
		//---------------------------------------------------------------
		//
		//      ACCESSORS
		//
		//---------------------------------------------------------------
		
		public function get ani():MovieClip
		{
			return _ani;
		}

	}
}
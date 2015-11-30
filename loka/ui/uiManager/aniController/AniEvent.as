package loka.ui.uiManager.aniController
{
	import flash.events.Event;
	
	
	/**
	 * ...
	 *
	 * @history create May 12, 2012 12:38:15 AM
	 * @author g.savenko
	 */    
	public class AniEvent extends Event
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		public static const ON_STATE_END:String = "ON_STATE_END";
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
//		public var data:AniState;
		private var _prevState:AniControllerState;
		private var _prevFrame:int;
		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------
		public function AniEvent(type:String, prevState:AniControllerState, prevFrame:int)
		{
			this._prevState = prevState;
			this._prevFrame = prevFrame;
			super(type, false, false);
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

		public function get prevFrame():int
		{
			return _prevFrame;
		}

		public function get prevState():AniControllerState
		{
			return _prevState;
		}

	}
}
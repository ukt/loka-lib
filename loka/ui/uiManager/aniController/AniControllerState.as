package loka.ui.uiManager.aniController
{
	
	/**
	 * ...
	 *
	 * @history create Apr 18, 2012 10:16:02 PM
	 * @author g.savenko
	 */    
	public class AniControllerState
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
		private var _label:String;
		private var _frameSet:int;
		private var _frameGroup:String;
		private var _length:uint;
		private var _frame:uint;
		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------
		public function AniControllerState(label:String, length:uint, frame:uint, frameGroup:String, frameSet:int)
		{
			_label		= label;
			_length		= length;
			_frame		= frame;
			_frameSet	= frameSet;
			_frameGroup = frameGroup;
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

		public function get frameGroup():String
		{
			return _frameGroup;
		}

		public function get frameSet():int
		{
			return _frameSet;
		}

		public function get frame():uint
		{
			return _frame;
		}

		public function get length():uint
		{
			return _length;
		}

		public function get label():String
		{
			return _label;
		}

	}
}
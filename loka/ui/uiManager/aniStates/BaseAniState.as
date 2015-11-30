package loka.ui.uiManager.aniStates
{
	import loka.ui.uiManager.aniController.AniEvent;
	import loka.ui.vo.TickVO;
	
	
	/**
	 * ...
	 *
	 * @history create Sep 3, 2012 9:56:56 AM
	 * @author g.savenko
	 */    
	public class BaseAniState implements IAniState
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
		protected var _ani:BasesAnimationStatesMovieClip;
		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------
		public function BaseAniState(ani:BasesAnimationStatesMovieClip)
		{
			_ani = ani;
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
		public function activate(reasone:* = null):void
		{
			
		}
		
		public function deactivate():void
		{
			
		}
		
		public function tick(data:TickVO):void
		{
			
		}
		
		public function get isTick():Boolean
		{
			return true;
		}
		
		public function gotoState(state:String):void
		{
			_ani.gotoState(state);
		}
		
		public function dispose():void
		{
			
		}
		
		public function onStateEnd(event:AniEvent):void
		{
			
		}
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
		
		protected var _isDispose:Boolean = false;
		public function get isDispose():Boolean
		{
			return _isDispose; 
		}
		
		public function get alias():String
		{
			throw new Error("need override this method");
		}
	}
}
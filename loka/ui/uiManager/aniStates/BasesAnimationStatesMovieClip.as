package loka.ui.uiManager.aniStates
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import loka.ui.ModernSprite;
	import loka.ui.uiManager.aniController.AniController;
	import loka.ui.uiManager.aniController.AniEvent;
	import loka.ui.vo.TickVO;
	
	
	/**
	 * ...
	 *
	 * @history create Sep 3, 2012 9:11:28 AM
	 * @author g.savenko
	 */    
	public class BasesAnimationStatesMovieClip extends ModernSprite
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
		protected var _ani:MovieClip;

		protected var _aniController:AniController;
		protected var _currentAniState:IAniState;
		private var _aniList:Dictionary = new Dictionary();
		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------
		public function BasesAnimationStatesMovieClip()
		{
			super();
		}
		
		//---------------------------------------------------------------
		//
		//      PRIVATE & PROTECTED METHODS
		//
		//---------------------------------------------------------------
		protected override function init(e:Event=null):void
		{
			super.init(e);
			_aniList = new Dictionary();
			_aniController = new AniController(createAni());
			_ani = _aniController.ani; 
//			_currentAniState = _aniList[registerAniStates()];
			gotoState(registerAniStates())
			_aniController.addEventListener(AniController.ON_STATE_END, onStateEnd);
		}
		
		protected function addAniState(state:IAniState):void
		{
			_aniList[state.alias] = state;
		}
		
		protected function registerAniStates():String
		{
			throw new Error("need overrride this method");
		}
		
		protected function createAni():MovieClip
		{
			throw new Error("need overrride this method: createAni");
		}
		
		//---------------------------------------------------------------
		//
		//      EVENT HANDLERS
		//
		//---------------------------------------------------------------
		
		private function onStateEnd(event:AniEvent):void
		{
			_currentAniState.onStateEnd(event);
		}
		//---------------------------------------------------------------
		//
		//      PUBLIC METHODS
		//
		//---------------------------------------------------------------
		public function playState(state:String):void
		{
			_aniController.playState(state);
		}
		
		public function gotoState(state:String):void 
		{
			if(_currentAniState)
			{
				_currentAniState.deactivate();
			}
			_currentAniState = IAniState(_aniList[state]);
			_currentAniState.activate();
			
			playState(state);
		}
		
		
		override public function tick(data:TickVO):void
		{
			super.tick(data);
			
			_currentAniState.tick(data);
			_aniController.tick(data);
		}
		
		override public function dispose():void
		{
			_ani = null;
			_aniController.dispose();
			_currentAniState.dispose();
			
			_currentAniState = null;
			_aniController = null;
			
			for (var aniStateAlias:String in _aniList)
			{
				IAniState(_aniList[aniStateAlias]).dispose();
				delete _aniList[aniStateAlias];
			}
			
			_aniList = null;
			
			super.dispose();
		}
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
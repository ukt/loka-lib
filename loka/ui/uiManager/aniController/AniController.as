package utils.loka.ui.uiManager.aniController
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import utils.loka.ui.vo.TickVO;
	
	/**
	 * ...
	 *
	 * @history create Mar 23, 2012 8:52:03 AM
	 * @author g.savenko
	 */	
	public class AniController extends EventDispatcher implements IAniController
	{
		//------------------------------------------------
		//	  Class constants
		//------------------------------------------------
		
		//------------------------------------------------
		//	  StaticVariables
		//------------------------------------------------
		public static var ON_STATE_END:String = "ON_STATE_END";
		public static var ON_STATE_UPDATE:String = "ON_STATE_UPDATE";
		
		//------------------------------------------------
		//	  Variables
		//------------------------------------------------
		
		private var _aniStates:Dictionary = new Dictionary();
		private var _ani:MovieClip = new MovieClip();
		private var _currentFrame:uint = 0;
		//---------------------------------------------------------------
		//
		//	  CONSTRUCTOR
		//
		//---------------------------------------------------------------
		public function AniController(ani:MovieClip, isTick:Boolean = true)
		{
			_ani = ani;
			var i:uint;
			for(i = 0; i < ani.currentLabels.length-1; i++) 
			{
				if(FrameLabel(ani.currentLabels[i]).frame >= FrameLabel(ani.currentLabels[i+1]).frame)
				{
					throw new Error("We need better algorithm to analize frames");
				}
			}
			var result:Boolean = false;
			for(i = 0; i < ani.currentLabels.length; i++)
			{
				var frameLabel:FrameLabel = FrameLabel(ani.currentLabels[i]);
				var length:uint = i < ani.currentLabels.length - 1 ? FrameLabel(ani.currentLabels[i + 1]).frame - frameLabel.frame : ani.totalFrames + 1 - frameLabel.frame;
				var label:String = frameLabel.name;
				var idx:int = label.lastIndexOf("_"); 
				if(idx != -1 && idx != label.length-1)
				{
					var frameSet:int = parseInt(label.substr(idx+1));
					if(!_aniStates[frameSet])
					{
						_aniStates[frameSet] = new Dictionary();
					}
//					_ani.cu
					var state:String = label.substr(0, idx);
					if(!_aniStates[frameSet][state])
					{
						_aniStates[frameSet][state] = new AniControllerState(frameLabel.name, length, frameLabel.frame, state, frameSet);
						result = true;
					}
					else
					{
						throw new Error("Animation state name error");
					}
					
//					_states[state] = state;
				}
			}
			if(!result)
			{
				trace("hmmm");
			}
			_ani.gotoAndStop(0);
			
			if(!isTick)
			{
				_ani.addEventListener(Event.ENTER_FRAME, onEnter);
			}
		}
		
		private var _lastTime:Number;
		private var _currentTime:Number;
		protected function onEnter(event:Event):void
		{
			// TODO Auto-generated method stub
			var dt:Number = (_currentTime - _lastTime);
			_lastTime = _currentTime;
			_currentTime = getTimer();
			
			var updateVO:TickVO	= new TickVO();
			updateVO.dt 		= dt;
			tick(updateVO);
//			updateVO.rect 		= new RectVO(0,0, _ani.stage.stageWidth, _ani.stage.stageHeight);
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			super.removeEventListener(type, listener, useCapture);
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		//---------------------------------------------------------------
		//
		//	  PRIVATE & PROTECTED METHODS
		//
		//---------------------------------------------------------------
		
		public function get ani():MovieClip
		{
			return _ani;
		}

		private function getRandomState(name:String):AniControllerState
		{
			var arr:Array = [];
			var result:AniControllerState;
			for each(var c:Dictionary in _aniStates)
			for each(result in c)
			{
				if(result.frameGroup == name)
				{
					arr.push(result.frameSet);
					//return result;
				}
			}
			
			return getState(name + "_" + arr[int(Math.random() * (arr.length))]);
		}
		
		private function getState(name:String):AniControllerState
		{ 
//			name = name.split("_")[0];
			var result:AniControllerState;
			for each(var c:Dictionary in _aniStates)
				for each(result in c)
				{
					if(result.label == name)
					{
						return result;
					}
				}
			
			return result;
		}
		
		//---------------------------------------------------------------
		//
		//	  EVENT HANDLERS
		//
		//---------------------------------------------------------------
		
		
		//---------------------------------------------------------------
		//
		//	  PUBLIC METHODS
		//
		//---------------------------------------------------------------
		private var _isTick:Boolean = true;
		public function get isTick():Boolean
		{
			return _isTick;
		}
		
		private var _doubleDispatch:Boolean = false;
		public function tick(data:TickVO):void
		{
			_percent = (100 / _prevState.length) * (_ani.currentFrame - _prevState.frame)
			var changeStates:Boolean = false;
			if(_ani.currentFrame == _ani.totalFrames)
			{
				changeStates = true;
			}
			_ani.nextFrame();
			
			if(_prevState.label != _ani.currentLabel)
			{
				changeStates = true;
				_currentState = getState(_ani.currentLabel);
			}
			ani.dispatchEvent(new AniEvent(ON_STATE_UPDATE, prevState, prevFrame));
			dispatchEvent(new AniEvent(ON_STATE_UPDATE, prevState, prevFrame));
			if(changeStates)
			{
				var prevState:AniControllerState = _prevState;
				var prevFrame:int = _ani.currentFrame - 1;
				if(_howToRepeat == 0)
				{
					playState(_prevState.frameGroup, _repeatCount);
				} 
				else if(_repeatCount > 0) 
				{
					_repeatCount--;
					if(_repeatCount)
					{
						playState(_prevState.frameGroup, _repeatCount);
					}
				}
				else if(_repeatCount < 0)
				{
					pause(prevFrame);
				}
				else{
					
				}
//				_prevState = _currentState;
				
				if(!_doubleDispatch)
				{
					_doubleDispatch = true;
					ani.dispatchEvent(new AniEvent(ON_STATE_END, prevState, prevFrame));
					dispatchEvent(new AniEvent(ON_STATE_END, prevState, prevFrame));
				}
			}
			
			
		}
		
		
		private var _prevState:AniControllerState;
		private var _currentState:AniControllerState;
		
		/**
		 *	=0 repeat and repeat
		 *	>0 count to repeat play, after play next frame
		 *	<0 once play ani state 
		 */
		private var _howToRepeat:int = 0;
		private var _repeatCount:int= 0; 
		/**
		 * 
		 * @param state
		 * @param repeatCount:
		 * 
		 * =0 repeat and repeat
		 * >0 count to repeat play, after play next frame
		 * <0 once play ani state
		 * 
		 */
		public function playState(state:String, repeatCount:int = 0):void
		{
			_doubleDispatch = false;
			/*if(prevState)
			{
				var prevState:AniState = getRandomState(_prevState.frameGroup);
	//			if(!_prevState || (_prevState && _prevState != _currentState))
				
			}*/
//			if(!prevState /*|| (prevState && prevState != _currentState)*/)
			{
				_prevState = _currentState = getRandomState(state);
				_ani.gotoAndStop(_currentState.frame);
				_repeatCount = repeatCount;
				_howToRepeat = _repeatCount; 
				/*
				switch(_repeatCount)
				{
					case 0:
						_repeatAlways = 1;
						break;
					case 0:
						_repeatAlways = 0;
						break;
					case -1:
						_repeatAlways = -1;
						break;
				}*/
//				_repeatAlways = !Boolean(_repeatCount);
			}
		}
		private var _percent:Number = 0;
		public function get currentStatePercent():Number
		{
			return _percent;
		}
		
		public function playStatePercent(state:String, value:Number, maxValue:Number = 100):void
		{
			if(value < 0 )
			{
				value = 0;
			}
			if(value > maxValue)
			{
				value = maxValue;
//				_prevState = _currentState = getState(state);
//				_ani.gotoAndStop(uint((maxValue / _currentState.length) * value) + _currentState.frame); 
			}
			else
			{
//				throw new Error("need think");
			}
			_percent = (100 / maxValue) * value;
			_prevState = _currentState = getState(state);
			
			_ani.gotoAndStop(uint((_currentState.length / maxValue) * value) + _currentState.frame);
		}
		
		public function gotoNextFrame():void
		{
			_ani.gotoAndStop(_currentFrame++);
		}
		
		public function start(frame:int = 0):void
		{
			if(!frame)
			{
				_ani.stop();
			}
			else
			{
				_ani.gotoAndStop(frame);
			}
		}
		
		public function pause(frame:int = 0):void
		{
			if(!frame)
			{
				_ani.stop();
			}
			else
			{
				_ani.gotoAndStop(frame);
			}
		}
		
		//---------------------------------------------------------------
		//
		//	  ACCESSORS
		//
		//---------------------------------------------------------------
		
		
		public function get prevState():AniControllerState
		{
			return _prevState;
		}
		
		public function get currentState():AniControllerState
		{
			return _currentState; 
		}
		
		protected var _isDispose:Boolean = false;
		public function get isDispose():Boolean
		{
			return _isDispose; 
		}
		
		public function dispose():void
		{
			_ani.removeEventListener(Event.ENTER_FRAME, onEnter);
			_ani = null;
			_aniStates = null;
			_isDispose = true;
		}
	}
}
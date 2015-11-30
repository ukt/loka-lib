package loka.ui.uiManager.aniController
{
	import loka.globalInterface.IDispose;
	import loka.ui.uiI.ITicker;

	public interface IAniController extends ITicker, IDispose
	{
		function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void;
		function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void;
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
		function playState(state:String, repeatCount:int = 0):void;
		function get currentStatePercent():Number;
		function playStatePercent(state:String, value:Number, maxValue:Number = 100):void;
		function gotoNextFrame():void;
		function start(frame:int = 0):void;
		function pause(frame:int = 0):void;
		function get prevState():AniControllerState
		function get currentState():AniControllerState;
	}
}
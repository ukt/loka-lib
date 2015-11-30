package loka.ui.uiManager.aniStates
{
	import loka.globalInterface.IActivateDeactivate;
	import loka.globalInterface.IDispose;
	import loka.ui.uiI.ITicker;
	import loka.ui.uiManager.aniController.AniEvent;

	public interface IAniState extends IDispose, ITicker, IActivateDeactivate
	{
		function onStateEnd(event:AniEvent):void;
		function get alias():String;
	}
}
package utils.loka.ui.uiManager.aniStates
{
	import utils.loka.globalInterface.IActivateDeactivate;
	import utils.loka.globalInterface.IDispose;
	import utils.loka.ui.uiI.ITicker;
	import utils.loka.ui.uiManager.aniController.AniEvent;

	public interface IAniState extends IDispose, ITicker, IActivateDeactivate
	{
		function onStateEnd(event:AniEvent):void;
		function get alias():String;
	}
}
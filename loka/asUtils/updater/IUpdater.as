package utils.loka.asUtils.updater
{
	import utils.loka.globalInterface.IDispose;
	import utils.loka.ui.uiI.ITicker;

	public interface IUpdater extends IDispose
	{
		function addUpdater(value:ITicker):void;
		function removeUpdater(value:ITicker):void;
		
	}
}
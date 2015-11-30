package loka.asUtils.updater
{
	import loka.globalInterface.IDispose;
	import loka.ui.uiI.ITicker;

	public interface IUpdater extends IDispose
	{
		function addUpdater(value:ITicker):void;
		function removeUpdater(value:ITicker):void;
		
	}
}
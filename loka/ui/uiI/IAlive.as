package utils.loka.ui.uiI
{
	import utils.loka.globalInterface.IDispose;

	public interface IAlive extends IDispose
	{
		function get isAlive():Boolean;
		function set isAlive(value:Boolean):void;
	}
}
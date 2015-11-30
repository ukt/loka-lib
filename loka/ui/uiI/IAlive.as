package loka.ui.uiI
{
	import loka.globalInterface.IDispose;

	public interface IAlive extends IDispose
	{
		function get isAlive():Boolean;
		function set isAlive(value:Boolean):void;
	}
}
package loka.ui.uiI
{
	import loka.globalInterface.IDispose;
	import loka.ui.vo.TickVO;

	public interface ITicker extends IDispose
	{
		function tick(data:TickVO):void;
		function get isTick():Boolean;
	}
}
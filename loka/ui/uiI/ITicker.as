package utils.loka.ui.uiI
{
	import utils.loka.globalInterface.IDispose;
	import utils.loka.ui.vo.TickVO;

	public interface ITicker extends IDispose
	{
		function tick(data:utils.loka.ui.vo.TickVO):void;
		function get isTick():Boolean;
	}
}
package utils.loka.app.controller.command.network.amf
{
	import utils.loka.app.controller.command.ICommand;

	/**
	 * 
	 * @author loka
	 * 
	 */
	public interface INetworkCommand extends ICommand
	{
		function get method():String;
		function get parrams():Object;
	}
}
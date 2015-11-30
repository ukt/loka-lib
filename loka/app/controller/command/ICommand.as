package utils.loka.app.controller.command
{
	import utils.loka.app.controller.Controller;

	/**
	 * 
	 * @author loka
	 * 
	 */
	public interface ICommand
	{
		function onResult(data:Object):void;
		function onFault(data:Object):void;
		function call(onRezult:Function = null, onFault:Function = null, parrrams:Object = null, controller:Controller = null):void;
	}
}
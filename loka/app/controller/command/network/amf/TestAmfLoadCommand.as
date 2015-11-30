package utils.loka.app.controller.command.network.amf
{

	/**
	 * 
	 * @author loka
	 * 
	 */
	public class TestAmfLoadCommand extends BaseNetwokCommand
	{
		public function TestAmfLoadCommand(method:String = "", onRezult:Function=null, onFault:Function=null)
		{
			method = "Bootstrap.load";
			super(method, onRezult, onFault);
		}
		
		override public function onResult(data:Object):void
		{
			super.onResult(data);
		}
	}
}
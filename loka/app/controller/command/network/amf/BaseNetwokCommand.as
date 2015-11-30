package utils.loka.app.controller.command.network.amf
{
	import utils.loka.app.controller.Controller;
	import utils.loka.app.controller.command.network.AmfNetwornk;

	/**
	 * 
	 * @author loka
	 * 
	 */
	public class BaseNetwokCommand implements INetworkCommand
	{
		private var _onRezult:Function;
		private var _onFault:Function;
		private var _method:String;
		private var _parrams:Object;
		
		public function BaseNetwokCommand(method:String = "", onRezult:Function = null, onFault:Function = null, params:Object = null)
		{
			_method = method;
			_onRezult = onRezult;
			_onFault = onFault;
			_parrams = params;
		}
		
		public function call(onRezult:Function = null, onFault:Function = null, parrrams:Object = null, controller:Controller = null):void
		{
			AmfNetwornk.instance.call(this);
		}
		
		public function onResult(data:Object):void
		{
			if(_onRezult != null)
			{
				if(_onRezult.length > 0)
				{
					_onRezult(data);
				}
				else
				{
					_onRezult();
				}
			}
		}
		
		public function onFault(data:Object):void
		{
			if(_onFault != null)
			{
				if(_onFault.length > 0)
				{
					_onFault(data);
				}
				else
				{
					_onFault();
				}
			}
		}
		
		public function get parrams():Object
		{
			return _parrams;
		}
		
		public function get method():String
		{
			return _method;
		}
	}
}
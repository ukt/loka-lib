package utils.loka.app.controller.command
{
	import utils.loka.app.controller.Controller;
	import utils.loka.app.controller.event.BaseEvent;

	/**
	 * 
	 * @author loka
	 * 
	 */
	public class BaseCommand implements ICommand
	{
		private var _controller:Controller;
		private var _onResult:Function;
		private var _onFault:Function;
		private var _name:String;
		protected var _parrams:*;
		
		public function BaseCommand(name:String)
		{
			_name = name;
		}
		
		public function onResult(data:Object):void
		{
			if(_onResult != null)
			{
				if(_onResult.length > 0)
				{
					_onResult(data);
				}
				else
				{
					_onResult();
				}
			}
			_controller.dispatchEvent(new BaseEvent(_name, false, false, data));
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
		
		public function call(onResult:Function = null, onFault:Function = null, parrams:Object=null, controller:Controller = null):void
		{
			_parrams	= parrams;
			_onResult	= onResult;
			_onFault 	= onFault;
			_controller	= controller;
			execute();
		}
		
		protected function execute():void
		{
			
		}
	}
}
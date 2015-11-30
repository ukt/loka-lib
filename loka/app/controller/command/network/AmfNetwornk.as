package utils.loka.app.controller.command.network
{
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	import utils.loka.app.controller.command.network.amf.INetworkCommand;
	import utils.loka.console.Console;
	
	/**
	 * 
	 * @author loka
	 * 
	 */
	public class AmfNetwornk extends EventDispatcher
	{
		public static var instance:AmfNetwornk
		private var _gateway:String;
		private var _connection:NetConnection;
		private var _responder:Responder;
		
		private var _pull:Vector.<INetworkCommand> = new Vector.<INetworkCommand>();
		private var _free:Boolean = true;

		private var _command:INetworkCommand;
		public function AmfNetwornk(gateway:String, target:IEventDispatcher=null)
		{
			super(target);
			_gateway = gateway;
			_responder = new Responder(onResult, onFault);
			
			Console.write("AmfNetwornk INIT");
			initConnection();
			instance = this;
		}
		
		private function removeConnection():void
		{
			_connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onFault)
			_connection.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onFault)
			_connection.removeEventListener(IOErrorEvent.IO_ERROR, onFault)
			_connection.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus)
			_connection.objectEncoding = ObjectEncoding.AMF3;
			_connection.close();
		}
		
		private function initConnection():void
		{
			if(_connection)
			{
				removeConnection();
			}
			
			_connection = new NetConnection();
			_connection.addEventListener(Event.ACTIVATE, onInit);
			_connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onFault)
			_connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onFault)
			_connection.addEventListener(IOErrorEvent.IO_ERROR, onFault)
			_connection.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus)
			_connection.objectEncoding = ObjectEncoding.AMF3;
			_connection.connect(_gateway);
		}
		
		protected function onNetStatus(event:NetStatusEvent):void
		{
			// TODO Auto-generated method stub
			trace("!!!");
			_free = true;
		}
		
		protected function onInit(event:Event):void
		{
			// TODO Auto-generated method stub
			Console.write("onInit");
			
			
		}
		
		private function innerCall():void
		{
			if(
				_free
				&&
				_pull.length > 0
			)
			{
				_command = _pull.shift();
				var params:* = "";
				_responder = new Responder(onResult, onFault);
				
//				_connection = new NetConnection();
//				_connection.addEventListener(Event.ACTIVATE, onInit);
//				_connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onFault)
//				_connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onFault)
//				_connection.addEventListener(IOErrorEvent.IO_ERROR, onFault)
//				_connection.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus)
//				_connection.connect(_gateway);
//				_connection.connect(_gateway);
				initConnection();
				_connection.call(_command.method, _responder, _command.parrams);
				Console.write("Call ", Console.GREEN, false);
				Console.write(" method: " + _command.method, Console.GREEY);
			}
		}
		
		public function call(command:INetworkCommand):void
		{
			_pull.push(command);
			innerCall();
		}
		
		public function onComplete( e:Event ):void
		{
			
		}
		
		private function onResult(result:Object):void 
		{
			_free = true;
			// Display the returned data
			Console.write("onResult: " + result);
			_command.onResult(result);
			
			innerCall();
		}
		
		private function onFault(fault:Object):void 
		{
			_command.onFault(fault);
			Console.write("onFault: "+ String(fault.description), Console.RED);
		}
	}
}
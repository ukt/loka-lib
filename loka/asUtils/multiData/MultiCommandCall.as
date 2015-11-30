package utils.loka.asUtils.multiData
{
	import flash.utils.Dictionary;

	public class MultiCommandCall {
		
		private var _dataCall:Dictionary;
		private var _dataRequest:Dictionary;
		
		private var callbackFailtureFunction:Function;
		private var callbackSuccessFunction:Function;
		
		private var _requestCount:uint 		= 0;
		private var _requestMaxCount:uint 	= 0;
		
		private static var ERROR_MAP:String = "error_map";
		
		public function MultiCommandCall() {
			_dataCall = new Dictionary();
			_dataRequest = new Dictionary();
		}
		
		private function calculateCallBacks():void {
			_requestCount++;
			if(_requestCount >= _requestMaxCount) {
				var calbackF:Function;
				if(!_dataRequest.hasOwnProperty(ERROR_MAP)) {
					calbackF = callbackSuccessFunction; 
				} else {
					calbackF = callbackFailtureFunction;
				}
				
				if(calbackF != null) {
					if(calbackF.length > 0) {
						calbackF.apply(null, [_dataRequest]);
					} else {
						calbackF.call();
					}
				}
			}
		}
		
		public function callBackSuccess(name:String, ...parrams):void {
			trace("callBackSuccess");
			_dataRequest[name] = parrams;
			calculateCallBacks();
		}
		
		public function callBackFail(name:String, ...parrams):void {
			trace("callBackFail");
			if(!_dataRequest.hasOwnProperty(ERROR_MAP)) {
				_dataRequest[ERROR_MAP] = {};
				_dataRequest[ERROR_MAP][name] = parrams;
			}
			calculateCallBacks();
		}
		
		public function addCommand(name:String, functionCall:Function, callSuccessCallbackFunctionNum:uint, callFailureCallbackFunctionNum:int=-1, ...parrams):void {
			_dataCall[name] = new DataCall(this, name, functionCall, callSuccessCallbackFunctionNum, callFailureCallbackFunctionNum, parrams);
			_requestMaxCount ++;
		}
		
		public function call(callbackSuccessFunction:Function, callbackFailtureFunction:Function = null):void {
			this.callbackSuccessFunction = callbackSuccessFunction;
			this.callbackFailtureFunction = callbackFailtureFunction;
			for each(var c:DataCall in _dataCall) {
				c.call();
			}
		}
		
	}
}
import utils.loka.asUtils.multiData.MultiCommandCall;

internal class DataCall {
	private var instance:MultiCommandCall;
	private var name:String;
	private var functionCall:Function;
	private var callSuccessCallbackFunctionNum:uint;
	private var callFailureCallbackFunctionNum:int;
	private var parrams:*;
	
	public function DataCall(instance:MultiCommandCall, name:String, functionCall:Function, callSuccessCallbackFunctionNum:uint, callFailureCallbackFunctionNum:int=-1, ...parrams) {
		this.instance = instance;
		this.name = name;
		this.functionCall = functionCall;
		this.callSuccessCallbackFunctionNum = callSuccessCallbackFunctionNum;
		this.callFailureCallbackFunctionNum = callFailureCallbackFunctionNum;
		this.parrams = parrams[0];
	}
	
	public function callSuccess(...paramms):void {
		paramms.unshift(name);
		instance.callBackSuccess.apply(null, paramms);
	}
	
	public function callFail(...paramms):void {
		paramms.unshift(name);
		instance.callBackFail.apply(null, paramms);
	}
	
	public function call():void {
		var parramsList:Array = [];
		
		var count:uint = 0;
		for each(var c:Object in parrams) {
			if(count == callSuccessCallbackFunctionNum) {
				parramsList.push(callSuccess);
			} else if (count == callSuccessCallbackFunctionNum) {
				parramsList.push(callFail);
			} else {
				parramsList.push(c);
			}
			count++;
		}
		
		this.functionCall.apply(null, parramsList); 
	}
}
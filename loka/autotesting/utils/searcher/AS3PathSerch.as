package utils.loka.autotesting.utils.searcher
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	public class AS3PathSerch
	{
		private var root:Stage;
		public function AS3PathSerch(root:Stage)
		{
			this.root = root;
		}
		private var limit:int;
		public function getInstances(commands : String, limit:int = int.MAX_VALUE):Array {
			this.limit = limit;
//			if (!container) {
//				return null;
//			}
			var commandsList:Array = commands.split("/");
			if (commandsList.length == 0) {
				return null;				
			}
			return getInstancesByCommands(this.root, commandsList)
			
		}
		
		private function getInstancesByCommands(container:DisplayObjectContainer, commandsList:Array):Array {
			var result:Array = [];
			var firstCommand : String = commandsList.shift();//[0];;// "=?name:bonus_mc"
			var condition:String = firstCommand.split("?", 1)[0];
			var propertyName:String = "name";
			var propertyValue:String;
			var propertyPaire:Array;
			if(firstCommand.split("?", 2).length>1){
				condition = firstCommand.split("?", 1)[0];
				propertyPaire = firstCommand.split("?", 2)[1].split(":", 2);
			} else {
				condition = "=";
				propertyPaire = firstCommand.split(":", 2);
			}
			
			if(condition == "*") condition = "*=";
			
			if(propertyPaire.length > 1){
				propertyName = propertyPaire[0];
				propertyValue = propertyPaire[1]
			} else{
				propertyName = "name";
				propertyValue = propertyPaire[0];
			}
			
			var child:DisplayObject;
			var resultForFirstCommand:Array = [];
			if(condition.split("*").length>1) {
				resultForFirstCommand = resultForFirstCommand.concat(getInstancesByPropertyAnyWhere(container, condition, propertyName, propertyValue));
			} else {
				resultForFirstCommand = resultForFirstCommand.concat(getInstancesByProperty(container, condition, propertyName, propertyValue));
			}
//			}
			if(commandsList.length > 0) {
				for each(var c:Object in resultForFirstCommand) {
					var resultForNextCommand:Array = getInstancesByCommands(c as DisplayObjectContainer, commandsList.concat());
					
					result = result.concat(resultForNextCommand);
				}
				commandsList.shift();
			} else {
				result = resultForFirstCommand;
			}
			return result;
		}
		
		private function getInstancesByPropertyAnyWhere(container:DisplayObject, condition:String, propertyName:String, propertyValue:String):Array
		{
			var result:Array = [];
			if(condition == "*") condition = "*=";
			if(container is DisplayObjectContainer) {
				var DOC:DisplayObjectContainer = DisplayObjectContainer(container);
				for (var i:int = 0; i < DOC.numChildren; i++) {
					result = result.concat(conditionsObjects(DOC.getChildAt(i), condition, propertyName, propertyValue));
					if(DOC.getChildAt(i) is DisplayObjectContainer) {
						result = result.concat(getInstancesByPropertyAnyWhere(DOC.getChildAt(i), condition, propertyName, propertyValue));
					}
				}
			}
			return result;
		}
		
		private function getInstancesByProperty(container:DisplayObject, condition:String, propertyName:String, propertyValue:String):Array {
			var result:Array = [];
			if(condition == "*") condition = "*=";
			if(container is DisplayObjectContainer) {
				var DOC:DisplayObjectContainer = DisplayObjectContainer(container);
				for (var i:int = 0; i < DOC.numChildren; i++) {
					result = result.concat(conditionsObjects(DOC.getChildAt(i), condition, propertyName, propertyValue));
				}
			}
			return result;
		}		
		
		private function conditionsObjects(DO:DisplayObject, condition:String, propertyName:String, propertyValue:String):Array {
			var result:Array = [];
			switch(condition){
				case "*=":
				case "=":
					if(getProperty(DO, propertyName) == propertyValue) {
						result.push(DO);
					}
					break;
				case "*>":
				case ">":
					if(getProperty(DO, propertyName) > propertyValue) {
						result.push(DO);
					}
					break;
				case "*<":
				case "<":
					if(getProperty(DO, propertyName) < propertyValue) {
						result.push(DO);
					}
					break;
			}
			limit -= result.length;
			return result;
		}
		
		private function getProperty(DO:DisplayObject, propertyName:String):String {
			var result:String = "";
			switch(propertyName){
				case "index":
					result = DO.parent.getChildIndex(DO).toString();
					break;
				default:
					if(DO.hasOwnProperty(propertyName)) {
						result = DO[propertyName];
					}
			}
			return result;
		}
		
	}
}
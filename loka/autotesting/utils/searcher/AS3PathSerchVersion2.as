package loka.autotesting.utils.searcher {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	
	import loka.autotesting.ui.DisplayObjectUtils;
	
	public class AS3PathSerchVersion2 {
		private var root:Stage;
		public function AS3PathSerchVersion2(root:Stage)
		{
			this.root = root;
		}
		private var limit:int;
		public function getInstances(commands : String, limit:int = int.MAX_VALUE):Array {
			return getInstancesByContainer(commands, this.root, limit);
		}

		public function getInstancesByContainer(commands : String, container:DisplayObject, limit:int = int.MAX_VALUE):Array {
			this.limit = limit;
			var commandsList:Array = commands.split("/");
			if (commandsList.length == 0) {
				return null;				
			}
			var result:Array = getInstancesByCommands(container, getCommandList(commandsList));
			removeDuplicate(result);
			return result;
			
		}
		
		private function removeDuplicate(arr:Array) : Boolean {
			var result:Boolean = false;
			var i:int; var j: int;
			for (i = 0; i < arr.length - 1; i++){
				for (j = i + 1; j < arr.length; j++){
					if (arr[i] === arr[j]){
						arr.splice(j, 1);
						result = true;
					}
				}
			}
			if(result){
				return removeDuplicate(arr);
			}
			return result;
		}
		
		private function getCommandList(commandsList:Array):Vector.<CommandSearchCondition> {
			var result:Vector.<CommandSearchCondition> = new Vector.<CommandSearchCondition>(); 
			for each(var c:String in commandsList) {
				result.push(new CommandSearchCondition(c))
			}
			return result;
		}
		
		private function getInstancesByCommands(container:DisplayObject, commandsList:Vector.<CommandSearchCondition>):Array {
			var result:Array = [];
			if(!commandsList || commandsList.length == 0 || container == null) return result;
			var firstCommand : CommandSearchCondition = commandsList[0];
			
			var child:DisplayObject;
			var commandsListCopy:Vector.<CommandSearchCondition>;
			if(firstCommand.moveToParent) {
				commandsListCopy = commandsList.concat();
				commandsListCopy.shift();
				if(commandsListCopy.length == 0) {
					result.push(container.parent);
				} else {
					result = result.concat(getInstancesByCommands(container.parent, commandsListCopy.concat()));
				}
			} else if(container is DisplayObjectContainer) {
				
				for (var i : int = 0; i < DisplayObjectContainer(container).numChildren; i++) {
                    try{
                        child = (DisplayObjectContainer(container).getChildAt(i));
                    }catch(e:Error) {
                        continue;
                    }
					commandsListCopy = commandsList.concat();
					if(child){
						if(getObjectAtConditions(child, firstCommand)){
							commandsListCopy.shift();
							if(commandsListCopy.length == 0) {
								limit--;
								result.push(child);
								if(limit <= 0){
									return result; 
								}
							} else {
								result = result.concat(getInstancesByCommands(child, commandsListCopy.concat()));
								if(limit <= 0){
									return result; 
								}
							}
						} 
						if(firstCommand.relativeName) {
							commandsListCopy = commandsList.concat();
							result = result.concat(getInstancesByCommands(child, commandsListCopy.concat()));
							if(limit <= 0){
								return result; 
							}
						} 
					}
				}
			}

			return result;
		}
		
		private function getObjectAtConditions(DO:DisplayObject, condition:CommandSearchCondition):DisplayObject {
			var result:DisplayObject = DO;
			for each(var c:ConditionsVO in condition.commands) {
				result = getObjectAtCondition(DO, c.condition, c.propertyName, c.propertyValue);
				if(!result) break;
			}
			return result;
			
		}
		
		private function getObjectAtCondition(DO:DisplayObject, condition:String, propertyName:String, propertyValue:String):DisplayObject {
			var result:DisplayObject;
			var propertyAtDO:String = getProperty(DO, propertyName);
			condition = condition.replace("*", "");
			switch(condition){
				case "contains":
					if(propertyAtDO.split(propertyValue).length > 1) {
						result = DO;
					}
					break;
				case "!contains":
					if(propertyAtDO.split(propertyValue).length <= 1) {
						result = DO;
					}
					break;
				case "=":
					if(propertyAtDO == propertyValue) {
						result = DO;
					}
					break;
				case "!=":
					if(propertyAtDO != propertyValue) {
						result = DO;
					}
					break;
				case ">":
					if(Number(propertyAtDO) > Number(propertyValue)) {
						result = DO;
					}
					break;
				case "<":
					if(Number(propertyAtDO) < Number(propertyValue)) {
						result = DO;
					}
					break;
				case ">=":
					if(Number(propertyAtDO) >= Number(propertyValue)) {
						result = DO;
					}
					break;
				case "<=":
					if(Number(propertyAtDO) <= Number(propertyValue)) {
						result = DO;
					}
					break;
			}
			return result;
		}
		
		private function getProperty(DO:DisplayObject, propertyName:String):String {
			var result:String = "";
			switch(propertyName){
				case "visibleOnStage":
					result = new DisplayObjectUtils().getVisibleOnStage(DO).toString();
					break;
				case "instanceOf":
					result = String(DO.toString().split(" ")[1]).split("]")[0].toString();
					break;
				case "index":
					result = DO.parent.getChildIndex(DO).toString();
					break;
				default:
					if(DO.hasOwnProperty(propertyName)) {
						result = DO[propertyName];
						
					} else if(propertyName.split(".").length > 1) {
						var data:* = DO;
						for each(var c:String in propertyName.split(".")) {
							if(DO.hasOwnProperty(c)) {
								data = data[c];
							} else {
								return "";
							}
						}
						result = data;
					}
			}
			return result ? result : "";
		}
		
	}
}
package utils.loka.autotesting.utils.searcher
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;

	public class AS3PathSerchOld
	{
		private var root:Stage;
		public function AS3PathSerchOld(root:Stage)
		{
			this.root = root;
		}
		
		/**
		 *		/relativeName:blablabla/index:2/../index:4/name:blablabla
		 *		findComplexInstanceInContainer(name, stage).getChildAt(2)...getChildAt(4).getChildByName("blablabla")
		 *		/[@name:blablabla]/[2]/../[4]/[@name:blablabla]
		 *		stage.getChildByName(name).getChildAt(2)...getChildAt(4).getChildByName("blablabla")
		 *		/[0..numChild]/../[0..numChild]/[@name:blablabla]
		 *		/[0..numChild]/../[0..numChild]/[@name:blablabla]
		 *		stage.getChildAt(index)...getChildAt(index).getChildByName(name) 
		 * @param instancePath
		 * @return 
		 * 
		 */
		public function getDisplayObjectByPath(instancePath : String):DisplayObject {
			var commands:Array = instancePath.split("/");
 
			if(commands.length > 1){
				return getDisplayObjectByPathAtInstance(null, commands)
				
			}
			return root;
		}
		private function getDisplayObjectByPathAtInstance(container : DisplayObjectContainer, commands : Array):DisplayObject {
			var command:String = commands.shift();
			var result:DisplayObject = container;
			var currentCommands:Array= command.split(":");  
			if(currentCommands.length>0){
				var currentCommand:String = currentCommands[0];
				var localContainer:DisplayObjectContainer = (DisplayObjectContainer(container ? container : root));
				switch(currentCommand){
					case "relativeName":
						result = findComplexInstanceInContainer(localContainer, currentCommands[1])
						break;
					case "name":
						result = localContainer.getChildByName(currentCommands[1]);
						break;
					case "index":
						if(localContainer.numChildren>int(currentCommands[1])){
							result = localContainer.getChildAt(int(currentCommands[1]));
						}else{
							result = null;
						}
						break;
					default :						
						//						container = getDisplayObjectByPath(container ? container:root, command[1]);
						break;
				}
			}
			if(result && result is DisplayObjectContainer && commands.length>0){
				result = getDisplayObjectByPathAtInstance(DisplayObjectContainer(result), commands)
			}
			
			return result;
		}
		
		public function findComplexInstanceInContainer(container : DisplayObjectContainer, instancePath : String):DisplayObject {
			var child : DisplayObject = null;
			var firstInstanceNameInPath : String;
			if (!container || !(container is DisplayObjectContainer)){
				return null;
			}
			var instanceStack : Array = instancePath.split(".");
			if (!(container is DisplayObjectContainer)){
				return null;
			}
			if (instanceStack.length == 0) {
				return null;				
			}
			firstInstanceNameInPath = instanceStack[0];
			if (instanceStack.length == 1 && container.hasOwnProperty(firstInstanceNameInPath)){
				return container[firstInstanceNameInPath];
			}
			if (instanceStack.length > 1 && container.hasOwnProperty(firstInstanceNameInPath)) {
				instanceStack.shift();
				return findComplexInstanceInContainer(container[firstInstanceNameInPath], instanceStack.join("."));
				instanceStack.unshift(firstInstanceNameInPath);
			}
			for (var i : int = 0; i < (container as DisplayObjectContainer).numChildren; i++) {
				try {
					child = container.getChildAt(i);
				} catch(error:Error) {
					continue;
				}
				if (child == null){
					continue;
				}
				if (instanceStack.length == 1) {
					if (child.hasOwnProperty(firstInstanceNameInPath)){
						return child[firstInstanceNameInPath];
					} else{ 
						child = findComplexInstanceInContainer(child as DisplayObjectContainer,firstInstanceNameInPath);
					}
				} else {
					if (firstInstanceNameInPath == "?") {
						instanceStack.shift();
						child = findComplexInstanceInContainer(child as DisplayObjectContainer, instanceStack.join("."));
						instanceStack.unshift(firstInstanceNameInPath);
					} else {
						if (child.hasOwnProperty(firstInstanceNameInPath)) {
							instanceStack.shift();
							child = findComplexInstanceInContainer(child[firstInstanceNameInPath] as DisplayObjectContainer, instanceStack.join("."));
							instanceStack.unshift(firstInstanceNameInPath);
						} else {
							child = findComplexInstanceInContainer(child as DisplayObjectContainer, instanceStack.join("."));
						}
					}
				}
				if (child && child.visible){
					return child;
				}
			}
			return null;
		}
	}
}
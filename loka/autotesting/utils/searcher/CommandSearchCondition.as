package loka.autotesting.utils.searcher {
	public class CommandSearchCondition {
		public var relativeName:Boolean = false;
		public var moveToParent:Boolean = false;
		public var commands:Vector.<ConditionsVO>;
		public function CommandSearchCondition(command:String) {
			commands = new Vector.<ConditionsVO>();
			relativeName = command.split("*").length > 1;
			moveToParent = command.split("..").length > 1;
			
			if(command.split(",").length > 1) {
				generateMultiConditions(command);
			} else {
				generateSingleCondition(command);
			}
			
		}
		
		private function generateSingleCondition(command:String):void {
			commands.push(new ConditionsVO(command));
		}
		
		private function generateMultiConditions(commands:String):void {
			for each(var command:String in commands.split(",")){
				generateSingleCondition(command);
			}
		}
	}
}
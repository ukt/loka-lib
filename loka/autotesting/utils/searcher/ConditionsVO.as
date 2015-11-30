package loka.autotesting.utils.searcher
{
	public class ConditionsVO {
		public var relativeName:Boolean = false;
		public var condition:String;
		public var propertyName:String = "name";
		public var propertyValue:String;
		
		public function ConditionsVO(command:String) {
			
			condition 		= command.split("?", 1)[0];
			propertyName 	= "name";
			
			var propertyPaire:Array;
			if(command.split("?", 2).length>1){
				condition = command.split("?", 1)[0];
				propertyPaire = command.split("?", 2)[1].split(":", 2);
			} else {
				condition = "=";
				propertyPaire = command.split(":", 2);
			}
			
			relativeName = false;
			if(condition.split("*").length > 1) relativeName = true;
			if(condition == "*") {
				condition = "*=";
			}
			
			if(propertyPaire.length > 1) {
				propertyName = propertyPaire[0];
				propertyValue = propertyPaire[1]
			} else{
				propertyName = "name";
				propertyValue = propertyPaire[0];
			}
		}
	}
}
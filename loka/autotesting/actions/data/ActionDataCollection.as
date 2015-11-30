package utils.loka.autotesting.actions.data {
	public class ActionDataCollection implements IActionDataCollection{
		private var data:Vector.<ActionData>;
		private var index:int;
		public function ActionDataCollection() {
			data = new Vector.<ActionData>();
			index = 0;
		}
		
		public function addCommand(actionData:ActionData):uint{
			return data.push(actionData);
		}
		
		public function getNext():ActionData {
			if(data[index].isComleted){
				index++;
			}
			return data[index];
		}
		
		public function hasNext():Boolean{
			return data.indexOf(index) != -1 && !data[index].isComleted;
		}
	}
}
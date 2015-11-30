package loka.autotesting.actions.data.parser{
	import loka.autotesting.actions.data.IActionDataCollection;

	public class ActionDataParser implements IActionDataParser{
		protected var data:Object;
		public function ActionDataParser(data:Object){
			this.data = data;
		}
		
		public function parse():IActionDataCollection{
			throw new Error("this methode need override for parse obj: " + data);
		}
	}
}
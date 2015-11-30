package utils.loka.autotesting.actions.data.parser {
	import utils.loka.autotesting.actions.data.ActionDataCollection;
	import utils.loka.autotesting.actions.data.IActionDataCollection;

	public class JsonActionDataParser extends ActionDataParser {
		public function JsonActionDataParser(data:Object) {
			super(data);
		}
		
		override public function parse():IActionDataCollection{
			var result:ActionDataCollection = new ActionDataCollection();
			var json:String;
			if(data is String) {
				json = String(data);
			}
			return result;
		}
	}
}
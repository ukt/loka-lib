package utils.loka.autotesting.actions.data.parser {
	import utils.loka.autotesting.actions.data.IActionDataCollection;

	public interface IActionDataParser {
		function parse():IActionDataCollection;
	}
}
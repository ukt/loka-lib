package loka.autotesting.actions.data.parser {
	import loka.autotesting.actions.data.IActionDataCollection;

	public interface IActionDataParser {
		function parse():IActionDataCollection;
	}
}
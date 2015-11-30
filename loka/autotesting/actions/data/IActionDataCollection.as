package loka.autotesting.actions.data {
	
	public interface IActionDataCollection {
		function getNext():ActionData;
		function hasNext():Boolean;
	}
}
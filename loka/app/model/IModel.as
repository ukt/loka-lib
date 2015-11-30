package loka.app.model
{
	/**
	 * 
	 * @author loka
	 * 
	 */
	public interface IModel
	{
		function set data(data:Object):void;
		function get data():Object;
		function get alias():String;
	}
}
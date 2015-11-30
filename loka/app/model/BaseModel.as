package utils.loka.app.model
{
	/**
	 * 
	 * @author loka
	 * 
	 */
	public class BaseModel implements IModel
	{
		public static var NAME:String = "BaseModel";
		
		protected var _data:Object;
		private var _alias:String;
		public function BaseModel(alias:String)
		{
			_alias = alias;
		}
		
		public function get alias():String
		{
			return _alias;
		}
		
		public function set data(data:Object):void
		{
			_data = data;
		}
		
		public function get data():Object
		{
			return _data;
		}
	}
}
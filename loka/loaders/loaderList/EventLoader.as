package loka.loaders.loaderList
{
	import flash.events.Event;
	
	public class EventLoader extends Event
	{
		private var _data:LoaderList;
		public function EventLoader(type:String, data:LoaderList, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this._data = data;
			super(type, bubbles, cancelable);
		}
		
		public function get data():LoaderList{
			return this._data;
		}
	}
}
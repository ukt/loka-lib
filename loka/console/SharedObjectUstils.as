package utils.loka.console
{
	import flash.net.SharedObject;

	public class SharedObjectUstils
	{
		private var _properties:SharedObject;
		private var NAME:String = "SharedObjectUstils";
		public function SharedObjectUstils()
		{
		}
		
		private function get consoleProperties():SharedObject
		{
			if(!_properties) _properties = SharedObject.getLocal(NAME);
			return _properties;
		}
		
		public function setProperty(name:String, value:*):void
		{
			consoleProperties.data[name] = value;
			consoleProperties.flush();
		}
		
		public function getProperty(name:String):*
		{
			return consoleProperties.data[name];
		}
	}
}
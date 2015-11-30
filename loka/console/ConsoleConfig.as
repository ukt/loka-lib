package loka.console
{
	import flash.display.DisplayObjectContainer;

	internal class ConsoleConfig
	{
		public static var enabled:Boolean = false;
		public static var globalInstance: DisplayObjectContainer;
		
		public static const CTRL:String 					= "CTRL";
		public static const SHIFT:String 					= "SHIFT";
		public static const ALT:String 						= "ALT";
		public static const KEY:String 						= "KEY";
		
		
		public static const ERROR_COMMAND_DO:String 	= "Can't register command, use -help to correct command";
		public static const ERROR_NEW_COMMAND:String 	= "This command name has registrate";
		public static const ERROR_COMMAND:String 		= "has any error in call method ";
		public static const COMMAND_NAME:String 		= "Command name:    ";
		public static const COMMAND_DESCRITION:String 	= "Description:     ";
		public static const COMMAND_HOT_KEY:String 		= "Hot key:         ";
		
		
		
		protected static var COMMENT:String = "comment";
		//		
		//		
		
		//Console
		
		
		public function ConsoleConfig()
		{
		}
	}
}
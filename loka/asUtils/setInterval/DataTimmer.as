package loka.asUtils.setInterval
{
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	
	/**
	 * ...
	 *
	 * @history create Apr 9, 2012 9:11:48 AM
	 * @author g.savenko
	 */    
	public class DataTimmer extends Timer
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
		private var _hash:Dictionary = new Dictionary();
		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------
		public function DataTimmer(delay:Number, repeatCount:int=0)
		{
			super(delay, repeatCount);
		}
		
		//---------------------------------------------------------------
		//
		//      PRIVATE & PROTECTED METHODS
		//
		//---------------------------------------------------------------
		
		
		//---------------------------------------------------------------
		//
		//      EVENT HANDLERS
		//
		//---------------------------------------------------------------
		
		
		//---------------------------------------------------------------
		//
		//      PUBLIC METHODS
		//
		//---------------------------------------------------------------
		
		public function setproperty(key:String, property:Object):void
		{
			_hash[key] = property;
		}
		
		public function getproperty(key:String):Object
		{
			return _hash[key];
		}
		
		//---------------------------------------------------------------
		//
		//      ACCESSORS
		//
		//---------------------------------------------------------------
	}
}
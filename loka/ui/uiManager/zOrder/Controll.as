package loka.ui.uiManager.zOrder
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 *
	 * @history create Jun 16, 2012 1:27:10 AM
	 * @author g.savenko
	 */    
	public class Controll
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
		
		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------
		public function Controll()
		{
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
		
//		static public const THRESHOLD:Number = 13;
		public static function order(layer:DisplayObjectContainer, THRESHOLD:Number = 1):void
		{
			if(layer.numChildren > 1)
			{
				var ordered:Boolean = false;
				
				while(!ordered)
				{
					ordered = true;
					
					var i:int;
					
					for(i = 0; i < layer.numChildren-1; i++)
					{
						if(layer.getChildAt(i).y > layer.getChildAt(i+1).y + THRESHOLD)
						{
							layer.swapChildrenAt(i, i+1);
							ordered = false;
						}
					}
					
					if(!ordered)
					{
						for(i = layer.numChildren-2; i >= 0; i--)
						{
							if(layer.getChildAt(i).y > layer.getChildAt(i+1).y +THRESHOLD )
							{
								layer.swapChildrenAt(i, i+1);
								ordered = false;
							}
						}
					}
				}
			}
		}
		//---------------------------------------------------------------
		//
		//      ACCESSORS
		//
		//---------------------------------------------------------------
	}
}
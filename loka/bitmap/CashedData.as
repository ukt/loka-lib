package loka.bitmap
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 *
	 * @history create May 11, 2012 9:06:58 AM
	 * @author g.savenko
	 */    
	public class CashedData
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		static private const NAME:String = "CashedData";
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
		private static var cash:Dictionary = new Dictionary();
		private static var _childAppeared:Dictionary = new Dictionary(true);
		/**
		 *TO DO 
		 */
		private static var localCash:SharedObject;
		private static var init:CashedData = new CashedData();
		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------
		public function CashedData()
		{
			localCash = SharedObject.getLocal(NAME);
			localCash.clear();
		}
		
		//---------------------------------------------------------------
		//
		//      PRIVATE & PROTECTED METHODS
		//
		//---------------------------------------------------------------
		protected static function allChildrenGotoFrame(mc:MovieClip, frame:int):void
		{
			var clip:DisplayObject;
			for (var i:int = 0; i < mc.numChildren; i++)
			{
				clip = mc.getChildAt(i);
				
				if (clip is MovieClip)
				{
					/*if (!_childAppeared[clip])
					{
						_childAppeared[clip] = frame;
					}*/
					
//					var tframe:int = frame - _childAppeared[clip];
					
//					clip.gotoAndStop(tframe);
					var canPlay:Boolean = true;
					if(MovieClip(clip).currentFrameLabel && MovieClip(clip).currentFrameLabel =="stop")
					{
						canPlay = false;
					}
					if(canPlay)
					{
						if(MovieClip(clip).currentFrame == MovieClip(clip).totalFrames)
						{
							MovieClip(clip).gotoAndStop(1);
						}
						else if(_childAppeared[clip])
						{
							MovieClip(clip).nextFrame();
						}
						
						_childAppeared[clip] = 1;
					}else
					{
						MovieClip(clip).stop();
					}
					
					allChildrenGotoFrame(clip as MovieClip, 1);
				}
			}
		}
		
		protected static function getFrameSize(mc:MovieClip):Rectangle
		{
			var min:Point = new Point();
			var max:Point = new Point();
			var bounds:Rectangle;
			
			bounds = mc.getBounds(mc);
			min.x = bounds.topLeft.x;
			min.y = bounds.topLeft.y;
			max.x = bounds.bottomRight.x;
			max.y = bounds.bottomRight.y;
			
			return new Rectangle(int(min.x), int(min.y), int(max.x - min.x), int(max.y - min.y));
		}
		
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
		public static function aliveBitmap(key:String, frame:uint):AssetBitmap
		{
			var rect:Rectangle;
			var locBitmap:AssetBitmap
			
			locBitmap = null;
			if(cash[key])
			{
				locBitmap = cash[key][frame] as AssetBitmap;
			}
			if(!locBitmap)
			{
				 
			}
			return locBitmap;
		}
		
		public static function clear():void
		{
			for each(var c1:String in cash)
			{
				for each(var c2:String in cash[c1])
				{
					cash[c1][c2] = null;
					delete cash[c1][c2]; 
				}
				cash[c1] = null;
				delete cash[c1];
			}
			cash = null;
			cash = new Dictionary();
		}
		public static function cashed(target:MovieClip, key:String):void
		{
			/*if(localCash.data[key])
			{
				cash[key] = localCash.data.key;
				return;
			}*/
			
			var rect:Rectangle;
			//target.gotoAndStop(0);
			
			if(!cash[key])
			{
				cash[key] = new Dictionary();
			}
			
			if(!cash[key][target.totalFrames])
			{
				for (var i:int = target.currentFrame; i <= target.totalFrames; i++)
				{
					
					target.gotoAndPlay(i);
					allChildrenGotoFrame(target, i);
					//frame = target.currentFrame;
					
					if(!cash[key][i])
					{
	//					cash[key][frame];
						
						rect = getFrameSize(target);
//						BitmapEdit.TRANSPARENT = false;
						var bmp:AssetBitmap = new AssetBitmap(BitmapEdit.drawImgNew(target, false, rect.x, rect.y, rect.width, rect.height).bitmapData);
						cash[key][i] = bmp; 
						bmp.x = rect.x;
						bmp.y = rect.y;
						
						//var bulletOut:DisplayObject;
						
						for (var childIterator:int = 0; childIterator < target.numChildren; childIterator++)
						{
							var child:DisplayObject = target.getChildAt(childIterator);
							
							if (child.name == "bulletOut" && child.alpha > 0)
							{
								bmp.addBulletOut(child.localToGlobal(new Point(0, 0)));
							}
						}
						/*
						if((bulletOut = target.getChildByName("bulletOut")) && bulletOut.alpha > 0)
						{
							bitmap.addBulletOut(bulletOut.localToGlobal(new Point(0, 0)));
						}*/
						
	//					localCash.data[key] = cash[key]; 
					}
				}
			}
			_childAppeared = new Dictionary();
			if(cash[key][target.totalFrames + 5])
			{
				throw new Error("What The Fuck!!!!")
			}
		}
		
		
		
		//---------------------------------------------------------------
		//
		//      ACCESSORS
		//
		//---------------------------------------------------------------
	}
}
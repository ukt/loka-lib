package utils.loka.bitmap
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	
	/**
	 * ...
	 *
	 * @history create May 15, 2012 1:57:32 PM
	 * @author g.savenko
	 */    
	public class AssetBitmap extends Bitmap
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
		private var _bulletOutList:Array;
		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------
		public function AssetBitmap(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
			_bulletOutList = [];
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
		public function get bulletOutList():Array
		{
			return _bulletOutList;
		}
		/*
		public function get BulletOut():Point
		{
			if(_bulletOutList.length)
			{
				return _bulletOutList[0];
			}
			return null;
		}
		*/
		
		public function addBulletOut(bulletOut:Point):void
		{
			_bulletOutList.push(bulletOut);
		}
		
		//---------------------------------------------------------------
		//
		//      ACCESSORS
		//
		//---------------------------------------------------------------
	}
}
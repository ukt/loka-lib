package utils.loka.ui.uiI
{
	import utils.loka.globalInterface.IDispose;
	
	public interface IEntityComplex extends IDispose, IAlive, ITicker
	{
		function initEntity(god:IModernSprite):void; 
		
		function getChildsByNameDifinition(name:String):Vector.<IEntityComplex>;
		function get nameDifinition():String;
		function set nameDifinition(value:String):void;
	}
}
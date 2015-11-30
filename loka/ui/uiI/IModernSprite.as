package utils.loka.ui.uiI
{
	public interface IModernSprite extends IEntityComplex
	{
		function get data():*;
		function addSliceInstance(child:IEntityComplex):void;
		function removeSliceInstance(child:IEntityComplex):void;
	}
}
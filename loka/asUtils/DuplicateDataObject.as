package loka.asUtils
{
	import flash.utils.ByteArray;

	public class DuplicateDataObject
	{
		public function DuplicateDataObject()
		{
		}
		
		public static function duplicate(data:Object):Object
		{
			var copyObj:Object;
			var copyObjByteArray:ByteArray = new ByteArray();
			copyObjByteArray.writeObject(data);
			copyObjByteArray.position = 0;
			
			copyObj = copyObjByteArray.readObject(); 
			
			return copyObj;
		}
	}
}
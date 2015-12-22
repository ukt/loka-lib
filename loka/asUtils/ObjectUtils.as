package loka.asUtils {
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class ObjectUtils {
		private static var uniqueKeys:Dictionary = new Dictionary();
		private static var _key:uint = 0;

		public function ObjectUtils() {
		}

		public static function getUniqueKey(data:Object):uint {
			if (!uniqueKeys[data]) {
				_key++;
				uniqueKeys[data] = _key;
			}
			return uniqueKeys[data];
		}

		public static function duplicate(data:Object):Object {
			var copyObj:Object;
			var copyObjByteArray:ByteArray = new ByteArray();
			copyObjByteArray.writeObject(data);
			copyObjByteArray.position = 0;

			copyObj = copyObjByteArray.readObject();

			return copyObj;
		}
	}
}
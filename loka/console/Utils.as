package loka.console
{
	import flash.utils.ByteArray;

	internal class Utils
	{
		
		public static function getPropertyCount(value:Object):int
		{
			var count:uint = 0;
			for (var key:String in value)
			{
				count ++;
			}
			return count;
		}
		
		public static function getWrapStr(value:Boolean, str:String):String 
		{
			if(str.length > 0)
			{
				return value ? "\n": "";
			}
			return "";
		}
		
		public static function getMaxPropertyLegthStr(value:Object):int
		{
			var count:uint = 0;
			var maxPropertyLegth:uint = 0;
			
			for (var key:String in value)
			{
				if(maxPropertyLegth < key.length)
				{
					maxPropertyLegth = key.length;
				}
				
				count ++;
				if(count>1000) 
				{
					continue;
				}
			}
			return maxPropertyLegth;
			
		}
		
		public static function concatArrayToStr(arr:Array):String{
			var result:String = ""; 
			for(var c:String in arr)
			{
				result += arr[c];
			}
			return result;
		}
		
		public static function getValidParametr(str:String, delimetr:String = " "):String
		{
			var result:String = "";
			var arr:Array = str.split(delimetr);
			result = concatArrayToStr(arr);
			/*for(var c:String in str){
			if(str[c] = !delimetr){
			result += str[c]  
			}
			}*/
			return result;
		}
		
		public static function getValidParams(arr:Array):Array
		{
			var result:Array = [];
			for(var c:String in arr)
			{
				var param:String = getValidParametr(arr[c], " ");
				if(param && param!= "")
				{
					result.push(param);
				}
			}
			return result;
		}
		
		public static function getParamsWithStrings(str:String, delimetr:String = ","):Array
		{
			var result:Array = [];
			var arr:Array = str.split("\"");
			if(arr.length > 0) {
				var t:uint;
				for(var c:String in arr)
				{
					var b:uint = t % 2;
					if (b) 
					{
						if(arr[c] != "")
						{
							result.push(arr[c]);
						}
					} 
					else 
					{
						var arrValidParams:Array = getValidParams(arr[c].toString().split(delimetr));
						if(arrValidParams.length >= 1)
						{
							result = result.concat(arrValidParams);
						}
					}
					t++;
				}
			}
			else
			{
				
			}
			return result;
		}
		
		public static function getWhiteSpace(length:int):String
		{
			var str:String = "";
			for(var c:int = 0; c < length;  c++) 
			{
				str += " ";
			}
			return str;
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
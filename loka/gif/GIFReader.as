package utils.loka.gif
{
	import flash.utils.ByteArray;

	public class GIFReader
	{
		//Байтовые массивы
		public var description:ByteArray;
		public var expand:Array = new Array();
		public var image:Array = new Array();
		public var array:Array = new Array();

		//Дескриптор логического экрана
		public var version:String;
		public var W:uint;
		public var H:uint;
		public var globalColorSize:uint;

		//Массивы со свойствами изоражения
		public var top:Array = new Array();
		public var left:Array = new Array();
		public var w:Array = new Array();
		public var h:Array = new Array();
		public var disp:Array = new Array();
		public var delay:Array = new Array();
		public var colorSize:Array = new Array();

		//Исходный массив
		private var byteArray:ByteArray;
		

		public function GIFReader(b:ByteArray)
		{
			byteArray = b;

			init();
		}

		//Инициализация
		private function init():void
		{
			if (checkVersion())
			{
				readDescription();
				readData();
			}
		}

		//Проверка версии файла
		private function checkVersion():Boolean
		{
			version = byteArray.readUTFBytes(6);

			if (version != "GIF89a" && version != "GIF87a")
			{
				return false;
			}
			return true;
		}

		//Считывание параметров из дескриптора
		private function readDescription():void
		{
			W = readDoubleByte();
			H = readDoubleByte();
			globalColorSize = readColorSize();
			byteArray.position += 2 + globalColorSize * 3;

			description = new ByteArray();
			description.writeBytes(byteArray, 0, byteArray.position);
		}

		//Считывание изображение и расширений
		private function readData():void
		{
			while (readGraphicExpansion() || readApplicationExpansion() || readImage() || readCommentExpansion() || readTextExpansion())
			createArray();
		}

		//Чтение расширения графики
		private function readGraphicExpansion():Boolean
		{
			if (String.fromCharCode(byteArray[byteArray.position]) == "!" && byteArray[byteArray.position+1] == 0xF9 && byteArray[byteArray.position+2] == 0x04 && byteArray[byteArray.position+7] == 0x00)
			{
				var start:uint = byteArray.position;
				
				byteArray.position += 3;
				readDisp();
				delay[image.length] = readDoubleByte();
				byteArray.position += 2;
				
				var end:uint = byteArray.position;
				var b:ByteArray = new ByteArray();
				b.writeBytes(byteArray, start, end - start);
				expand[image.length] = b;
				
				return true;

			}
			return false;
		}
		
		//Чтение расширения приложения
		private function readApplicationExpansion():Boolean
		{
			if (String.fromCharCode(byteArray[byteArray.position]) == "!" && byteArray[byteArray.position+1] == 0xFF && byteArray[byteArray.position+2] == 0x0B)
			{
				byteArray.position += 14;
				readBlocks();
				
				return true;

			}
			return false;
		}
		
		//Чтение расширения простого текста
		private function readTextExpansion():Boolean
		{
			if (String.fromCharCode(byteArray[byteArray.position]) == "!" && byteArray[byteArray.position+1] == 0x01 && byteArray[byteArray.position+2] == 0x0C)
			{
				byteArray.position += 15;
				readBlocks();
				
				return true;

			}
			return false;
		}
		
		//Чтение расширения комментария
		private function readCommentExpansion():Boolean
		{
			if (String.fromCharCode(byteArray[byteArray.position]) == "!" && byteArray[byteArray.position+1] == 0xFE)
			{
				byteArray.position += 2;
				readBlocks();
				
				return true;

			}
			return false;
		}
		
		//Чтение изображения
		private function readImage():Boolean
		{
			if (String.fromCharCode(byteArray[byteArray.position]) == ",")
			{
				var start:uint = byteArray.position;				
				
				byteArray.position += 1;
				left.push(readDoubleByte());
				top.push(readDoubleByte());
				w.push(readDoubleByte());
				h.push(readDoubleByte());
				colorSize.push(readColorSize());
				byteArray.position += 1;
				byteArray.position += colorSize[colorSize.length - 1] * 3;
				readBlocks();
				
				var end:uint = byteArray.position;
				var b:ByteArray = new ByteArray();
				b.writeBytes(byteArray, start, end - start);
				image.push(b)
				
				return true;
			}
			return false;
		}
		
		//Считывание способа замены изображения
		private function readDisp():void
		{
			var byte:uint = byteArray.readUnsignedByte();
			var array:Array = new Array(8);
			for (var i:int = 7; i >= 0; i--)
			{
				if (byte > Math.pow(2, i))
				{
					array[i] = true;
					byte -= Math.pow(2, i);
				}
			}
			
			disp[image.length] = uint(array[2]) + 2 * uint(array[3]) + 4 * uint(array[4]);
		}

		//Считавыние целого числа из двух байтов
		private function readDoubleByte():uint
		{
			var value:uint=byteArray.readUnsignedByte();
			value+=256*byteArray.readUnsignedByte();
			return value;
		}

		//Сичитывание количества цветов
		private function readColorSize():uint
		{
			var byte:uint=byteArray.readUnsignedByte();
			var array:Array=new Array(8);
			for (var i:int = 7; i >= 0; i--)
			{
				if (byte>Math.pow(2,i))
				{
					array[i]=true;
					byte-=Math.pow(2,i);
				}
			}

			if (array[7])
			{
				var size:uint=uint(array[0])+2*uint(array[1])+4*uint(array[2]);
				return Math.pow(2, size + 2);
			}
			else
			{
				return 0;
			}
		}
		
		//Считывание блоков
		private function readBlocks():void
		{
			while (byteArray[byteArray.position] != 0)
			{
				byteArray.position += byteArray.readUnsignedByte() + 1;
			}
			byteArray.position += 1;
		}
		
		//Создание байтовых массивов для каждого изображения
		private function createArray():void
		{
			var b:ByteArray;
			for (var i:int = 0; i < image.length; i++)
			{
				b = new ByteArray();
				b.writeBytes(description);
				if (expand[i])
				{
					b.writeBytes(expand[i]);
				}
				b.writeBytes(image[i]);
				array.push(b); 
			}
		}
	}
}
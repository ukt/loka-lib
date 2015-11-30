package utils.loka.gif
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.*;

	public class GIFAnimator extends Sprite
	{
		//Время отображения кадра по умолчанию в десятках миллисукунд
		private static const DEFAULT_DELAY:uint = 5;
		
		//Исходный массив байтов
		private var byteArray:ByteArray;

		//Класс, считавыющий и хранящий параметры анимации и изображений
		private var reader:GIFReader;
		
		//Массивы загрузчиков и изображений
		private var loader:Array = new Array();
		private var image:Array = new Array();
		private var imageCounter:uint = 0;
		
		//Классы для отображения итоговой картинки
		private var imgBitmapData:BitmapData;
		private var imgBitmap:Bitmap;
		
		//Массив таймеров
		private var timer:Array = new Array();
		
		//Номер текущего кадра
		private var currFrame:uint = 0;

		public function GIFAnimator(b:ByteArray)
		{
			byteArray = b;

			reader = new GIFReader(b);

			loadImages();
		}
		
		//Создание массива объектов Loader
		//для преобразования байтовых массивов в BitmapData
		private function loadImages():void
		{
			
			for (var i:int = 0; i < reader.array.length; i++)
			{
				loader[i] = new Loader();
				loader[i].contentLoaderInfo.addEventListener(Event.COMPLETE, completeListener);
				loader[i].loadBytes(reader.array[i]);
			}
		}
		
		//Успешная загрузка изображения
		private function completeListener(event:Event):void
		{	
			image[loadedImageNum(event)] = Bitmap(event.target.content).bitmapData;
			imageCounter++;
			if (imageCounter == reader.array.length) {
				deleteLoaders();
				createImage();
			}
		}
		
		//Определение номера загруженнай картинки
		private function loadedImageNum(event:Event):uint
		{
			for (var i:int = 0; i < reader.array.length; i++)
			{
				if (event.target === loader[i].contentLoaderInfo)
				{
					return i;
				}
			}
			return 0;
		}
		
		//Удаление всех загрузчиков
		private function deleteLoaders():void
		{
			for (var i:int = 0; i < reader.array.length; i++)
			{
				loader[i].contentLoaderInfo.removeEventListener(Event.COMPLETE, completeListener);
			}
			loader = new Array();
		}
		
		//Создание изображения
		private function createImage():void
		{
			imgBitmapData = new BitmapData(reader.W,reader.H,true,0xFF);
			imgBitmap = new Bitmap(imgBitmapData);
			addChild(imgBitmap);
			
			drawImage();
			
			if (image.length > 1)
			{
				createTimers();
				startTimers();
			}
		}
		
		//Создание таймеров
		private function createTimers():void
		{
			var time:uint = 0;
			for (var i:int = 0; i < image.length; i++)
			{
				if (reader.delay[i] == 0)
				{
					time += DEFAULT_DELAY;
				}
				else
				{
					time += reader.delay[i];
				}
				timer[i] = new Timer(time * 10, 1);
				timer[i].addEventListener(TimerEvent.TIMER, timerListener);
			}
		}
		
		//Запуск таймеров
		private function startTimers():void
		{
			for (var i:int = 0; i < image.length; i++)
			{
				timer[i].start();
			}
		}
		
		//Сборос таймеров
		private function restartTimers():void
		{
			for (var i:int = 0; i < image.length; i++)
			{
				timer[i].reset();
			}
			startTimers();
		}
		
		//Срабатывание таймера
		private function timerListener(event:TimerEvent):void
		{
			currFrame++;
			if (currFrame == image.length)
			{
				currFrame = 0;
				restartTimers();
			}
			trace(currFrame);
			drawImage();
		}
		
		//Рисование изображения
		private function drawImage():void
		{
			var rect:Rectangle;
			var point:Point;
			var b:BitmapData = new BitmapData(reader.W,reader.H,true,0xFF);

			imgBitmapData.lock();

			//Первый кадр
			if (currFrame == 0)
			{
				clearImage();
			}

			//Рисование повех предидущего изображения
			if (reader.disp[currFrame] == 0 || reader.disp[currFrame] == 1 || reader.disp[currFrame] == undefined)
			{
				drawCurrImage();
			}

			//Замещение изображения
			if (reader.disp[currFrame] == 2 || reader.disp[currFrame] == 3)
			{
				clearImage();
				drawCurrImage();
			}

			imgBitmapData.unlock();
		}
		
		//Очистка изображения
		private function clearImage():void
		{
			var rect:Rectangle = new Rectangle(0,0,reader.W,reader.H);
			imgBitmapData.fillRect(rect, 0xFF);
		}
		
		//Рисование текушего кадра поверх изображения 
		private function drawCurrImage():void
		{
			var b:BitmapData = new BitmapData(reader.W,reader.H,true,0xFF);
			var rect:Rectangle = new Rectangle(reader.left[currFrame],reader.top[currFrame],reader.w[currFrame],reader.h[currFrame]);
			var point:Point = new Point(reader.left[currFrame],reader.top[currFrame]);
			b.copyPixels(image[currFrame], rect, point);
			imgBitmapData.draw(b);
		}


		//Удаление анимации
		public function deleteData():void
		{
			for (var i:int = 0; i < timer.length; i++)
			{
				timer[i].removeEventListener(TimerEvent.TIMER, timerListener);
			}
			timer[i] = new Array();
			loader = new Array();
			image = new Array();
			while (numChildren > 0)
			{
				removeChildAt(0);
			}
			imgBitmap = null;
			imgBitmapData = null;
			reader = null;
		}
		
		//Ширина изображения
		public function get w():uint
		{
			return reader.W;
		}

		//Высота изображения
		public function get h():uint
		{
			return reader.H;
		}
	}
}
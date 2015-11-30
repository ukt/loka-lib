package loka.console
{
	import flash.display.DisplayObjectContainer;

	public interface IConsole
	{
		function init(instance:DisplayObjectContainer, enable:Boolean = true):void;
		function write(value:Object, color:uint = 0xFFFFFF, wrap:Boolean = true, stream:uint = 1):String;
		function showHidenConsole(stream:uint):void;
		function changeStream(stream:uint):void;
		function getCurrentStream():uint;
		function updateStage():void;
		function openConsole():void;
		function openCommandLine():void;
//		function writeString(value:String, color:uint = 0xFFFFFF):void;
//		function writeObject(value:Object, color:uint = 0xFFFFFF, paddingWhiteSpaceNum:int = 4):void;
		function update():void;
		function clear():void;
		
		function setProperty(name:String, value:*):void;
		function getProperty(name:String):*;
		function deleteProperty(name:String):void;
		
		function get time():int;
		function set time(value:int):void;
		function set enabled(value:Boolean):void;
	}
}
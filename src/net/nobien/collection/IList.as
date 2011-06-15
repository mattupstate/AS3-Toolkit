package net.nobien.collection 
{	
	public interface IList
    {
		function addItem(item:*):Boolean;
		function addItemAt(item:*, index:int):Boolean;
		function addItems(items:IList):Boolean;
		function addItemsAt(items:IList, index:int = 0x7fffffff):Boolean;
		function clear():void;
		function contains(item:*):Boolean;
		function containsAll(items:IList):Boolean;
		function equals(list:IList):Boolean;
		function getItemAt(index:uint):*;
		function subList(startIndex:int = 0, endIndex:int = 16777215):IList;
		function indexOf(item:*, fromIndex:int = 0):int;
		function isEmpty():Boolean;
		function lastIndexOf(item:*, fromIndex:int = 0x7fffffff):int;
		function get length():uint;
		function removeAllInstancesOfItem(item:*):Boolean;
		function removeItem(item:*):Boolean;
		function removeItemAt(index:int):*;
		function removeItems(items:IList):Boolean;
		function retainItems(items:IList):Boolean;
		function setItem(item:*, index:int):*;
		function toArray():Array;
		function clone():IList;
		function toString():String
	}
}
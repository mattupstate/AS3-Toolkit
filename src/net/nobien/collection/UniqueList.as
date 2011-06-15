package net.nobien.collection 
{
	import net.nobien.utils.ArrayUtil;
	
	public class UniqueList extends List 
    {
		public function UniqueList( collection:Array = null ) 
        {
			super( ( collection == null ) ? null : ArrayUtil.removeDuplicates( collection ) );
		}
		
		override public function addItem( item:* ):Boolean 
        {
			if ( contains( item ) ) return false;
			_collection.push(item);
			return true;
		}
		
		override public function addItemAt( item:*, index:int ):Boolean 
        {
			if ( contains( item ) ) return false;
			_collection.splice( index, 0, item );
			return true;
		}
		
		override public function addItems( items:IList ):Boolean 
        {
			var uniqueItems:Array = items.toArray();
			ArrayUtil.removeItems( uniqueItems, toArray() );
			if ( uniqueItems.length == 0 ) return false;
			_collection = _collection.concat( uniqueItems );
			return true;
		}
		
		override public function addItemsAt( items:IList, index:int = 0x7fffffff ):Boolean 
        {
			var uniqueItems:Array = items.toArray();
			ArrayUtil.removeItems( uniqueItems, toArray() );
			if ( uniqueItems.length == 0 ) return false;
			return ArrayUtil.addItemsAt( _collection, uniqueItems, index );
		}
		
		override public function setItem( item:*, index:int ):* 
        {
			if (contains(item))	throw new Error("Error: list already contains (" + item + ")." );
			return _collection.splice( index, 1, item )[0];
		}
		
		override public function subList( startIndex:int = 0, endIndex:int = 16777215 ):IList 
        {
			return new UniqueList( _collection.slice( startIndex, endIndex ) );
		}
		
		override public function clone():IList 
        {
			return new UniqueList( toArray() );
		}
	}
}
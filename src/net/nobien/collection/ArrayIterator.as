package net.nobien.collection 
{
    /**
	 * An array iterator is used to traverse an array of items.
	 */
    public class ArrayIterator implements IIterator
    {
        private var source:Array;
		
		/**
		 * Creates a new ArrayIterator.
		 * @param Array the array you want this iterator to traverse.
		 */
		public function ArrayIterator( source:Array )
		{
			this.source = source.slice(0); // make a copy of the array
		}
		
		public function get hasNext():Boolean
		{
			return source.length > 0; // there is another item if items still exist within the collection
		}
		
		public function next():Object
		{
			return source.shift(); // remove and return the next item in the collection
		}
		
		public function peek():Object
		{
			return source[0]; // return the next item, but don't move
		}
    }

}
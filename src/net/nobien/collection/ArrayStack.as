package net.nobien.collection 
{
    /**
	 * An implementation of the IStack data structure using an Array.  An ArrayStack is an
	 * ArrayCollection and therefore also wraps an Array object, however, for convenience
	 * the ArrayStack will provide a new Array if one is not specified.
	 */
    public class ArrayStack extends ArrayCollection implements IStack
    {
        /**
		 * Creates a new ArrayStack.  You can either have it wrap an already
		 * existing array object, or you can not specifiy an array object and have
		 * it create a new one for you.
		 */
		public function ArrayStack( array:Array=null )
		{
			if ( !array )
				array = new Array();
			
			super( array );
		}
		
		public function push( object:Object ):void
		{
			array.push( object );
		}
		
		public function pop():Object
		{
			return array.pop();
		}
		
		/**
		 * Returns an iterate which iterates over the items as they would be returned by subsequent calls to pop.
		 */
		public override function getIterator():IIterator
		{
			return new StackIterator( this );
		}
        
        public function get top():Object { return array[array.length - 1]; }
    }
}
package net.nobien.collection 
{
    
    /**
	 * Defines the stack data structure. A stack is a specific kind of collection where
	 * the last item added to it, is the next one returned from it. You add an item to it using
	 * the push, and remove an item from it using pop.
	 */
    public interface IStack extends ICollection
    {
        /**
		 * The object at the top of our stack, would be return and removed on a subsequent call to pop.
		 */
		function get top():Object;
		
		/**
		 * Adds an object onto the top of the stack.
		 */
		function push( object:Object ):void;
		
		/**
		 * Removes and returns the object at the top of the stack.
		 */
		function pop():Object;
    }
    
}
package net.nobien.collection 
{
    /**
	 * Defines the queue data structure.  A queue is a specific kind of collection where
	 * are added to it at one end, and removed from it from the other end. You add an item 
     * to it using the enqueue, and remove an item from it using dequeue.
     */
    public interface IQueue extends ICollection
    {
        /**
		 * The next object in the queue, would be return and removed on a subsequent call to dequeue.
		 */
		function get head():Object;
		
		/**
		 * Adds an object onto the end of the queue.
		 */
		function enqueue( object:Object ):void;
        
		/**
		 * Removes and returns the next object in the queue.
		 */
		function dequeue():Object;
    }
    
}
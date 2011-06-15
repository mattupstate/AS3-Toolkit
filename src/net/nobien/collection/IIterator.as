package net.nobien.collection 
{
    
    /**
     * Defines how iterating collections of items is achieved.
     */
    public interface IIterator 
    {
        /**
         * Is there another item in the collection to move to.
         */
        function get hasNext():Boolean;
        
        /**
         * Move to the next item and return it.
         */
        function next():Object;
        
        /**
         * Returns the next item in the collection without moving to it.
         */
        function peek():Object;
    }
    
}
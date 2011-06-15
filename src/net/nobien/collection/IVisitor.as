package net.nobien.collection 
{
    
    /**
     * Visitor objects are passed to ICollection objects using the collections accept( visitor ) method.
     * The collection will pass, one by one, each item it contains to the visitor until the visitor is done.
     */
    public interface IVisitor 
    {
        /**
         * Defines whether or not the visitor is done visiting items. A visitor doesn't necessarily have to
         * visit each item in the collection, it may only want take action on a portion of them.
         */
        function get isDone():Boolean;
        
        /**
         * Is passed an object from within the collection.  What the visitor does with that object is entirely
         * up to the visitor implementation.
         */
        function visit( object:Object ):void;
    }
    
}
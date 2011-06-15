package net.nobien.collection 
{
    import flash.utils.getQualifiedClassName;
    
    /**
     * A wrapper for the Array which allows them to be used as an ICollection.
     */
    public class ArrayCollection implements ICollection
    {
        private var _array:Array;
        
        /**
         * Creates a new ArrayCollection wrapper for the array specified.
         * 
         * @param Array is the Array this ArrayCollection wrapper is wrapping.
         */
        public function ArrayCollection( array:Array ):void
        {
            _array = array;
        }
        
        /**
         * Passes a visitor object each item in the collection using the wrappers iterator.
         */
        public function accept( visitor:IVisitor ):void
        {
            var iterator:IIterator = getIterator();
            while ( iterator.hasNext && !visitor.isDone )
                visitor.visit( iterator.next() );
        }
        
        /**
         * Removes all of the items from the collection this wrapper is wrapping.
         */
        public function clear():void
        {
            while ( length > 0 )
                array.pop();
        }
        
        /**
         * Returns an IIterator which traverses the items in the collection starting at index 0, and going to index length-1.
         */
        public function getIterator():IIterator
        {
            return new ArrayIterator( array.slice(0) );
        }
        
        /**
         * The array this wrapper is wrapping.
         */
        public function get array():Array { return _array; }
        
        public function get count():uint { return array.length; }
        
        public function get isEmpty():Boolean { return count == 0; }
        
        public function toString():String
        {
            var className:String = getQualifiedClassName( this );
            return "[" + className.slice( className.lastIndexOf( ":" ) + 1, className.length )  + " " + array.toString() + " ]";
        }
        
    }

}
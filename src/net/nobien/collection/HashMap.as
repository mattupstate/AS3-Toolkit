package net.nobien.collection
{   
    /**
     * The HashMap class is an optimized lookup table implementation. Each object is 
     * stored using a unique key and can then be retrieved by that key at a later time.
     */
    public class HashMap
    {
        private var _lookup:Object;
        private var _objects:Vector.<Object>;
        
        /**
         * Creates a new HashMap object.
         */
        public function HashMap() 
        {
            _lookup = { };
            _objects = new Vector.<Object>();
        }
        
        /**
         * Adds an object to the map.
         * @param	key A key to reference the object by
         * @param	obj The object to be stored
         * @return  True if the object was stored successfully, false if the key already exists.
         */
        public function add( key:String, obj:Object ):Boolean
        {
            if( !exists( key ) )
            {
                _lookup[ key ] = obj;
                _objects.push( obj );
                return true;
            }
            return false;
        }
        
        /**
         * Checks for the existance of an object based on its key.
         * @param	key The object key
         * @return  True if the object exists, false if not.
         */
        public function exists( key:String ):Boolean
        {
            return ( _lookup[ key ] != null );
        }
        
        /**
         * Removes an object from the map based on its key
         * @param	key The object key
         * @return  True if the object existed and was removed, false if not.
         */
        public function remove( key:String ):Boolean
        {
            var index:int = _objects.indexOf( _lookup[ key ] );
            
            if( index > -1 )
            {
                _lookup[ key ] = null;
                _objects.splice( index, 1 );
                return true;
            }
            
            return false;
        }
        
        /**
         * Retrieves an object based on its key.
         * @param	key The object key
         * @return  The stored object
         */
        public function retrieve( key:String ):Object
        {
            var index:int = _objects.indexOf( _lookup[ key ] );
            return ( index > -1 ) ? _objects[ index ] : null;
        }
        
    }

}
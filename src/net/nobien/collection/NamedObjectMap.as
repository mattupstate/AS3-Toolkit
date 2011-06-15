package net.nobien.collection
{
	import flash.utils.Dictionary;
	
    /**
     * The NamedObjectMap class quickly sets up an object map that indexes objects by a named key.
     */
	public class NamedObjectMap
	{
		protected var objectByKey:Dictionary;
		protected var keyByObject:Dictionary;
		
		public function NamedObjectMap()
		{
			flush();
		}
		
        /**
         * Checks to see if the object is in the map.
         * @param	object  The object to check.
         * @return  True if the object exists in the map. False if not.
         */
		public function hasObject( object:Object ):Boolean
		{
			return keyByObject[object] != null;
		}
		
        /**
         * Checks to see if the key exists in the map.
         * @param	key The key to check.
         * @return  True if the key exists in the map. False if not.
         */
		public function hasKey( key:String ):Boolean
		{
			return objectByKey[key] != null;
		}
		
        /**
         * Registers an object in the map.
         * @param	object  The object to register
         * @param	key     The object's lookup key
         */
		public function registerObject( object:Object, key:String ):void
		{
			objectByKey[key] = object;
			keyByObject[object] = key;
		}
		
        /**
         * Removes an object by its key name.
         * @param	key The key of the object to remove.
         */
		public function removeByKey( key:String ):void
		{
			delete keyByObject[getObject( key )];
			delete objectByKey[key];
		}
		
        /**
         * Removes the object specified by the object itself.
         * @param	object  The object to remove.
         */
		public function removeByObject( object:Object ):void
		{
			delete objectByKey[getKey( object )];
			delete keyByObject[object];
		}
		
        /**
         * Gets an object based on its key.
         * @param	key The object's key name.
         * @return  The object.
         */
		public function getObject( key:String ):*
		{
			return objectByKey[key];
		}
		
        /**
         * Get's an object key name.
         * @param	object  The object.
         * @return  The object's key name.
         */
		public function getKey( object:Object ):String
		{
			return keyByObject[object];
		}
		
        /**
         * Cleans up the object map.
         */
		public function flush():void
		{
			objectByKey = new Dictionary();
			keyByObject = new Dictionary();
		}
	}
}
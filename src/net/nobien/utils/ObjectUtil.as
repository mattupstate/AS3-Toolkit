package net.nobien.utils 
{
    import flash.utils.ByteArray;
    import flash.utils.describeType;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;

    /**
     * The ObjectUtil class contains static utility methods for analyzing and manipulating Objects.
     */
    public class ObjectUtil
    {
        public static function newSibling(sourceObj:Object):* 
        {
            if( sourceObj ) 
            {
                var objSibling:*;
                try 
                {
                    var classOfSourceObj:Class = getDefinitionByName(getQualifiedClassName(sourceObj)) as Class;
                    objSibling = new classOfSourceObj();
                }
                catch(e:Object) { }
                return objSibling;
            }
            return null;
        }
        
        public static function clone( source:Object ):Object 
        {
            var clone:Object;
            if(source) 
            {
                clone = newSibling(source);

                if(clone) 
                    copyData( source, clone );
            }
            return clone;
        }
        
        public static function copyData( source:Object, destination:Object ):void 
        {
            if((source) && (destination)) 
            {
                try 
                {
                    var sourceInfo:XML = describeType( source );
                    var prop:XML;
                    
                    for each( prop in sourceInfo.variable ) 
                    {
                        if( destination.hasOwnProperty( prop.@name ) )
                            destination[prop.@name] = source[prop.@name];
                    }

                    for each( prop in sourceInfo.accessor )
                    {
                        if( prop.@access == "readwrite") 
                        {
                            if(destination.hasOwnProperty(prop.@name)) 
                                destination[prop.@name] = source[prop.@name];
                        }   
                    }
                }
                catch ( err:Object ) {}
            }
        }
        
        /**
         * Count the properties in an object.
         * @param obj Object to count the properties of
         * @return The number of properties in the specified object. If the specified object is null, this is 0.
         */
        public static function numProperties( obj:Object ):int
        {
            var count:int = 0;
            
            for each ( var prop:Object in obj )
            {
                count++;
            }
            
            return count;
        }
         
        /**
         * Check if an object has any properties
         * @param obj Object to check for properties
         * @return If the specified object has any properties. If the specified object is null, this is false.
         */
        public static function hasProperties( obj:Object ):Boolean
        {
            for each ( var prop:Object in obj )
            {
                return true;
            }
            
            return false;
        }
        
        /**
         * Check if the properties of an object are all the same
         * @param obj Object whose properties should be checked
         * @param type Type to check the object's properties against
         * @return If all of the properties of the specified object are of the specified type
         */
        public static function isUniformPropertyType( obj:Object, type:Class ):Boolean
        {
            for each ( var prop:Object in obj )
            {
                if ( !( prop is type ) )
                {
                    return false;
                }
            }
            
            return true;
        }
        
        /**
         * Copy an object
         * @param obj Object to copy
         * @param into (optional) Object to copy into. If null, a new object is created.
         * @return A one-level deep copy of the object or null if the argument is null
         */
        public static function shallowCopy( obj:Object, into:Object=null ):Object
        {
            if ( into == null )
            {
                into = {};
            }
            if ( obj != null )
            {
                for ( var o:* in obj )
                {
                    into[o] = obj[o];
                }
            }
            return into;
        }
        
        /**
         * Creates a deep object copy of the specified object.
         * @param	obj	Object to clone
         * @return	The cloned object.
         */
        public static function deepCopy( obj:Object ):Object 
        {
            var byt:ByteArray = new ByteArray();
            byt.writeObject( obj );
            byt.position = 0;
            return byt.readObject();
        }
        
        /**
         * Convert the object to an array. Note that the order of the array is undefined.
         * @param obj Object to convert
         * @return An array with all of the properties of the given object or null if the given object is null
         */
        public static function toArray( obj:Object ):Array
        {
            if ( obj == null )
            {
                return null;
            }
            else
            {
                var ret:Array = [];
                
                for each ( var prop:Object in obj )
                {
                    ret.push( prop );
                }
                
                return ret;
            }
        }
        
        /**
         * Convert the object to a string of form: PROP: VAL&PROP: VAL where: PROP is a property VAL is its corresponding value & is the specified optional delimiter
         * @param obj Object to convert
         * @param delimiter (optional) Delimiter of property/value pairs
         * @return An string of all property/value pairs delimited by the given string or null if the input object or delimiter is null.
         */
        public static function toString( obj:Object=null, delimiter:String = "\n" ):String
        {
            if ( obj == null || delimiter == null )
            {
                return "";
            }
            else
            {
                var ret:Array = [];
                
                for ( var s:Object in obj )
                {
                    ret.push( s + ": " + obj[s] );
                }
                
                return ret.join( delimiter );
            }
        }
    }
}
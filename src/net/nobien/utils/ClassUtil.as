package net.nobien.utils 
{
    import flash.display.DisplayObject;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;

    /**
     * The ClassUtil class contains static utility methods for retrieving Class objects.
     */
    public class ClassUtil
    {
        /**
         * Get a class by its fully-qualified name
         * @param className Fully-qualified name of the class
         * @return The class with the given name or null if none exists
         */
        public static function getClassByName( className:String ):Class
        {
            var c:Class;
            
            try
            {
                return Class( getDefinitionByName( className ) );
            }
            catch( refErr:ReferenceError )
            {
                return null;
            }
            catch( typeErr:TypeError )
            {
                return null;
            }
         
            return null;
        }
        
        /**
         * Get the class of an object
         * @param obj Object to get the class of
         * @return The class of the given object or null if the class cannot be determined
         */
        public static function getClass( obj:Object ):Class
        {
            if ( obj == null )
            {
                return null;
            }
            try
            {
                var className:String = getQualifiedClassName( obj );
                var ret:Class = Class( getDefinitionByName( className ) );
                if ( ret == null && obj is DisplayObject )
                {
                    ret = getDisplayObjectClass( DisplayObject( obj ) );
                }
                return ret;
            }
            catch ( refErr:ReferenceError )
            {
                return null;
            }
            catch ( typeErr:TypeError )
            {
                return null;
            }
         
            return null;
        }
         
        /**
         * Get the class of a display object
         * @param obj Object to get the class of
         * @return The class of the given object or null if the class cannot be determined
         */
        public static function getDisplayObjectClass( obj:DisplayObject ):Class
        {
            try
            {
                return Class( obj.loaderInfo.applicationDomain.getDefinition( getQualifiedClassName( obj ) ) );
            }
            catch ( refErr:ReferenceError )
            {
                return null;
            }
            catch ( typeErr:TypeError )
            {
                return null;
            }
         
            return null;
        }
    }
}
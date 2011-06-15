package net.nobien.core 
{

    /**
     * Common component methods and properties.
     */
    public interface IComponent extends ISprite
    {
        /**
         * Moves the component to the specified coordinates.
         * @param	x	X position
         * @param	y	Y position
         */
        function move( x:Number, y:Number ):void;
        
        /**
         * Prepares the object for removal from memory.
         */
        function cleanup():void;
        
        /**
         * Is equal to <code>true</code> if the button is enabled and vice versa.
         */
        function get enabled():Boolean;
        function set enabled( value:Boolean ):void;
    }
}
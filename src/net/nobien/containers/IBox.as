package net.nobien.containers 
{
    import net.nobien.core.IDisplayObjectContainer;

    /**
     * The IBox interface defines a set of common methods and properties for box containers.
     */
    public interface IBox extends IDisplayObjectContainer
    {
        /**
         * The direction constant that specifies the manner in which the display children are arranged.
         */
        function get direction():String;
        function set direction( value:String ):void;
        
        /**
         * The amount of pixels to place between each display child.
         */
        function get itemMargin():Number;
        function set itemMargin( value:Number ):void;
        
        /**
         * The alignment rule for each child.
         */
        function get align():String;
        function set align( value:String ):void;
        
    }
}
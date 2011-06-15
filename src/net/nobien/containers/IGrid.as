package net.nobien.containers 
{
    import net.nobien.core.IDisplayObjectContainer;

    /**
     * The IGrid interface defines a set of common methods and properties for grid containers.
     */
    public interface IGrid extends IDisplayObjectContainer
    {
        /**
         * The grid's cell alignmen constant.
         */
        function get align():String;
        function set align( value:String ):void;
        
        /**
         * The canvas width of the grid.
         */
        function get canvasWidth():Number;
        function set canvasWidth( value:Number ):void;
        
        /**
         * The canvas height of the grid.
         */
        function get canvasHeight():Number;
        function set canvasHeight( value:Number ):void;
        
        /**
         * The direction constant that defines the order in which the display children are arranged.
         */
        function get direction():String;
        function set direction( value:String ):void;
        
        /**
         * The grid tile width.
         */
        function get tileWidth():Number;
        function set tileWidth( value:Number ):void;
        
        /**
         * The grid tile height.
         */
        function get tileHeight():Number;
        function set tileHeight( value:Number ):void;
    }
}
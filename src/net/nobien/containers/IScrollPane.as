package net.nobien.containers 
{
    import flash.geom.Rectangle;
    import net.nobien.controls.ISlider;
    import net.nobien.core.IDisplayObjectContainer;

    /**
     * The IScrollPane interface defines a set of common methods and properties for scrollable containers.
     */
    public interface IScrollPane extends IDisplayObjectContainer
    {
        /**
         * The vertical scrollbar. Scrollbar instance must implement the ISlider interface.
         * @see net.nobien.controls.interfaces.ISlider
         */
        function get vScrollbar():ISlider;
        function set vScrollbar( v:ISlider ):void;
        
        /**
         * The horizontal scrollbar. Scrollbar instance must implement the ISlider interface.
         * @see net.nobien.controls.interfaces.ISlider
         */
        function get hScrollbar():ISlider
        function set hScrollbar( v:ISlider ):void
        
        /**
         * Specifies the vertical scroll position as a number between 0 and 1.
         */
        function get vScroll():Number;
        function set vScroll( value:Number ):void;
        
        /**
         * Specifies the horizontal scroll position as a number between 0 and 1.
         */
        function get hScroll():Number;
        function set hScroll( value:Number ):void;
        
        /**
         * The scroll window.
         */
        function get scrollWindow():Rectangle;
        function set scrollWindow( value:Rectangle ):void;
    }
}
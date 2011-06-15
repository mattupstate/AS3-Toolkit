package net.nobien.controls
{
    import flash.display.Sprite;
    import net.nobien.core.IComponent;

    /**
     * The ISlider interface defines a set of common methods and properties for sliders/scroll bars.
     */
    public interface ISlider extends IComponent
    {
        /**
         * The draggable part of the slider.
         */
        function set thumb( value:Sprite ):void;
        function get thumb():Sprite;
        
        /**
         * Specifies the position of the slider expressed as a number between 0 and 1.
         */
        function get position():Number;
        function set position( value:Number ):void;
    }
}
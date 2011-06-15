package net.nobien.controls
{
    import net.nobien.core.IComponent;

    /**
     * The IButton interface defines a set of common methods and properties for buttons.
     */
    public interface IButton extends IComponent
    {
        /**
         * Is equal to <code>true</code> if the button is selected and vice versa.
         */
        function get selected():Boolean;
        function set selected( value:Boolean ):void;
    }
}

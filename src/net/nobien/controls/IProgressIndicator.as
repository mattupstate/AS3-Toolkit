package net.nobien.controls
{
    import net.nobien.core.IComponent;

    /**
     * The IProgressIndicator interface defines a set of common methods and properties for progress indicators.
     */
    public interface IProgressIndicator extends IComponent
    {
        /**
         * Specifies the progress value expressed as a number between 0 and 1.
         */
        function get progress():Number;
        function set progress( value:Number ):void;
    }
}

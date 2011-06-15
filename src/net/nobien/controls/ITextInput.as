package net.nobien.controls
{
    /**
     * The ITextInput interface defines a set of common methods and properties for text input controls.
     */
    public interface ITextInput extends ITextControl
    {
        /**
         * Specifies if the text input is editable.
         */
        function get editable():Boolean;
        function set editable( value:Boolean ):void;
        
        /**
         * A string of characters that are allowed in the text input.
         */
        function get restrict():String;
        function set restrict( value:String ):void;	
        
        /**
         * The maxmium amount of characters allowed in the text input.
         */
        function get maxChars():int;
        function set maxChars( value:int ):void;
        
        /**
         * Equal to <code>true</code> if the text input should conceal the text input.
         */
        function get displayAsPassword():Boolean;
        function set displayAsPassword( value:Boolean ):void;
    }
}
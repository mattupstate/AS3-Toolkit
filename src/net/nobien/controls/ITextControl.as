package net.nobien.controls 
{
    import flash.text.TextField;
    import flash.text.TextFormat;
    import net.nobien.core.IComponent;

    /**
     * The ITextControl interface defines a set of common methods and properties for text controls.
     */
    public interface ITextControl extends IComponent
    {
        /**
         * Specifies if the text expects a bitmap font.
         */
        function get bitmapFont():Boolean;
        function set bitmapFont( value:Boolean ):void;
        
        /**
         * Specifies if the content should be rendered as HTML.
         */
        function get html():Boolean;
        function set html( value:Boolean ):void;
        
        /**
         * Specifies if the text control can be scrolled with the mouse wheel.
         */
        function set mouseWheelEnabled( value:Boolean ):void;
        function get mouseWheelEnabled():Boolean;
        
        /**
         * Specifies if the text should be selectable.
         */
        function get selectable():Boolean;
        function set selectable( value:Boolean ):void;
        
        /**
         * The text displayed by the component.
         */
        function get text():String;
        function set text( value:String ):void;
        
        /**
         * The internal TextField used by the component.
         */
        function set textField( value:TextField ):void;
        function get textField():TextField;
        
        /**
         * The text input text format object.
         */
        function get textFormat():TextFormat;
        function set textFormat( value:TextFormat ):void;
        
        /**
         * Specifies if the text control should use embedded fonts.
         */
        function get useEmbeddedFonts():Boolean;
        function set useEmbeddedFonts( value:Boolean ):void;
    }
}
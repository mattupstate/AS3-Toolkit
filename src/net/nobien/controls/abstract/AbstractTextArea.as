package net.nobien.controls.abstract 
{
	import net.nobien.utils.TextFieldUtil;

    /**
     * The AbstractTextArea class is used to create custom text area components. Extending this 
     * class will give your custom text area a set of common methods and properties that a basic
     * text arear should have.
     */
    public class AbstractTextArea extends AbstractTextControl
    {
        protected var _textWidth:Number = 300;
        protected var _textHeight:Number = 0;
        
        /**
         * Creates a new <code>AbstractTextArea</code> object.
         */
        public function AbstractTextArea() 
        {
            
        }
        
        override protected function setText():void 
        {
            if( _html )
                TextFieldUtil.setHTMLTextColumn( textField, text, textWidth, textHeight, useEmbeddedFonts, bitmapFont );
            else
                TextFieldUtil.setPlainTextColumn( textField, text, textWidth, textHeight, useEmbeddedFonts, bitmapFont );
        }
        
        /**
         * The height of the text field within the component.
         */
        public function get textHeight():Number { return _textHeight; }
        public function set textHeight( value:Number ):void 
        {
            if( _textHeight != value )
            {
                _textHeight = value;
                invalidate();
            }
        }
        
        /**
         * The width of the text field within the component.
         */
        public function get textWidth():Number { return _textWidth; }
        public function set textWidth( value:Number ):void 
        {
            if( _textWidth != value )
            {
                _textWidth = value;
                invalidate();
            }
        }
        
    }
}
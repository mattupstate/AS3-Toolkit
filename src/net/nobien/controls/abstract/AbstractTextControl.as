package net.nobien.controls.abstract 
{
	import net.nobien.core.SpriteComponent;
	import net.nobien.utils.TextFieldUtil;
	import flash.text.TextField;
	import flash.text.TextFormat;
    
    /**
     * The AbstractTextControl class is used to create custom text control components. Extending this 
     * class will give your custom text control a set of common methods and properties that a basic
     * text control should have.
     */
    public class AbstractTextControl extends SpriteComponent
    {
        protected var _bitmapFont:Boolean = false;
        protected var _html:Boolean = false;
        protected var _mouseWheelEnabled:Boolean = false;
        protected var _selectable:Boolean = false;
        protected var _text:String = "";
        protected var _textField:TextField;
        protected var _textFormat:TextFormat;
        protected var _useEmbeddedFonts:Boolean = false;
        
        public function AbstractTextControl()
        {
            
        }
        
        protected function setText():void
        {
            if( _html )
                TextFieldUtil.setHTMLTextField( textField, text, 0, useEmbeddedFonts, bitmapFont );
            else
                TextFieldUtil.setPlainTextField( textField, text, 0, useEmbeddedFonts, bitmapFont );
        }
        
        override protected function draw():void 
        {
            if( textFormat ) textField.defaultTextFormat = textFormat;
            textField.mouseWheelEnabled = mouseWheelEnabled;
            textField.selectable = selectable;
            setText();   
            super.draw();
        }
        
        override protected function enable():void 
        {
            mouseChildren = true;
            super.enable();
        }
        
        override protected function disable():void 
        {
            mouseChildren = false;
            super.disable();
        }
        
        override public function validate():void 
        {
            if( textField != null )
                initialized = true;
                
            super.validate();
        }
        
        /**
         * Specifies if the text expects a bitmap font.
         */
        public function get bitmapFont():Boolean { return _bitmapFont; }
        public function set bitmapFont( value:Boolean ):void 
        {
            if( _bitmapFont != value )
            {
                _bitmapFont = value;
                invalidate();
            }
        }
        
        /**
         * Specifies if the content should be rendered as HTML.
         */
        public function get html():Boolean { return _html; }
        public function set html( value:Boolean ):void 
        {
            if( _html != value )
            {
                _html = value;
                invalidate();
            }
        }
        
        /**
         * Specifies if the text field should be mouse wheel enabled.
         */
        public function get mouseWheelEnabled():Boolean { return _mouseWheelEnabled; }
        public function set mouseWheelEnabled( value:Boolean ):void 
        {
            if( _mouseWheelEnabled != value )
            {
                _mouseWheelEnabled = value;
                invalidate();
            }
        }
        
        /**
         * Specifies if the text should be selectable.
         */
        public function get selectable():Boolean { return _selectable; }
        public function set selectable( value:Boolean ):void 
        {
            if( _selectable != value )
            {
                _selectable = value;
                invalidate();
            }
        }
        
        /**
         * The text.
         */
        public function get text():String { return _text; }
        public function set text( value:String ):void
        {
            if( _text != value )
            {
                _text = value;
                invalidate();
            }
        }
        
        /**
         * Access to the internal text field of the component.
         */
        public function get textField():TextField { return _textField; }
        public function set textField( value:TextField ):void 
        {
            if( _textField != value )
            {
                _textField = value;
                invalidate();
            }
        }
        
        /**
         * The default text format to use when not using HTML formatted text.
         */
        public function get textFormat():TextFormat { return _textFormat; }
        public function set textFormat( value:TextFormat ):void 
        {
            if( _textFormat != value )
            {
                _textFormat = value;
                invalidate();
            }
        }
        
        public function get useEmbeddedFonts():Boolean { return _useEmbeddedFonts; }
        public function set useEmbeddedFonts( value:Boolean ):void 
        {
            if( _useEmbeddedFonts != value )
            {
                _useEmbeddedFonts = value;
                invalidate();
            }
        }
        
    }
}
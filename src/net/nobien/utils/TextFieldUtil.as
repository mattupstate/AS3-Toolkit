package net.nobien.utils 
{
	import flash.display.BlendMode;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextLineMetrics;

    /**
     * The TextFieldUtil class contains static utility functions for creating and manipulating TextFields.
     */
    public class TextFieldUtil
    {
        static private function _setHTMLText( tf:TextField, content:String, useEmbeddedFonts:Boolean = false ):void
        {
            tf.embedFonts = useEmbeddedFonts;
            tf.htmlText = StringUtil.removeLineBreaks( content );
        }
        
        static private function _setPlainText( tf:TextField, content:String, useEmbeddedFonts:Boolean = false ):void
        {
            tf.embedFonts = useEmbeddedFonts;
            tf.text = content;
        }
        
        static private function _setTextFieldAliasing( tf:TextField, bitmapFont:Boolean ):void
        {
            if( !bitmapFont )
                tf.antiAliasType = ( tf.embedFonts ) ? AntiAliasType.ADVANCED : AntiAliasType.NORMAL;
        }
        
        static private function _setTextFieldSize( tf:TextField, width:Number = 0, height:Number = 0 ):void
        {
            if( width > 0 )
                tf.width = width;
            
            if( height > 0 )
                tf.height = height;
        }
        
        static private function _setSingleLineTextFieldWidth( tf:TextField, width:Number = 0 ):void
        {
            if( width > 0 )
            {
                var metrics:TextLineMetrics = tf.getLineMetrics(0);
                tf.autoSize = TextFieldAutoSize.NONE;
                tf.width = width;
                tf.height = metrics.height + 4;
            }
        }
        
        /**
         * Encapsulates the creation of a <code>TextField</code> object using commonly specified properties.
         * @param	autoSize    Autosize direction of the text field
         * @param	wordWrap    If the text field should wrap text based on its width
         * @param	multline    If the text field should render more than one line
         * @param	selectable  If the text should be selectable
         * @param	mouseWheenEnabled   If the mouse wheel should be enabled for the text field
         * @return  A TextField object.
         */
        static public function createTextField( selectable:Boolean = false, mouseWheelEnabled:Boolean = false ):TextField
        {
            var tf:TextField = new TextField();
            tf.type = TextFieldType.DYNAMIC;
            tf.selectable = selectable;
            tf.mouseWheelEnabled = mouseWheelEnabled;
            tf.blendMode = BlendMode.LAYER;
            return tf;
        }
        
        /**
         * Creates a plain <code>TextField</code> that dynamically adjusts its width based on the content 
         * placed within it. Additionally, <code>embedFonts</code> and <code>antiAliasType</code> properties 
         * are automatically adjusted based on the specified content and formatting options.
         * @param	content     The text field content
         * @param	width       The width of the text field
         * @param	selectable  If the text should be selectable
         * @param	bitmapFont  If the font used is a bitmap font
         * @return  A TextField object
         */
        static public function createPlainTextField( content:String, width:Number = 0, selectable:Boolean = false, useEmbeddedFonts:Boolean = false, bitmapFont:Boolean = false ):TextField
        {
            var tf:TextField = createTextField( selectable );
            setPlainTextField( tf, content, width, useEmbeddedFonts, bitmapFont );
            return tf;
        }
        
        /**
         * Sets the content of an existing <code>TextField</code> object and dynamically adjusts its width based on the 
         * content placed within it. Additionally, <code>embedFonts</code> and <code>antiAliasType</code> properties 
         * are automatically adjusted based on the specified content and formatting options.
         * @param	tf          A text field
         * @param	content     The text field content
         * @param	width       The text field width
         * @param	textFormat  The text format for the text field
         * @param	bitmapFont  If the font used is a bitmap font
         */
        static public function setPlainTextField( tf:TextField, content:String, width:Number = 0, useEmbeddedFonts:Boolean = false, bitmapFont:Boolean = false ):void
        {
            tf.autoSize = ( width > 0) ? TextFieldAutoSize.NONE : TextFieldAutoSize.LEFT;
            tf.multiline = false;
            tf.wordWrap = false;
            _setPlainText( tf, content, useEmbeddedFonts );
            _setTextFieldAliasing( tf, bitmapFont );
            _setSingleLineTextFieldWidth( tf, width );
        } 
        
        /**
         * Creates a plain <code>TextField</code> column that dynamically adjusts its height based on the 
         * content placed within it. Additionally, <code>embedFonts</code> and <code>antiAliasType</code> properties 
         * are automatically adjusted based on the specified content and formatting options.
         * @param	content     The text field content
         * @param	width       The width of the text field
         * @param	selectable  If the text is selectable
         * @param	bitmapFont  If the font used is a bitmap font
         * @return  A TextField object
         */
        static public function createPlainTextColumn( content:String, width:Number = 300, height:Number = 300, selectable:Boolean = false, useEmbeddedFonts:Boolean = false, bitmapFont:Boolean = false ):TextField
        {
            var tf:TextField = createTextField( selectable );
            setPlainTextColumn( tf, content, width, height, useEmbeddedFonts, bitmapFont );
            return tf;
        }
        
        /**
         * Sets the content of an existing <code>TextField</code> object and dynamically adjusts its height based on the 
         * content placed within it. Additionally, <code>embedFonts</code> and <code>antiAliasType</code> properties 
         * are automatically adjusted based on the specified content and formatting options.
         * @param	tf          A text field
         * @param	content     The text field content
         * @param	width       The width of the text field
         * @param	height      The height of the text field
         * @param	textFormat  The text format for the text field
         * @param	bitmapFont  If the font used is a bitmap font
         */
        static public function setPlainTextColumn( tf:TextField, content:String, width:Number = 300, height:Number = 0, useEmbeddedFonts:Boolean = false, bitmapFont:Boolean = false  ):void
        {
            tf.autoSize = ( height > 0 ) ? TextFieldAutoSize.NONE : TextFieldAutoSize.LEFT;
            tf.multiline = true;
            tf.wordWrap = true;
            _setPlainText( tf, content, useEmbeddedFonts );
            _setTextFieldAliasing( tf, bitmapFont );
            _setTextFieldSize( tf, width, height );
        }
        
        /**
         * Creates an HTML <code>TextField</code> that dynamically adjusts its width based on the content 
         * placed within it. Additionally, <code>embedFonts</code> and <code>antiAliasType</code> properties 
         * are automatically adjusted based on the specified content and formatting options.
         * @param	content     The text field content
         * @param	width       The width of the text field
         * @param	selectable  If the text is selectable
         * @param	bitmapFont  If the font used is a bitmap font
         * @return  A TextField object
         */
        static public function createHTMLTextField( content:String, width:Number = 0, selectable:Boolean = false, useEmbeddedFonts:Boolean = false, bitmapFont:Boolean = false ):TextField
        {
            var tf:TextField = createTextField( selectable );
            setHTMLTextField( tf, content, width, useEmbeddedFonts, bitmapFont );
            return tf;
        }
        
        /**
         * Sets the content of an existing <code>TextField</code> object and dynamically adjusts its width based on the 
         * content placed within it. Additionally, <code>embedFonts</code> and <code>antiAliasType</code> properties 
         * are automatically adjusted based on the specified content and formatting options.
         * @param	tf          A text field
         * @param	content     The text field content
         * @param	width       The width of the text field
         * @param	bitmapFont  If the font used is a bitmap font
         */
        static public function setHTMLTextField( tf:TextField, content:String, width:Number = 0, useEmbeddedFonts:Boolean = false, bitmapFont:Boolean = false  ):void
        {
            tf.autoSize = TextFieldAutoSize.LEFT;
            tf.multiline = false;
            tf.wordWrap = false;
            _setHTMLText( tf, content, useEmbeddedFonts );
            _setTextFieldAliasing( tf, bitmapFont );
            _setSingleLineTextFieldWidth( tf, width );
        }
        
        /**
         * Creates an HTML <code>TextField</code> column that dynamically adjusts its height based on the 
         * content placed within it. Additionally, <code>embedFonts</code> and <code>antiAliasType</code> properties 
         * are automatically adjusted based on the specified content and formatting options.
         * @param	content     The text field content
         * @param	width       The width of the text field
         * @param	selectable  If the text is selectable
         * @param	bitmapFont  If the font used is a bitmap font
         * @return
         */
        static public function createHTMLTextColumn( content:String, width:Number = 300, height:Number = 300, selectable:Boolean = false, useEmbeddedFonts:Boolean = false, bitmapFont:Boolean = false ):TextField
        {
            var tf:TextField = createTextField( selectable );
            setHTMLTextColumn( tf, content, width, height, useEmbeddedFonts, bitmapFont );
            return tf;
        }
        
        /**
         * Sets the content of an existing <code>TextField</code> object and dynamically adjusts its height based on the 
         * content placed within it. Additionally, <code>embedFonts</code> and <code>antiAliasType</code> properties 
         * are automatically adjusted based on the specified content and formatting options.
         * @param	tf          A text field
         * @param	content     The text field content
         * @param	width       The width of the text field
         * @param	height      The height of the text field
         * @param	bitmapFont  If the font used is a bitmap font
         */
        static public function setHTMLTextColumn( tf:TextField, content:String, width:Number = 300, height:Number = 300, useEmbeddedFonts:Boolean = false, bitmapFont:Boolean = false  ):void
        {
            tf.autoSize = ( height > 0 ) ? TextFieldAutoSize.NONE : TextFieldAutoSize.LEFT;
            tf.multiline = true;
            tf.wordWrap = true;
            _setHTMLText( tf, content, useEmbeddedFonts );
            _setTextFieldAliasing( tf, bitmapFont );
            _setTextFieldSize( tf, width, height );
        }
        
        /**
         * Checks if the specified font has been registered in the global <code>Font</code> registry.
         * @param	fontName	The font name.
         * @param	style		The font style. Either regular, bold, italic, or boldItalic
         * @return  True if the font is registered. False if not.
         */
        static public function isFontRegistered( fontName:String, style:String = "regular" ):Boolean
        {
            var result:Boolean = false;
            var fonts:Array = Font.enumerateFonts();
            
            for( var i:int = 0; i < fonts.length; i++ )
            {
                var f:Font = fonts[i];
                
                if( fontName == f.fontName && style == f.fontStyle )
                {
                    result = true;
                    break;
                }
            }
            
            return result;
        }
    }
}
package net.nobien.controls.abstract
{
	import net.nobien.events.InputEvent;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	
    
    /**
     * Dispatched when the user inputs one or more characters of text.
     * @eventType flash.events.TextEvent
     */
    [Event(name="textInput", type="flash.events.TextEvent")]

    /**
     * Dispatched when the text input gains focus.
     * @eventType flash.events.FocusEvent
     */
    [Event(name="focusIn", type="flash.events.FocusEvent")]

    /**
     * Dispatched when the text input loses focus.
     * @eventType flash.events.FocusEvent
     */
    [Event(name="focusOut", type="flash.events.FocusEvent")]

    /**
     * Dispatched when the user presses the ENTER button on their keyboard and the TextInput has focus .
     * @eventType net.nobien.events.InputEvent
     */
    [Event(name="inputEnter", type="net.nobien.events.InputEvent")]

    /**
     * The AbstractTextInput class is used to create custom text input components. Extending this 
     * class will give your custom text input a set of common methods and properties that a basic
     * text input should have.
     */
    public class AbstractTextInput extends AbstractTextControl
    {
        protected var _displayAsPassword:Boolean = false;
        protected var _editable:Boolean = true;
        protected var _maxChars:int = 0;
        protected var _restrict:String;
        
        /**
         * Creates a new <code>AbstractTextInput</code> object.
         * @param	autoEnable	Specifies if the component is automatically enabled upon it being initialized.
         * @param	autoInit	Specifies if the component should instantly initialize. A value of false assumes the component must wait for various properties to be set before being initialized.
         */
        public function AbstractTextInput() 
        {
            
        }
        
        /**
         * Utility method which dispatches <code>InputEvent.ENTER</code> event.
         */
        protected function notifyEnterButton():void
        {
            dispatchEvent( new InputEvent( InputEvent.ENTER ) );
        }
        
        /**
         * Adds the event listeners to the text field.
         */
        protected function initEventListeners():void
        {
            if( textField )
            {
                textField.addEventListener( Event.CHANGE, onTextFieldChange );
                textField.addEventListener( TextEvent.TEXT_INPUT, onTextInput );
                textField.addEventListener( FocusEvent.FOCUS_IN, onTextFieldFocusIn );
                textField.addEventListener( FocusEvent.FOCUS_OUT, onTextFieldFocusOut );
            }
        }
        
        /**
         * Removes the event listeners on the text field.
         */
        protected function killEventListeners():void
        {
            if( textField )
            {
                textField.removeEventListener( Event.CHANGE, onTextFieldChange );
                textField.removeEventListener( TextEvent.TEXT_INPUT, onTextInput );
                textField.removeEventListener( FocusEvent.FOCUS_IN, onTextFieldFocusIn );
                textField.removeEventListener( FocusEvent.FOCUS_OUT, onTextFieldFocusOut );
            }
            
            removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
        }
        
        /**
         * TextEvent.TEXT_INPUT event handler.
         * @param	event
         */
        protected function onTextInput( event:TextEvent ):void 
        {
            event.stopPropagation();
            dispatchEvent( event.clone() );
        }
        
        /**
         * Abstracted <code>Event.CHANGE</code> event functionality of the text field. 
         * Override with custom behavior. Note: By default, the text field is not configued 
         * with this event handler. You must add it yourself.
         * @param event Event object.
         */
        protected function onTextFieldChange( event:Event ):void
        {
            _text = textField.text;
            event.stopPropagation();
            dispatchEvent( event.clone() );
        }
        
        /**
         * Abstracted <code>FocusEvent.FOCUS_IN</code> event functionality of the text field. 
         * Override with custom behavior. Note: By default, the text field is not configued 
         * with this event handler. You must add it yourself.
         * @param event FocusEvent object.
         */
        protected function onTextFieldFocusIn( event:FocusEvent ):void
        {
            addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
            dispatchEvent( event.clone() );
        }
        
        /**
         * Abstracted <code>FocusEvent.FOCUS_OUT</code> event functionality of the text field. 
         * Override with custom behavior. Note: By default, the text field is not configued 
         * with this event handler. You must add it yourself.
         * @param event FocusEvent object.
         */
        protected function onTextFieldFocusOut( event:FocusEvent ):void
        {
            removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
            dispatchEvent( event.clone() );
        }
        
        /**
         * Abstracted <code>KeyboardEvent.KEY_UP</code> event functionality. This event handler
         * becomes active only when the text field gains focus to manage the dispatching of a
         * <code>InputEvent.ENTER</code> event. Override with custom behavior.
         * @param event KeyboardEvent object.
         */
        protected function onKeyUp( event:KeyboardEvent ):void
        {
            if ( event.charCode == Keyboard.ENTER )
                notifyEnterButton();
        }
        
        override protected function enable():void 
        {
            initEventListeners();
            super.enable();
        }
        
        override protected function disable():void 
        {
            killEventListeners();
            super.disable();
        }
        
        override protected function setText():void 
        {
            textField.text = text;
        }
        
        override protected function draw():void 
        {
            textField.displayAsPassword = displayAsPassword;
            textField.embedFonts = useEmbeddedFonts;
            textField.maxChars = maxChars;
            textField.restrict = restrict;
            textField.type = ( editable ) ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
            
            if( !bitmapFont )
                textField.antiAliasType = ( useEmbeddedFonts ) ? AntiAliasType.ADVANCED : AntiAliasType.NORMAL;
            
            super.draw();
        }
        
        /**
         * Equal to <code>true</code> if the text input should conceal the text input.
         */
        public function get displayAsPassword():Boolean { return textField.displayAsPassword; }
        public function set displayAsPassword( value:Boolean):void
        {
            if( _displayAsPassword != value )
            {
                _displayAsPassword = value;
                invalidate();
            }
        }
        
        /**
         * Equal to <code>true</code> if the text input is editable.
         */
        public function get editable():Boolean { return _editable; }
        public function set editable( value:Boolean ):void
        {
            if( _editable != value )
            {
                _editable = value;
                invalidate();
            }
        }
        
        /**
         * The maxmium amount of characters allowed in the text input.
         */
        public function get maxChars():int { return _maxChars; }
        public function set maxChars( value:int ):void
        {
            if( _maxChars != value )
            {
                _maxChars = value;
                invalidate();
            }
        }
        
        /**
         * A string of characters that are allowed in the text input.
         */
        public function get restrict():String { return _restrict; }
        public function set restrict( value:String ):void
        {
            if( _restrict != value )
            {
                _restrict = value;
                invalidate();
            }
        }
        
    }
}
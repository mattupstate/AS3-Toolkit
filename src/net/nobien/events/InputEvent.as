package net.nobien.events 
{
    import flash.events.Event;

    /**
     * An InputEvent object is dispatched when simple user input has been made. These events are usually generated when a
     * user interacts with a component that allows for user input.
     */
    public class InputEvent extends Event
    {
        /**
         * The <code>InputEvent.ENTER</code> constant defines the value of the type property of an <code>inputEnter</code> event object.
         */
        public static const ENTER:String = "inputEnter";
        
        /**
         * The <code>InputEvent.CHANGE</code> constant defines the value of the type property of an <code>inputChange</code> event object.
         */
        public static const CHANGE:String = "inputChange";
        
        /**
         * Creates an InputEvent object to pass as a parameter to event listeners.
         * @param	type		The type of the event, accessible as InputEvent.type.
         * @param	bubbles		Determines whether the ComponentEvent object participates in the bubbling stage of the event flow. The default value is false.
         * @param	cancelable	Determines whether the InputEvent object can be canceled. The default values is false.
         */
        public function InputEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) 
        {
            super( type, bubbles, cancelable );
        }
        
        public override function clone():Event 
        { 
            return new InputEvent(type, bubbles, cancelable);
        } 
        
        public override function toString():String 
        { 
            return formatToString("InputEvent", "type", "bubbles", "cancelable", "eventPhase"); 
        }
    }
}

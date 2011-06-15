package net.nobien.events 
{
    import flash.events.Event;

    /**
     * The SliderEvent class represents the event object passed to the event listener for the sliderChange, 
     * sliderThumbPress, sliderThumbRelease, and sliderThumbDrag events for a standardized slider component.
     * @see net.nobien.controls.abstract.AbstractSlider
     */
    public class SliderEvent extends Event
    {
        /**
         * The <code>SliderEvent.THUMB_PRESS</code> constant defines the value of the type property of an <code>sliderThumbPress</code> event object.
         */
        public static const THUMB_PRESS:String = "sliderThumbPress";
        
        /**
         * The <code>SliderEvent.THUMB_RELEASE</code> constant defines the value of the type property of an <code>sliderThumbRelease</code> event object.
         */
        public static const THUMB_RELEASE:String = "sliderThumbRelease";
        
        /**
         * The <code>SliderEvent.THUMB_DRAG</code> constant defines the value of the type property of an <code>sliderThumbDrag</code> event object.
         */
        public static const THUMB_DRAG:String = "sliderThumbDrag";
        
        /**
         * Creates a SliderEvent object to pass as a parameter to event listeners.
         * @param	type		The type of the event, accessible as SliderEvent.type.
         * @param	bubbles		Determines whether the SliderEvent object participates in the bubbling stage of the event flow. The default value is false.
         * @param	cancelable	Determines whether the SliderEvent object can be canceled. The default values is false.
         */
        public function SliderEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) 
        {
            super( type, bubbles, cancelable );
        }
        
        public override function clone():Event 
        { 
            return new SliderEvent(type, bubbles, cancelable);
        } 
        
        public override function toString():String 
        { 
            return formatToString("SliderEvent", "type", "bubbles", "cancelable", "eventPhase"); 
        }
    }
}

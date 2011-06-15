package net.nobien.events 
{
    import flash.events.Event;
    
    public class TransitionEvent extends Event 
    {
        public static const TRANSITION_IN_START:String = "transitionInStart";
        public static const TRANSITION_OUT_START:String = "transitionOutStart";
        public static const TRANSITION_IN_COMPLETE:String = "transitionInComplete";
        public static const TRANSITION_OUT_COMPLETE:String = "transitionOutComplete";
        
        /**
         * Creates a new TransitionEvent object.
         * @param	type The type of the event, accessible as TransitionEvent.type.
         * @param	bubbles	Determines whether the TransitionEvent object participates in the bubbling stage of the event flow. The default value is false.
         * @param	cancelable Determines whether the TransitionEvent object can be canceled. The default values is false.
         */
        public function TransitionEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) 
        { 
            super( type, bubbles, cancelable );
        } 
        
        public override function clone():Event 
        { 
            return new TransitionEvent( type, bubbles, cancelable );
        } 
        
        public override function toString():String 
        { 
            return formatToString( "TransitionEvent", "type", "bubbles", "cancelable", "eventPhase" ); 
        }
        
    }
    
}
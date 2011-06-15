package net.nobien.events 
{	
    import flash.events.Event;

    /**
     * A BufferingEvent object is dispatched when a buffering operation has begun, has made progress, or has completed. These events are usually
     * generated when media is being loaded by the application.
     */
    public class BufferEvent extends Event 
    {
        /**
         * The <code>BufferingEvent.BUFFERING_START</code> constant defines the value of the type property of an <code>bufferingStart</code> event object.
         */
        public static const BUFFER_START:String = "bufferingStart";
        
        /**
         * The <code>BufferingEvent.BUFFERING_PROGRESS</code> constant defines the value of the type property of an <code>bufferingProgress</code> event object.
         */
        public static const BUFFER_PROGRESS:String = "bufferingProgress";
        
        /**
         * The <code>BufferingEvent.BUFFERING_COMPLETE</code> constant defines the value of the type property of an <code>bufferingComplete</code> event object.
         */
        public static const BUFFER_COMPLETE:String = "bufferingComplete";
        
        private var _progress:Number;
        
        /**
         * Creates a BufferEvent object to pass as a parameter to event listeners.
         * @param	type		The type of the event, accessible as BufferingEvent.type.
         * @param	bubbles		Determines whether the BufferingEvent object participates in the bubbling stage of the event flow. The default value is false.
         * @param	cancelable	Determines whether the BufferingEvent object can be canceled. The default values is false.
         * @param	progress	A value between 0 and 1 representing the buffering progress at the time the listener processes the event.
         */
        public function BufferEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, progress:Number = 0 ) 
        { 
            super( type, bubbles, cancelable );
            _progress = progress;
        } 
        
        public override function clone():Event 
        { 
            return new BufferEvent( type, bubbles, cancelable, progress );
        } 
        
        public override function toString():String 
        { 
            return formatToString( "BufferEvent", "type", "bubbles", "cancelable", "eventPhase", "progress" ); 
        }
        
        /**
         * A value between 0 and 1 representing the buffering progress at the time the listener processes the event.
         */
        public function get progress():Number { return _progress; }
    }
}
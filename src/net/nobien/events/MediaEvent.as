package net.nobien.events 
{
    import flash.events.Event;

    /**
     * The MediaEvent class represents the event object passed to the event listener for various types of media, 
     * most often videos and music.
     */
    public class MediaEvent extends Event 
    {
        /**
         * The <code>MediaEvent.COMPLETE</code> constant defines the value of the type property of an <code>mediaComplete</code> event object.
         */
        public static const COMPLETE:String = "mediaComplete";
        
        /**
         * The <code>MediaEvent.CUE_POINT</code> constant defines the value of the type property of an <code>mediaCuePoint</code> event object.
         */
        public static const CUE_POINT:String = "mediaCuePoint";
        
        /**
         * The <code>MediaEvent.META_DATA</code> constant defines the value of the type property of an <code>mediaMetaData</code> event object.
         */
        public static const META_DATA:String = "mediaMetaData";
        
        /**
         * The <code>MediaEvent.PAUSED</code> constant defines the value of the type property of an <code>mediaPaused</code> event object.
         */
        public static const PAUSED:String = "mediaPaused";
        
        /**
         * The <code>MediaEvent.PLAYING</code> constant defines the value of the type property of an <code>mediaPlaying</code> event object.
         */
        public static const PLAYING:String = "mediaPlaying";
        
        /**
         * The <code>MediaEvent.REWIND</code> constant defines the value of the type property of an <code>mediaRewind</code> event object.
         */
        public static const REWIND:String = "mediaRewind";
        
        /**
         * The <code>MediaEvent.SEEK</code> constant defines the value of the type property of an <code>mediaSeek</code> event object.
         */
        public static const SEEK:String = "mediaSeek";
        
        /**
         * The <code>MediaEvent.STOP</code> constant defines the value of the type property of an <code>mediaStop</code> event object.
         */
        public static const STOP:String = "mediaStop";
        
        /**
         * The <code>MediaEvent.TIME</code> constant defines the value of the type property of an <code>mediaTime</code> event object.
         */
        public static const TIME:String = "mediaTime";
        
        /**
         * Creates a MediaEvent object to pass as a parameter to event listeners.
         * @param	type		The type of the event, accessible as MediaEvent.type.
         * @param	bubbles		Determines whether the MediaEvent object participates in the bubbling stage of the event flow. The default value is false.
         * @param	cancelable	Determines whether the MediaEvent object can be canceled. The default values is false.
         */
        public function MediaEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) 
        { 
            super(type, bubbles, cancelable);
        } 
        
        public override function clone():Event 
        { 
            return new MediaEvent( type, bubbles, cancelable );
        } 
        
        public override function toString():String 
        { 
            return formatToString( "MediaEvent", "type", "bubbles", "cancelable", "eventPhase" ); 
        }
    }
}
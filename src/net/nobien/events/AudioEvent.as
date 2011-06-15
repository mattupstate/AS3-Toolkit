package net.nobien.events 
{
    import flash.events.Event;

    /**
     * The SoundEvent class represents the event object passed to the event listener for various sound related events.
     */
    public class AudioEvent extends Event 
    {
        /**
         * The <code>SoundEvent.VOLUME_CHANGE</code> constant defines the value of the type property of an <code>soundVolumeChange</code> event object.
         */
        public static const VOLUME_CHANGE:String = "soundVolumeChange";
        
        /**
         * The <code>SoundEvent.PAN_CHANGE</code> constant defines the value of the type property of an <code>soundPanChange</code> event object.
         */
        public static const PAN_CHANGE:String = "soundPanChange";
        
        /**
         * The <code>SoundEvent.MUTE_CHANGE</code> constant defines the value of the type property of an <code>soundMuteChange</code> event object.
         */
        public static const MUTE_CHANGE:String = "soundMuteChange";
        
        /**
         * Creates a AudioEvent object to pass as a parameter to event listeners.
         * @param	type		The type of the event, accessible as SoundEvent.type.
         * @param	bubbles		Determines whether the SoundEvent object participates in the bubbling stage of the event flow. The default value is false.
         * @param	cancelable	Determines whether the SoundEvent object can be canceled. The default values is false.
         */
        public function AudioEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) 
        { 
            super( type, bubbles, cancelable );
            
        } 
        
        public override function clone():Event 
        { 
            return new AudioEvent( type, bubbles, cancelable );
        } 
        
        public override function toString():String 
        { 
            return formatToString( "SoundEvent", "type", "bubbles", "cancelable", "eventPhase" ); 
        }
    }
}
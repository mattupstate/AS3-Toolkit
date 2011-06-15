package net.nobien.controls.abstract 
{
	import net.nobien.core.SpriteComponent;
	import net.nobien.utils.NumberUtil;
	import flash.events.Event;

    /**
     * Dispatched when the progress indicator has visually indicated a 100% progress.
     * @eventType flash.events.Event
     */
    [Event(name="complete", type="flash.events.Event")]

    /**
     * The AbstractProgressIndicator class is used to create custom progress indicator components. Extending this 
     * class will give your custom progress indicator a set of common methods and properties that a basic
     * progress indicator should have.
     */
    public class AbstractProgressIndicator extends SpriteComponent
    {
        /**
         * The progress value.
         */
        protected var _progress:Number = 0;
        
        /**
         * Creates a new <code>AbstractProgressIndicator</code> object.
         */
        public function AbstractProgressIndicator() 
        {
            
        }
        
        /**
         * Dispatches an Event.COMPLETE event.
         */
        protected function notifyComplete():void
        {
            dispatchEvent( new Event( Event.COMPLETE ) );
        }
        
        /**
         * Specifies the progress value. This value is a number between 0 and 1.
         */
        public function get progress():Number
        {
            return _progress;
        }
        
        public function set progress( value:Number ):void
        {
            if( _progress != value )
            {
                _progress = NumberUtil.constrain( value, 0, 1 );
                invalidate();
            }
        }
    }
}

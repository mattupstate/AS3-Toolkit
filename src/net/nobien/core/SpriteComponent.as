package net.nobien.core 
{
	import net.nobien.events.ComponentEvent;
	import flash.display.Sprite;
	import flash.events.Event;

    /**
     * Dispatched when the component has initialized.
     * @eventType net.nobien.events.ComponentEvent
     */
    [Event(name="componentInit", type="net.nobien.events.ComponentEvent")]

    /**
     * Dispatched when the component is enabled.
     * @eventType net.nobien.events.ComponentEvent
     */
    [Event(name="componentEnable", type="net.nobien.events.ComponentEvent")]

    /**
     * Dispatched when the component is disabled.
     * @eventType net.nobien.events.ComponentEvent
     */
    [Event(name="componentDisable", type="net.nobien.events.ComponentEvent")]

    /**
     * Dispatched when the component is moved using the <code>move()</code> method.
     * @eventType net.nobien.events.ComponentEvent
     */
    [Event(name="componentMove", type="net.nobien.events.ComponentEvent")]

    /**
     * Dispatched when the component is redrawn.
     * @eventType net.nobien.events.ComponentEvent
     */
    [Event(name="componentDraw", type="net.nobien.events.ComponentEvent")]
    
    /**
     * The SpriteComponent class is the core class for creating custom visual components. Extend this
     * class when you want to add some basic visual component functionality to your custom components.
     */
    public class SpriteComponent extends Sprite
    {
        protected var USE_DEFERRED_VALIDATION:Boolean = false;
        
        private var _initialized:Boolean = false;
        private var _isInitialized:Boolean = false;
        private var _enabled:Boolean = false;
        private var _isEnabled:Boolean = false;
        
        /**
         * Creates an instance of the <code>SpriteComponent</code> class.
         * @param	autoEnable	Specifies if the component is automatically enabled upon it being initialized.
         * @param	autoInit	Specifies if the component should instantly initialize. A value of false assumes the component must wait for various properties to be set before being initialized.
         */
        public function SpriteComponent() 
        {
            invalidate();
            addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
        }
        
        /**
         * Throws an error with the specified error message
         * @param	errorMsg
         */
        protected function notifyError( errorMsg:String ):void
        {
            throw new Error( errorMsg );
        }
        
        /**
         * Dispatches a ComponentEvent.DISABLE event.
         */
        protected function notifyDisabled():void
        {
            dispatchEvent( new ComponentEvent( ComponentEvent.DISABLE ) );
        }
        
        /**
         * Dispatches a ComponentEvent.DRAW event.
         */
        protected function notifyDraw():void
        {
            dispatchEvent( new ComponentEvent( ComponentEvent.DRAW ) );
        }
        
        /**
         * Dispatches a ComponentEvent.ENABLE event.
         */
        protected function notifyEnabled():void
        {
            dispatchEvent( new ComponentEvent( ComponentEvent.ENABLE ) );
        }
        
        /**
         * Dispatches a ComponentEvent.INIT event.
         */
        protected function notifyInit():void
        {
            dispatchEvent( new ComponentEvent( ComponentEvent.INIT ) );
        }
        
        /**
         * Dispatches a ComponentEvent.MOVE event.
         */
        protected function notifyMove():void
        {
            dispatchEvent( new ComponentEvent( ComponentEvent.MOVE ) );
        }
        
        /**
         * Internal ComponentEvent.INIT event handler.
         * @param	event
         */
        protected function onInitialized( event:ComponentEvent ):void
        {
            removeEventListener( ComponentEvent.INIT, onInitialized );
            enabled = true;
        }
        
        /**
         * Internal defferred invalidation event handler.
         * @param	event
         */
        protected function onInvalidate( event:Event ):void 
        {
            removeEventListener( Event.ENTER_FRAME, onInvalidate );
            validate();
        }
        
        /**
         * Event.ADDED_TO_STAGE handler. Override with custom routine.
         * @param	event Event object
         */
        protected function onAddedToStage( event:Event ):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
        }
        
        /**
         * Event.REMOVED_FROM_STAGE handler. Override with custom routine.
         * @param	event Event object
         */
        protected function onRemovedFromStage( event:Event ):void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
            addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
        }
        
        /**
         * Draw method. Updates the component's view.
         */
        protected function draw():void
        {
            if( enabled && !_isEnabled )
                enable();
            else if( !enabled && _isEnabled )
                disable();
                
            notifyDraw();
        }
        
        /**
         * Performs the enable action.
         */
        protected function enable():void
        {
            _isEnabled = true;
            mouseEnabled = true;
            notifyEnabled();
        }
        
        /**
         * Performs the disable action.
         */
        protected function disable():void
        {
            _isEnabled = false;
            mouseEnabled = false;
            notifyDisabled();
        }
        
        /**
         * Moves the display object to the specified x and y position
         * @param	x	x position
         * @param	y	y position
         */
        public function move( x:Number, y:Number ):void
        {
            this.x = x;
            this.y = y;
            notifyMove();
        }
        
        /**
         * Begins validation process of the component.
         */
        public function invalidate():void
        {
            if( USE_DEFERRED_VALIDATION )
                addEventListener( Event.ENTER_FRAME, onInvalidate );
            else
                validate();
        }
        
        /**
         * Performs the validation of the component.
         */
        public function validate():void
        {
            if( initialized && !_isInitialized )
            {
                _isInitialized = true;
                notifyInit();
            }
            else if( !_isInitialized )
            {
                addEventListener( ComponentEvent.INIT, onInitialized );
            }
            else if( initialized && _isInitialized )
            {
                draw();
            }
        }
        
        /**
         * Prepares the component for removal from memory.
         */
        public function cleanup():void
        {
            removeEventListener( ComponentEvent.INIT, onInitialized );
            removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
            removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
            removeEventListener( Event.ENTER_FRAME, onInvalidate );
        }
        
        /**
         * Specifies if the component has been initialized.
         */
        protected function get initialized():Boolean { return _initialized; }
        protected function set initialized( value:Boolean ):void
        {
            if( value != _initialized )
            {
                _initialized = value;
                invalidate();
            }
        }
        
        /**
         * Specifies if the component is enabled or disabled.
         */
        public function get enabled():Boolean { return _enabled; }
        public function set enabled( value:Boolean ):void
        {
            if( value != _enabled )
            {
                _enabled = value;
                invalidate();
            }
        }
    }
}

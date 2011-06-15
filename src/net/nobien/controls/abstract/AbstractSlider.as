package net.nobien.controls.abstract
{
	import net.nobien.core.SpriteComponent;
	import net.nobien.events.ComponentEvent;
	import net.nobien.events.SliderEvent;
	import net.nobien.utils.NumberUtil;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

    /**
     * Dispatched when the slider's value has changed.
     * @eventType net.nobien.events.ComponentEvent
     */
    [Event(name="componentChange", type="net.nobien.events.ComponentEvent")]

    /**
     * Dispatched when the slider's thumb has been pressed and is about to start being dragged.
     * @eventType net.nobien.events.SliderEvent
     */
    [Event(name="sliderThumbPress", type="net.nobien.events.SliderEvent")]

    /**
     * Dispatched when the slider's thumb has been released and is done being dragged.
     * @eventType net.nobien.events.SliderEvent
     */
    [Event(name="sliderThumbRelease", type="net.nobien.events.SliderEvent")]

    /**
     * Dispatched when the slider's thumb is being dragged.
     * @eventType net.nobien.events.SliderEvent
     */
    [Event(name="sliderThumbDrag", type="net.nobien.events.SliderEvent")]

    /**
     * The AbstractSlider class is used to create custom slider/scroll bar components. Extending this 
     * class will give your custom slider/scroll bar a set of common methods and properties that a basic
     * slider/scroll bar should have.
     */
    public class AbstractSlider extends SpriteComponent
    {
        /**
         * If the slider is being dragged or not.
         */
        private var _dragging:Boolean = false;
        
        /**
         * The position value.
         */
        private var _position:Number = 0;
        
        /**
         * The draggable range of the thumb.
         */
        private var _dragBounds:Rectangle;
        
        /**
         * The slider's thumb (the part that is draggable).
         */
        private var _thumb:Sprite;
        
        /**
         * Creates a new <code>AbstractSlider</code> object.
         */
        public function AbstractSlider() 
        {
            
        }
        
        /**
         * Utility method which dispatches <code>SliderEvent.THUMB_PRESS</code> event.
         */
        protected function notifyThumbPress():void
        {
            dispatchEvent( new SliderEvent( SliderEvent.THUMB_PRESS ) );
        }
        
        /**
         * Utility method which dispatches <code>SliderEvent.THUMB_RELEASE</code> event.
         */
        protected function notifyThumbRelease():void
        {
            dispatchEvent( new SliderEvent( SliderEvent.THUMB_RELEASE ) );
        }
        
        /**
         * Utility method which dispatches <code>SliderEvent.THUMB_RELEASE</code> event.
         */
        protected function notifyThumbDrag():void
        {
            dispatchEvent( new SliderEvent( SliderEvent.THUMB_DRAG ) );
        }
        
        /**
         * Utility method which dispatches <code>ComponentEvent.CHANGE</code> event.
         */
        protected function notifySliderChange():void
        {
            dispatchEvent( new ComponentEvent( ComponentEvent.CHANGE ) );
        }
        
        /**
         * Abstracted <code>MouseEvent.MOUSE_DOWN</code> event functionality of the slider's thumb. 
         * Override with custom (dragging) behavior.
         * @param event MouseEvent object.
         */
        protected function onThumbMouseDown( event:MouseEvent ):void
        {
            notifyThumbPress();
            stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
            stage.addEventListener( MouseEvent.MOUSE_UP, onThumbMouseUp );
            startThumbDrag();
        }
        
        /**
         * Abstracted <code>MouseEvent.MOUSE_UP</code> event functionality of the slider's thumb. 
         * Override with custom (dragging) behavior.
         * @param event MouseEvent object.
         */
        protected function onThumbMouseUp( event:MouseEvent ):void
        {
            notifyThumbRelease();
            stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
            stage.removeEventListener( MouseEvent.MOUSE_UP, onThumbMouseUp );
            stopThumbDrag();
        }
        
        /**
         * Place holder method. Override with custom behavior.
         * @param event MouseEvent object.
         */
        protected function onMouseMove( event:MouseEvent ):void
        {
            if( _position != getPositionFromThumb() )
            {
                _position = getPositionFromThumb();
                notifySliderChange();
                notifyThumbDrag();
            }
        }
        
        /**
         * @inheritDoc
         */
        override protected function draw():void 
        {
            moveThumbToPosition();
            super.draw();
        }
        
        /**
         * Starts the dragging of the thumb.
         */
        protected function startThumbDrag():void
        {
            if( !_dragging )
            {
                thumb.startDrag( false, _dragBounds );
                _dragging = true;
            }
        }
        
        /**
         * Stops the dragging of the thumb.
         */
        protected function stopThumbDrag():void
        {
            if( _dragging )
            {
                thumb.stopDrag();
                _dragging = false;
            }
        }
        
        /**
         * Place holder method. Override with custom behavior.
         */
        protected function moveThumbToPosition():void
        {
            
        }
        
        /**
         * Abstracted position calculation. Override with custom calculation.
         */
        protected function getPositionFromThumb():Number
        {
            return 0;
        }
        
        /**
         * Initializes mouse events.
         */
        protected function initMouseEvents():void
        {
            thumb.addEventListener( MouseEvent.MOUSE_DOWN, onThumbMouseDown );
        }
        
        /**
         * Kills all mouse events.
         */
        protected function killMouseEvents():void
        {
            thumb.removeEventListener( MouseEvent.MOUSE_DOWN, onThumbMouseDown );
            
            if( stage )
            {
                stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
                stage.removeEventListener( MouseEvent.MOUSE_UP, onThumbMouseUp );
            }
        }
        
        override protected function enable():void 
        {
            super.enable();
            mouseChildren = true;
            initMouseEvents();
        }
        
        override protected function disable():void 
        {
            super.disable();
            mouseChildren = false;
            killMouseEvents();
            stopThumbDrag();
        }
        
        override public function cleanup():void 
        {
            disable();
            super.cleanup();
        }
        
        /**
         * Checks to see if the necessary parts of the slider have been specified.
         */
        override public function validate():void 
        {
            if( dragBounds != null && thumb != null )
                initialized = true;
                
            super.validate();
        }
        
        /**
         * Indicates if the slider is being dragged or not.
         */
        public function get dragging():Boolean { return _dragging; }
        
        /**
         * The position of the slider. The position is represented by a number between 0 and 1.
         */
        public function get position():Number { return _position; }
        public function set position( value:Number ):void
        {
            if( value != position )
            {
                _position = NumberUtil.constrain( value, 0, 1 );
                invalidate();
                notifySliderChange();
            }
        }
        
        /**
         * The slider drag bounds.
         */
        public function get dragBounds():Rectangle { return _dragBounds; }
        public function set dragBounds( value:Rectangle ):void 
        {
            if( _dragBounds != value )
            {
                _dragBounds = value;
                invalidate();
            }
        }
        
        /**
         * The slider thumb.
         */
        public function get thumb():Sprite { return _thumb; }
        public function set thumb( value:Sprite ):void 
        {
            if( _thumb != value )
            {
                _thumb = value;
                invalidate();
            }
        }
    }
}

package net.nobien.controls.abstract 
{
	import net.nobien.core.SpriteComponent;
	import net.nobien.events.ComponentEvent;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
    
    /**
     * The AbstractButton class is used to create custom button components. Extending this 
     * class will give your custom button a set of common methods and properties that a basic
     * button should have.
     */
    public class AbstractButton extends SpriteComponent
    {
        private var _selected:Boolean = false;
        private var _isSelected:Boolean = false;
        
        /**
         * Creates a new <code>AbstractButton</code> object.
         */
        public function AbstractButton() 
        {
            mouseChildren = false;
        }
        
        private function onStageMouseUp( event:MouseEvent ):void 
        {
            stage.removeEventListener( MouseEvent.MOUSE_UP, onStageMouseUp );
            addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
            
            if( contains( event.target as DisplayObject ) )
                onMouseUp( event );
            else
                onMouseUpOutside( event );
        }
        
        protected function notifySelect():void
        {
            dispatchEvent( new ComponentEvent( ComponentEvent.SELECT ) );
        }
        
        protected function notifyDeselect():void
        {
            dispatchEvent( new ComponentEvent( ComponentEvent.DESELECT ) );
        }
        
        /**
         * Abstracted <code>MouseEvent.ROLL_OVER</code> event functionality. Override with custom roll over behavior.
         * @param	event	MouseEvent object
         */
        protected function onRollOver( event:MouseEvent ):void
        {
            removeEventListener( MouseEvent.ROLL_OVER, onRollOver );
            addEventListener( MouseEvent.ROLL_OUT, onRollOut );
        }
        
        /**
         * Abstracted <code>MouseEvent.ROLL_OUT</code> event functionality. Override with custom roll out behavior.
         * @param	event	MouseEvent object
         */
        protected function onRollOut( event:MouseEvent ):void
        {
            removeEventListener( MouseEvent.ROLL_OUT, onRollOut );
            addEventListener( MouseEvent.ROLL_OVER, onRollOver );
        }
        
        /**
         * Abstracted <code>MouseEvent.MOUSE_DOWN</code> event functionality. Override with custom mouse down behavior.
         * @param	event	MouseEvent object
         */
        protected function onMouseDown( event:MouseEvent ):void
        {
            removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
            stage.addEventListener( MouseEvent.MOUSE_UP, onStageMouseUp );
        }
        
        /**
         * Abstracted <code>MouseEvent.MOUSE_UP</code> event functionality. Override with custom mouse up behavior.
         * @param	event	MouseEvent object
         */
        protected function onMouseUp( event:MouseEvent ):void
        {
            
        }
        
        /**
         * Abstracted <code>MouseEvent.MOUSE_UP</code> event functionality. Override with custom mouse up behavior.
         * @param	event	MouseEvent object
         */
        protected function onMouseUpOutside( event:MouseEvent ):void
        {
            
        }
        
        /**
         * Abstracted <code>MouseEvent.CLICK</code> event functionality. Override with custom click behavior.
         * @param	event	MouseEvent object
         */
        protected function onClick( event:MouseEvent ):void
        {
            
        }
        
        /**
         * Activates mouse events for the button.
         */
        protected function initMouseEvents():void
        {
            addEventListener( MouseEvent.ROLL_OVER, onRollOver );
            addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
            addEventListener( MouseEvent.CLICK, onClick );
        }
        
        /**
         * Deactivates mouse events for the button.
         */
        protected function killMouseEvents():void
        {
            removeEventListener( MouseEvent.ROLL_OVER, onRollOver );
            removeEventListener( MouseEvent.ROLL_OUT, onRollOut );
            removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
            removeEventListener( MouseEvent.CLICK, onClick );
            if( stage ) stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
        }
        
        /**
         * Selects the button.
         */
        protected function select():void
        {
            _isSelected = true;
            notifySelect();
        }
        
        /**
         * Deselects the button.
         */
        protected function deselect():void
        {
            _isSelected = false;
            notifyDeselect();
        }
        
        /**
         * Enables the button and activates mouse events.
         */
        override protected function enable():void
        {
            super.enable();
            initMouseEvents();
            buttonMode = true;
        }
        
        /**
         * Disables the button and deactivates mouse events.
         */
        override protected function disable():void
        {
            super.disable();
            killMouseEvents();
            buttonMode = false;
        }
        
        override public function cleanup():void
        {
            disable();
            super.cleanup();
        }
        
        override protected function draw():void 
        {
            if( selected && !_isSelected )
                select();
            else if( !selected && _isSelected )
                deselect();
                
            super.draw();
        }
        
        /**
         * Is equal to <code>true</code> if the button is selected and vice versa.
         */
        public function get selected():Boolean { return _selected; }
        public function set selected( value:Boolean ):void
        {
            if( _selected != value )
            {
                _selected = value;
                invalidate();
            }
        }
    }
}

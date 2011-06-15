package net.nobien.controls.abstract 
{
	import net.nobien.constants.States;
	import net.nobien.controls.IButton;
	import net.nobien.controls.IMenu;
	import net.nobien.controls.ITextControl;
	import net.nobien.core.SpriteComponent;
	import net.nobien.events.ComponentEvent;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;

    /**
     * Dispatched when the combo box has been closed.
     * @eventType net.nobien.events.ComponentEvent
     */
    [Event(name="componentClose", type="net.nobien.events.ComponentEvent")]

    /**
     * Dispatched when the combo box has been opened.
     * @eventType net.nobien.events.ComponentEvent
     */
    [Event(name="componentOpen", type="net.nobien.events.ComponentEvent")]

    /**
     * Dispatched when a selection has been made by the user.
     * @eventType net.nobien.events.ComponentEvent
     */
    [Event(name="componentSelect", type="net.nobien.events.ComponentEvent")]

    /**
     * The AbstractComboBox class is used to create custom combo box components. Extending this 
     * class will give your custom combo box a set of common methods and properties that a basic
     * combo box should have.
     */
    public class AbstractComboBox extends SpriteComponent
    {
        protected var _state:String = States.CLOSED;
        protected var _data:Array;
        protected var _labelProperty:String = "label";
        protected var _valueProperty:String = "value";
        protected var _label:ITextControl;
        protected var _button:IButton;
        protected var _menu:IMenu;
        
        /**
         * Creates a new AbstractComboBox object.
         * @param	autoEnable	Specifies if the component is automatically enabled upon it being initialized.
         * @param	autoInit	Specifies if the component should instantly initialize. A value of false assumes the component must wait for various properties to be set before being initialized.
         */
        public function AbstractComboBox() 
        {
            
        }
        
        /**
         * Dispatches a ComponentEvent.CLOSE event.
         */
        protected function notifyClose():void
        {
            dispatchEvent( new ComponentEvent( ComponentEvent.CLOSE ) );
        }
        
        /**
         * Dispatches a ComponentEvent.OPEN event.
         */
        protected function notifyOpen():void
        {
            dispatchEvent( new ComponentEvent( ComponentEvent.OPEN ) );
        }
        
        /**
         * Dispatches a ComponentEvent.SELECT event.
         */
        protected function notifySelect():void
        {
            dispatchEvent( new ComponentEvent( ComponentEvent.SELECT ) );
        }
        
        override protected function onInitialized( event:ComponentEvent ):void 
        {
            menu.data = data;
            super.onInitialized( event );
        }
        
        /**
         * Handles the click action of the button.
         * @param	event
         */
        protected function onButtonClick( event:MouseEvent ):void 
        {
            if( _state == States.OPENED || _state == States.OPENING )
                close();
            else
                open();
        }
        
        /**
         * Handler for the MouseEvent.MOUSE_DOWN event when the combo box is open.
         * @param	event
         */
        protected function onMouseDown( event:MouseEvent ):void 
        {
            stage.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
            stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
        }
        
        /**
         * Handler for the MouseEvent.MOUSE_UP event when the combo box is open.
         * @param	event
         */
        protected function onMouseUp( event:MouseEvent ):void 
        {
            stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
            
            if( !contains( event.target as DisplayObject ) ) 
                close();
            else
                stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
        }
        
        /**
         * Set's the label text based on the menu selection.
         * @param	event
         */
        protected function onMenuSelect( event:Event ):void 
        {
            _label.text = data[menu.selectedIndex][labelProperty];
            notifySelect();
            close();
        }
        
        /**
         * Handler for when open action has completed.
         */
        protected function onOpenComplete():void
        {
            _state = States.OPENED;
        }
        
        /**
         * Handler for when close action has completed.
         */
        protected function onCloseComplete():void
        {
            _state = States.CLOSED;
        }
        
        override protected function enable():void 
        {
            mouseChildren = true;
            button.addEventListener( MouseEvent.CLICK, onButtonClick );
            menu.addEventListener( ComponentEvent.SELECT, onMenuSelect );
            super.enable();
        }
        
        override protected function disable():void 
        {
            mouseChildren = false;
            button.removeEventListener( MouseEvent.CLICK, onButtonClick );
            menu.removeEventListener( ComponentEvent.SELECT, onMenuSelect );
            close();
            super.disable();
        }
        
        /**
         * Performs the open action.
         */
        protected function doOpen():void
        {
            menu.visible = true;
            onOpenComplete();
        }
        
        /**
         * Performs the close action.
         */
        protected function doClose():void
        {
            menu.visible = false;
            onCloseComplete();
        }
        
        override public function validate():void 
        {
            if( menu != null && label != null && button != null && data != null )
                initialized = true;
            
            super.validate();
        }
        
        /**
         * Opens the combo box. Override <code>doOpen()</code> to adjust the animation routine.
         */
        public function open():void
        {
            if( _state != States.OPENED && _state != States.OPENING )
            {
                _state = States.OPENING;
                stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
                doOpen();
                notifyOpen();
            }
        }
        
        /**
         * Closes the combo box. Override <code>doClose()</code> to adjust the animation routine.
         */
        public function close():void
        {
            if( _state != States.CLOSED && _state != States.CLOSING )
            {
                _state = States.CLOSING;
                stage.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
                doClose();
                notifyClose();
            }
        }
        
        /**
         * The comb box label. Commonly used to display text representing the selection.
         */
        public function get label():ITextControl { return _label; }
        public function set label( value:ITextControl ):void 
        {
            if( _label != value )
            {
                _label = value;
                invalidate();
            }
        }
        
        /**
         * The button that opens and closes the combo box. This button commonly has
         * a downward facing arrow on it.
         */
        public function get button():IButton { return _button; }
        public function set button( value:IButton ):void 
        {
            if( _button != value )
            {
                _button = value;
                invalidate();
            }
        }
        
        /**
         * The menu of options for the combo box.
         */
        public function get menu():IMenu { return _menu; }
        public function set menu( value:IMenu ):void 
        {
            if( _menu != value )
            {
                _menu = value;
                invalidate();
            }
        }
        
        /**
         * The current selected index.
         */
        public function get selectedIndex():int { return menu.selectedIndex; }
        public function set selectedIndex( value:int ):void
        {
            if( menu.selectedIndex != value )
                menu.selectedIndex = value;
        }
        
        /**
         * The current selected data item.
         */
        public function get selectedItem():Object
        {
            return data[selectedIndex][valueProperty];
        }
        
        /**
         * The property of the data set to use as the selection label.
         */
        public function get labelProperty():String { return _labelProperty; }
        public function set labelProperty( value:String ):void 
        {
            _labelProperty = value;
        }
        
        /**
         * The property of the data set to use as the selected item.
         */
        public function get valueProperty():String { return _valueProperty; }
        public function set valueProperty( value:String ):void 
        {
            _valueProperty = value;
        }
        
        /**
         * The combo box data set to be used when populating the menu.
         */
        public function get data():Array { return _data; }
        public function set data( value:Array ):void 
        {
            if( _data != value )
            {
                _data = value;
                invalidate();
            }
        }
    }
}
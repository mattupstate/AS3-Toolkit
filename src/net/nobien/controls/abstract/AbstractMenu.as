package net.nobien.controls.abstract
{
	import flash.events.ErrorEvent;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.describeType;
	import net.nobien.controls.IButton;
	import net.nobien.core.SpriteComponent;
	import net.nobien.events.ComponentEvent;

    /**
     * Dispatched when a selection has been made.
     * @eventType net.nobien.events.ComponentEvent
     */
    [Event(name="componentSelect", type="net.nobien.events.ComponentEvent")]

    /**
     * The <code>AbstractMenu</code> class provides a set of common methods that can be used to build a 
     * basic menu/navigation. The menu assumes that it will consist of a set of items/items and that 
     * each of those items will be constructed using a data object. The menu will be created upon setting 
     * both the <code>menuItemClass</code> and <code>menuItemData</code> properties. Override the
     * <code>positionMenuItem()</code> method to position each menu item.
     */
    public class AbstractMenu extends SpriteComponent 
    {
        public static const REQUIRED_ITEM_INTERFACE:String = "net.nobien.controls::IButton";
        
        protected var _itemClass:Class;
        protected var _data:Array;
        protected var _items:Array = [];
        protected var _selectedIndex:int = -1;
        
        /**
         * Creates a new <code>AbstractMenu</code> object.
         */
        public function AbstractMenu() 
        {
            
        }
        
        /**
         * Dispatches a ComponenteEvent.SELECT event.
         */
        protected function notifySelect():void
        {
            dispatchEvent( new ComponentEvent( ComponentEvent.SELECT ) );
        }
        
        
        override protected function onInitialized( event:ComponentEvent ):void 
        {
            _data.forEach( createMenuItem );
            positionItems();
            super.onInitialized( event );
        }
        
        /**
         * Handler for each button's <code>MouseEvent.CLICK</code> event.
         * @param	event
         */
        protected function onMenuItemClick( event:MouseEvent ):void
        {
            if( event.target is itemClass )
                setSelection( _items.indexOf( event.target ) );
        }
        
        /**
         * Adds the <code>MouseEvent.CLICK</code> event handler for each button.
         * @param	element
         * @param	index
         * @param	array
         */
        protected function addItemListeners( element:Object ):void
        {
            if( element is IEventDispatcher )
                IEventDispatcher( element ).addEventListener( MouseEvent.CLICK, onMenuItemClick );
        }
        
        /**
         * Removes the <code>MouseEvent.CLICK</code> event handler for each button.
         * @param	element
         * @param	index
         * @param	array
         */
        protected function removeClickListener( element:Object ):void
        {
            if( element is IEventDispatcher )
                IEventDispatcher( element ).removeEventListener( MouseEvent.CLICK, onMenuItemClick );
        }
        
        /**
         * Creates the menu items.
         * @param	element
         * @param	index
         * @param	array
         */
        protected function createMenuItem( element:Object ):void
        {
            var btn:IButton = new itemClass();
            
            var itemDescription:XML = describeType( itemClass );
            var dataDescription:XML = describeType( element );
            
            var itemType:String = itemDescription.@name.toString();
            var dataType:String = dataDescription.@name.toString();
            
            var accessor:XMLList = itemDescription.factory.accessor.(@declaredBy == itemType && @type == dataType);
            
            if( accessor.length() == 1 )
            {
                var accessorName:String = accessor.@name.toString();
                btn[accessorName] = element;
            }
            
            _items.push( btn );
        }
        
        /**
         * Positions the items. Override with custom positioning routine.
         */
        protected function positionItems():void
        {
            var dX:Number = 0;
            
            for( var i:int = 0; i < items.length; i++ )
            {
                items[i].x = dX;
                dX += items[i].width + 15;
                addChild( items[i] );
            }
        }
        
        override protected function disable():void
        {
            mouseChildren = false;
            items.forEach( removeClickListener );
            super.disable();
        }
        
        override protected function enable():void
        {
            mouseChildren = true;
            items.forEach( addItemListeners );
            super.enable();
        }
        
        /**
         * Selects the specified index.
         * @param	index
         */
        protected function setSelection( index:int ):void
        {
            if( index >= -1 && index < _items.length )
            {
                if( selectedIndex != index )
                {
                    if( selectedItem )
                        selectedItem.selected = false;
                    
                    _selectedIndex = index;
                    
                    if( selectedItem )
                        selectedItem.selected = true;
                    
                    notifySelect();
                }
            }
            else
            {
                notifyError( "Specified index (" + index + ") is out of range (-1 to " + ( items.length - 1 ) + ")" );
            }
        }
        
        override public function validate():void 
        {
            var validItemClass:Boolean = false;
            
            if( itemClass != null )
            {
                var description:XML = describeType( itemClass );
                
                validItemClass = 
                    ( description.factory.implementsInterface.(@type == REQUIRED_ITEM_INTERFACE).length() > 0 ) 
                    ? true 
                    : false;
                
                if( !validItemClass )
                {
                    var errorMsg:String = "Error: property 'itemClass' of " + this + " does not implement required interface: " + REQUIRED_ITEM_INTERFACE;
                    dispatchEvent( new ErrorEvent( ErrorEvent.ERROR, false, false, errorMsg ) );
                }
            }
            
            if( validItemClass && itemClass != null && data != null && data.length > 0 )
                initialized = true;
                
            super.validate();
        }
        
        override public function cleanup():void 
        {
            disable();
            _data = [];
            _items = [];
            _itemClass = null;
            super.cleanup();
        }
        
        /**
         * An Array consisting of all the menu item objects.
         */
        public function get items():Array { return _items; }
        
        /**
         * The Class used when creating menu items.
         */
        public function get itemClass():Class { return _itemClass; }
        public function set itemClass( value:Class ):void 
        {
            if( _itemClass != value )
            {
                _itemClass = value;
                invalidate();
            }
        }
        
        /**
         * The data used when creating the menu items.
         */
        public function get data():Array { return _data; }
        public function set data( value:Array ):void 
        {
            _data = value;
            invalidate();
        }
        
        /**
         * The current selected index.
         */
        public function get selectedIndex():int { return _selectedIndex; }
        public function set selectedIndex( value:int ):void
        {
            setSelection( value );
        }
        
        /**
         * The current selected menu item.
         */
        public function get selectedItem():IButton { return _items[selectedIndex]; }
        
        /**
         * The current selected data item.
         */
        public function get selectedData():Object { return _data[selectedIndex]; }
    }
}
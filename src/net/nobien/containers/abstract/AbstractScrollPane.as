package net.nobien.containers.abstract 
{
	import net.nobien.controls.ISlider;
	import net.nobien.events.ComponentEvent;
	import net.nobien.utils.DisplayObjectUtil;
	import net.nobien.utils.NumberUtil;
	import flash.geom.Rectangle;

    /**
     * The AbstractScrollPane class is used to create custom display object container that displays
     * its display children within a scrollable window. Extending this class will give your custom 
     * display object container a set of common methods and properties that a basic scroll pane should have.
     */
    public class AbstractScrollPane extends AbstractContainer
    {
        /**
         * The scrollable window area of the display object
         */
        protected var _scrollWindow:Rectangle = new Rectangle( 0, 0, 300, 300 );
        
        /**
         * The vertical scrollbar.
         */
        protected var _vScrollbar:ISlider;
        
        /**
         * The horizontal scrollbar.
         */
        protected var _hScrollbar:ISlider;
        
        protected var _hScroll:Number = 0;
        protected var _vScroll:Number = 0;
        protected var _contentBounds:Rectangle;
        
        /**
         * Creates a new <code>AbstractScrollPane</code> object.
         * @param	autoEnable	Specifies if the component is automatically enabled upon it being initialized.
         * @param	autoInit	Specifies if the component should instantly initialize. A value of false assumes the component must wait for various properties to be set before being initialized.
         */
        public function AbstractScrollPane() 
        {
            
        }
        
        /**
         * Vertical scrollbar <code>ComponentEvent.CHANGE</code> event handler.
         * @param	event	ComponentEvent object
         */
        protected function onvScrollbarChange( event:ComponentEvent ):void
        {
            vScroll = vScrollbar.position;
        }
        
        /**
         * Horizontal scrollbar <code>ComponentEvent.CHANGE</code> event handler.
         * @param	event	ComponentEvent object
         */
        protected function onhScrollbarChange( event:ComponentEvent ):void
        {
            hScroll = hScrollbar.position;
        }
        
        /**
         * Updates the display object's <code>scrollRect</code> property to give the appearance of scrolling.
         */
        protected function updateScrollRect():void
        {
            if( scrollRect )
            {
                var newScrollRect:Rectangle = scrollRect.clone();
                
                newScrollRect.y = ( _contentBounds.height - scrollRect.height ) * vScroll;
                newScrollRect.x = ( _contentBounds.width - scrollRect.width ) * hScroll;
                
                scrollRect = newScrollRect;
            }
        }
        
        /**
         * Checks the size of the content and enables scroll bars accordingly.
         */
        protected function checkContentSize():void
        {
            if( vScrollbar )
            {
                if( _contentBounds.height > scrollRect.height )
                {
                    vScrollbar.enabled = true;
                    vScrollbar.addEventListener( ComponentEvent.CHANGE, onvScrollbarChange );
                }
                else
                {
                    vScrollbar.enabled = false;
                }
            }
            
            if( hScrollbar )
            {
                if( _contentBounds.width > scrollRect.width )
                {
                    hScrollbar.enabled = true;
                    hScrollbar.addEventListener( ComponentEvent.CHANGE, onhScrollbarChange );
                }
                else
                {
                    hScrollbar.enabled = false;
                }
            }
        }
        
        protected function getContentBounds():void
        {
            _contentBounds = DisplayObjectUtil.getFullBounds( this );
        }
        
        protected function positionScrollbars():void
        {
            if( vScrollbar )
            {
                vScrollbar.removeEventListener( ComponentEvent.CHANGE, onvScrollbarChange );
                vScrollbar.position = vScroll;
            }
            
            if( hScrollbar )
            {
                hScrollbar.removeEventListener( ComponentEvent.CHANGE, onhScrollbarChange );
                hScrollbar.position = hScroll;
            }
        }
        
        override protected function draw():void 
        {
            getContentBounds();
            positionScrollbars();
            checkContentSize();
            updateScrollRect();
            super.draw();
        }
        
        override public function validate():void 
        {
            if( scrollWindow != null )
                initialized = true;
            
            super.validate();
        }
        
        /**
         * The vertical scrollbar. Scrollbar instance must implement the ISlider interface.
         * @see net.nobien.controls.interfaces.ISlider
         */
        public function get vScrollbar():ISlider { return _vScrollbar; }
        public function set vScrollbar( value:ISlider ):void
        {
            if( _vScrollbar != value )
            {
                if ( vScrollbar )
                    vScrollbar.removeEventListener( ComponentEvent.CHANGE, onvScrollbarChange );
            
                _vScrollbar = value;
                invalidate();
            }
        }
        
        /**
         * The horizontal scrollbar. Scrollbar instance must implement the ISlider interface.
         * @see net.nobien.controls.interfaces.ISlider
         */
        public function get hScrollbar():ISlider { return _hScrollbar; }
        public function set hScrollbar( value:ISlider ):void
        {
            if( _vScrollbar != value )
            {
                if ( hScrollbar )
                    hScrollbar.removeEventListener( ComponentEvent.CHANGE, onhScrollbarChange );
                
                _hScrollbar = value;
                invalidate();
            }
        }
        
        /**
         * Specifies the vertical scroll position as a number between 0 and 1.
         */
        public function get vScroll():Number { return _vScroll; }
        public function set vScroll( value:Number ):void
        {
            if( _vScroll != value )
            {
                _vScroll = NumberUtil.constrain( value, 0, 1 );
                invalidate();
            }
        }
        
        /**
         * Specifies the horizontal scroll position as a number between 0 and 1.
         */
        public function get hScroll():Number { return _hScroll; }
        public function set hScroll( value:Number ):void
        {
            if( _hScroll != value )
            {
                _hScroll = NumberUtil.constrain( value, 0, 1 );
                invalidate();
            }
        }
        
        /**
         * The bounds of the unmaksed content.
         */
        public function get contentBounds():Rectangle { return _contentBounds; }
        
        /**
         * The scroll window.
         */
        public function get scrollWindow():Rectangle { return _scrollWindow; }
        public function set scrollWindow( value:Rectangle ):void 
        {
            _scrollWindow = scrollRect = value;
            invalidate();
        }
        
    }
}
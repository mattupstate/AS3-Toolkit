package net.nobien.containers.abstract 
{
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import net.nobien.constants.Direction;
    import net.nobien.utils.AlignUtil;
    import net.nobien.utils.DisplayObjectUtil;

    /**
     * The AbstractBox class is used to create custom display object container that lays
     * out its children in a horizontal or vertical manner. Extending this class will give 
     * your custom display object container a set of common methods and properties that a 
     * basic box container should have.
     */
    public class AbstractBox extends AbstractContainer
    {
        protected var _align:String = AlignUtil.TOP_LEFT;
        protected var _direction:String = Direction.HORIZONTAL;
        protected var _itemMargin:Number = 0;
        protected var _cells:Array = [];
        
        /**
         * Creates a new <code>AbstractBox</code> object.
         */
        public function AbstractBox() 
        {
            
        }
        
        override protected function arrangeChildren():void 
        {
            for( var i:int = 0; i < numChildren; i++ )
            {
                var child:DisplayObject = getChildAt( i );
                var objBounds:Rectangle = child.getBounds( null );
                var pos:Point = AlignUtil.getAlign( _align, objBounds, _cells[i] );
                positionChild( child, pos );
            }
        }
        
        /**
         * Creates the box cell definitions.
         */
        protected function createCells():void
        {
            _cells = [];
            
            if( numChildren > 0 )
            {
                var tile:Rectangle = new Rectangle( 0, 0, 0, 0 );
                var tall:Number = DisplayObjectUtil.getTallestChild( this ).height;
                var wide:Number = DisplayObjectUtil.getWidestChild( this ).width;
                
                for( var i:int = 0; i < numChildren; i++ )
                {
                    var child:DisplayObject = getChildAt( i );
                    
                    switch( _direction )
                    {
                        case Direction.HORIZONTAL:
                            tile.width = child.width;
                            tile.height = tall;
                            break;
                            
                        case Direction.VERTICAL:
                            tile.width = wide;
                            tile.height = child.height;
                            break;
                    }
                    
                    _cells.push( tile.clone() );
                    
                    switch( _direction )
                    {
                        case Direction.HORIZONTAL:
                            tile.x += child.width + _itemMargin;
                            break;
                            
                        case Direction.VERTICAL:
                            tile.y += child.height + _itemMargin;
                            break;
                    }
                }
            }
        }
        
        override protected function draw():void 
        {
            createCells();
            super.draw();
        }
        
        /**
         * Positions a child object
         * @param	child       The child object
         * @param	position    The position
         */
        protected function positionChild( child:DisplayObject, position:Point ):void
        {
            child.x = position.x;
            child.y = position.y;
        }
        
        /**
         * The direction constant that specifies the manner in which the display children are arranged.
         */
        public function get direction():String { return _direction; }
        public function set direction( value:String ):void 
        {
            if( value != _direction )
            {
                _direction = value;
                invalidate();
            }
        }
        
        /**
         * The amount of pixels to place between each display child.
         */
        public function get itemMargin():Number { return _itemMargin; }
        public function set itemMargin( value:Number ):void 
        {
            if( value != _itemMargin )
            {
                _itemMargin = value;
                invalidate();
            }
        }
        
        public function get align():String { return _align; }
        public function set align( value:String ):void 
        {
            if( value != _align )
            {
                _align = value;
                invalidate();
            }
        }
    }
}
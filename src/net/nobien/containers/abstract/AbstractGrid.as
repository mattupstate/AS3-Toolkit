package net.nobien.containers.abstract 
{
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import net.nobien.constants.Direction;
    import net.nobien.utils.AlignUtil;
    import net.nobien.utils.DisplayObjectUtil;

    /**
     * The AbstractGrid class is used to create custom display object container that lays
     * out its children in a grid. Extending this class will give your custom display object 
     * container a set of common methods and properties that a basic grid container should have.
     */
    public class AbstractGrid extends AbstractContainer
    {
        protected var _align:String = AlignUtil.TOP_LEFT;
        protected var _direction:String = Direction.HORIZONTAL;
        protected var _canvasWidth:Number = 300;
        protected var _canvasHeight:Number = 300;
        protected var _tileWidth:Number = 50;
        protected var _tileHeight:Number = 50;
        protected var _gridCells:Array = [];
        
        /**
         * Creates a new <code>AbstractGrid</code> object.
         */
        public function AbstractGrid() 
        {
            
        }
        
        override protected function arrangeChildren():void 
        {
            for( var i:int = 0; i < numChildren; i++ )
            {
                var child:DisplayObject = getChildAt( i );
                var objBounds:Rectangle = child.getBounds( null );
                var pos:Point = AlignUtil.getAlign( _align, objBounds, _gridCells[i] );
                positionChild( child, pos );
            }
        }
        
        override protected function draw():void 
        {
            createCells();
            super.draw();
        }
        
        /**
         * Creates the grid cell definitions.
         */
        protected function createCells():void
        {
            _gridCells = [];
            
            if( numChildren > 0 )
            {
                var tileWidth:Number = ( isNaN( _tileWidth ) ) ? DisplayObjectUtil.getWidestChild( this ).width : _tileWidth;
                var tileHeight:Number = ( isNaN( _tileHeight ) ) ? DisplayObjectUtil.getTallestChild( this ).height : _tileHeight;
                var columns:Number = ( isNaN( _canvasWidth ) ) ? 10000000 : Math.floor( _canvasWidth / tileWidth );
                var rows:Number = ( isNaN( _canvasHeight ) ) ? 10000000 : Math.floor( _canvasHeight / tileHeight );
                var neededCellAmt:Number = Math.min( numChildren, columns * rows );
                
                for( var i:int = 0; i < neededCellAmt; i++ )
                {
                    var row:int;
                    var col:int;
                    
                    switch( _direction )
                    {
                        case Direction.HORIZONTAL:
                            row = Math.floor( i / columns );
                            col = i % columns;
                            break;
                            
                        case Direction.VERTICAL:
                            row = i % rows;
                            col = Math.floor( i / rows );
                            break;
                    }
                    
                    _gridCells.push( new Rectangle( tileWidth * col, tileHeight * row, tileWidth, tileHeight ) );
                }
            }
        }
        
        /**
         * Positions a child
         * @param	child       The child object
         * @param	position    The position
         */
        protected function positionChild( child:DisplayObject, position:Point ):void
        {
            child.x = position.x;
            child.y = position.y;
        }
        
        /**
         * The grid's cell alignmen constant.
         */
        public function get align():String { return _align; }
        public function set align( value:String ):void 
        {
            if( _align != value )
            {
                _align = value;
                invalidate();
            }
        }
        
        /**
         * The canvas width of the grid.
         */
        public function get canvasWidth():Number { return _canvasWidth; }
        public function set canvasWidth( value:Number ):void 
        {
            if( canvasWidth != value )
            {
                _canvasWidth = value;
                invalidate();
            }
        }
        
        /**
         * The canvas height of the grid.
         */
        public function get canvasHeight():Number { return _canvasHeight; }
        public function set canvasHeight( value:Number ):void 
        {
            if( _canvasHeight != value )
            {
                _canvasHeight = value;
                invalidate();
            }
        }
        
        /**
         * The direction constant that defines the order in which the display children are arranged.
         */
        public function get direction():String { return _direction; }
        public function set direction( value:String ):void 
        {
            if( _direction != value )
            {
                _direction = value;
                invalidate();
            }
        }
        
        /**
         * The grid tile width.
         */
        public function get tileWidth():Number { return _tileWidth; }
        public function set tileWidth( value:Number ):void 
        {
            if( _tileWidth != value )
            {
                _tileWidth = value;
                invalidate();
            }
        }
        
        /**
         * The grid tile height.
         */
        public function get tileHeight():Number { return _tileHeight; }
        public function set tileHeight( value:Number ):void 
        {
            if( _tileHeight != value )
            {
                _tileHeight = value;
                invalidate();
            }
        }
    }
}
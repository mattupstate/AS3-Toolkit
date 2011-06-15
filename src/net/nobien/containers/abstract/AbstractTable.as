package net.nobien.containers.abstract 
{
	import net.nobien.utils.AlignUtil;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;

    /**
     * The AbstractTable class is used to create custom display object container that lays
     * out its children in a table. Extending this class will give your custom display object 
     * container a set of common methods and properties that a basic table container should have.
     */
    public class AbstractTable extends AbstractContainer
    {
        protected var _align:String = AlignUtil.TOP_LEFT;
        protected var _canvas:Rectangle = new Rectangle( 0, 0, 300, 300 );
        protected var _columns:int = 1;
        protected var _rows:int = 1;
        protected var _tableCells:Array = [];
        
        /**
         * Creates a new <code>AbstractTable</code> object.
         * @param	autoEnable	Specifies if the component is automatically enabled upon it being initialized.
         * @param	autoInit	Specifies if the component should instantly initialize. A value of false assumes the component must wait for various properties to be set before being initialized.
         */
        public function AbstractTable() 
        {
            
        }
        
        override protected function arrangeChildren():void 
        {
            for( var i:int = 0; i < numChildren; i++ )
            {
                var child:DisplayObject = getChildAt( i );
                
                if( i < _tableCells.length )
                {
                    var cell:Rectangle = _tableCells[i];
                    var objBounds:Rectangle = child.getBounds( null );
                    var position:Point = AlignUtil.getAlign( _align, objBounds, cell );
                    positionChild( child, position );
                    child.visible = true;
                }
                else
                {
                    child.visible = false;
                }
            }
        }
        
        /**
         * Creates the table cell definitions.
         */
        protected function createCells():void
        {
            var cellWidth:Number = width / columns;
            var cellHeight:Number = height / rows;
            
            var newTableCells:Array = [];
            
            for( var i:int = 0; i < rows * columns; i++ )
            {
                var newCell:Rectangle;
                var row:int = Math.floor( i / columns );
                var column:int = i % columns;
                
                if( getCell( row, column ) != null )
                {
                    newCell = getCell( row, column ).clone();
                    newCell.x = column * cellWidth;
                    newCell.y = row * cellHeight;
                    newCell.width = cellWidth;
                    newCell.height = cellHeight;
                }
                else
                {
                    newCell = new Rectangle( column * cellWidth, row * cellHeight, cellWidth, cellHeight );
                }
                
                newTableCells.push( newCell );
            }
            
            _tableCells = newTableCells;
        }
        
        override protected function draw():void
        {
            createCells();
            super.draw();
        }
        
        /**
         * Positions a child object.
         * @param	child       The child object
         * @param	position    The position
         */
        protected function positionChild( child:DisplayObject, position:Point ):void
        {
            child.x = position.x;
            child.y = position.y;
        }
        
        /**
         * Gets a table cell layout definition.
         * @param	row		Row number
         * @param	column	Column number
         * @return	A Rectangle representing the table cell.
         */
        public function getCell( row:int, column:int ):Rectangle
        {
            var index:int = ( row * columns ) + column;
            return _tableCells[index];
        }
        
        /**
         * The table's cell alignment constant.
         */
        public function get align():String { return _align; }
        public function set align( value:String ):void 
        {
            _align = value;
            invalidate();
        }
        
        /**
         * The amount of rows in the table.
         */
        public function get rows():int { return _rows; }
        public function set rows( value:int ):void 
        { 
            _rows = value; 
            invalidate();
        }
        
        /**
         * The amount of columns in the table.
         */
        public function get columns():int { return _columns; }
        public function set columns( value:int ):void 
        {	
            _columns = value; 
            invalidate();
        }
        
        override public function get width():Number	{ return _canvas.width;	}
        override public function set width( value:Number ):void 
        { 
            _canvas.width = value; 
            invalidate();
        }
        
        override public function get height():Number	{ return _canvas.height;	}
        override public function set height( value:Number ):void 
        { 
            _canvas.height = value; 
            invalidate();
        }
    }
}
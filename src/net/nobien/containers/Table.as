package net.nobien.containers 
{
	import net.nobien.containers.abstract.AbstractTable;
	import flash.geom.Rectangle;

    /**
     * The Table container lays out its children in accordance to the table parameters.
     */
    public class Table extends AbstractTable
    {
        protected var _showGuides:Boolean = false;
        
        /**
         * Creates a new Table container.
         * @param	width		The width of the table.
         * @param	height		The height of the table.
         * @param	columns		The amount of columns.
         * @param	rows		The amount of rows.
         * @param	align		The cell alignment constant.
         * @param	showGuides	A flag, that if set to true, will show guides.
         */
        public function Table( width:Number, height:Number, columns:int = 1, rows:int = 1, align:String = "TL", showGuides:Boolean = false ) 
        {
            this.align = align;
            this.width = width;
            this.height = height;
            this.columns = columns;
            this.rows = rows;
            this.showGuides = showGuides;
            initialized = true;
        }
        
        override protected function draw():void 
        {
            drawGuides();
            super.draw();
        }
        
        /**
         * Draws table guide lines.
         */
        protected function drawGuides():void
        {
            graphics.clear();
            
            if( showGuides )
            {	
                graphics.lineStyle( 1, 0x66FFFF );
                
                for ( var i:int = 0; i < _tableCells.length; i++ )
                {
                    var cell:Rectangle = _tableCells[i];
                    graphics.moveTo( cell.x, cell.y );
                    graphics.lineTo( cell.x + cell.width, cell.y );
                    graphics.lineTo( cell.x + cell.width, cell.y + cell.height );
                    graphics.lineTo( cell.x, cell.y + cell.height );
                    graphics.lineTo( cell.x, cell.y );
                }
            }
        }
        
        /**
         * A flag, that if set to true, will show guides.
         */
        public function get showGuides():Boolean { return _showGuides; }
        public function set showGuides( value:Boolean ):void 
        {
            if( _showGuides != value )
            {
                _showGuides = value;
                invalidate();
            }
        }
    }
}
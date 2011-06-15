package net.nobien.containers 
{
    import net.nobien.containers.abstract.AbstractGrid;

    /**
     * The Grid container lays out its display children in accordance to the specified grid parameters.
     */
    public class Grid extends AbstractGrid
    {
        /**
         * Creates a new Grid layout container.
         * @param	canvasWidth		The grid's canvas width.
         * @param	canvasHeight	The grid's canvas height.
         * @param	tileWidth		The grid's tile width.
         * @param	tileHeight		The grid's tile height.
         * @param	direction		The direction which the children are arranged.
         */
        public function Grid( canvasWidth:Number = NaN, canvasHeight:Number = NaN, tileWidth:Number = NaN, tileHeight:Number = NaN, direction:String = "horizontal" ) 
        {
            this.canvasWidth = canvasWidth;
            this.canvasHeight = canvasHeight;
            this.tileWidth = tileWidth;
            this.tileHeight = tileHeight;
            this.direction = direction;
            initialized = true;
        }
    }
}